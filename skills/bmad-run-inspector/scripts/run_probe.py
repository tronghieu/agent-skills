#!/usr/bin/env python3
"""Probe a bmad-loop run: health flags, per-task progress, and delta vs last probe.

Never mutates bmad-loop's own artifacts. Writes exactly one file of its own,
`.probe-snapshot.json`, into the run directory, so the next probe can tell
"moved forward" from "stuck" — a distinction no single point-in-time reading
can make.

Thresholds are read from state.json's policy_snapshot rather than hardcoded,
because every project tunes max_dev_attempts / session_timeout_min differently
and a hardcoded number turns into a wrong alarm on the next repo.

The plain-text report also shells out to `bmad-loop status <run-id>` as a live
cross-check; that call is skipped, not silently wrong, when the run sits
outside --project's .bmad-loop/runs (bmad-loop status can't see archived runs
either).

Usage:
  run_probe.py                          # newest run under ./.bmad-loop/runs
  run_probe.py --project /path/to/repo
  run_probe.py --run .bmad-loop/runs/<run-id>
  run_probe.py --snapshot /tmp/probe.json --json
"""
from __future__ import annotations

import argparse
import glob
import json
import os
import re
import subprocess
import sys
import time

FAILURE_KINDS = ("error", "crash", "escalat", "stall", "fail", "env_fault", "pause", "budget")

# The engine rewrites heartbeat.json roughly this often while a session is alive.
HEARTBEAT_INTERVAL_S = 30
# Bar for calling a heartbeat stale (also reused below as the minimum quiet
# interval before a flat log is even eligible to be called a hang) — one
# threshold, not two arbitrary ones.
STALE_S = 120

ATTENTION_HEADER = re.compile(r"^\[(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2})\]\s+")
ATTENTION_TIME_FORMAT = "%Y-%m-%d %H:%M:%S"
# These events settle or supersede an earlier notice. Escalated and
# awaiting-operator are deliberately absent: both still need a human.
ATTENTION_RESOLUTION_KINDS = {
    "checkpoint-resume",
    "run-complete",
    "run-resume",
    "run-stop",
    "story-deferred",
    "story-done",
}

# bmad-loop cuts each escalation detail at this many characters and appends no
# marker, then wraps the result in ESCALATION_PREFIX. Every copy in the run dir
# carries the same cut, so a detail sitting exactly on the cap means the uncut
# text survives only in the story spec.
ESCALATION_DETAIL_CAP = 2000
ESCALATION_PREFIX = "CRITICAL escalation from dev session: "


def sh(cmd: list[str], cwd: str | None = None, timeout: int = 30) -> str:
    try:
        r = subprocess.run(cmd, cwd=cwd, capture_output=True, text=True, timeout=timeout)
        return (r.stdout or "") + (r.stderr or "")
    except Exception as e:  # missing binary, timeout — report, don't crash the probe
        return f"<{' '.join(cmd)} unavailable: {e}>"


def newest_run(project: str) -> str | None:
    runs = sorted(glob.glob(os.path.join(project, ".bmad-loop", "runs", "*", "")))
    runs = [r for r in runs if os.path.isfile(os.path.join(r, "state.json"))]
    return runs[-1] if runs else None


def pid_alive(pid: str) -> bool:
    try:
        os.kill(int(pid), 0)
        return True
    except (ValueError, ProcessLookupError):
        return False
    except PermissionError:
        return True  # exists, owned by someone else


def stop_request(run: str) -> dict | None:
    """Read the pending stop-control file without treating malformed bytes as hard.

    bmad-loop 0.11.1 reads a present legacy, malformed, or temporarily unreadable
    body as graceful; only an explicit ``mode: hard`` is hard. Mirror that
    conservative contract here.
    """
    path = os.path.join(run, "stop-request.json")
    if not os.path.isfile(path):
        return None
    try:
        with open(path, encoding="utf-8") as fh:
            body = json.load(fh)
    except (json.JSONDecodeError, OSError, ValueError):
        body = None
    mode = "hard" if isinstance(body, dict) and body.get("mode") == "hard" else "graceful"
    requested_at = body.get("requested_at") if isinstance(body, dict) else None
    return {"mode": mode, "requested_at": requested_at}


