---
name: bmad-run-inspector
description: >-
  Inspect and explain bmad-loop run artifacts under `.bmad-loop/runs/`. Use for
  live health checks ("is it stuck?", "is the loop alive?", "what is the agent
  doing?") and post-run forensics ("what happened?", "why did story X fail?",
  "where did the tokens go?"). Also triggers on "monitor/check/summarize the
  loop", "why did the run pause?", Vietnamese "theo dõi bmad loop", "phân tích
  run", "đọc log của run", and equivalent requests in other languages. Use only
  for bmad-loop's own run artifacts, not application runtime logs or CI-provider
  build logs.
allowed-tools: Read Glob Grep Bash(python3 *) Bash(bmad-loop *) Bash(git *) Bash(ls *) Bash(ps *) Bash(wc *) Bash(tmux *) Bash(psmux *)
---

# BMAD Run Inspector

Verified against [bmad-loop 0.11.1](https://github.com/bmad-code-org/bmad-loop/releases/tag/v0.11.1).
The bundled scripts run on Python 3.9+. `bmad-loop` itself needs 3.11+, but it often lives in
an isolated environment while the host's `python3` is still stock macOS 3.9.

A run leaves a directory of evidence. This skill is about reading it honestly: saying what it
proves, and refusing to say what it doesn't.

## The one thing to get right

**The `.log` file is a terminal redraw capture, not a transcript.** The coding CLI paints a
live TUI into a tmux or psmux pane. The capture records every repaint.

One adapter differs. `opencode-http` writes a real transcript instead. Read
`references/log-forensics.md` before applying any of this to it.

Three consequences:

- Each logical line appears hundreds of times, growing character by character. `tail -50`
  returns fragments of one frame, not the last 50 things that happened.
- Whitespace is dropped unpredictably. `Done(10tooluses·99.2ktokens·1m0s)` is one real line.
- **Long tool output is collapsed into `… +N lines (ctrl+o to expand)` and never painted.**
  Those lines do not exist in the file.

The third one decides what you may claim. Test summaries sit inside collapsed blocks. Your test
runner's pass/fail line is long output, so the TUI hides it. One measured 4.35 MB log had 58
collapse markers hiding roughly 2,463 lines. Its largest single block was 484 lines.

So **never report that tests passed or failed based on the log.** Report which test *commands*
ran. The verdict comes from "Deciding whether verify passed" below.

**The heuristics are stack-specific. They fail quietly.** `scripts/extract_transcript.py`
matches one coding CLI's TUI vocabulary: its spinner frames, its `Done(N tool uses · T tokens ·
Ns)` footer, its `… +N lines (ctrl+o to expand)` marker. Its `results` and `errors` sections
match one test runner's banner, one type checker's error codes, one runtime's errno names.

Change the CLI or change the test stack and the script does not error. It matches fewer
patterns and still returns a result. An empty `--section errors` or `--section results` on an
unfamiliar CLI or stack is a miss, not good news.

So establish which CLI and which stack the repo runs before you read anything. The next section
covers that. Run `scripts/extract_transcript.py --collapsed` to print how much is hidden, then
quote that number instead of hedging.

## Know the project before you read it

This skill ships generic. Everything that varies between repositories lives in a project
adapter at `_project/bmad-loop/`. Read it before the first inspection. Bootstrap it when it is
not there.

| File | Holds |
|---|---|
| `_project/bmad-loop/environment.toml` | the values: which coding CLI, which test runner and type checker, which multiplexer, whether the dev skill writes `result.json`, which verify steps are non-fatal, what feeds the backlog |
| `_project/bmad-loop/environment.md` | the knowledge: a dated current-state snapshot, which of the extractor's constants match here and which don't, and the judgment calls a bare value can't carry |

When `environment.toml` is missing:

```bash
python3 <skill>/scripts/bootstrap_adapter.py --repo-root /path/to/repo
```

It writes skeletons, never overwrites, and prints every value still marked `TODO(confirm: …)`.
Those TODOs are the point. Research each one from a real file or a real `bmad-loop` command.
Then show the user the drafted values and where each came from, before you inspect anything.

An adapter of plausible guesses is worse than no adapter. A wrong `coding_cli` makes the
extractor match nothing and return a result that reads clean.
`references/adapter-bootstrap.md` sources each field, including the ones no one can answer
until a run exists.

When the adapter and a live run disagree, the run wins. The disagreement is itself a finding
about the adapter. Report it. Do not quietly override either one.

## Check the CLI before reading the disk

`bmad-loop` answers some questions faster and more reliably than parsing artifacts. `list`,
`status`, `diagnose`, `validate`, `adapters` and bare `mux` are safe on a live run. Try them
first.

| Command | What it gives you |
|---|---|
| `list`, `status` | Run state, but only for `.bmad-loop/runs/`. An archived run is invisible to both and returns `no such run`. Extract the tarball and read the artifacts by hand, starting at `## Workflow` |
| `adapters` | Which coding-CLI adapter each profile selects. This is where the adapter's `orchestrator.coding_cli` comes from. Re-run it when an extraction comes back suspiciously empty |
| `validate` | Live host facts no run directory holds: multiplexer availability and version, whether the coding CLI is on PATH, hook registration and staleness, worktree cleanliness. Run it when a story fails for reasons that look environmental |

