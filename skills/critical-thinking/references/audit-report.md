# Audit Report — templates for each mode

These reports are read by a decision-maker with minutes, not a professor
grading a paper. Verdict first, detail below — someone who reads only the
first section should already know whether to trust the document and what
to do next. Everything after the verdict is for the reader who wants to
check your work, not for you to prove you read closely.

Two rules hold across every template in this file:

- **Every finding traces to an exact quote**, copied character-for-character
  per references/argument-anatomy.md, with its location. A finding without
  an anchor is an opinion wearing a report's clothes.
- **Findings are numbered F1, F2, … in severity order** — ranked by
  load-bearing × severity, never by the order they appear in the document.
  The reader's attention is the scarcest resource in the room; spend it on
  what matters first.

The audit never collapses into one score. A document can be clear and
well-written and still have a conclusion that doesn't follow — averaging
those two facts into a "7/10" hides the only fact that matters. Lead with
the worst problem, not the mean of all of them.

Length discipline: a quick audit report fits on one screen. If a finding
needs a paragraph to explain why it matters, the stake probably calls for
a deep audit instead — say so and offer to switch modes.

## Quick audit template

Use for short documents, low stakes, or time pressure. Skeleton plus the
three findings that matter most — nothing else.

```markdown
# Audit: <document title>
mode: quick | date: YYYY-MM-DD | stake: <what decision hangs on this>

## Verdict
<2-3 sentences: does the core argument hold? What's the single biggest
issue? What should the reader do before acting on this document — approve
as-is, ask a question first, send it back, get a second opinion?>

## Top findings
**F1 [TYPE]** — <the defect, one sentence>
> <exact quote> (<location>)

<1-2 sentences: why this matters for the stated stake specifically, not
critical thinking in the abstract.>

**F2 [TYPE]** — <the defect, one sentence>
> <exact quote> (<location>)

<1-2 sentences.>

**F3 [TYPE]** — <the defect, one sentence>
> <exact quote> (<location>)

<1-2 sentences.>

## Not examined
<one line: what a deep audit would add that this pass skipped — e.g.
"full assumption register, source credibility, falsifiability check.">
```

Cap at three findings even if more exist — a quick audit's value is
triage, not completeness. If the document has more than three real
problems, say that in the verdict and recommend a deep audit.

## Deep audit template

Use for load-bearing decisions and long or dense documents. Full anatomy
(references/argument-anatomy.md), full rubric
(references/rubric.md), fallacy scan (references/fallacies-biases.md).

Proportionality: full Toulmin blocks belong to the one or two claims that
carry the report — the map table covers the rest. When the stake has a
clock on it (a board meeting this afternoon), the Verdict plus the
recommendation must stand alone; everything below them is for the reader
who wants to check the work, and it is fine for that reader to skim.

```markdown
# Audit: <document title>
mode: deep | date: YYYY-MM-DD | stake: <what decision hangs on this>

## Verdict
<3-5 sentences: does the core argument hold? The top 2-3 issues, named
plainly. What observable evidence would change this verdict — the single
most useful sentence in the report for a reader who wants to keep
tracking the question after today.>

## Argument map
Conclusion: "<exact quote>" (<location>)

| Claim | Quote (location) | Verdict |
|---|---|---|
| C1 | "<quote>" (<loc>) | holds |
| C2 | "<quote>" (<loc>) | [GAP] |
| C3 | "<quote>" (<loc>) | [LEAP] |

<Use the full per-claim Toulmin block from argument-anatomy.md instead of
the table when a claim's warrant needs explaining — the table is for
scanning, not for the claims that carry the report.>

## Findings
All findings F1..Fn, ranked by severity, same anchor discipline as the
quick template:

**F1 [TYPE]** — <the defect, one sentence>
> <exact quote> (<location>)

<Explanation. For [FALLACY] findings: name the pattern from
references/fallacies-biases.md, and add a "repair" line — what would need
to change for the reasoning to hold, e.g. "repair: would need a control
group, not just a before/after on the same city.">

**F2 [TYPE]** — <the defect, one sentence>
> <exact quote> (<location>)

<...continue through Fn.>

## Assumptions register
Unstated assumptions from argument-anatomy.md Step 4, ranked by
fragility × load — the assumption most likely to be false *and* most
load-bearing leads:

| # | Assumption | Fragility | Load | Note |
|---|---|---|---|---|
| A1 | <stated in your words> | high | high | <why it's likely false, if it is> |
| A2 | <...> | med | high | |

## Falsifiability
<What observable evidence would show the conclusion is wrong? Did the
author look for it? Use the three grades from argument-anatomy.md Step 5:
named kill-criteria (rare, say so if present), checkable evidence the
document didn't engage with (a finding), or a claim built so nothing
could count against it (also a finding — positioning language, not a
claim).>

## Honest corner
<[OPINION] and [CANNOT-ASSESS] items only, explicitly separated from
Findings so disagreement never masquerades as logic:>

**[OPINION]** <the claim> — reasoning holds; I read it differently
because <your actual basis, stated as a basis, not a fact>.

**[CANNOT-ASSESS]** <the claim> — requires <specific domain knowledge or
data>. Recommend <a named expert or a specific verification step>.

## Questions to send back
<3-5 questions for the document's author, each derived from a specific
finding — this is the concrete next action a decision-maker takes after
reading an audit: they don't re-derive the analysis, they send questions.>

1. <question tied to F1 or A1>
2. <question tied to F2>
3. <question tied to the falsifiability gap, if any>
```