def attention_state(run: str, journal: list[dict]) -> dict:
    """Summarize append-only ATTENTION files without trusting their prose labels.

    A timestamped header starts a notice; continuation lines belong to that notice.
    We retain only metadata here — an inspector must still read the whole file and
    corroborate the newest block against structured artifacts.
    """
    files = []
    newest_epoch = None
    newest_stamp = None
    for path in sorted(glob.glob(os.path.join(run, "ATTENTION*"))):
        item = {
            "name": os.path.basename(path),
            "size": None,
            "notice_count": 0,
            "newest_notice_at": None,
            "ends_with_newline": None,
            "read_error": None,
        }
        try:
            with open(path, "rb") as fh:
                raw = fh.read()
            item["size"] = len(raw)
            item["ends_with_newline"] = not raw or raw.endswith(b"\n")
            stamps = []
            for line in raw.decode("utf-8", "replace").splitlines():
                match = ATTENTION_HEADER.match(line)
                if match:
                    stamps.append(match.group(1))
            item["notice_count"] = len(stamps)
            if stamps:
                item["newest_notice_at"] = stamps[-1]
                try:
                    epoch = time.mktime(time.strptime(stamps[-1], ATTENTION_TIME_FORMAT))
                except (OverflowError, ValueError):
                    epoch = None
                if epoch is not None and (newest_epoch is None or epoch > newest_epoch):
                    newest_epoch = epoch
                    newest_stamp = stamps[-1]
        except OSError as exc:
            item["read_error"] = str(exc)
        files.append(item)

    resolutions = [
        j for j in journal
        if j.get("kind") in ATTENTION_RESOLUTION_KINDS and isinstance(j.get("ts"), (int, float))
    ]
    resolution = max(resolutions, key=lambda j: j["ts"]) if resolutions else None

    # ATTENTION timestamps have only whole-second precision. Require the structured
    # event to be more than one second newer before calling a notice historical;
    # same-second ordering is ambiguous and therefore stays live.
    historical = bool(
        newest_epoch is not None
        and resolution is not None
        and resolution["ts"] > newest_epoch + 1
    )
    unreadable = any(item["read_error"] for item in files)
    return {
        "files": files,
        "newest_notice_at": newest_stamp,
        "last_resolution": (
            {"kind": resolution.get("kind"), "ts": resolution.get("ts")} if resolution else None
        ),
        "historical": historical,
        "unreadable": unreadable,
        "possible_partial_append": any(item["ends_with_newline"] is False for item in files),
    }


def escalation_truncated(reason: str | None) -> bool:
    """True when a paused_reason carries a detail sitting on bmad-loop's cap.

    Several escalations join with "; ", so each part is measured as well as the
    whole; a detail whose own prose contains "; " is caught by the whole-string
    check. A part can never exceed the cap, so equality is the signal.
    """
    body = (reason or "").strip()
    if body.startswith(ESCALATION_PREFIX):
        body = body[len(ESCALATION_PREFIX):]
    return any(len(part) == ESCALATION_DETAIL_CAP for part in [body] + body.split("; "))


def truncated_escalation(cur: dict) -> tuple | None:
    """Locate a truncated escalation reason, live or historical.

    `bmad-loop resume` clears paused_reason outright while journal.jsonl keeps
    its byte-identical copy forever, so a post-mortem on a resumed run finds
    nothing unless the journal is consulted too. Returns (story_key, source).
    """
    f = cur["flags"]
    if escalation_truncated(f.get("paused_reason")):
        return f.get("paused_story_key"), "state.json paused_reason"
    for j in reversed(cur.get("journal_failures") or []):
        kind = str(j.get("kind", ""))
        if ("escalat" in kind or "pause" in kind) and escalation_truncated(j.get("reason")):
            return j.get("story_key"), f"journal {kind}"
    return None


