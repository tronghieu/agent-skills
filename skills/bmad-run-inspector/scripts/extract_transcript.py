#!/usr/bin/env python3
"""Reconstruct a readable transcript from a bmad-loop session log.

The .log in a run's logs/ directory is not a transcript — it is a raw capture of
a terminal pane that the coding CLI keeps redrawing. The same logical line is
written hundreds of times as it grows character by character, interleaved with
cursor-movement escapes. Reading it with tail/grep gives you shredded fragments.

The reconstruction: strip escapes, bucket lines by a normalized prefix, and keep
the LONGEST version seen in each bucket. Redraws are prefixes of the final text,
so the longest variant is the completed line.

What this CANNOT recover: the coding CLI collapses long tool output into
"… +N lines (ctrl+o to expand)". Those lines are never painted to the pane, so
they are absent from the capture. Test summaries live there. Counting the
collapse markers tells you how much is missing; --collapsed reports it.

Usage:
  extract_transcript.py                       # newest run under ./.bmad-loop/runs
  extract_transcript.py --run <dir> --tail-bytes 400000
  extract_transcript.py --section tools       # tools|errors|results|prose|progress|subagents|all
  extract_transcript.py --collapsed           # how much output is hidden
"""
from __future__ import annotations

import argparse
import glob
import os
import re
import sys

# --- Capture-mechanism constants: follow from parsing a redrawn terminal
# pane, not from any particular tool. Hold for any coding CLI.
# OSC sequences (\x1b]...) end in either BEL or ST (\x1b\\) per the xterm spec;
# a hyperlink or title-set using the ST form must match too, or its payload
# leaks into the transcript and misclassifies whatever line it wraps.
ANSI = re.compile(
    r"\x1b\[[0-9;?]*[a-zA-Z]|\x1b[()][A-B0-2]|\x1b[=>]"
    r"|\x1b\](?:[^\x07]*\x07|[^\x1b]*\x1b\\)"
)

# --- Stack-specific constants: tuned for Claude Code's TUI (spinner words,
# the "ctrl+o to expand" collapse marker, the ⏺ tool-call glyph, the
# "Done(...)" subagent line) and a Vitest-based test suite (banner and
# summary tokens, TS error codes, Node errno names). Review and retune these
# before trusting output on a different coding CLI or test stack: a mismatch
# doesn't error, it misclassifies lines or matches nothing, so an empty
# `--section errors`/`--section results` then reads as a clean run instead
# of "nothing matched."
SPINNER = re.compile(r"^[\W\s]*(Precipitating|Thinking|Cogitating|Pondering|Musing|Working|"
                     r"Simmering|Percolating|thinking with|thought for)", re.I)
NOISE = re.compile(r"^[\s\W]*$|^\d+$|ctrl\+o to expand|esc to interrupt", re.I)
TOOL_MARKER = "⏺"
RESULTS = re.compile(r"^\s*(⎿|│|└|Test Files|Tests |Duration|RUN\s+v|✓|PASS|passed|✔)")
COLLAPSED = re.compile(r"\+\s?(\d+)\s?lines?\s?\(ctrl")
# The pane capture drops spaces unpredictably ("Done(10tooluses·99.2ktokens·1m0s)"),
# so every gap in these patterns has to tolerate zero-or-more whitespace.
PROGRESS = re.compile(r"(\d+m\s*\d+s|\d+s)\s*·\s*[↓↑]?\s*([\d.]+k\s*tokens)")
SUBAGENT = re.compile(r"Done\s*\(\s*(\d+)\s*tool\s*uses?\s*·\s*([\d.]+k)\s*tokens?\s*·\s*([^)]+?)\s*\)")
# A leading \b applies before "Error:" too, but ":" and the space after it are both
# non-word chars, so no boundary ever forms there — drop it. ✗/× are non-word chars
# themselves, so \b never matches around them either; anchor them to line-start instead,
# since an unanchored × also matches inside things like "1920×1080".
FAILISH = re.compile(r"\b(FAIL|error TS\d+|AssertionError|ECONNREFUSED|"
                     r"ENOENT|Timeout|timed out|not ok|rejected)\b"
                     r"|Error:"
                     r"|^\s*[✗×]")


def norm_key(s: str, width: int = 28) -> str:
    return re.sub(r"\s+", "", s)[:width].lower()


def _clean_lines(path: str, tail_bytes: int | None = None) -> list[str]:
    """ANSI-stripped, CR-normalized, blank/noise lines dropped — the painted-frame
    stream both reconstruct() and collapsed_stats() bucket from.
    """
    with open(path, "rb") as fh:
        if tail_bytes:
            fh.seek(0, os.SEEK_END)
            fh.seek(max(0, fh.tell() - tail_bytes))
        raw = fh.read().decode("utf-8", "replace")
    clean = ANSI.sub("", raw).replace("\r", "\n")
    out = []
    for line in clean.split("\n"):
        line = line.rstrip()
        stripped = line.strip()
        if not stripped or NOISE.match(stripped):
            continue
        out.append(line)
    return out


