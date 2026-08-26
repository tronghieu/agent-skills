---
name: bmad-run-inspector
description: >
  Inspect and explain bmad-loop run artifacts under `.bmad-loop/runs/`. Use for live health
  checks ("is it stuck?", "is the loop alive?", "what is the agent doing?") and post-run
  forensics ("what happened?", "why did story X fail?", "where did the tokens go?").
  Reconstruct terminal-redraw captures before interpreting them; naive tail/grep can produce
  fragments and false claims about test results. Also triggers on "monitor/check/summarize the
  loop", "why did the run pause?", Vietnamese "theo dõi bmad loop", "phân tích run", "đọc log
  của run", and equivalent requests in other languages. Use only for bmad-loop's own run
  artifacts, not application runtime logs or CI-provider build logs.
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
live TUI into a tmux or psmux pane; the capture records every repaint. (The `opencode-http`
adapter is the exception — it writes a real transcript instead; see
`references/log-forensics.md` before applying any of this to that adapter.) Consequences
that bite:

- Each logical line appears hundreds of times, growing character by character. `tail -50`
  returns fragments of a frame, not the last 50 things that happened.
- Whitespace is dropped unpredictably — `Done(10tooluses·99.2ktokens·1m0s)` is one real line.
- **Long tool output is collapsed into `… +N lines (ctrl+o to expand)` and never painted.**
  Those lines do not exist in the file.

The collapse is what decides your claims. Test summaries live inside collapsed blocks —
whatever line your test runner prints for pass/fail counts is exactly the long output the TUI
hides. On one measured 4.35 MB log, 58 collapse markers hid roughly 2,463 lines, largest block
484. So **never report that tests passed or failed based on the log.** Report which test
*commands* were launched; the verdict comes from "Deciding whether verify passed" below.

**The heuristics are stack-specific, and they fail quietly.** `scripts/extract_transcript.py`
is pattern-matched against one coding CLI's TUI vocabulary — its spinner frames, its `Done(N
tool uses · T tokens · Ns)` footer, its `… +N lines (ctrl+o to expand)` marker — and its
`results`/`errors` sections against one test runner's banner, one type checker's error codes,
one runtime's errno names. Change either axis and the classifier does not error; it degrades
silently, matching fewer patterns while still returning a result. An empty `--section errors`
or `--section results` on an unfamiliar CLI or stack is a miss, not good news.

So establish which CLI and which stack the repo runs before reading anything — the next section
is where that lives. `scripts/extract_transcript.py --collapsed` prints how much is hidden;
quote that number instead of hedging.

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

It writes skeletons, never overwrites, and prints every value still marked `TODO(confirm: …)`.
Those TODOs are the point: research each from a real file or a real `bmad-loop` command, then
show the user the drafted values and their sources before inspecting anything. An adapter of
plausible guesses is worse than no adapter — a wrong `coding_cli` makes the extractor match
nothing and hand back a result that reads clean. `references/adapter-bootstrap.md` sources each
field, including the ones no one can answer until a run exists.

When the adapter and a live run disagree, the run wins — and the disagreement is itself a
finding about the adapter. Report it; don't quietly override either one.

## Check the CLI before reading the disk

`bmad-loop` answers some questions faster and more reliably than parsing artifacts. `list`,
`status`, `diagnose`, `validate`, `adapters` and bare `mux` are safe on a live run — try them
first.

| Command | What it gives you |
|---|---|
| `list`, `status` | Run state, but only for `.bmad-loop/runs/`. An archived run is invisible to both and returns `no such run` — extract the tarball and read by hand, starting at `## Workflow` |
| `adapters` | Which coding-CLI adapter each profile selects, and the source of the adapter's `orchestrator.coding_cli`. Re-run it when an extraction comes back suspiciously empty |
| `validate` | Live host facts no run directory holds: multiplexer availability and version, whether the coding CLI is on PATH, hook registration and staleness, worktree cleanliness. Run it when a story fails for reasons that look environmental |

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
tail, ATTENTION metadata, any pending hard/graceful stop request, and a findings list. It
also writes `.probe-snapshot.json` into the run directory so the *next* probe can report
deltas — that delta is what separates "working" from "hung", and distinguishes a new
ATTENTION notice from an unchanged append-only file. No single reading can tell you.

Thresholds come from `state.json`'s `policy_snapshot`, never from memory — every project tunes
`max_dev_attempts` and `session_timeout_min` differently, so a remembered 2 becomes a false
alarm on the next repo.

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
describes only whether the CLI session ended normally, never whether the work was accepted: a
`completed` session can still be rejected, a `crashed` or `timeout` one still salvaged. It is
the tempting answer in a hurry — grepping it and stopping there is the mistake.

The actual verdict, in order:

1. **`dev-decision.action`** — one of `proceed, retry, defer, pause, salvage` — is the
   authoritative outcome for that attempt.
2. **Terminal journal kinds** — `story-done`, `story-deferred`, `story-escalated`,
   `story-awaiting-operator` — record where the story itself landed.
3. **`tasks.<story>.phase`** in `state.json` — the task's terminal phase should agree with
   whichever of the above fired.

A `finally` block writes `session-end` for every session, crashed ones included. So a launched
session with no `session-end` is itself a finding, not a gap to explain away. Silence anywhere
else carries no such guarantee: a journal with no failure entries proves only that nothing
reportable has happened yet.

A story can also land at `story-awaiting-operator` and stay there indefinitely — that is
terminal, not stuck, and clears only when a human runs `bmad-loop confirm <story-key>`. See
`references/anomaly-triage.md` for the full handling; don't improvise it here.

A story landing at `story-escalated` pauses the run, and its reason needs one extra step. The
escalation text is cut at 2000 characters with no marker, and `dev-decision.reason`,
`story-escalated.reason`, `run-paused.reason`, `state.json`'s `paused_reason` and the ATTENTION
notice all carry byte-identical copies of that cut — so corroborating them against each other
is circular and proves nothing. The uncut text is in the story spec's `## Auto Run Result`
section, named by `tasks.<story>.spec_file`. Reading only the truncated copies is how a real
blocker gets reported as a misclassification; `references/anomaly-triage.md` has the reading
order and the matching care about which remedy to offer.

**Watch the field names.** `session-end` carries `status`; `dev-decision` carries a
differently-named `session_status`; `rc` belongs to `plugin-hook` alone. The wrong key on the
wrong kind returns a plausible-looking wrong answer.

**Re-run the command yourself** if the user needs the actual failing assertions. The journal
gives the verdict, not the test output — run the verify command from
`policy_snapshot.verify.commands` directly and report that.

Two traps worth naming when you report:

- **`|| true` swallows failures.** Verify commands ending in `|| true` always exit 0. They are
  operator-authored, not shipped by bmad-loop; the adapter's `verify.non_fatal_steps` names a
  project's, derived from `policy_snapshot.verify.commands` — re-check there when they disagree.
  The failure is invisible, and the only symptom is downstream: a sprint backlog count that
  never moves although a story reached `done`.
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
  set, engine pid dead while unfinished, a new or unresolved `ATTENTION` notice, or the run
  concluding. The file's mere existence is not enough because it is append-only, and an
  escalation's text needs the extra step above before you explain the pause.
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
- Absence of a stated blocker is not evidence that there was no blocker. When a notice is
  truncated, say the text is partial and go to the uncut source before concluding anything.
- When a reading is ambiguous, say which extra command would settle it, and offer to run it.
- Never claim a story is done because the agent said it was done. Check the phase and the diff.
