# Log Forensics — Reading a Terminal Redraw Capture

`logs/<task-id>.log` is the largest artifact a run produces, at multiple megabytes per hour. It
is also the most misleading. Understanding how it is written tells you what can be recovered.

## How the file is produced

`bmad-loop` launches the coding CLI inside a tmux pane and captures the pane. The CLI draws
a live interface there: a spinner, a scrolling body, a status footer. Every repaint is
appended to the file, escape sequences and all.

So the file is a **video of a screen**, serialized. It is not a log in the sense of one
append per event.

This holds for the tmux and psmux backends. Check which one you have before assuming it. Run
`bmad-loop mux` to see the registered and selected backend, or read the `[mux] backend` key in
your `.bmad-loop/policy.toml`.

The `opencode-http` adapter is different. It writes a curated role-prefixed `<task-id>.log`,
plus `<task-id>.server.out`, plus a structured SSE trace at `<task-id>.sse.jsonl`. Those are an
actual transcript, not a redraw capture. Everything below assumes a pane capture and does not
apply to that adapter.

Four consequences:

1. **Massive duplication.** A single line is written on every frame it is visible in, each
   time slightly longer as it is typed out. One real line can appear hundreds of times.
2. **Cursor-movement escapes interleave with text.** Grep matches land in the middle of
   escape sequences and return unreadable spans.
3. **Whitespace is unreliable.** Redraws optimize by repositioning the cursor rather than
   emitting spaces, so words run together: `Done(10tooluses·99.2ktokens·1m0s)`,
   `⏺Bash(find.-name*.log-mtime-1|xargsgrep-lERROR)`. Any regex over this text must tolerate
   zero-or-more whitespace at every gap.
4. **Truncated frames.** A pane has a fixed width. Long lines are cut at the edge, and the
   remainder may never appear.

## The reconstruction

`<skill>/scripts/extract_transcript.py` does this:

1. Strip ANSI/OSC escapes and normalize `\r` to `\n`.
2. Bucket lines by a whitespace-free 28-character prefix.
3. Keep the **longest** line in each bucket, preserving first-seen order.

Step 3 is the trick. Redraws are progressive, so every partial version is a prefix of the
finished line. The longest variant in a bucket is therefore the completed one.

One known imperfection: the same logical line can land in two buckets when its prefix differs
between frames. A result line often appears both as `⎿ Done(…)` and as a bare `Done(…)`. The
script de-duplicates subagent entries by normalized content for this reason. If you add a new
extracted category and see near-duplicates, apply the same treatment. Do not widen the bucket
key, because that merges genuinely distinct lines.

## Slicing the log by journal offset

`journal.jsonl` entries carry `log_task` and `log_pos` whenever an active log is set. `log_pos`
is the byte size of `logs/<log_task>.log`, stat'd at the moment the journal entry is appended.
It is not a marker paired with the event it describes.

Two consecutive entries sharing the same `log_task` therefore bracket a byte range of that
session's log. Read only that slice instead of the whole capture.

This is imprecise. Whether an offset lands before or after the event it describes depends on the
call site. `session-start` is appended before the session runs, so its offset is effectively the
start. `session-end` is appended after it finished, so its offset is the final size. Neither
pins one mid-session action exactly. `session-lifecycle.jsonl` entries carry neither field, so
this correlation exists only on the journal.

`--tail-bytes` (below) reads only the tail of a log. It is a cruder version of the same idea and
does not use `log_pos`. Slicing by journal offset is the targeted one. Bracket the phase you
want first, then read that range.

### When the log tail is the last surviving copy

Everything above says the capture cannot be trusted, which reads as *do not go there*. One case
is the exception.

bmad-loop cuts an escalation's `reason` at 2000 characters, and every copy in the run directory
carries that same cut. If the story spec has no `## Auto Run Result` section, the blocker exists
nowhere else. The last painted frame of that session's log is the only remaining copy. The tell
is a detail reading exactly `generic dev session reported a blocked outcome`, which is
bmad-loop's fallback when it found no result body to parse.

Bracket the dev session's byte range with `log_task` and `log_pos`, reconstruct the tail, and
quote it. Then label it for what it is: text recovered from a redraw capture, not a transcript.
A reconstructed tail reported as reconstructed beats repeating a truncated notice as though it
were whole. In `anomaly-triage.md` this is step 4. It comes after the spec, not instead of it.

## What is NOT in the file

**Collapsed tool output.** The CLI shows long results as `… +N lines (ctrl+o to expand)`. The
hidden lines are never painted, so they never enter the capture.

Two runs, measured. One hour-long run's log of 4.35 MB gave a deduped count of 58 markers
hiding roughly 2,463 lines, largest single block 484. A second run's log gave 23 markers and
roughly 884 lines, largest 104. These are evidence of scale. Do not expect these figures on
your own run.

`--collapsed` prints two figures and both matter. The gap between them comes from the same
mechanic as "Massive duplication" above: the pane repaints a collapsed block on every redraw,
so an unfiltered scan counts one block once per repaint. The first log's unfiltered count was
78 markers and 4,079 lines, against 58 and 2,463 deduped. The second's was 27 and 1,093,
against 23 and 884. Dedup keys on the marker text plus the line painted right before it, so
repeats of one block collapse to a single entry.

