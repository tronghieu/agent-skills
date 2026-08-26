# Anomaly Triage

Three tiers, ordered by how quickly a human needs to act. Every threshold traces to a key in
`state.json`'s `policy_snapshot`.

The numbers quoted below are one project's settings, not defaults of this skill. Before you act
on any of them, read the actual value from your own run's `policy_snapshot`.

## Tier 1 — a human is needed now

| Finding | Evidence | Remedy |
|---|---|---|
| Engine crashed | `crashed: true`, `crash_error` non-null | Report the traceback. `bmad-loop diagnose` produces a sanitized dump for maintainers |
| Run paused | `paused_reason` / `paused_stage` non-null. On an escalation the reason text is truncated. Read "Reading an escalation" below before you explain the pause | `bmad-loop resolve <run-id>` for a CRITICAL escalation. It re-drives `paused_story_key` by default; pass `--story <key>` only to override that. Use `bmad-loop resume <run-id>` when the block is already cleared |
| Engine died silently | `engine.pid` not alive while `finished` and `stopped` are both false | Nothing will resume it. Choose between `bmad-loop resume <run-id>` and a fresh run. Check the working tree first if `scm.isolation = "none"` |
| Attention raised | A new or unresolved notice in `ATTENTION`. File existence alone is not enough | Read the whole file, then corroborate the newest notice as described below. Governed by `notify.file` |
| Run concluded | `finished: true` or `stopped: true` | Not a fault. It is the moment a summary is owed: stories completed, backlog remaining, working-tree state |
| Story parked for an operator | `tasks.<k>.phase = "awaiting-operator"` | `bmad-loop confirm <story-key>` (`--list`, `--json`, `--yes`, `--reverify`) |

A gate can also hold a run. `gates.mode = "per-epic"` pauses at each epic boundary for
approval. It surfaces as a pause with a gate-shaped reason. That is approval, not debugging.

### Reading an ATTENTION file

`ATTENTION` is append-only. Once the first notice is written, the file stays present for the
rest of the run. So existence alone cannot remain a Tier 1 signal.

Read it as a sequence of timestamped blocks, oldest first. A line matching
`[YYYY-MM-DD HH:MM:SS] title: message` starts a block. Unprefixed lines below it continue that
block.

1. Read the whole file, then start with the newest block. Compare its timestamp against the
   prior probe and against later settling journal events: `story-done`, `story-deferred`,
   `run-resume`, `run-stop`, `run-complete`. A notice superseded by one of those is historical,
   not a live Tier 1 finding. Same-second ordering is ambiguous, because ATTENTION timestamps
   have no fractions. Keep the notice live until another source settles it.
2. Check whether the newest block is complete. A missing final newline is direct evidence of a
   partial append. A newline does **not** prove completeness. Repeated blocks ending at the
   same mid-word, or an abruptly cut sentence, are also truncation clues. Report partial
   evidence explicitly, then recover the rest from the right place. For an ordinary notice,
   `journal.jsonl`, `state.json` and the task artifacts hold the outcome. **For an escalation
   they do not.** They carry byte-identical copies of the same cut, and repeated mid-word
   endings are the signature of exactly that. Go to "Reading an escalation" below.
3. Treat the title and severity label as classifier output over free text, not as a verdict.
   Cross-check `dev-decision.action`, the terminal `story-*` event, the task phase, and the
   project's findings or ledger artifacts. Do not repeat `CRITICAL` merely because the notice
   says it.
4. Check the project adapter. With `dev.writes_result_json = false`, bmad-loop has no
   structured `result.json` channel for that dev session, so it may classify synthesized prose
   instead. A severity mismatch is then more plausible, not more authoritative.

`scripts/run_probe.py` records each ATTENTION file's size, notice count, newest timestamp and
newline state in `.probe-snapshot.json`. It reports a changed block as `new since last probe`.
It keeps an unsuperseded block as `unresolved`. It demotes a block followed by a settling
journal event to historical context. This metadata narrows the reading. It never replaces
reading the notice itself.

### Reading an escalation

A CRITICAL escalation pauses the run. bmad-loop builds the escalation detail by parsing the
story spec, cuts it at 2000 characters, and appends no marker.

