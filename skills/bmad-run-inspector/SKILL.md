---
name: bmad-run-inspector
description: >
  Read and explain what a bmad-loop run actually did, from the artifacts it leaves in
  `.bmad-loop/runs/<run-id>/`. Use for both live watching (periodic health checks while a
  run is in flight, "is it stuck?", "should I be worried?") and after-the-fact forensics
  ("what did last night's run do?", "why did story X fail?", "where did the tokens go?").
  Reach for this before hand-rolling `tail`/`grep` over a run log — the log is a terminal
  redraw capture, not a transcript, and reading it naively produces shredded fragments and
  confident wrong answers about whether tests passed. Triggers on requests like "check the
  loop", "monitor the run", "is the loop still alive", "what is the agent doing right now",
  "summarize the run", "why did the run pause", "the loop stopped, what happened", or any
  question that would be answered by opening a run directory — in any language (e.g.
  Vietnamese "theo dõi bmad loop", "phân tích run", "đọc log của run", "run này làm gì";
  Spanish "qué pasó en la última ejecución"; Chinese "查看运行日志发生了什么"; Japanese
  "実行ログで何が起きたか確認して"; French "que s'est-il passé dans cette exécution").
  (This is for bmad-loop's own run artifacts under `.bmad-loop/runs/` — not for reading an
  application's runtime logs or a CI provider's build logs, which belong elsewhere.)
allowed-tools: Read Glob Grep Bash(python3 *) Bash(bmad-loop *) Bash(git *) Bash(ls *) Bash(ps *) Bash(wc *) Bash(tmux *) Bash(psmux *)
---

# BMAD Run Inspector

Verified against bmad-loop 0.10.0.

A `bmad-loop` run leaves a directory of evidence behind. This skill is about reading that
evidence honestly: saying what it proves, and refusing to say what it doesn't.

## The one thing to get right

**The `.log` file is a terminal redraw capture, not a transcript.** The coding CLI paints a
live TUI into a tmux or psmux pane; the capture records every repaint. (The `opencode-http`
adapter is the exception — it writes a real transcript instead; see
`references/log-forensics.md` before applying any of this to that adapter.) Consequences
that bite:

- Each logical line appears hundreds of times, growing character by character. `tail -50`
  returns fragments of a frame, not the last 50 things that happened.
- Whitespace is dropped unpredictably — `Done(10tooluses·99.2ktokens·1m0s)` is one real line.
- **Long tool output is collapsed into `… +N lines (ctrl+o to expand)` and never painted.**
  Those lines do not exist in the file.

That last point decides what you may claim. Test summaries live inside collapsed blocks —
whatever line your test runner prints for its pass/fail counts is exactly the kind of long
output the TUI hides. On one measured 4.35 MB log, 58 distinct collapse markers hid roughly
2,463 lines, the largest single block 484. So: **never report that tests passed or failed
based on the log.** You can report which test *commands* were launched; whether they passed is
inferred elsewhere (see "Deciding whether verify passed").