Treat the deduped figure as an estimate, not a measurement. Without timestamps, a genuinely
repeated command is indistinguishable from a repaint of one block, so the count can go either
way. Quote it as an estimate when you report it.

This is where test summaries live. That same run executed a unit-test suite, an end-to-end
suite, a type checker and a linter. The raw log contained **zero** matches for every one of
these: `Test Files`, `N passed`, `N failed`, `FAIL`, `error TS####`, `AssertionError`.

Zero failures found, and zero passes found. The correct conclusion is *the log does not contain
test results*. It is not *the tests passed*. Reporting the second one is the most damaging
mistake available in this task. It tells the user their story is green when nothing checked.

Run `--collapsed` on your own run before you report anything about test results. The figures
above prove the failure mode is real and large. They are not a baseline your run should
reproduce.

## What IS reliably recoverable

The categories below are matched by pattern, not detected structurally. The patterns were built
against two things at once.

First, one specific coding CLI's terminal UI: its spinner vocabulary, its `⏺` tool-call glyph,
its `ctrl+o to expand` collapse marker. Run `bmad-loop adapters` to see which coding-CLI adapter
your profile selects.

Second, one test stack's output shape. `RESULTS` hardcodes `Test Files`, `Tests `, `Duration`,
`RUN v`. `FAILISH` hardcodes `error TS\d+`, `ECONNREFUSED`, `ENOENT`.

Change either one and none of these strings match. Lines land in the wrong bucket or vanish. A
query like `--section errors` or `--section results` then comes back clean because nothing
matched it. That reads as good news and is actually a miss.

So when an extracted section looks implausibly thin, open the raw log by hand before you trust
it. Check what your CLI actually prints for a spinner and for a collapsed block. Check what your
test runner actually prints for a summary line. Then adjust the matching constants in
`extract_transcript.py` to fit.

| Section | Content | Why it survives |
|---|---|---|
| `tools` | `⏺ Bash(…)`, `⏺ Write(…)`, `⏺ Agent(…)` — the actions taken, in order | The invocation line is painted before output collapses |
| `subagents` | `Done(N tool uses · Xk tokens · Ym Zs)` per delegated task | Painted as a summary line |
| `progress` | `50m 20s · ↓151.7k tokens` from the spinner footer | Repainted constantly |
| `results` | Streaming output that arrives line-by-line — a test runner's list reporter, `RUN v4.1.9` (Vitest's own banner shape, not a generic reporter line) | Streamed to the pane before any collapse decision |
| `prose` | The agent's own narration between tool calls | Painted as body text |

The `progress` counter is the CLI's own elapsed-time and token counter for the **orchestrating
session**. Comparing it across two probes catches a state a byte count cannot: the pane
repainting a static frame while nothing advances.

It has one loud false positive and you will hit it. **When the session delegates to subagents,
the footer switches to the subagents' progress and stops painting the parent's own counter.**
A frozen parent counter then sits alongside a log growing by hundreds of kilobytes. That reads
exactly like a hang. It is in fact the busiest the run ever gets.

So treat a frozen counter as a prompt to look closer, never as a verdict.

| Parent counter | Log growing | New `prose`/`results` lines | Reading |
|---|---|---|---|
| advancing | yes | yes | working normally |
| frozen | yes | yes, subagent names and `N tool uses · Xk tokens` | delegating, healthy |
| frozen | yes | no, the same frame repeating | genuinely stuck |
| frozen | no | no | hung, confirm with the heartbeat |

Read the `prose` and `results` tails before you call a stall. Subagent activity shows up there
as named lines such as `Edge case hunter review · 3 tool uses · 80.3k tokens`, even while the
parent footer sits still.

One measured sighting: a parent frozen at `59m 34s · ↓180.5k tokens` across two probes while
the log grew 199 KB. Three review agents were running. The parent then planned thirteen patches
from their findings.

## Cost accounting

Sum the `subagents` section for delegated spend. Read the last `progress` entry for the
orchestrating session's own spend. The footer covers one context only.

On one measured run, a story showing `212.0k tokens` in the footer had actually spent **~1.1M**
once its eight subagents were counted. That ratio is illustrative, not a multiplier to apply.
Sum your own run's `subagents` section before quoting a token figure.

This matters because the footer figure is not what governs the story's token budget. See
`./anomaly-triage.md` for how that budget behaves. Give the user the summed figure, not the
footer figure.

## Practical recipes

```bash
# What has it done, in order?
python3 <skill>/scripts/extract_transcript.py --section tools

# Where did the time and tokens go?
python3 <skill>/scripts/extract_transcript.py --section subagents

# Is it actually advancing? (compare across two probes)
python3 <skill>/scripts/extract_transcript.py --section progress --limit 3

# How much of the story can't I read?
python3 <skill>/scripts/extract_transcript.py --collapsed

# Only the recent past, on a multi-megabyte log
python3 <skill>/scripts/extract_transcript.py --tail-bytes 400000 --section tools
```

`--tail-bytes` is a speed lever on large files. It costs completeness. A bucket's longest
variant may sit outside the window, so lines can come back truncated. Prefer a full read unless
the file is large enough to be slow. Say which one you used when a result looks odd.
