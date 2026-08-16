# Log Forensics — Reading a Terminal Redraw Capture

`logs/<task-id>.log` is the largest artifact a run produces — multiple megabytes per hour —
and the most misleading. Understanding how it is written tells you what can be recovered.

## How the file is produced

`bmad-loop` launches the coding CLI inside a tmux pane and captures the pane. The CLI draws
a live interface there: a spinner, a scrolling body, a status footer. Every repaint is
appended to the file, escape sequences and all.

So the file is a **video of a screen**, serialized. It is not a log in the sense of one
append per event.

This holds for the tmux and psmux backends. Check which one you have before assuming it: run
`bmad-loop mux` to see the registered and selected backend, or read the `[mux] backend` key in
your `.bmad-loop/policy.toml`. The `opencode-http` adapter is different: it writes a curated
role-prefixed `<task-id>.log` plus `<task-id>.server.out` and a structured SSE trace at
`<task-id>.sse.jsonl` — an actual transcript, not a redraw capture. Everything below assumes a
pane capture; on that adapter it does not apply.

Four consequences:

1. **Massive duplication.** A single line is written on every frame it is visible in, each
   time slightly longer as it is typed out. One real line can appear hundreds of times.
2. **Cursor-movement escapes interleave with text.** Grep matches land in the middle of
   escape sequences and return unreadable spans.
3. **Whitespace is unreliable.** Redraws optimize by repositioning the cursor rather than
   emitting spaces, so words run together: `Done(10tooluses·99.2ktokens·1m0s)`,
   `⏺Bash(find.-name*.log-mtime-1|xargsgrep-lERROR)`. Any regex over this text must
   tolerate zero-or-more whitespace at every gap.
4. **Truncated frames.** A pane is a fixed width; long lines are cut at the edge, and the
   remainder may never appear.

## The reconstruction

`<skill>/scripts/extract_transcript.py` does this:

1. Strip ANSI/OSC escapes and normalize `\r` to `\n`.
2. Bucket lines by a whitespace-free 28-character prefix.
3. Keep the **longest** line in each bucket, preserving first-seen order.

Step 3 is the trick. Because redraws are progressive, every partial version is a prefix of
the finished line, so the longest variant in a bucket is the completed one.

Known imperfection: the same logical line can land in two buckets when its prefix differs
between frames — typically a result line appearing both as `⎿ Done(…)` and bare `Done(…)`.
The script de-duplicates subagent entries by normalized content for this reason. If you add
a new extracted category and see near-duplicates, apply the same treatment rather than
widening the bucket key, which would merge genuinely distinct lines.

## Slicing the log by journal offset

`journal.jsonl` entries carry `log_task` and `log_pos` whenever an active log is set. `log_pos`
is the byte size of `logs/<log_task>.log`, stat'd at the moment the journal entry is appended —
not a marker paired with the event it describes. Two consecutive entries sharing the same
`log_task` therefore bracket a byte range of that session's log: read only that slice instead
of the whole capture.

This is imprecise, not exact. Whether an offset lands before or after the event it describes
depends on the call site: `session-start` is appended before the session runs, so its offset is
effectively the start; `session-end` after it finished, so its offset is the final size. It will
not pin one mid-session action exactly. `session-lifecycle.jsonl` entries carry neither field —
this correlation exists only on the journal.

`--tail-bytes` (below) reads only the tail of a log and is a cruder version of the same idea; it
does not read or use `log_pos`. Slicing by journal offset is the targeted one — bracket the
phase you want first, then read that range.

## What is NOT in the file

**Collapsed tool output.** The CLI shows long results as `… +N lines (ctrl+o to expand)`.
The hidden lines are never painted, so they never enter the capture. On one measured
hour-long run this hid ~2,000 lines across ~50 markers, with a single block reaching 237
lines — evidence of scale, not a figure to expect on yours.

This is where test summaries live. On that same run — a unit-test suite, an end-to-end
suite, a type checker, and a linter, all executed — the raw log contained **zero** matches
for every one of: `Test Files`, `N passed`, `N failed`, `FAIL`, `error TS####`,
`AssertionError`.