def attention_signature(attention: dict | None) -> list[tuple]:
    return [
        (item.get("name"), item.get("size"), item.get("newest_notice_at"))
        for item in (attention or {}).get("files", [])
    ]


def collect(project: str, run: str) -> dict:
    state = json.load(open(os.path.join(run, "state.json")))
    policy = state.get("policy_snapshot", {})
    limits = policy.get("limits", {})
    now = time.time()

    pid = ""
    pid_path = os.path.join(run, "engine.pid")
    if os.path.exists(pid_path):
        pid = open(pid_path).read().strip()

    tasks = {}
    for key, t in (state.get("tasks") or {}).items():
        tasks[key] = {
            "phase": t.get("phase"),
            "attempt": t.get("attempt"),
            "review_cycle": t.get("review_cycle"),
            "followup_reviews_spent": t.get("followup_reviews_spent"),
            "baseline_commit": t.get("baseline_commit"),
            # The uncut escalation text lives here, not in the run dir.
            "spec_file": t.get("spec_file"),
        }

    heartbeats = {}
    for f in glob.glob(os.path.join(run, "tasks", "*", "heartbeat.json")):
        try:
            h = json.load(open(f))
        except (json.JSONDecodeError, OSError):
            continue  # engine may be mid-write; a torn read is not an anomaly
        heartbeats[os.path.basename(os.path.dirname(f))] = {
            "age_s": round(now - h.get("ts", now), 1),
            "remaining_s": round(h.get("remaining_s", 0)),
            "stall_armed": h.get("stall_armed"),
            "nudges": h.get("stall_nudges_sent"),
        }

    logs = {os.path.basename(p): os.path.getsize(p)
            for p in glob.glob(os.path.join(run, "logs", "*.log"))}

    journal = []
    jpath = os.path.join(run, "journal.jsonl")
    if os.path.exists(jpath):
        for line in open(jpath):
            line = line.strip()
            if line:
                try:
                    journal.append(json.loads(line))
                except json.JSONDecodeError:
                    pass

    attention = attention_state(run, journal)

    return {
        "run_dir": run,
        "probed_at": now,
        "run_id": state.get("run_id"),
        "run_type": state.get("run_type"),
        "started_at": state.get("started_at"),
        "current_epic": state.get("current_epic"),
        "flags": {k: state.get(k) for k in
                  ("finished", "stopped", "crashed", "crash_error",
                   "paused_reason", "paused_stage", "paused_story_key")},
        "limits": {k: limits.get(k) for k in
                   ("max_dev_attempts", "max_review_cycles", "max_followup_reviews",
                    "session_timeout_min", "dev_stall_grace_s", "max_tokens_per_session")},
        "isolation": (policy.get("scm") or {}).get("isolation"),
        "verify_commands": (policy.get("verify") or {}).get("commands", []),
        "pid": pid,
        "pid_alive": pid_alive(pid) if pid else False,
        "tasks": tasks,
        "heartbeats": heartbeats,
        "logs": logs,
        "journal_lines": len(journal),
        "journal_tail": journal[-3:],
        "journal_failures": [j for j in journal
                             if any(k in str(j.get("kind", "")).lower() for k in FAILURE_KINDS)],
        # Keep attention_files for snapshots and consumers written before the
        # structured attention metadata was added.
        "attention_files": [item["name"] for item in attention["files"]],
        "attention": attention,
        "stop_request": stop_request(run),
    }


def display_flags(flags: dict) -> dict:
    """Trim paused_reason for on-screen display only; --json keeps it whole."""
    out = dict(flags)
    reason = (out.get("paused_reason") or "").strip().splitlines()
    if reason:
        first = reason[0]
        out["paused_reason"] = first[:160] + ("..." if len(first) > 160 else "")
    return out


