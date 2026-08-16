# Anomaly Triage

Three tiers, ordered by how quickly a human needs to act. Every threshold traces to a key
in `state.json`'s `policy_snapshot`. The numbers quoted below are one project's settings,
not defaults of this skill — before you act on any of them, read the actual value from
your own run's `policy_snapshot` instead of trusting what's printed here.

## Tier 1 — a human is needed now

| Finding | Evidence | Remedy |
|---|---|---|
| Engine crashed | `crashed: true`, `crash_error` non-null | Report the traceback. `bmad-loop diagnose` produces a sanitized dump for maintainers |
| Run paused | `paused_reason` / `paused_stage` non-null | `bmad-loop resolve <run-id>` for a CRITICAL escalation — re-drives `paused_story_key` by default, pass `--story <key>` only to override it; `bmad-loop resume <run-id>` if the block is already cleared |
| Engine died silently | `engine.pid` not alive while `finished` and `stopped` are both false | Nothing will resume it. Decide between `bmad-loop resume <run-id>` and a fresh run; check the working tree first if `scm.isolation = "none"` |
| Attention raised | An `ATTENTION` file in the run dir | Read it — the engine writes it precisely because it wants a human. Governed by `notify.file` |
| Run concluded | `finished: true` or `stopped: true` | Not a fault, but the moment a summary is owed: stories completed, backlog remaining, working-tree state |
| Story parked for an operator | `tasks.<k>.phase = "awaiting-operator"` | `bmad-loop confirm <story-key>` (`--list`, `--json`, `--yes`, `--reverify`) |

A gate can also hold a run: `gates.mode = "per-epic"` pauses at each epic boundary for
approval. That surfaces as a pause with a gate-shaped reason — approval, not debugging.

A story parks when three things hold: `policy.operator.enabled` (sprint mode only), the dev
session's spec frontmatter reads `status: awaiting-operator`, and it declares a non-empty
`operator_actions:` list. The story skips review, takes the normal verify-and-commit path, and
journals `story-awaiting-operator`. The record lands at `.bmad-loop/operator/<story-key>.json`
(`story_key, actions, spec_file, run_id, parked_at`) — **it carries no `commit` field, because it
is written into the very commit that carries it**; the commit is recovered from `git log` over
the record's own path, not stored. **The parked task's phase stays `awaiting-operator` forever —
the run will not pick it back up and re-drive it.** Waiting for the run to advance the story is a
mistake; only a human running `bmad-loop confirm <story-key>` clears the park.

## Tier 2 — failing soon

| Finding | Evidence | Why it matters |
|---|---|---|
| Last dev attempt | `tasks.<k>.attempt >= limits.max_dev_attempts` | The next failure ends the story. With `max_dev_attempts = 2`, seeing `2` means one chance left |
| Review not converging | `tasks.<k>.review_cycle` approaching `limits.max_review_cycles` | Repeated review rounds mean the agent cannot satisfy the findings, not that it is being careful |
| Follow-up review spent | `followup_reviews_spent > 0` | Budget from `max_followup_reviews` is being consumed |
| Session went idle | `heartbeat.stall_armed: true`, or `stall_nudges_sent > 0` | The session ended a turn without a result and sat past `dev_stall_grace_s`. Nudges are capped by `dev_stall_nudges` |
| Heartbeat stale | `age_s` beyond ~2× the write interval | The engine may have stopped writing even though the pid lives |
| Budget nearly gone | `remaining_s < 600` while phase is still `dev-*` | `session_timeout_min` is about to end the session mid-implementation, before verify and review have run at all |
| Session budget warned | `session-lifecycle.jsonl` has `budget-tripped` (`weighted, budget, mode`), plus an ATTENTION notice | `session_budget_mode = "warn"` (the default) tripped `max_tokens_per_session`; the session keeps running to its natural end — a pure degradation signal, no consequence yet |
| Session killed for budget | `session-lifecycle.jsonl` has `over-budget-fired` (`weighted, budget, grace_s, zero_grace`); `session-end.status = "over_budget"` | `session_budget_mode = "enforce"` ran out the `session_budget_grace_s` grace window and killed the session. This already consumed a dev attempt via the ordinary retry/defer decision — not just a warning |
| Journal failure entries | `kind` matching error/crash/escalat/stall/fail/env_fault/pause/budget | Each is a recorded event with a timestamp — quote it |

Two unrelated things share the name "environment fault." `dev-decision.env_fault` is set only
when the **verify command** exits 126 or 127 (POSIX) — the shell's "found but not executable" /
"not found" convention — plus a signature-based arm on Windows. Any other verify breakage — a
stopped database, an unreachable port, a missing service — is recorded as an ordinary failure and
consumes a dev attempt. When a story fails on the first attempt, check the environment before
assuming the agent is at fault.

`session-end.env_fault` is unrelated and fed by a different mechanism: after any non-completed
session, the last 64 KiB of that session's log is regex-scanned against the adapter profile's
`env_fault_patterns`. The default pattern tuple is empty, so this path is inert unless a profile
configures it — its silence is not evidence the session was healthy, it usually just means nobody
wired the patterns.

## Tier 3 — silent rot

These produce no flag, no journal entry, and nothing in the TUI. They are found only by
comparing artifacts across time, which is why a probe writes a snapshot.