Zero failures found and zero passes found. The correct conclusion is *the log does not
contain test results* — not *the tests passed*. Reporting the latter is the single most
damaging mistake available in this task, because it tells the user their story is green
when nothing checked.

`--collapsed` prints the marker count and hidden-line estimate for your own run. Run it
before you report anything about test results — the figures above are proof the failure
mode is real and large, not a baseline your run should reproduce.

## What IS reliably recoverable

The categories below are matched by pattern, not detected structurally, and the patterns
were built against two things at once: one specific coding CLI's terminal UI — its spinner
vocabulary, its `⏺` tool-call glyph, its `ctrl+o to expand` collapse marker — and one test
stack's output shape — `RESULTS` hardcodes `Test Files`, `Tests `, `Duration`, `RUN v`;
`FAILISH` hardcodes `error TS\d+`, `ECONNREFUSED`, `ENOENT`. Run `bmad-loop adapters` to see
which coding-CLI adapter your profile selects. If `bmad-loop` is driving a different coding
CLI, or the story runs a different test stack (pytest, `go test`, JUnit), none of these
strings match: lines land in the wrong bucket or vanish outright, and a query like
`--section errors` or `--section results` comes back clean because nothing matched it —
which reads as good news and is actually a miss. If an extracted section looks implausibly
thin, before trusting it, open the raw log by hand and check what your CLI actually prints
for a spinner and for a collapsed block, and what your test runner actually prints for a
summary line, then adjust the matching constants in `extract_transcript.py` to fit.

| Section | Content | Why it survives |
|---|---|---|
| `tools` | `⏺ Bash(…)`, `⏺ Write(…)`, `⏺ Agent(…)` — the actions taken, in order | The invocation line is painted before output collapses |
| `subagents` | `Done(N tool uses · Xk tokens · Ym Zs)` per delegated task | Painted as a summary line |
| `progress` | `50m 20s · ↓151.7k tokens` from the spinner footer | Repainted constantly |
| `results` | Streaming output that arrives line-by-line — a test runner's list reporter, `RUN v4.1.9` (Vitest's own banner shape, not a generic reporter line) | Streamed to the pane before any collapse decision |
| `prose` | The agent's own narration between tool calls | Painted as body text |

The `progress` counter is the CLI's own elapsed-time and token counter for the
**orchestrating session**. Comparing it across two probes catches a state a byte count
cannot: the pane repainting a static frame while nothing advances.

It has one loud false positive, and you will hit it. **When the session delegates to
subagents, the footer switches to showing the subagents' progress, and the parent's own
counter stops being painted.** A frozen parent counter then coexists with a log growing by
hundreds of kilobytes — which reads exactly like a hang, and is in fact the busiest the run
ever gets.

So a frozen counter is a prompt to look closer, never a verdict:

| Parent counter | Log growing | New `prose`/`results` lines | Reading |
|---|---|---|---|
| advancing | yes | yes | working normally |
| frozen | yes | yes — subagent names, `N tool uses · Xk tokens` | delegating; healthy |
| frozen | yes | no — same frame repeating | genuinely stuck |
| frozen | no | no | hung; confirm with the heartbeat |

Before calling a stall, read the `prose` and `results` tails. Subagent activity shows up
there as named lines (`Edge case hunter review · 3 tool uses · 80.3k tokens`) even while the
parent footer sits still. One measured sighting: a parent frozen at `59m 34s · ↓180.5k tokens`
across two probes while the log grew 199 KB — three review agents were running, and the
parent went on to plan thirteen patches from their findings.

## Cost accounting

Sum the `subagents` section for delegated spend, and read the last `progress` entry for the
orchestrating session's own spend. On one measured run, a story that showed `151.7k tokens`
in the footer had actually spent **~1.1M** once its eight subagents were counted — the footer
covers one context only. The ratio here is illustrative, not a multiplier to apply; sum your
own run's `subagents` section before quoting a token figure.

This matters: the footer figure is not what governs the story's token budget. See
`./anomaly-triage.md` for how that budget actually behaves. Give the user the summed figure
rather than the footer figure.

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

`--tail-bytes` is a speed lever on large files. It costs completeness: a bucket's longest
variant may sit outside the window, so lines can come back truncated. Prefer a full read
unless the file is large enough to be slow, and say which one you used when a result looks
odd.
