# The assumption log

`assumptions.md` in the workspace is where the skill's anti-fabrication
discipline becomes a working artifact instead of a vibe. Every
load-bearing `[assumed]` link from any phase lands here, gets a
confidence level and a validation plan, and gets *updated when reality
answers* — in either direction.

## What earns an entry

**Load-bearing assumptions only**: if this turned out wrong, the
diagnosis, the chosen solution, or the plan would change. The user's
opening hunch about the cause, an unverified link in the cause tree
holding up the leading candidate, a decision-matrix score marked
`unknown — assumption`, a plan step that presumes a resource exists.

Not every utterance. A log stuffed with trivial maybes buries the three
assumptions that actually carry the building — curation is part of the
honesty.

## Entry format

```markdown
### A2 — Custom cakes take ~50 min prep, not the 30 the schedule assumes
- Entered: Diagnose (five-whys, capacity branch)
- Source: facilitator hypothesis, user found it plausible
- Confidence: medium (0.55)
- Impact if wrong: capacity diagnosis collapses; solutions targeting
  prep scheduling address nothing
- Cheapest check: time the next 5 custom-cake preps
- Status: open — check scheduled for this weekend
```

After a check, append the outcome as a `Result` line *under the
existing entry* — never create a second block with the same ID, and
never overwrite the original assessment. One entry per assumption, with
its history stacked inside it; the trail is part of the value:

```markdown
- Result (2026-07-21): 5 preps timed — 42–65 min, median 52.
  Confidence: medium (0.55) → very high (0.95). Link in
  diagnosis.md promoted to [verified — timed sample].
```

## Confidence bands

Use words with numbers behind them, so "probably" means the same thing
next week:

| Band | Range | Reads as |
|---|---|---|
| very high | 0.90–1.00 | would be surprised if wrong |
| high | 0.75–0.89 | solid, one confirmation from done |
| medium | 0.50–0.74 | plausible either way — the danger zone |
| low | 0.25–0.49 | doubtful, kept only because impact-if-true is big |
| very low | 0.00–0.24 | effectively dead; keep for the record |

The danger zone note is deliberate: *medium* assumptions feel safe to
build on and aren't. They're exactly the ones whose cheapest check
should run before Solve.

## Lifecycle

Identify → assess (confidence + impact-if-wrong) → validate (cheapest
check, scheduled) → update (new confidence, propagate to the cause
tree's labels). Assumptions the user decides not to check become
**accepted risks** — explicitly, in the log, never silently.

**Downward revision is a win.** An entry moving 0.70 → 0.10 after a
check means the discipline just prevented a solution built on sand —
say so out loud when it happens. From the running example: *"A1 —
courier service degraded (user's opening belief, 0.70): handoff-time
stamps show transit unchanged since spring. 0.70 → 0.10. That's the
best money this session didn't spend — a second courier contract was
the parked solution."*

## Pitfalls that corrupt logs

- **Confirmation bias** — designing checks that can only confirm.
  Antidote: every check is phrased as *what would disprove this* (the
  verification-test rule from diagnosis.md).
- **Anchoring** — the first stated cause (usually the user's opening
  hunch) gravitationally pulls every confidence after it. Antidote: log
  the hunch immediately *as* an assumption; the act of labeling breaks
  the anchor.
- **Availability** — vivid recent events feel causal ("we got a bad
  review that week"). Antidote: the Is/Is-Not time boundary — does the
  vivid event actually line up with onset?
- **Planning fallacy** — plan-phase assumptions ("the pilot takes a
  weekend") skew optimistic. Antidote: impact-if-wrong plus a pivot
  trigger, not a better guess.