**Never mutate what you are observing.** These commands read as harmless and are not:

- `mux set` writes `policy.toml`.
- `confirm` and `decisions` act on their target unless called with `--list`.
- `attach` joins a live session. Any keystroke sent to it acts.
- `probe-adapter --probe` launches a real CLI turn.
- `run`, `sweep`, `clean` and `cleanup` act unless given `--dry-run`.
- `tui` is not confirmed inert in every view. Treat it as not scriptable.

`references/anomaly-triage.md` has the full table.

## Workflow

Live watch and post-hoc forensics use the same three steps. Only the leading question differs.

### 1. Probe the state

```bash
python3 <skill>/scripts/run_probe.py --project /path/to/repo
```

Prints health flags, per-task phase/attempt/review_cycle, heartbeats, log sizes, journal tail,
ATTENTION metadata, any pending hard or graceful stop request, and a findings list.

It also writes `.probe-snapshot.json` into the run directory. The next probe reads that file
and reports what changed. The delta is what separates "working" from "hung". It also separates
a new ATTENTION notice from an unchanged append-only file. One reading alone answers neither.

Read thresholds from `state.json`'s `policy_snapshot`, never from memory. Every project tunes
`max_dev_attempts` and `session_timeout_min` differently. A remembered 2 becomes a false alarm
on the next repo.

For a live watch, run this on an interval and compare against the previous probe. For forensics
on a finished run, one probe is enough. Go straight to the flags.

### 2. Reconstruct the narrative

```bash
python3 <skill>/scripts/extract_transcript.py --section tools      # what it did, in order
python3 <skill>/scripts/extract_transcript.py --section subagents  # cost per delegated task
python3 <skill>/scripts/extract_transcript.py --collapsed          # how much is unreadable
```

The script strips escapes and rebuilds each logical line by keeping the longest variant
seen. Sections: `tools`, `subagents`, `errors`, `results`, `prose`, `progress`.

`progress` reports the orchestrating session's own elapsed/token counter. Claude Code prints it
as `50m 20s · ↓151.7k tokens`. Another coding CLI prints it differently, or not at all.

A log that grows while this counter stands still is worth investigating. It is not proof of a
hang. A session that delegates hands its footer to the subagents and stops painting its own
counter. So check the `prose` and `results` tails for named subagent lines before you call a
stall. `references/log-forensics.md` has the decision table.

### 3. Cross-check against the working tree

The log says what the agent *tried*. Git says what actually landed. Read
`tasks.<story>.baseline_commit` from `state.json`, then:

```bash
git status --short
git diff --stat <baseline_commit>
```

This is where you catch the difference between an agent that wrote code and an agent that
narrated writing code. It also catches partial work: five locale files touched and the sixth
missed, a service added with no test beside it.

When `scm.isolation` is `none`, that diff sits in the user's live checkout. Say so. If the run
fails, those changes stay there, and `rollback_on_failure = false` means nothing cleans them
up.

## Deciding whether verify passed

The log cannot tell you. Read `journal.jsonl` instead. It is authoritative and structured.

Do not use `session-end.status` as the verdict. It looks like one and is not.
`session-end.status` is one of `completed | stalled | timeout | crashed | over_budget |
aborted`, and it describes only whether the CLI session ended normally. It never says whether
the work was accepted. A `completed` session can still be rejected. A `crashed` or `timeout`
session can still be salvaged. Grepping this field and stopping there is the mistake.

Read the actual verdict in this order:

1. **`dev-decision.action`** is the authoritative outcome for that attempt. One of `proceed,
   retry, defer, pause, salvage`.
2. **The terminal journal kind** records where the story landed: `story-done`,
   `story-deferred`, `story-escalated`, `story-awaiting-operator`.
3. **`tasks.<story>.phase`** in `state.json` should agree with whichever of the above fired.