**The heuristics are stack-specific, and they fail quietly.** The spinner frames, the `Done(N
tool uses · T tokens · Ns)` footer and the `… +N lines (ctrl+o to expand)` collapse marker are
one coding CLI's TUI vocabulary, and `scripts/extract_transcript.py` is pattern-matched
against it. That script's `results` and `errors` sections are separately matched against one
test runner's banner, one type checker's error codes and one runtime's errno names. Drive a
different coding CLI through bmad-loop, or run a different test stack under it, and the
classifier does not error on either axis — it degrades silently, matching fewer or none of a
section's patterns while still returning a result. A clean `--section errors` or `--section
results` on an unfamiliar CLI or test stack is not evidence of a clean run; an empty section
is a miss, not good news.

Which CLI and which stack a given repo actually runs is therefore the first thing to
establish, and it is not something this skill can know in advance — the next section is where
that lives.

Run `scripts/extract_transcript.py --collapsed` to show exactly how much is hidden. Quoting
that number is a good way to make the limitation concrete for the user instead of hedging.

## Know the project before you read it

This skill ships generic. Everything that varies between repositories lives in a project
adapter at `_project/bmad-loop/`. Read it before the first inspection; bootstrap it when it
isn't there.

| File | Holds |
|---|---|
| `_project/bmad-loop/environment.toml` | the values: which coding CLI, which test runner and type checker, which multiplexer, whether the dev skill writes `result.json`, which verify steps are non-fatal, what feeds the backlog |
| `_project/bmad-loop/environment.md` | the knowledge: a dated current-state snapshot, which of the extractor's constants match here and which don't, and the judgment calls a bare value can't carry |

When `environment.toml` is missing:

```bash
python3 <skill>/scripts/bootstrap_adapter.py --repo-root /path/to/repo
```

It writes the skeletons, never overwrites an existing file, and prints every value still
marked `TODO(confirm: …)`. Those TODOs are the point of the scaffold: research each from a
real file or a real `bmad-loop` command, then put the drafted values and where each came from
to the user before running a real inspection. An adapter filled with plausible guesses is
worse than no adapter — a wrong `coding_cli` makes the extractor match nothing and hand back a
result that reads clean. `references/adapter-bootstrap.md` has the field-by-field sourcing
table, including which fields simply cannot be answered until a run exists.

When the adapter and a live run disagree, the run wins — and the disagreement is itself a
finding about the adapter. Report it; don't quietly override either one.

## Check the CLI before reading the disk

`bmad-loop` itself answers some questions faster and more reliably than parsing artifacts.
`list`, `status`, `diagnose`, `validate`, `adapters`, and bare `mux` are safe to run while
observing a live run — try these first.

`list` and `status` see only `.bmad-loop/runs/`; a run already moved to
`.bmad-loop/archive/*.tar.gz` is invisible to both and gets you `no such run`. Post-mortem
work on an archived run therefore has no CLI shortcut — extract it and read the artifacts by
hand, starting with the `## Workflow` steps below.

`bmad-loop adapters` names which coding-CLI adapter each profile selects — it is where the
adapter's `orchestrator.coding_cli` comes from, and worth re-running when an extraction looks
suspiciously empty. `bmad-loop validate`
reports live host facts a run directory can't: multiplexer availability and version, whether
the coding CLI's binary is on PATH, hook registration and staleness, git worktree
cleanliness — worth running when a story fails for reasons that look environmental.

**Never mutate what you're observing.** Several commands read as harmless and aren't: `mux
set` writes `policy.toml`; `confirm` and `decisions` act on their target unless called with
`--list`; `attach` joins a live session where any keystroke acts; `probe-adapter --probe`
launches a real CLI turn; `run`, `sweep`, `clean`, and `cleanup` act unless given
`--dry-run`; `tui` isn't confirmed inert in every view, so treat it as not scriptable. Full
table: `references/anomaly-triage.md`.

## Workflow

Both modes — live watch and post-hoc forensics — use the same three steps. The difference
is only which questions you lead with.

### 1. Probe the state

```bash
python3 <skill>/scripts/run_probe.py --project /path/to/repo
```

Prints health flags, per-task phase/attempt/review_cycle, heartbeats, log sizes, journal
tail, and a findings list. It also writes `.probe-snapshot.json` into the run directory so
the *next* probe can report deltas — that delta is what separates "working" from "hung", and
no single reading can tell you.

Thresholds come from `state.json`'s `policy_snapshot`, not from hardcoded numbers. Every
project tunes `max_dev_attempts` and `session_timeout_min` differently; a hardcoded 2 turns
into a false alarm on the next repo. Where the policy key is absent, the probe falls back to
`max_dev_attempts or 2` and `max_review_cycles or 3` — bmad-loop's own shipped defaults, not
a hardcoded guess.

For a live watch, run this on an interval and compare against the previous probe. For
forensics on a finished run, one probe is enough — go straight to the flags.

### 2. Reconstruct the narrative

```bash
python3 <skill>/scripts/extract_transcript.py --section tools      # what it did, in order
python3 <skill>/scripts/extract_transcript.py --section subagents  # cost per delegated task
python3 <skill>/scripts/extract_transcript.py --collapsed          # how much is unreadable
```

The script strips escapes and rebuilds each logical line by keeping the longest variant
seen. Sections: `tools`, `subagents`, `errors`, `results`, `prose`, `progress`.

`progress` reports the CLI's own elapsed/token counter (`50m 20s · ↓151.7k tokens` — Claude
Code's format; a different coding CLI prints this differently or not at all) for the
orchestrating session. A log that grows while this counter stands still is worth
investigating — but it is not proof of a hang, because a session that delegates hands its
footer to the subagents and stops painting its own counter. Check the `prose` and `results`
tails for named subagent lines before calling a stall; `references/log-forensics.md` has the
decision table.

### 3. Cross-check against the working tree

The log says what the agent *tried*. Git says what actually landed. Read
`tasks.<story>.baseline_commit` from `state.json`, then:

```bash
git status --short
git diff --stat <baseline_commit>
```

This is where you catch the difference between an agent that wrote code and an agent that
narrated writing code. It also catches partial work: five locale files touched but the
sixth missed, a service added with no test beside it.

When `scm.isolation` is `none`, that diff is sitting in the user's live checkout. Say so —
if the run fails, those changes stay there, and `rollback_on_failure = false` means nothing
cleans them up.

## Deciding whether verify passed

Since the log can't tell you, read `journal.jsonl` — it is authoritative and structured. Do
not reach for `session-end.status` as the verdict; it looks like one and isn't.

**`session-end.status`** (`completed | stalled | timeout | crashed | over_budget | aborted`)
describes only whether the CLI session ended normally. It says nothing about whether the work
was accepted: a `completed` session can still be rejected, and a `crashed` or `timeout`
session can still be salvaged. This is the tempting wrong answer when you're in a hurry —
resist grepping it and stopping there.

The actual verdict, in order:

1. **`dev-decision.action`** — one of `proceed, retry, defer, pause, salvage` — is the
   authoritative outcome for that attempt.
2. **Terminal journal kinds** — `story-done`, `story-deferred`, `story-escalated`,
   `story-awaiting-operator` — record where the story itself landed.
3. **`tasks.<story>.phase`** in `state.json` — the task's terminal phase should agree with
   whichever of the above fired.

`session-end` is written for every session, including crashed ones — a `finally` block
guarantees it. So if a session you know was launched has no `session-end`, that absence is
itself a finding, not a gap to explain away.

Silence anywhere else carries no such guarantee. A journal with no failure entries is not
proof of success; it is proof that nothing reportable has happened yet.

A story can also land at `story-awaiting-operator` and stay there indefinitely — that is
terminal, not stuck, and clears only when a human runs `bmad-loop confirm <story-key>`. See
`references/anomaly-triage.md` for the full handling; don't improvise it here.

**Watch the field names** — the easiest way to read this wrong: `session-end` carries
`status`; `dev-decision` carries a differently-named `session_status`. `rc` belongs to
`plugin-hook` alone. Grepping the wrong key on the wrong kind gets you a plausible-looking
wrong answer.

**Re-run the command yourself** if the user needs the actual failing assertions — the journal
gives you the verdict, not the test output. Run the verify command from
`policy_snapshot.verify.commands` directly and report that.

Two traps worth naming when you report:

- **`|| true` swallows failures.** Verify commands ending in `|| true` always exit 0 — these
  are operator-authored, not shipped by bmad-loop. The adapter's `verify.non_fatal_steps`
  names the ones a given project made non-fatal; `policy_snapshot.verify.commands` is where
  that list is derived from and what to re-check when they disagree. Their failure is
  invisible; the only symptom is downstream — a sprint backlog count that never moves even though a story reached `done`.
- **Verify runs twice per story and discards output on timeout.** A verify step with no
  output did not necessarily skip; it may have timed out and thrown the evidence away.

## Reporting

Lead with the state, then the analysis, then the recommendation. For a live watch where
nothing is wrong, one or two lines is the whole report — the user asked to be told when
something is wrong, and a wall of green text trains them to stop reading.

When something is wrong, the shape that works:

```
<current state: story, phase, attempt, elapsed>
<what changed since last check>
<the finding, and the evidence for it>
<what to do — the exact command>
```

Anomalies fall into three tiers; `references/anomaly-triage.md` has the full table with the
policy key behind each threshold and the recommended action.

- **Tier 1 — needs a human now.** `crashed`, `crash_error`, `paused_reason`/`paused_stage`
  set, engine pid dead while unfinished, an `ATTENTION` file, or the run concluding.
- **Tier 2 — about to fail.** `attempt` at the policy max, `review_cycle` not converging,
  `stall_armed` or nudges sent, stale heartbeat, session budget nearly gone while still in dev.
- **Tier 3 — silent rot.** The ones nothing else catches: log growing while the progress
  counter is frozen, identical tool calls repeating across checks, deferred-work ledger
  swelling while `sweep.auto = "never"`, backlog stuck despite stories completing.

Tier 3 is the reason this skill exists. Tiers 1 and 2 are visible in `bmad-loop tui`; tier 3
is only visible if someone reads the artifacts and compares them over time.

## Reference material

Read these when the question goes past the workflow above:

| File | Read it when |
|---|---|
| `references/run-anatomy.md` | You need the exact key that answers a question — which file, which field, what its values mean |
| `references/log-forensics.md` | The reconstruction is losing something, or you need to recover data the default sections drop |
| `references/anomaly-triage.md` | You have a finding and need the threshold's source and the right remedy |
| `references/adapter-bootstrap.md` | `_project/bmad-loop/` is missing or incomplete, and you need where each field's value legitimately comes from |

## Honesty rules

These exist because the failure mode of this task is a confident, wrong, reassuring report.

- Distinguish "I read this" from "I inferred this". The user acts on the difference.
- Absence of error lines is not evidence of success — especially here, where the error
  lines are structurally absent from the capture.
- When a reading is ambiguous, say which extra command would settle it, and offer to run it.
- Never claim a story is done because the agent said it was done. Check the phase and the diff.