def session_active(task_id: str, cur: dict) -> bool:
    """A session is inactive only on positive evidence it concluded — run over,
    engine dead, or that task-id's own kill-outcome logged. Anything else counts
    as active so a genuinely hung live session still gets reported.
    """
    f = cur["flags"]
    if f.get("finished") or f.get("stopped") or f.get("crashed") or f.get("crash_error"):
        return False
    if cur["pid"] and not cur["pid_alive"]:
        return False
    lifecycle = os.path.join(cur["run_dir"], "tasks", task_id, "session-lifecycle.jsonl")
    if os.path.exists(lifecycle):
        for line in open(lifecycle):
            line = line.strip()
            if not line:
                continue
            try:
                if json.loads(line).get("event") == "kill-outcome":
                    return False
            except json.JSONDecodeError:
                continue
    return True


def diagnose(cur: dict, prev: dict | None, git: dict) -> list[str]:
    """Turn readings into findings. Tier 1 = needs a human now, 3 = silent rot."""
    out = []
    f, lim = cur["flags"], cur["limits"]
    # Keyed by task-id (story key + phase + attempt), which is what heartbeats and
    # log basenames use — not by story key, which cur["tasks"] uses.
    active = {k: session_active(k, cur) for k in
              set(cur["heartbeats"]) | {os.path.splitext(n)[0] for n in cur["logs"]}}

    if f.get("crashed") or f.get("crash_error"):
        out.append(f"T1 engine crashed: {f.get('crash_error')}")
    if f.get("paused_reason") or f.get("paused_stage"):
        # paused_reason is free-form text from the escalating session and runs to
        # kilobytes of markdown; printed whole it buries every other finding.
        lines = (f.get("paused_reason") or "").strip().splitlines()
        reason = lines[0][:160] + ("..." if len(lines[0]) > 160 else "") if lines else ""
        out.append(f"T1 paused at {f.get('paused_stage')} on {f.get('paused_story_key')}: "
                   f"{reason} -> `bmad-loop resolve {cur['run_id']}` or "
                   f"`bmad-loop resume {cur['run_id']}`")
    hit = truncated_escalation(cur)
    if hit:
        story, found_in = hit
        spec = (cur["tasks"].get(story) or {}).get("spec_file")
        source = spec or "the story's spec (tasks.<k>.spec_file)"
        out.append(
            f"T1 escalation detail is cut at {ESCALATION_DETAIL_CAP} chars ({found_in}) and "
            f"every copy in the run dir carries the same cut — read `## Auto Run Result` in "
            f"{source} for the blocker; do not report it from the truncated text"
        )
    if cur["pid"] and not cur["pid_alive"] and not (f.get("finished") or f.get("stopped")):
        out.append(f"T1 engine pid {cur['pid']} is dead but the run never finished")
    attention = cur.get("attention") or {}
    if attention.get("files"):
        names = [item.get("name") for item in attention["files"]]
        newest = attention.get("newest_notice_at") or "timestamp unreadable"
        if attention.get("unreadable"):
            out.append(f"T1 ATTENTION cannot be read: {names}")
        elif attention.get("historical"):
            resolution = attention.get("last_resolution") or {}
            out.append(
                f"context: ATTENTION contains historical notices; newest={newest}, "
                f"later resolution={resolution.get('kind')}"
            )
        else:
            changed = (
                not prev
                or attention_signature(attention) != attention_signature(prev.get("attention"))
            )
            state = "new since last probe" if prev and changed else "unresolved"
            partial = (
                " (possible partial append: file lacks final newline)"
                if attention.get("possible_partial_append")
                else ""
            )
            out.append(
                f"T1 {state} ATTENTION notice: {names}, newest={newest}{partial} — "
                "read the whole file and corroborate its label"
            )
    if f.get("finished") or f.get("stopped"):
        out.append(f"T1 run concluded (finished={f.get('finished')} stopped={f.get('stopped')}) — report a summary")

    # 2 and 3 are bmad-loop's own shipped defaults for these two limits, used
    # only when the policy key is absent — not a guess tuned for one project.
    max_att = lim.get("max_dev_attempts") or 2
    max_rev = lim.get("max_review_cycles") or 3
    for k, t in cur["tasks"].items():
        if (t.get("attempt") or 0) >= max_att:
            out.append(f"T2 {k}: attempt {t['attempt']}/{max_att} — last chance before the story fails")
        if (t.get("review_cycle") or 0) >= max_rev - 1:
            out.append(f"T2 {k}: review_cycle {t['review_cycle']}/{max_rev} — review is not converging")
        if (t.get("followup_reviews_spent") or 0) > 0:
            out.append(f"T2 {k}: followup review spent ({t['followup_reviews_spent']})")
        # `resume` clears the pause without re-arming; `resolve` re-arms. So an
        # escalated phase outstanding on an unpaused run means someone resumed
        # past it, and nothing left in the run will pick the story back up.
        if t.get("phase") == "escalated" and not (f.get("paused_reason") or f.get("paused_stage")):
            out.append(f"T3 {k}: phase escalated while the run is not paused — resumed past the "
                       "escalation without re-arming it; nothing will re-drive this story")

    for k, h in cur["heartbeats"].items():
        if h.get("stall_armed"):
            out.append(f"T2 {k}: stall_armed — the session went idle past its grace window")
        if (h.get("nudges") or 0) > 0:
            out.append(f"T2 {k}: {h['nudges']} stall nudge(s) sent")
        if active.get(k, True) and h.get("age_s", 0) > STALE_S:
            out.append(f"T2 {k}: heartbeat {h['age_s']}s old — engine may not be writing")
        if active.get(k, True) and h.get("remaining_s", 1e9) < 600:
            phases = {t.get("phase") for t in cur["tasks"].values()}
            if any(p and "dev" in p for p in phases):
                out.append(f"T2 {k}: only {h['remaining_s']}s of session budget left, still in dev")

    if cur["journal_failures"]:
        kinds = sorted({j.get("kind") for j in cur["journal_failures"]})
        out.append(f"T2 journal carries failure entries: {kinds}")

    if cur.get("stop_request"):
        request = cur["stop_request"]
        when = f" since {request['requested_at']}" if request.get("requested_at") else ""
        out.append(f"context: {request['mode']} stop request pending{when}")

    if prev and prev.get("run_id") == cur["run_id"]:
        # Missing on a pre-timestamp snapshot: elapsed stays None, so the floor
        # check below can't suppress anything — same as the old, no-floor behaviour.
        elapsed = None
        if isinstance(prev.get("probed_at"), (int, float)) and isinstance(cur.get("probed_at"), (int, float)):
            elapsed = cur["probed_at"] - prev["probed_at"]
        for name, size in cur["logs"].items():
            delta = size - prev.get("logs", {}).get(name, 0)
            same_phase = prev.get("tasks") == cur["tasks"]
            task_id = os.path.splitext(name)[0]
            if delta == 0 and same_phase and active.get(task_id, True):
                too_soon = elapsed is not None and elapsed < STALE_S
                hb_age = cur["heartbeats"].get(task_id, {}).get("age_s")
                # A heartbeat this fresh is direct evidence the engine is alive and
                # writing — the log being quiet is just the shape of a long tool call.
                fresh_heartbeat = hb_age is not None and hb_age <= HEARTBEAT_INTERVAL_S
                if too_soon or fresh_heartbeat:
                    continue
                interval = f"no growth in {elapsed / 60:.0f}m" if elapsed is not None \
                    else "no growth since last probe (interval unknown)"
                if hb_age is not None and hb_age > STALE_S:
                    out.append(f"T3 {name}: {interval}, heartbeat also stale ({hb_age:.0f}s) — suspect a hang")
                else:
                    out.append(f"T3 {name}: {interval} and no phase change — suspect a hang")
            if delta > 5 * 1024 * 1024:
                out.append(f"T3 {name}: grew {delta / 1048576:.1f}MB in one interval — suspect a tool-call loop")
        if prev.get("tasks") == cur["tasks"]:
            out.append("note: no task state changed since the last probe")

    dirty = git.get("dirty_count", 0)
    if cur.get("isolation") == "none" and dirty:
        out.append(f"context: isolation=none, {dirty} file(s) dirty in the live checkout — "
                   "a failed attempt will leave them there")
    return out


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--project", default=os.getcwd())
    ap.add_argument("--run", default=None, help="run directory; default = newest")
    ap.add_argument("--snapshot", default=None, help="delta snapshot path")
    ap.add_argument("--json", action="store_true", help="emit raw JSON instead of a report")
    a = ap.parse_args()

    project = os.path.abspath(a.project)
    run = os.path.abspath(a.run) if a.run else newest_run(project)
    if not run:
        print("no bmad-loop run found under", os.path.join(project, ".bmad-loop", "runs"))
        return 0

    cur = collect(project, run)
    git = {
        "branch": sh(["git", "branch", "--show-current"], project).strip(),
        "dirty_count": len([l for l in sh(["git", "status", "--short"], project).splitlines() if l.strip()]),
    }
    cur["git"] = git

    snap = a.snapshot or os.path.join(run, ".probe-snapshot.json")
    prev = None
    if os.path.exists(snap):
        try:
            prev = json.load(open(snap))
        except (json.JSONDecodeError, OSError):
            prev = None

    findings = diagnose(cur, prev, git)

    if a.json:
        print(json.dumps({"current": cur, "findings": findings}, indent=1, default=str))
    else:
        print(f"# run {cur['run_id']}  type={cur['run_type']}  started {cur['started_at']}")
        runs_root = os.path.join(project, ".bmad-loop", "runs") + os.sep
        print("\n## bmad-loop status")
        if run.startswith(runs_root):
            print(sh(["bmad-loop", "status", cur["run_id"]], project).rstrip())
        else:
            print("  (skipped — run is outside --project's .bmad-loop/runs; "
                  "bmad-loop status can't see archived runs either, so this is "
                  "not evidence the run doesn't exist)")
        print(f"\n## engine\npid={cur['pid']} alive={cur['pid_alive']}  "
              f"isolation={cur['isolation']}  branch={git['branch']}  dirty={git['dirty_count']}")
        print(f"flags: {display_flags(cur['flags'])}")
        print(f"limits: {cur['limits']}")
        print(f"stop_request: {cur['stop_request']}")
        print("\n## tasks")
        for k, t in cur["tasks"].items():
            prev_t = (prev or {}).get("tasks", {}).get(k)
            mark = "" if prev_t is None else ("  [unchanged]" if prev_t == t else f"  [changed from {prev_t}]")
            print(f"  {k}: {t}{mark}")
        print("\n## heartbeats")
        for k, h in cur["heartbeats"].items():
            print(f"  {k}: {h}")
        print("\n## logs")
        for name, size in cur["logs"].items():
            d = size - (prev or {}).get("logs", {}).get(name, 0) if prev else None
            print(f"  {name}: {size:,} B" + (f"  (delta {d:+,})" if d is not None else ""))
        print(f"\n## journal ({cur['journal_lines']} lines)")
        for j in cur["journal_tail"]:
            print("  ", json.dumps(j)[:220])
        print("\n## attention")
        print("  ", json.dumps(cur["attention"], default=str)[:1000])
        print("\n## findings")
        if findings:
            for f in findings:
                print("  -", f)
        else:
            print("   none — run looks healthy")

    json.dump(cur, open(snap, "w"), indent=1, default=str)
    return 0


if __name__ == "__main__":
    sys.exit(main())