Five places carry byte-identical copies of that same cut: `dev-decision.reason`,
`story-escalated.reason`, `run-paused.reason`, `state.json`'s `paused_reason`, and the
ATTENTION notice. This is also what produces the mid-word endings a notice shows. It is one
truncation seen from five files, not five truncations. So corroborating them against each other
proves nothing.

**No file in the run directory holds the whole blocker.** The dropped half is the actionable
one. It usually holds the blocking condition and the command an operator needs.

1. **Treat the notice as an index entry, not as evidence.** Its severity label is a
   classifier's guess. Its body may be cut. Neither supports a conclusion.
2. **Establish the cut before reading further.** `scripts/run_probe.py` measures it and raises
   its own Tier 1 finding, so a probe usually answers this for you. Without a probe, the
   eye-level tell is text stopping mid-word or mid-sentence. To confirm by hand, strip the
   `CRITICAL escalation from dev session: ` prefix and measure the detail. Exactly 2000
   characters is the cap, not a coincidence. Measure each detail separately, because several
   escalations join with `; `. Report the text as partial either way.
3. **Read the story spec's `## Auto Run Result` section.** This is the untruncated original.
   For an escalated story it is the primary source: complete and structured, where the notice
   is capped and the log is a redraw capture. `state.json`'s `tasks.<k>.spec_file` names the
   file. `run-anatomy.md` covers how the path resolves. The project's own dev skill writes the
   prose inside that section, so read the section through. Do not grep for a subheading it may
   not use.
4. **If the spec has no `## Auto Run Result` section, reconstruct the log tail.** The tell is a
   detail reading exactly `generic dev session reported a blocked outcome`. That is bmad-loop's
   fallback when it found no result body to parse, which means the spec holds nothing to
   recover. Bracket the session's byte range with `log_task` and `log_pos` per
   `log-forensics.md`. Report it as a reconstruction from a redraw capture. Quote it rather
   than paraphrasing.
5. **Only then say why the run paused.** Quote the blocker. Do not summarize it. A report
   calling the escalation spurious without having reached step 3 or 4 is not a finding.

Give the remedy the same care as the finding. `bmad-loop resolve` re-drives the story. If the
blocker is still in place, the next session hits it again: the pre-commit hook still refuses,
the service is still down. So lead with whatever clears the block. The spec's result section
often names the exact command. Quote that instead of offering the generic `resolve`. Use
`resolve` when the block is genuinely cleared, or when the escalation really was spurious, and
say which of the two you concluded.

**Do not read a cleared pause as a settled escalation.** `resume` and `resolve` both clear
`paused_reason`, `paused_stage` and `paused_story_key`. Only `resolve` re-arms the story. The
two therefore look identical in `state.json`'s pause fields, and they are not. After a plain
`resume`, the task sits at `phase: escalated` forever. That phase is terminal, so nothing left
in the run will pick the story back up. It is the parked-story trap, one phase over. A task at
`escalated` on a run that is not paused is that trap, and `scripts/run_probe.py` reports it as
Tier 3.

This is also why a post-mortem cannot lead with `paused_reason`. On a resumed run that field is
already gone. `journal.jsonl` keeps `story-escalated.reason` and `run-paused.reason` forever,
because it is append-only and bmad-loop has no compaction path. For a finished or resumed run,
start from the journal and take the same five steps above.

Absence of a stated blocker in `ATTENTION` is not evidence that there was no blocker. It is the
same mistake as reading an empty `--section errors` as a clean run.

A story parks when three things hold: `policy.operator.enabled` is set (sprint mode only), the
dev session's spec frontmatter reads `status: awaiting-operator`, and it declares a non-empty
`operator_actions:` list. The story then skips review, takes the normal verify-and-commit path,
and journals `story-awaiting-operator`.

The park record lands at `.bmad-loop/operator/<story-key>.json` with `story_key, actions,
spec_file, run_id, parked_at`. **It carries no `commit` field, because it is written into the
very commit that carries it.** Recover that commit from `git log` over the record's own path.

**The parked task's phase stays `awaiting-operator` forever. The run will not pick it back up.**
Waiting for the run to advance the story is a mistake. Only a human running `bmad-loop confirm
<story-key>` clears the park.

## Tier 2 — failing soon