## Draft review template

Use when the document is the user's own. The job inverts: fortify before
demolishing. Same taxonomy, same anchor discipline, but every finding
carries a repair, and the report opens with what already works.

```markdown
# Draft review: <document title>
mode: draft-review | date: YYYY-MM-DD | stake: <what this draft needs to survive>

## What holds
<Structural strengths first — which claims are well-grounded, which
pillars can bear more weight if the argument leans on them harder. A
writer needs to know what's load-bearing before they know what to fix.>

## Findings
**F1 [TYPE]** — <the defect, one sentence>
> <exact quote> (<location>)

<Why it matters.>
repair: <the specific evidence to add, qualifier to soften or drop, or
restructuring that closes the gap — never just "fix this.">

**F2 [TYPE]** — <...>
> <exact quote> (<location>)

repair: <...>

## Decision structure
<Does the draft define its own stop conditions — stage-gates between
phases, go/no-go criteria, a kill-criterion the author commits to in
advance? An all-upfront ask with no gates is one of the first things a
sophisticated reader attacks, and one of the cheapest repairs to make
before sending. If gates exist, check they are observable and dated; if
none exist, that is a finding with a repair, not a footnote.>

## Steelman
<The strongest objection a hostile reader raises — quoted from the exact
place in the draft where it lands hardest, plus where in the draft to
pre-empt it. One real objection, argued at full strength, beats three
weak ones.>

> <quote showing where the draft is vulnerable> (<location>)

Pre-empt at: <where in the draft this belongs, and roughly how>.

## Priority
<The 2-3 repairs that matter most before this goes out — not every
finding, the ones that actually change whether the draft survives
contact with its audience.>

1. <repair, tied to a finding id>
2. <repair, tied to a finding id>
```

## Progress review template

Use for "how is my thinking developing?" — read profile.md and
calibration.md per references/coaching.md before writing this.

```markdown
# Progress review — <date range>

## Volume & mix
<Sessions in period, split by mode (quick / deep / draft-review), and
commit-skip rate. If skip rate is climbing, say so plainly — it's the
one honesty check this section owes the reader.>

## Blind spots
<Per recurring miss-type: count, trend across the period (improving /
flat / worsening), and the session links backing the count — per
references/coaching.md, a pattern needs evidence the same way a finding
does.>

- [ASSUME] misses: <count> of <total>, trend <...> (sessions: <links>)
- [GAP] misses: <count> of <total>, trend <...> (sessions: <links>)

## Calibration
<Stated confidence vs. verdict-match, sliced by document type or source
only if there are 10+ sessions to slice — under that, report as
observation, not conclusion.>

## One thing to watch
<Exactly one suggestion for the next few audits. A coach who hands back
five drills gets zero of them done.>
```

## Writing discipline

State the defect in one sentence before explaining it — the reader
should never have to finish a paragraph to learn what's wrong. Cut hedges
that pad without informing ("it could perhaps be argued that…", "one
might reasonably question…") — either you have a finding or you don't.
The verdict alone should be actionable; if the reader has to read every
finding to know what to do, the verdict failed its job. Reserve severity
language for what it actually describes: "fatal" means the conclusion
collapses without this claim, not that the finding is merely real —
inflating severity trains the reader to discount your next report.