| Finding | How to detect | What it means |
|---|---|---|
| Hung session | Log size unchanged **and** task state unchanged across two probes | The agent is not producing output at all |
| Repainting, not working | Log grows, `progress` counter frozen, **and** no new `prose`/`results` lines | The pane is redrawing a static frame. Confirm the third condition first — a session running subagents also freezes its own counter while working hard |
| Tool-call loop | The last several `tools` entries are near-identical to the previous probe's | The agent is retrying the same thing rather than advancing |
| Runaway output | Log grew by more than a few MB in one interval | Usually a command dumping enormous output, or a loop |
| Story re-driven | Multiple `story-start` entries for one `story_key` in the journal | Work restarted from the beginning |
| Silent verify failure | Backlog count unchanged although a story reached `done` | A verify command ending in `\|\| true` failed without failing the run — check `policy_snapshot.verify.commands` for which steps this project made non-fatal |
| Session budget guard disabled | No `budget-tripped` or `over-budget-fired` ever appears, despite a heavy-spend session | The adapter has no mid-session usage signal to sample, so `session_budget_mode` (`warn` or `enforce`) is inert regardless of setting. Absence of the event is not evidence the session stayed under budget |
| Debt accumulating | `deferred-work.md` growing while `sweep.auto = "never"` | Nothing triages the ledger until someone runs `bmad-loop sweep` |
| Working tree drifting | `git status --short` count climbing under `scm.isolation = "none"` | The run edits the live checkout. With `rollback_on_failure = false`, a failed attempt leaves it dirty and pauses |

## Thresholds that lie

Three settings read like guardrails and are not. Say so plainly rather than reassuring a
user with them:

- **`max_tokens_per_story` enforces nothing — but it does warn once.** It resets per run — the
  counter lives in that run's `state.json`, so a new run starts every story at zero. The first
  time a story's cumulative weighted spend crosses the cap, it journals `token-budget-exceeded`
  (`story_key, weighted, total, budget`) and raises an ATTENTION notice, latched by
  `tasks.<k>.token_budget_warned` so it fires exactly once per run. Cost control has to come from
  watching the summed subagent spend — the story keeps running past the warning.
- **`|| true` on a verify command guarantees exit 0.** Anything after `||` in
  `policy_snapshot.verify.commands` cannot fail the run, so a green verify says nothing
  about those steps.
- **Verify runs twice per story and discards its output on timeout.** A verify step with no
  output may have run and timed out. Absent output is not absent execution.

## Session token budget

`limits.max_tokens_per_session` (default 4,000,000) is a mid-session guard, sampled every
heartbeat tick, governed by `limits.session_budget_mode`:

- `off` — no sampling.
- `warn` (the default) — one `budget-tripped` lifecycle event (`weighted, budget, mode`) and one
  ATTENTION notice; the session runs to its natural end. Same non-enforcement as
  `max_tokens_per_story` above.
- `enforce` — same trip, then a wrap-up nudge and a `session_budget_grace_s` grace window
  (default 240s). If the session hasn't finished by then, it is killed with status `over_budget`
  (`over-budget-fired`: `weighted, budget, grace_s, zero_grace`), which then rides the ordinary
  retry/defer decision like any other session ending — this already consumed a dev attempt, it
  is not merely a warning.

It is inert on any adapter with no mid-session usage signal to sample, regardless of mode: no
event ever fires. That silence is not evidence the session stayed under budget — it means the
guard never ran.

## Suggesting a remedy

Give one command, not a menu. The useful ones:

| Situation | Command |
|---|---|
| Paused on an escalation | `bmad-loop resolve <run-id>` — interactive, a human answers; re-drives `paused_story_key` by default, pass `--story <key>` to override |
| Paused, block already cleared | `bmad-loop resume <run-id>` |
| Story parked for an operator | `bmad-loop confirm <story-key>` — clears the park, does not re-drive the story |
| Need to watch the agent live | `bmad-loop attach`, then the multiplexer's detach chord (`Ctrl-b d` for tmux). Never `Ctrl-c` — that kills the session |
| Need to stop everything | `bmad-loop stop <run-id>` |
| Handing a fault to maintainers | `bmad-loop diagnose` — sanitized dump |
| Ledger has grown untriaged | `bmad-loop sweep` |
| Story failed and the environment is suspect | `bmad-loop validate` — reports host facts no run directory contains: multiplexer availability and version, whether the coding CLI's binary is on PATH, hook registration and staleness, git worktree cleanliness |

When advising on a dirty working tree under `isolation = "none"`, do not propose a blanket
clean. The run's own recovery is deliberately conservative, and untracked files in the tree
may predate the run — `tasks.<k>.baseline_untracked` records which ones did.

## Looks harmless, acts anyway

An agent asked only to observe a run must never mutate what it observes. Safe to run while
watching: `list`, `status`, `diagnose`, `validate`, `adapters`, and bare `mux`. The rest of the
surface reads as read-only and is not:

| Command | What it actually does |
|---|---|
| `mux set <name>` | Writes `policy.toml`. Bare `mux` (no subcommand) only reports the selected backend and is safe |
| `confirm <story-key>` | Completes the parked story by default. Only `confirm --list` observes |
| `decisions` | Answers a pending decision by default. Only `decisions --list` observes |
| `attach` | Joins a live session — any keystroke sent to it acts, including an accidental one |
| `probe-adapter --probe` | Launches a real turn of the coding CLI, not a dry check |
| `run`, `sweep`, `clean`, `cleanup` | Act on the run/ledger/filesystem unless called with `--dry-run` |
| `tui` | Not confirmed inert in every view. Treat it as not scriptable and avoid it in an observation-only task |