| Finding | Evidence | Why it matters |
|---|---|---|
| Last dev attempt | `tasks.<k>.attempt >= limits.max_dev_attempts` | The next failure ends the story. With `max_dev_attempts = 2`, seeing `2` means one chance left |
| Review not converging | `tasks.<k>.review_cycle` approaching `limits.max_review_cycles` | Repeated review rounds mean the agent cannot satisfy the findings, not that it is being careful |
| Follow-up review spent | `followup_reviews_spent > 0` | Budget from `max_followup_reviews` is being consumed |
| Session went idle | `heartbeat.stall_armed: true`, or `stall_nudges_sent > 0` | The session ended a turn without a result and sat past `dev_stall_grace_s`. Nudges are capped by `dev_stall_nudges` |
| Heartbeat stale | `age_s` beyond ~2× the write interval | The engine may have stopped writing even though the pid lives |
| Budget nearly gone | `remaining_s < 600` while phase is still `dev-*` | `session_timeout_min` is about to end the session mid-implementation, before verify and review have run at all |
| Session budget warned | `session-lifecycle.jsonl` has `budget-tripped` (`weighted, budget, mode`), plus an ATTENTION notice | `session_budget_mode = "warn"`, the default, tripped `max_tokens_per_session`. The session keeps running to its natural end. A degradation signal with no consequence yet |
| Session killed for budget | `session-lifecycle.jsonl` has `over-budget-fired` (`weighted, budget, grace_s, zero_grace`); `session-end.status = "over_budget"` | `session_budget_mode = "enforce"` ran out the `session_budget_grace_s` window and killed the session. This already consumed a dev attempt through the ordinary retry/defer decision. It is not just a warning |
| Journal failure entries | `kind` matching error/crash/escalat/stall/fail/env_fault/pause/budget | Each is a recorded event with a timestamp. Quote it |

Two unrelated things share the name "environment fault."

`dev-decision.env_fault` is set only when the **verify command** exits 126 or 127 on POSIX,
the shell's "found but not executable" and "not found" convention. Windows adds a
signature-based arm. Every other verify breakage is recorded as an ordinary failure and
consumes a dev attempt: a stopped database, an unreachable port, a missing service. So when a
story fails on the first attempt, check the environment before you blame the agent.

`session-end.env_fault` comes from a different mechanism. After any non-completed session,
bmad-loop regex-scans the last 64 KiB of that session's log against the adapter profile's
`env_fault_patterns`. The default pattern tuple is empty, so this path is inert unless a
profile configures it. Its silence is not evidence the session was healthy. It usually means
nobody wired the patterns.

## Tier 3 — silent rot

These produce no flag, no journal entry, and nothing in the TUI. You find them only by comparing
artifacts across time. That is why a probe writes a snapshot.

| Finding | How to detect | What it means |
|---|---|---|
| Hung session | Log size unchanged **and** task state unchanged across two probes | The agent is not producing output at all |
| Repainting, not working | Log grows, `progress` counter frozen, **and** no new `prose`/`results` lines | The pane is redrawing a static frame. Confirm the third condition first. A session running subagents also freezes its own counter while working hard |
| Tool-call loop | The last several `tools` entries are near-identical to the previous probe's | The agent is retrying the same thing rather than advancing |
| Runaway output | Log grew by more than a few MB in one interval | Usually a command dumping enormous output, or a loop |
| Story re-driven | Multiple `story-start` entries for one `story_key` in the journal | Work restarted from the beginning |
| Silent verify failure | Backlog count unchanged although a story reached `done` | A verify command ending in `\|\| true` failed without failing the run. Check `policy_snapshot.verify.commands` for which steps this project made non-fatal |
| Session budget guard disabled | No `budget-tripped` or `over-budget-fired` ever appears, despite a heavy-spend session | The adapter has no mid-session usage signal to sample, so `session_budget_mode` (`warn` or `enforce`) is inert regardless of setting. Absence of the event is not evidence the session stayed under budget |
| Story resumed past, not resolved | `tasks.<k>.phase = "escalated"` while `paused_reason` is null | A plain `bmad-loop resume` clears the pause without re-arming the story. The phase is terminal, so nothing re-drives it. See "Reading an escalation" |
| Debt accumulating | `deferred-work.md` growing while `sweep.auto = "never"` | Nothing triages the ledger until someone runs `bmad-loop sweep` |
| Working tree drifting | `git status --short` count climbing under `scm.isolation = "none"` | The run edits the live checkout. With `rollback_on_failure = false`, a failed attempt leaves it dirty and pauses |

