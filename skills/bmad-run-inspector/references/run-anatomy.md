# Run Directory Anatomy

Every `bmad-loop` run writes to `.bmad-loop/runs/<run-id>/`. The run id is
`<YYYYMMDD>-<HHMMSS>-<ref>`; the four-character ref is the short handle
`bmad-loop list` prints. The run-scoped subcommands accept it — `status`, `resume`,
`resolve`, `attach`, `stop`, `diagnose`, `delete`, `archive` — but not every subcommand
does; see `anomaly-triage.md` for the ones that don't.

| Entry | Purpose | Presence |
|---|---|---|
| `state.json` | machine state — authoritative for everything structural | always |
| `journal.jsonl` | append-only event log — authoritative for what happened, when | always |
| `engine.pid` | the engine's pid, not the coding CLI's | while the engine runs |
| `logs/<task-id>.log` | per-session terminal capture (see `log-forensics.md`); the `opencode-http` adapter also writes `<task-id>.server.out` and a structured `<task-id>.sse.jsonl` trace instead of a redraw capture | one per tmux/psmux session |
| `tasks/<task-id>/` | per-session working dir (see below) | one per session |
| `.probe-snapshot.json` | this skill's own previous-probe snapshot, not written by `bmad-loop` | present after a `scripts/run_probe.py` run |
| `stop-request.json` | pending stop control: `mode` is `graceful` or `hard`; a legacy, malformed or unreadable present body is treated as graceful | while a request is waiting for the engine to consume it |
| `ATTENTION` | accumulated human-attention notices, plain text, append-only, `[YYYY-MM-DD HH:MM:SS] title: message`; existence does not mean the newest notice is still live | any `notify` call |
| `crash.txt` | unhandled-exception traceback | only on an uncaught crash |
| `feedback/<story>-<n>.md` | verify-failure text handed to the repair session | on a fixable retry |
| `deferred/<story>/<spec-name>` | preserved spec copy of a deferred story | on a deferral |
| `failed/<unit-key>/changes.patch` | diff of a discarded isolated unit's uncaptured changes | worktree isolation + teardown failure |
| `worktrees/` | isolation checkouts | `scm.isolation = "worktree"` only |
| `bundles/<dirname>/intent.md` | deferred-work bundle briefing for a dev session | sweep runs |
| `sweep.json` | sweep run options | sweep runs |
| `decisions.json` | sweep's pre-answered human decisions | sweep unattended flow |
| `migrate-manifest.json`, `migrate-result.json` | ledger-format migration artifacts | `sweep --migrate` |
| `sentinels/` | copies of pre-planning-halt sentinel specs | stories engine, sentinel hit |
| `events/` | legacy in-tree hook-event channel — receives nothing on a current install, see `events/` below | legacy |

The `resume` config-digest baseline is run-scoped but is not in the run dir; it lives
out of tree — see `events/` below.

Sibling directories under `.bmad-loop/`:

| Entry | What it is |
|---|---|
| `runs/` | live runs |
| `archive/` | concluded runs, `<run-id>.tar.gz` |
| `cache/` | plugins' rebuildable caches; gitignored |
| `policy.toml` | live policy; a run snapshots its own copy into `state.json`. Gitignored by default on fresh installs |
| `plugins/` | project-level engine plugins, highest precedence |
| `operator/<story-key>.json` | per-story park record — committed, rides the story's own commit |
| `operator-actions.json` | legacy pre-0.10 single-file park index; nothing writes it now, only read-and-prune |
| `bmad_loop_hook.py` | the hook relay script copied into the project |

`bmad-loop list` and `bmad-loop status` read only `runs/` — an archived run is invisible
to both, and asking either for one returns `no such run`. Post-mortem work on an archived
run means extracting the tarball and reading the artifacts by hand.

## state.json

The structural source of truth. Read it before anything else — it is small, exact, and
never lies about phase or attempt counts.

**Top-level failure flags.** These are the tier-1 signals; all default to `false`/`null`
on a healthy in-flight run:

| Key | Meaning when set |
|---|---|
| `finished` | The run completed its backlog and exited normally |
| `stopped` | Someone ran `bmad-loop stop`, or the engine was told to halt |
| `crashed` + `crash_error` | The orchestrator itself died; `crash_error` carries the traceback |
| `paused_reason` | Why the run is waiting for a human — the text to quote in a report |
| `paused_stage` | Which phase it paused in |
| `paused_story_key` | The story `bmad-loop resolve <run-id>` re-drives by default; pass `--story <key>` to override it |

**Run identity.** `run_id`, `run_type` (`story` or `sweep`), `started_at`, `current_epic`,
`epic_filter`, `story_filter`, `max_stories`, `source` (which backlog mode fed the run —
a choice made by the project's policy, not a default the tool picks for you), `target_branch`,
`sweep_cycle`, `sweeps_triggered`, `trusted_config_digest`, `project`, `spec_folder`,
`plugin_shared`.
`trusted_config_digest` is not new in 0.10.0 — the field predates the release. What
changed is that the authoritative config-digest baseline moved out of tree (see `events/`
below); this copy was demoted to a fallback, consulted only when the out-of-tree file is
missing.

**`tasks`** — a dict keyed by story key. This is the field people miss; it is not
`units` and not `stories`. Note the collision: this map is keyed by story key, while the
`tasks/` **directory** (below) is keyed by task-id — different things sharing a name.

| Field | Use |
|---|---|
| `story_key`, `epic` | identity |
| `phase` | `pending`, `dev-running`, `review-*`, `done`, … — see Phase values below |
| `attempt` | Dev attempts spent. Compare against `policy_snapshot.limits.max_dev_attempts` |
| `review_cycle` | Review rounds spent. Compare against `max_review_cycles` |
| `followup_reviews_spent` | Non-zero means review already needed a second pass |
| `baseline_commit` | The commit the run started from — diff against this for the real change set |
| `baseline_untracked` | Untracked files that already existed, so they are not blamed on the run |
| `baseline_ledger_digest` | Hash of the deferred-work ledger at start, used to detect harvest |
| `spec_file` | Path to the story's spec. For an escalated story this is primary evidence, not a cross-reference — see "The story spec" below |
| `commit_sha` | The commit the story landed on, once committed |
| `defer_reason` | Why a deferred story was deferred |
| `worktree_path`, `branch` | Where isolated work lives, under `scm.isolation = "worktree"` |
| `sentinel_kind` | Which pre-planning-halt sentinel the story hit, if any |
| `tokens` | Cumulative token spend recorded against the story |
| `token_budget_warned` | Once-per-run latch: the token-budget warning has already fired for this story, see `anomaly-triage.md` |
| `preserve_ref` | **New in 0.10.0.** The branch a defer preserved the story's work on |
| `operator_actions` | **New in 0.10.0.** The operator-actions list a parked story declared — see `.bmad-loop/operator/` above |

The rest are internal bookkeeping an inspector rarely reads directly: harvest/ledger
fields (`pre_harvest_ledger`, `harvest_wrote_ledger`, `harvested_deferrals`, …),
close-intent flags (`bundle_closes_intended`, `story_closes_intended`,
`board_advance_intended`, …), and defer/redrive internals (`rearmed`, `resolved_redrive`,
`restore_patch`, `dw_ids`, …).

**Phase enum, complete.** `pending, dev-running, dev-verify, review-running,
review-verify, committing, triage-running, triage-verify, done, deferred, escalated,
awaiting-operator`. `triage-running` and `triage-verify` are sweep-only.
`TERMINAL_PHASES = {done, deferred, escalated, awaiting-operator}`. `awaiting-operator`
is **new in 0.10.0** — see `.bmad-loop/operator/` above for the park record; see
`anomaly-triage.md` for how to respond to a parked story.

**`policy_snapshot`** — the policy as frozen at run start. Always read thresholds from
here rather than from `.bmad-loop/policy.toml`, because the live file may have been edited
after the run began. Sub-tables: `limits`, `verify`, `review`, `gates`, `scm`, `adapter`,
`stories`, `dev`, `notify`, `sweep`, `cleanup`, `plugins`, `tui`, `operator`, `mux`.
Two of those are load-bearing elsewhere in this skill: `log-forensics.md` sends the reader
to `[mux] backend` to identify the multiplexer, and `anomaly-triage.md` builds its whole
story-parking explanation on `policy.operator.enabled`.

The `limits` worth knowing: `max_dev_attempts`, `max_review_cycles`,
`max_followup_reviews`, `session_timeout_min`, `dev_stall_grace_s`, `dev_stall_nudges`,
`stop_without_result_nudges`, `max_tokens_per_story`, `max_tokens_per_session`,
`session_budget_mode`, `cache_read_weight`.

Two `scm` keys change how you advise the user: `isolation` (`none` means the run edits the
live checkout) and `rollback_on_failure` (`false` means a failed attempt is left in place).

## journal.jsonl

One JSON object per line, append-only, ordered. Every entry has `ts` (epoch float) and
`kind`; when an active log is set, entries also carry `log_task` and `log_pos`. This is
where you reconstruct *when* things happened.

There are well over 150 distinct kinds. The table below is a selection of the ones that
matter, not an inventory.

| Kind | Fields |
|---|---|
| `run-start` | `run_id, source, adapter_dev, adapter_review`; sweep form `run_id, run_type, trigger` |
| `plugins-active` | `plugins` |
| `plugin-hook` | `plugin, stage, rc[, blocking]` |
| `story-start` | `story_key` |
| `session-start` | `task_id, role, adapter, model, story_key, prompt` |
| `session-end` | `task_id, status, tokens, tokens_weighted`, plus applicable extras: `fired_at, teardown_s, expired_clock` / `budget_weighted, budget, budget_mode` / `env_fault, env_fault_evidence` / `session_vanished`. Abort form: `task_id, status="aborted", error` |
| `dev-decision` | `story_key, attempt, session_status, action, reason, env_fault, session_vanished`. On an escalation the `reason` is truncated — see below |
| `spec-deferrals-harvested` | `story_key, spec, dw_ids, deduped, malformed` |
| `story-escalated` | `story_key, reason` — the same truncated text, see below |
| `story-awaiting-operator` | `story_key, commit, actions` |
| `token-budget-exceeded` | `story_key, weighted, total, budget` |
| `run-paused` | `reason, stage, story_key` — the same truncated text, see below |
| `run-crash` | `error, message, epic` |
| `run-stop` | varies: `graceful, remaining` / `reason` / `pid, fallback` |

**Watch the field names.** `session-end` carries `status`; `dev-decision` carries
`session_status` — different keys on different kinds. `rc` belongs to `plugin-hook`,
not to either of them.

Treat any kind containing `error`, `crash`, `escalat`, `stall`, `fail`, `env_fault`,
`pause`, or `budget` as a finding to report.

**An escalation `reason` is truncated, silently.** bmad-loop builds the detail by parsing the
story spec's `## Auto Run Result` section, then cuts it at 2000 characters and appends no
marker. That one cut string is what reaches `dev-decision.reason`, `story-escalated.reason`,
`run-paused.reason`, `state.json`'s `paused_reason` and the ATTENTION notice alike — **no file
in the run directory holds the whole blocker.** The wrapper `CRITICAL escalation from dev
session: ` is added on top of the already-cut detail, so measure the detail rather than the
whole string. `anomaly-triage.md` has the reading order; "The story spec" below has the
uncut original.

Two readings that need care:

- A short journal is normal. Most of a run's activity happens inside one long dev session
  and produces no journal entries until it ends. Seven lines after an hour is healthy, not
  stalled — check the heartbeat and progress counter instead.
- Repeated `story-start` entries for the same `story_key` mean the story is being
  re-driven from the beginning, not progressing.

**Reading pass/fail.** `session-end.status` (`completed | stalled | timeout | crashed |
over_budget | aborted`) describes only how the CLI session ended — nothing about whether
the work was accepted. A `completed` session can still be rejected, and a `crashed` or
`timeout` session can still be salvaged. The authoritative outcome is
**`dev-decision.action`** (`proceed, retry, defer, pause, salvage`), together with the
terminal per-story kinds — `story-done`, `story-deferred`, `story-escalated`,
`story-awaiting-operator` — and the task's terminal `phase` in `state.json`.

**`log_pos` / `log_task`.** `log_pos` is the byte size of `logs/<log_task>.log`, stat'd at
the moment the journal entry is appended — not a marker inside the log. Whether it lands
before or after the event it describes depends on the call site (`session-start` is
appended before the session runs; `session-end` after it finishes). See
`log-forensics.md` for slicing a log by these offsets.

## tasks/&lt;task-id&gt;/

task-id = story key + phase + attempt, e.g. `story-key-example-dev-1`. The log
basename minus `.log` (`logs/<task-id>.log`) is exactly the task-id — that's how you join
a log to its task dir.

| File | Shape | Presence |
|---|---|---|
| `prompt.txt` | the launching prompt, raw text | always |
| `heartbeat.json` | `{ts, remaining_s, stall_armed, stall_nudges_sent}`, overwritten every 30s while the session waits | once the wait loop survives one tick; absent for a near-instant session |
| `session-lifecycle.jsonl` | one JSON object per line, `{ts, event, ...}` | usually present once a session has been torn down — see below |
| `resultless-stops.jsonl` | `{ts, verdict, detail}` per line | only on a Stop whose artifact read-back was empty |
| `result.json` | skill-defined dict | written by the driven skill, not by bmad-loop, which only deletes it at session start and reads it back |

**Whether `result.json` appears depends on which dev skill the project's policy wires up.**
Some skill contracts write it; others never do and the adapter instead synthesises the
result from the story spec's frontmatter. Check the project's `policy.toml` (or the
`policy_snapshot.dev.skill` key in `state.json` — `policy_snapshot.adapter` holds the
coding-CLI selection, not the skill) for the dev skill in play before treating
an absent `result.json` as evidence of anything — on its own, absence is not a fault.

`prompt.txt` holds the launching prompt (e.g. `/bmad-build-auto <story-key>`), which is
how you confirm the session is working on the story you think it is.

## tasks/&lt;task-id&gt;/heartbeat.json

Written by the engine while a session runs. Four fields:

| Field | Reading |
|---|---|
| `ts` | Epoch of the last write. Age over ~2 minutes suggests the engine stopped writing |
| `remaining_s` | Seconds left of `session_timeout_min`. Counts down from `session_timeout_min × 60` |
| `stall_armed` | `true` once the session has been idle past `dev_stall_grace_s` |
| `stall_nudges_sent` | How many wake-up nudges were sent; budget is `dev_stall_nudges` |

## tasks/&lt;task-id&gt;/session-lifecycle.jsonl

**There is no event marking a normal session end.** This file records teardown and guard
breadcrumbs, not a success/failure verdict. `kill-outcome` and `straggler-reap` are
ordinary — teardown emits `kill-outcome` whenever any process in the session's tree is
still alive at that point, which is the common case, not a red flag. Read the
`timeout-fired`, `budget-tripped`/`over-budget-fired`, and the contract-refusal events
(`frontmatter-unmodified-refused`, `readback-refused-no-proof-of-work`) as the findings.

| Event | Fields |
|---|---|
| `timeout-fired` | `expired_clock, timeout_s, mono_remaining_s` |
| `budget-tripped` | `weighted, budget, mode` |
| `over-budget-fired` | `weighted, budget, grace_s, zero_grace` |
| `kill-escalated` | `pids` |
| `kill-outcome` | wedged arm `alive, escalated`; clean arm `reaped, forced, unreaped` |
| `straggler-reap` | `pids` |
| `spec-status-transition-observed` | `spec, status` |
| `frontmatter-unmodified-refused` | `spec, status, dead_window` |
| `frontmatter-synthesized` | `spec, status, dead_window, transition` |
| `contract-nudge-sent` | `spec, status` |
| `readback-refused-no-proof-of-work` | `fallback, spec, status[, dead_window]` |
| `session-vanished` | `session, status` |
| `env-fault-classified` | `status, evidence` |

`kill-outcome` specifically means that session was reaped and its log will never grow
again.

## engine.pid

One line, no trailing newline. Check liveness with `os.kill(pid, 0)` or `ps -p`. A dead
pid with `finished`/`stopped` still `false` is tier 1: the orchestrator died without
recording an ending, and nothing will resume it on its own.

Note the file holds the *engine* pid, not the coding CLI's. The agent session lives in a
multiplexer session named `bmad-loop-<run-id>`; `bmad-loop attach` opens it regardless of
backend. For tmux specifically, `tmux ls` shows it. Run `bmad-loop mux` (bare, no
subcommand) to see which backend a run is on.

## events/

**Empty once the relay is current; a populated directory means a stale relay.** Hook
events moved out of the project tree.
The engine sets `BMAD_LOOP_EVENTS_DIR` for every session it launches, so
`runs/<run-id>/events/` receives nothing on any current install; it survives only so an
un-upgraded relay script — which falls back to the in-tree path when that variable is
absent — keeps working.

State-root resolution, first match wins:

1. `BMAD_LOOP_STATE_DIR` — used verbatim as the root, must be absolute.
2. POSIX: `$XDG_STATE_HOME/bmad-loop` if absolute, else `~/.local/state/bmad-loop`.
3. Windows: `%LOCALAPPDATA%\bmad-loop\state`, else the `%USERPROFILE%` equivalent.

Events for a run land at `<state-root>/<project-tag>/<run-id>/events`, where the project
tag is the first 16 hex chars of the sha256 of the resolved project path.

`bmad-loop validate` reports a stale relay as `hooks.relay-stale`; `bmad-loop relay
<Event>` is the current entry point.

## The story spec

The spec lives outside the run directory, and on an escalation it is the only artifact that
survives whole. `state.json`'s `tasks.<k>.spec_file` names it — use that path rather than
building one.

Where specs live is the project's decision, not bmad-loop's. The directory comes from
`implementation_artifacts` in `_bmad/bmm/config.yaml`, a required key with no bmad-loop
default, resolved against the project root. bmad-loop then globs `*.md` there and keeps files
that either carry a `## Auto Run Result` heading or whose names begin with
`bmad-build-auto-result-` or `bmad-dev-auto-result-`. A `spec-<story-key>.md` filename is one
project's convention, not a pattern bmad-loop enforces. Stories mode resolves specs on a
different key entirely — `policy_snapshot.stories.spec_folder`, empty by default, putting them
at `<spec-folder>/stories/<id>-*.md`.

`## Auto Run Result` is the section that matters. bmad-loop reads a `Status:` line out of it —
tolerating bullet and bold markup — and takes the whole trimmed body as the escalation detail,
which it then truncates. The body is free-form prose from the project's dev skill, and
bmad-loop parses no subheadings inside it, so what a blocker is called there varies by project.
Read the section through; do not grep for a heading name. For an escalated story this comes
before anything in the run directory — see `anomaly-triage.md`.

When no result body parses, the detail falls back to the literal `generic dev session reported
a blocked outcome`. Seeing exactly that string in `paused_reason` means the spec has nothing to
recover and the log tail is the only remaining source.

## What no file in here records

Be explicit about these when reporting, because their absence reads as absence of problems:

- Test pass/fail counts (see `log-forensics.md`).
- The result of verify commands ending in `|| true` — they always exit 0.
- Anything a subagent did internally; only its final `Done(…)` summary line reaches the log.
- The second half of a truncated escalation. Every copy in here is cut at the same 2000
  characters; only the story spec has it whole.