A `finally` block writes `session-end` for every session, crashed ones included. So a launched
session with no `session-end` is itself a finding, not a gap to explain away. Silence anywhere
else carries no such guarantee: a journal with no failure entries proves only that nothing
reportable has happened yet.

A story can land at `story-awaiting-operator` and stay there indefinitely. That is terminal,
not stuck. It clears only when a human runs `bmad-loop confirm <story-key>`. Read
`references/anomaly-triage.md` for the full handling. Do not improvise it here.

A story landing at `story-escalated` pauses the run. Its reason needs one extra step, because
bmad-loop cuts the escalation text at 2000 characters and appends no marker. Five places carry
byte-identical copies of that same cut: `dev-decision.reason`, `story-escalated.reason`,
`run-paused.reason`, `state.json`'s `paused_reason`, and the ATTENTION notice. Corroborating
them against each other is circular. It proves nothing.

The uncut text is in the story spec's `## Auto Run Result` section. `tasks.<story>.spec_file`
names the file. Reading only the truncated copies is how a real blocker gets reported as a
misclassification. `references/anomaly-triage.md` has the reading order and the matching care
about which remedy to offer.

**Watch the field names.** `session-end` carries `status`. `dev-decision` carries a
differently-named `session_status`. `rc` belongs to `plugin-hook` alone. The wrong key on the
wrong kind returns a plausible-looking wrong answer.

**Re-run the command yourself** if the user needs the actual failing assertions. The journal
gives the verdict, not the test output. Run the verify command from
`policy_snapshot.verify.commands` directly and report that.

Name these two traps when you report:

- **`|| true` swallows failures.** A verify command ending in `|| true` always exits 0. These
  are operator-authored, not shipped by bmad-loop. The adapter's `verify.non_fatal_steps` names
  the ones a given project made non-fatal, derived from `policy_snapshot.verify.commands`.
  Re-check there when the two disagree. The failure itself is invisible. The only symptom is
  downstream: a sprint backlog count that never moves although a story reached `done`.
- **Verify runs twice per story and discards output on timeout.** A verify step with no output
  did not necessarily skip. It may have timed out and thrown the evidence away.

## Reporting

Lead with the state, then the analysis, then the recommendation. On a live watch where nothing
is wrong, one or two lines is the whole report. The user asked to be told when something is
wrong. A wall of green text trains them to stop reading.

When something is wrong, use this shape:

```
<current state: story, phase, attempt, elapsed>
<what changed since last check>
<the finding, and the evidence for it>
<what to do — the exact command>
```

Anomalies fall into three tiers. `references/anomaly-triage.md` has the full table, the policy
key behind each threshold, and the remedy.

- **Tier 1, needs a human now.** `crashed` or `crash_error` set. `paused_reason` or
  `paused_stage` set. Engine pid dead while the run is unfinished. A new or unresolved
  `ATTENTION` notice. The run concluding. An ATTENTION file's existence alone is not enough,
  because the file is append-only. An escalation needs the extra step above before you explain
  the pause.
- **Tier 2, about to fail.** `attempt` at the policy max. `review_cycle` not converging.
  `stall_armed` set or nudges sent. Stale heartbeat. Session budget nearly gone while still in
  dev.
- **Tier 3, silent rot.** The ones nothing else catches. Log growing while the progress counter
  is frozen. Identical tool calls repeating across checks. Deferred-work ledger swelling while
  `sweep.auto = "never"`. Backlog stuck despite stories completing.

Tier 3 is the reason this skill exists. `bmad-loop tui` already shows tiers 1 and 2. Tier 3 is
visible only to someone who reads the artifacts and compares them over time.

## Reference material

Read these when the question goes past the workflow above:

| File | Read it when |
|---|---|
| `references/run-anatomy.md` | You need the exact key that answers a question: which file, which field, what its values mean |
| `references/log-forensics.md` | The reconstruction is losing something, or you need data the default sections drop |
| `references/anomaly-triage.md` | You have a finding and need the threshold's source and the right remedy |
| `references/adapter-bootstrap.md` | `_project/bmad-loop/` is missing or incomplete, and you need where each field's value legitimately comes from |

## Honesty rules

These exist because the failure mode of this task is a confident, wrong, reassuring report.

- Distinguish "I read this" from "I inferred this". The user acts on the difference.
- Absence of error lines is not evidence of success. That holds double here, because the error
  lines are structurally absent from the capture.
- Absence of a stated blocker is not evidence that there was no blocker. When a notice is
  truncated, say the text is partial. Go to the uncut source before concluding anything.
- When a reading is ambiguous, name the extra command that would settle it, and offer to run it.
- Never claim a story is done because the agent said it was done. Check the phase and the diff.
