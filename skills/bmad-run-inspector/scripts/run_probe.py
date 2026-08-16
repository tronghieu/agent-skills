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
import subprocess
import sys
import time

FAILURE_KINDS = ("error", "crash", "escalat", "stall", "fail", "env_fault", "pause", "budget")


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

    return {
        "run_dir": run,
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
        "attention_files": [os.path.basename(p) for p in glob.glob(os.path.join(run, "ATTENTION*"))],
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
        tail = " (full text in state.json's paused_reason)" if reason else ""
        out.append(f"T1 paused at {f.get('paused_stage')} on {f.get('paused_story_key')}: "
                   f"{reason}{tail} -> `bmad-loop resolve` or `bmad-loop resume`")
    if cur["pid"] and not cur["pid_alive"] and not (f.get("finished") or f.get("stopped")):
        out.append(f"T1 engine pid {cur['pid']} is dead but the run never finished")
    if cur["attention_files"]:
        out.append(f"T1 ATTENTION file present: {cur['attention_files']}")
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

    for k, h in cur["heartbeats"].items():
        if h.get("stall_armed"):
            out.append(f"T2 {k}: stall_armed — the session went idle past its grace window")
        if (h.get("nudges") or 0) > 0:
            out.append(f"T2 {k}: {h['nudges']} stall nudge(s) sent")
        if active.get(k, True) and h.get("age_s", 0) > 120:
            out.append(f"T2 {k}: heartbeat {h['age_s']}s old — engine may not be writing")
        if active.get(k, True) and h.get("remaining_s", 1e9) < 600:
            phases = {t.get("phase") for t in cur["tasks"].values()}
            if any(p and "dev" in p for p in phases):
                out.append(f"T2 {k}: only {h['remaining_s']}s of session budget left, still in dev")

    if cur["journal_failures"]:
        kinds = sorted({j.get("kind") for j in cur["journal_failures"]})
        out.append(f"T2 journal carries failure entries: {kinds}")

    if prev and prev.get("run_id") == cur["run_id"]:
        for name, size in cur["logs"].items():
            delta = size - prev.get("logs", {}).get(name, 0)
            same_phase = prev.get("tasks") == cur["tasks"]
            task_id = os.path.splitext(name)[0]
            if delta == 0 and same_phase and active.get(task_id, True):
                out.append(f"T3 {name}: no growth and no phase change since last probe — suspect a hang")
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
