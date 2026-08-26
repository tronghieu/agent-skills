# BMAD Run Inspector

**Language:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

Read what a `bmad-loop` autonomous coding run actually did — and refuse to answer from the one file that lies.

```bash
npx skills add tronghieu/agent-skills --skill bmad-run-inspector
```

## Quick start

```text
Is the loop still running, and is it stuck?
```

```text
What did last night's bmad-loop run do? Why did story auth-3 fail?
```

```text
Where did the tokens go on this run?
```

```text
The run paused. What's it waiting for, and what do I run next?
```

## Why not just grep the log?

`bmad-loop` runs the coding CLI inside a tmux or psmux pane and captures the pane, so the biggest file in a run directory — `logs/<task-id>.log` — is a serialized video of a screen, not a transcript. Lines are repainted hundreds of times as they're typed, whitespace is dropped between redraws, and long tool output collapses behind `… +N lines (ctrl+o to expand)` and is never painted at all.

Test summaries live inside exactly those collapsed blocks. `grep` the log for `FAIL` or `passed` and it comes back clean — which reads as a green run and is actually a file that never received the evidence. That is the trap this skill exists to avoid: it never reports pass/fail from the log, and it names the sources that can actually answer — the run's structured journal, its machine state, or re-running the verify command yourself.

## Who it's for

Anyone driving `bmad-loop` who needs an honest read on a run: watching one still in flight ("is it stuck, should I be worried?"), or doing forensics on one that finished, failed, or paused overnight ("what happened, where did the tokens go, why did this story fail?").

## How it works

1. **Learn the project first.** The log heuristics below are stack-specific and fail silently on a mismatch, so before reading anything the skill establishes which coding CLI drives the pane and which test/type stack the project runs, from `_project/bmad-loop/environment.toml` and `environment.md`. Where a value is missing or unconfirmed, it asks rather than guesses — a wrong guess produces a clean-looking result over evidence it never actually matched.
2. **Probe the state.** `scripts/run_probe.py` reads `state.json` and `journal.jsonl` directly — no log parsing — and reports health flags, per-story phase/attempt/review-cycle, heartbeat age, and findings, ranked into three severity tiers. It snapshots itself so the next probe can report what changed, which is what separates "working" from "hung."
3. **Reconstruct the narrative, carefully.** `scripts/extract_transcript.py` strips terminal escapes and rebuilds each logical line from its longest repainted variant, reducing a multi-megabyte capture to a few dozen classified lines: tool calls, subagent cost, streamed results, prose, and the CLI's own progress counter. A `--collapsed` pass reports how much of the story is structurally unreadable, so that number can be quoted instead of hedged.
4. **Cross-check the working tree.** The log says what the agent tried; git says what landed. Diffing against the story's recorded baseline commit catches the gap between an agent that wrote code and one that narrated writing code.
5. **Read the actual verdict.** `session-end.status` looks like the answer and isn't — it only says how the CLI session ended, not whether the work was accepted. The real outcome is `dev-decision.action`, the terminal journal kind (`story-done`, `story-deferred`, `story-escalated`, `story-awaiting-operator`), and the story's terminal phase, in that order. If the user needs the actual failing assertions, the skill re-runs the verify command rather than guessing from the journal.

## What comes back

A live-watch check that finds nothing wrong is one or two lines — not a wall of green text that trains you to stop reading. When something needs attention, the report leads with current state (story, phase, attempt, elapsed), what changed since the last check, the finding with its evidence, and the exact command to run next.

Findings are ranked by urgency, not discovery order:

| Tier | Example | Typical remedy |
| --- | --- | --- |
| **1 — needs a human now** | Crashed engine, a run paused on an escalation, a dead engine pid, a new or unresolved `ATTENTION` notice | `bmad-loop resolve <run-id>`, `bmad-loop resume <run-id>`, or `bmad-loop diagnose` |
| **2 — about to fail** | Last dev attempt before the story's cap, review cycles not converging, a stale heartbeat, session budget nearly gone mid-implementation | Watch closely; intervene before the next automatic failure |
| **3 — silent rot** | Log growing while the progress counter is frozen and nothing new is streaming, identical tool calls repeating, a deferred-work ledger swelling with sweeps disabled | Compare two probes; nothing else in the run surfaces these on its own |

Tier 3 is the reason this skill exists: tiers 1 and 2 are visible in `bmad-loop tui` already; tier 3 is only visible to something that reads the artifacts and compares them over time.

## Limits

This skill requires `bmad-loop` and reads its run directories directly — it has no use outside a project driving `bmad-loop`. The log-reading heuristics in `extract_transcript.py` are pattern-matched against one coding CLI's terminal UI (its spinner vocabulary, its `⏺` tool-call glyph, its collapse marker) and against logs from projects running one particular test stack. Point it at a different coding CLI inside `bmad-loop` and it won't error — it degrades silently, matching fewer or none of a section's patterns while still returning a result, which reads as a clean run and isn't. The project adapter under `_project/bmad-loop/` records and confirms which CLI and stack this repo actually runs, which is what closes off most of that risk before the skill starts reading — but it doesn't eliminate it: the extractor's matching constants are still literal patterns, so if a section looks implausibly thin, open the raw log by hand and check what your CLI actually prints before trusting the output.

It also can't tell you whether tests passed — nothing can, from this file. The verdict comes from the journal and the working tree, or from re-running verify yourself.