def reconstruct(path: str, tail_bytes: int | None = None) -> list[str]:
    # Prefix key can collide across genuinely different lines (two Bash(...) commands
    # sharing their first 28 chars), so a bucket holds variants, not one winner. A new
    # line either redraws an existing variant (one is a whitespace-stripped prefix of
    # the other — keep the longer raw form in place) or is a new variant appended in
    # first-appearance order. Two identical commands run twice are indistinguishable
    # from a redraw and still collapse to one entry.
    buckets: dict[str, list[str]] = {}
    order: list[tuple[str, int]] = []
    for line in _clean_lines(path, tail_bytes):
        k = norm_key(line.strip())
        if not k:
            continue
        flat = re.sub(r"\s+", "", line)
        variants = buckets.setdefault(k, [])
        for i, variant in enumerate(variants):
            v_flat = re.sub(r"\s+", "", variant)
            if v_flat.startswith(flat) or flat.startswith(v_flat):
                if len(line) > len(variant):
                    variants[i] = line
                break
        else:
            variants.append(line)
            order.append((k, len(variants) - 1))
    return [buckets[k][i] for k, i in order]


def collapsed_stats(path: str, tail_bytes: int | None = None) -> tuple[list[int], list[int]]:
    """Two counts of the '+N lines (ctrl+o to expand)' collapse marker.

    raw: every marker as painted. The pane repaints the same collapsed block on
    each redraw, so this over-counts — one real block can appear dozens of times.
    deduped: markers keyed on (marker text, the line painted right before it), so
    repaints of one block collapse to a single entry while two distinct blocks
    that happen to hide the same line count both survive. Still an estimate:
    without timestamps, a genuinely repeated command is indistinguishable from a
    repaint of one block, so this can over- or under-count in either direction.
    """
    lines = _clean_lines(path, tail_bytes)
    raw = [int(m.group(1)) for line in lines for m in [COLLAPSED.search(line)] if m]

    seen: set[tuple[str, str]] = set()
    deduped: list[int] = []
    prev = ""
    for line in lines:
        m = COLLAPSED.search(line)
        if m:
            key = (line, prev)
            if key not in seen:
                seen.add(key)
                deduped.append(int(m.group(1)))
        else:
            prev = line
    return raw, deduped


def classify(lines: list[str]) -> dict[str, list[str]]:
    out = {"tools": [], "errors": [], "results": [], "prose": [], "progress": [], "subagents": []}
    for line in lines:
        s = line.strip()
        m = SUBAGENT.search(s)
        if m:
            # Spacing varies between redraws, so the same completion can survive
            # bucketing twice ("⎿ Done(...)" vs "Done(...)"). Compare on the
            # space-free form to report each subagent once.
            entry = f"{m.group(1)} tool uses · {m.group(2)} tokens · {re.sub(r'\s+', '', m.group(3))}"
            if entry not in out["subagents"]:
                out["subagents"].append(entry)
        if SPINNER.match(s):
            p = PROGRESS.search(s)
            if p:
                out["progress"].append(p.group(0))
            continue
        if s.startswith(TOOL_MARKER):
            out["tools"].append(s)
        elif FAILISH.search(s):
            out["errors"].append(s)
        elif RESULTS.match(s):
            out["results"].append(s)
        elif len(s) > 40 and not s.startswith(("[", "{", "<")):
            out["prose"].append(s)
    return out


def newest_run(project: str) -> str | None:
    runs = sorted(glob.glob(os.path.join(project, ".bmad-loop", "runs", "*", "")))
    runs = [r for r in runs if os.path.isdir(os.path.join(r, "logs"))]
    return runs[-1] if runs else None


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--project", default=os.getcwd())
    ap.add_argument("--run", default=None)
    ap.add_argument("--log", default=None, help="a specific .log; default = every log in the run")
    ap.add_argument("--tail-bytes", type=int, default=None)
    ap.add_argument("--section", default="all",
                    choices=["all", "tools", "errors", "results", "prose", "progress", "subagents"])
    ap.add_argument("--limit", type=int, default=40, help="lines per section (tools/subagents always full)")
    ap.add_argument("--collapsed", action="store_true", help="report how much output the pane hid")
    a = ap.parse_args()

    project = os.path.abspath(a.project)
    run = os.path.abspath(a.run) if a.run else newest_run(project)
    if not run:
        print("no bmad-loop run found under", os.path.join(project, ".bmad-loop", "runs"))
        return 0

    logs = [a.log] if a.log else sorted(glob.glob(os.path.join(run, "logs", "*.log")))
    if not logs:
        print("run has no logs yet:", run)
        return 0

    for log in logs:
        print(f"===== {os.path.basename(log)}  ({os.path.getsize(log):,} B) =====")
        lines = reconstruct(log, a.tail_bytes)
        print(f"reconstructed {len(lines)} logical lines")

        if a.collapsed:
            raw_hidden, hidden = collapsed_stats(log, a.tail_bytes)
            print(f"\n## collapsed output (estimate): {len(hidden)} markers hiding ~{sum(hidden):,} lines "
                  f"(largest {max(hidden) if hidden else 0})")
            print(f"   Unfiltered capture: {len(raw_hidden)} markers / {sum(raw_hidden):,} lines — the gap "
                  f"is the pane repainting the same collapsed block on every redraw.")
            print("   The deduped figure is still an estimate: without timestamps, a genuinely repeated")
            print("   command is indistinguishable from a repaint of one block.")
            print("   Those lines were never painted to the pane, so they are not in this file.")
            print("   Test pass/fail counts usually live there — do not infer them from this log.")

        buckets = classify(lines)
        want = buckets.keys() if a.section == "all" else [a.section]
        for name in want:
            vals = buckets[name]
            shown = vals if name in ("tools", "subagents") else vals[-a.limit:]
            print(f"\n## {name} ({len(vals)})")
            for v in shown:
                print("  ", v[:200])
            if name == "progress" and vals:
                print(f"   span: {vals[0]}  ->  {vals[-1]}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