## Thresholds that lie

Three settings read like guardrails and are not. Say so plainly. Do not reassure a user with
them.

- **`max_tokens_per_story` enforces nothing. It warns once.** The counter resets per run,
  because it lives in that run's `state.json`, so a new run starts every story at zero. The
  first time a story's cumulative weighted spend crosses the cap, bmad-loop journals
  `token-budget-exceeded` (`story_key, weighted, total, budget`) and raises an ATTENTION
  notice. `tasks.<k>.token_budget_warned` latches it, so it fires exactly once per run. The
  story keeps running past the warning. Real cost control means watching the summed subagent
  spend.
- **`|| true` on a verify command guarantees exit 0.** Anything after `||` in
  `policy_snapshot.verify.commands` cannot fail the run. So a green verify says nothing about
  those steps.
- **Verify runs twice per story and discards its output on timeout.** A verify step with no
  output may have run and timed out. Absent output is not absent execution.

## Session token budget

`limits.max_tokens_per_session` (default 4,000,000) is a mid-session guard. bmad-loop samples it
every heartbeat tick. `limits.session_budget_mode` governs what happens:

- `off`: no sampling.
- `warn` (the default): one `budget-tripped` lifecycle event (`weighted, budget, mode`) and one
  ATTENTION notice. The session runs to its natural end. Same non-enforcement as
  `max_tokens_per_story` above.
- `enforce`: the same trip, then a wrap-up nudge, then a `session_budget_grace_s` window
  (default 240s). If the session has not finished by then, bmad-loop kills it with status
  `over_budget` and logs `over-budget-fired` (`weighted, budget, grace_s, zero_grace`). That
  ending rides the ordinary retry/defer decision like any other. It already consumed a dev
  attempt. It is not merely a warning.

The guard is inert on any adapter with no mid-session usage signal to sample, whatever the mode.
No event ever fires. That silence is not evidence the session stayed under budget. It means the
guard never ran.

## Suggesting a remedy

Give one command, not a menu. The useful ones:

| Situation | Command |
|---|---|
| Paused on an escalation | `bmad-loop resolve <run-id>`. Interactive: a human answers. It re-drives `paused_story_key` by default; pass `--story <key>` to override |
| Paused, block already cleared | `bmad-loop resume <run-id>` |
| Story parked for an operator | `bmad-loop confirm <story-key>`. It clears the park. It does not re-drive the story |
| Need to watch the agent live | `bmad-loop attach`, then the multiplexer's detach chord (`Ctrl-b d` for tmux). Never `Ctrl-c`. That kills the session |
| Need to stop everything | `bmad-loop stop <run-id>` |
| Handing a fault to maintainers | `bmad-loop diagnose`. Produces a sanitized dump |
| Ledger has grown untriaged | `bmad-loop sweep` |
| Story failed and the environment is suspect | `bmad-loop validate`. Reports host facts no run directory contains: multiplexer availability and version, whether the coding CLI's binary is on PATH, hook registration and staleness, git worktree cleanliness |

When advising on a dirty working tree under `isolation = "none"`, do not propose a blanket
clean. The run's own recovery is deliberately conservative. Untracked files in the tree may
also predate the run, and `tasks.<k>.baseline_untracked` records which ones did.

## Looks harmless, acts anyway

An agent asked only to observe a run must never mutate what it observes. These are safe to run
while watching: `list`, `status`, `diagnose`, `validate`, `adapters`, and bare `mux`. The rest
of the surface reads as read-only and is not.

| Command | What it actually does |
|---|---|
| `mux set <name>` | Writes `policy.toml`. Bare `mux` (no subcommand) only reports the selected backend and is safe |
| `confirm <story-key>` | Completes the parked story by default. Only `confirm --list` observes |
| `decisions` | Answers a pending decision by default. Only `decisions --list` observes |
| `attach` | Joins a live session. Any keystroke sent to it acts, including an accidental one |
| `probe-adapter --probe` | Launches a real turn of the coding CLI, not a dry check |
| `run`, `sweep`, `clean`, `cleanup` | Act on the run/ledger/filesystem unless called with `--dry-run` |
| `tui` | Not confirmed inert in every view. Treat it as not scriptable and avoid it in an observation-only task |
