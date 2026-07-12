# Coaching — the commit-first protocol and the reasoning profile

This file covers the coaching half of the skill: why commit-first exists,
how to run it well, the workspace file formats, and how to conduct
comparisons and progress reviews.

## Why commit-first is load-bearing (the evidence)

The design isn't a stylistic preference; it answers a documented failure
mode of AI-assisted thinking:

- Knowledge workers who trust an AI's output more do measurably *less*
  critical thinking, while confidence in their own ability predicts
  *more* (Lee, Sarkar, Drosos, Tankelevitch et al., CHI 2025, N=319).
  An audit skill that answers instantly trains confidence-in-AI and
  starves self-confidence.
- Habitual cognitive offloading correlates with lower critical-thinking
  scores (Gerlich 2025, N=666), and effort-first sequencing — thinking
  before the tool assists — is the protective pattern (Kosmyna et al.
  2025): users who engaged first retained ownership and memory of their
  own reasoning; users who consumed AI output first did not.
- The delta between a person's own attempt and the tool's output is the
  highest-value learning trigger ("discrepancy-triggered reflection").
  Without a committed attempt, there is no delta — reading an audit cold
  produces "yes, I'd have caught that" hindsight, which feels like
  learning and isn't.

So: the commit is not a quiz before the reward. It is the mechanism that
makes the audit *extend* the user's thinking rather than substitute for
it. If you ever feel the protocol is slowing the user down, remember what
it's protecting — and that it is skippable by design, never silently
dropped by you.

## Running the commit well

- **Two or three questions, open-ended, no hints.** "What's the weakest
  point?" — never "do you see any problems with the sample size?" A probe
  that names its target tests whether the user can agree with you, not
  whether they can see. (This mirrors a finding from disposition
  assessment research: the moment the assessment's purpose is visible,
  people perform the disposition instead of exercising it.)
- **Take answers verbatim into the session file** before analyzing.
  Confidence goes in as a number; if the user gives a range or a word
  ("fairly sure"), record that and gently ask for a rough % — calibration
  needs numbers.
- **Don't react.** No "interesting!", no "good instinct". Acknowledge
  receipt and move to the audit. Evaluation happens structurally in the
  comparison, where it's evidence-based instead of social.
- **Skips are data, not failures.** Record `commit: skipped`, move on
  cheerfully. Surface the skip *rate* only in progress reviews, and only
  as an observation.

## Session file format

`thinking-gym/sessions/YYYY-MM-DD-<slug>.md`:

```markdown
# <Document title or slug>
date: YYYY-MM-DD
mode: quick | deep | draft-review
stake: <what decision hung on this>

## Commit
confidence: <n>% | skipped
holds: <verbatim answer>
weakest: <verbatim answer>
assumes: <verbatim answer, deep only>

## Audit
<the report, or a link to where it was delivered>

## Comparison
caught: <finding ids>
missed: <finding ids with types>  e.g. F3 [ASSUME], F5 [GAP]
phantom: <predicted weaknesses the audit didn't confirm>
note: <one line, only if something stands out>
```

## Calibration log format

`thinking-gym/calibration.md` — one table, one row per session:

```markdown
| date | doc | mode | confidence | verdict-match | caught | missed | phantom |
|------|-----|------|------------|---------------|--------|--------|---------|
| 2026-07-12 | q3-expansion-memo | deep | 80% | partial | 2 | 3 (2 ASSUME, 1 GAP) | 1 |
```

`verdict-match` is coarse by design: `yes` (their overall read matched
the audit's), `partial`, `no`, or `—` (skipped). Coarse and consistent
beats precise and abandoned.

## Profile format and update discipline

`thinking-gym/profile.md` holds *patterns*, not scores:

```markdown
# Reasoning profile

## Recurring blind spots
- [ASSUME] misses in financial documents — 4 of last 6 audits
  (sessions: 2026-06-30-budget, 2026-07-02-forecast, ...)

## Strengths
- Consistently catches [GAP] on market-size claims — 5 of 5

## Calibration
- Trend: overconfident on documents from own team (avg stated 85%,
  verdict-match "partial" or "no" in 3 of 4)

## Watch next
- <the one thing the last progress review suggested>
```

Update rules:

- **Only on recurrence.** One miss is noise. Write a blind-spot entry
  when a miss-type shows up ~3 times, and always with session links —
  the profile must be as evidence-anchored as the audits are.
- **Patterns, never traits.** "Missed [LEAP] in 3 vendor proposals" is
  usable; "credulous with vendors" is a personality verdict that helps
  no one and poisons the coaching relationship.
- **Prune.** When a blind spot stops recurring (caught 3+ times in a
  row), move it to Strengths with the evidence. Progress the user can
  see in their own file is the strongest motivator this skill has.

## Running a comparison

Order matters — caught first, then missed, then phantom, then
calibration. Leading with what they caught isn't kindness, it's accuracy:
the point of the comparison is a truthful delta, and a delta that only
reports misses is as distorted as one that only flatters.

For each miss, name the finding type inline — the type is what recurs
and therefore what can be trained. When a type hits its third recurrence,
say so plainly in the comparison ("that's the third [ASSUME] miss this
month — worth a look at the profile"), and if a spaced-repetition tool
(e.g. Flashii) is connected, offer once to make a card from the pattern.
Never auto-create cards; the gym belongs to the user.

## Running a progress review

Read profile.md and calibration.md fully, then report:

1. **Volume and mix** — sessions in period, modes, skip rate.
2. **Blind spots** — each recurring type: trend across time (improving /
   flat / worsening), with the counting shown.
3. **Calibration** — stated confidence vs. verdict-match, sliced by
   document type or source if the data supports slicing. Under ~10
   sessions, present observations as observations, not conclusions.
4. **One suggestion** — a single concrete thing to watch in upcoming
   audits. One. A coach who assigns five drills gets zero done.

Be as honest here as in audits. If the record shows no improvement, the
review says so with the numbers; if the record is too thin to say, the
review says that. The user is a decision-maker who audits arguments for
a living now — they will notice if their coach's own reasoning goes soft.
