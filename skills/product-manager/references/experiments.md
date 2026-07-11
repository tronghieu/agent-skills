# Design-Experiment: Killing Assumptions Cheaply

The Lab lens (Mai). Read `references/pm-discipline.md` first. This play exists
because the assumption registry and sensitivity analyses keep producing
the same output: a short list of beliefs the roadmap is betting on. An
experiment is how a belief stops being a bet.

The division of labor mirrors design-thinking's: **this skill designs the
experiment; the user runs it.** Never simulate results, never extrapolate
"what the data would probably show", never register an imagined outcome.
The play ends with an instrument and a pause (⏸), not with findings.

## Contents

- [Picking what to test](#picking-what-to-test)
- [Choosing the cheapest honest method](#choosing-the-cheapest-honest-method)
- [The test card: experiments/exp-<slug>.md](#the-test-card-experimentsexp-slugmd)
- [Statistical honesty without a statistics degree](#statistical-honesty-without-a-statistics-degree)
- [The learning card: closing the loop](#the-learning-card-closing-the-loop)
- [When to hand off to design-thinking](#when-to-hand-off-to-design-thinking)

## Picking what to test

Test the assumption that is **high-impact-if-wrong × low-evidence** — not
the one that is easiest to test or most likely to pass. Two feeds rank
the candidates automatically:

1. **Sensitivity output**: any assumption a prioritization rank or OKR
   commitment *flips on* (see pm-discipline) is a candidate by
   construction — a week of testing A4 can save a quarter of building the
   wrong winner.
2. **PRD risk sections**: the `A#` links in approved specs, ordered by
   what falsifies the spec fastest.

If the user asks to test something comfortable while a load-bearing
assumption sits untested, say so once, with the citation, then follow
their call (Habits: challenge before you comply).

## Choosing the cheapest honest method

Cheapest method that could *falsify* the assumption — not the most
impressive one:

| Assumption is about | Cheap methods, in escalating cost |
|---|---|
| Demand ("they'd use/click it") | painted-door / fake-door, landing page + signup, waitlist |
| Willingness to pay | pre-order, paid pilot, pricing-page A/B (real WTP needs real money at stake — stated intent is weak evidence, label it so) |
| Behavior change ("they'd do X more") | A/B test on the live metric, holdout cohort |
| Feasibility ("we can deliver it") | spike/prototype behind a flag, wizard-of-oz (humans faking the backend) |
| Comprehension/usability | moderated test — usually a design-thinking handoff (below) |

Beware the **disguised full build**: if the "experiment" requires shipping
the feature, it is not an experiment, it is the investment wearing a lab
coat. Also beware tests that cannot fail: a painted door on your most
loyal segment, a survey of fans — passing tells you nothing (the audit
calls this discrimination).

## The test card: experiments/exp-<slug>.md

Written and frozen **before** any data is collected:

```markdown
# E2 — Onboarding-churn attribution        status: designed
targets: A4 (60% of churn is onboarding-related) · linked: OP2, prioritization-2026-07

## Hypothesis
If we survey churned users within 7 days of churn, ≥40% will name
onboarding/setup as the primary reason.

## Method
Exit survey, single question + free text, sent to every churned account,
2 full weeks or n≥50 responses, whichever comes first.

## Pass / fail — fixed before data
- PASS (A4 supported): ≥40% name onboarding as primary reason
- FAIL (A4 falsified): <25%
- GRAY ZONE: 25–40% — pre-committed interpretation: partial support;
  rerun sensitivity with A4 range narrowed to the observed value ±10pp

## What we'll do with each outcome
PASS → OP2 stays #1. FAIL → prioritization-2026-07 rerun (rank flips to
OP5 per sensitivity). Committing to consequences in advance is what makes
the result unarguable later.

## Cost & duration
~2h setup, 2 weeks calendar, no engineering.
```

The thresholds live on the card *before* launch precisely so nobody —
user or skill — can quietly move the goalposts after seeing the data.
The gray zone is declared honestly rather than pretending the world is
binary.

## Statistical honesty without a statistics degree

This skill doesn't run power calculations by default, but it refuses the
classic sins:

- **Decide sample size / duration before starting**, even roughly (the
  card's "2 weeks or n≥50"). Stopping the moment the numbers look good is
  peeking, and it manufactures false positives.
- **Small-n humility**: n=12 supports "signal worth a bigger test", never
  "validated". Write conclusions at the strength the n deserves; the
  learning card's status field enforces it.
- **One primary metric per experiment.** Secondary metrics are
  exploratory; promoting whichever moved into "the result" is p-hacking
  by another name.
- **A/B specifics**: randomize at the right unit (account, not pageview,
  for team products), run full weeks to absorb weekday cycles, and mind
  novelty effects on short tests of visible changes.
- When stakes are high (pricing, irreversible migrations), recommend the
  user involve someone who can size the test properly — and say why.

## The learning card: closing the loop

When the user brings results back, append to the same file:

```markdown
## Learning — 2026-07-24
Result: 31% named onboarding (n=54) [S9 — survey export in discovery/]
Verdict: GRAY ZONE per pre-committed interpretation
Actions:
- A4 range narrowed 25–40% (was 40–75%) → assumptions.md updated
- prioritization-2026-07 sensitivity rerun: OP2 rank now borderline vs
  OP5 → flagged for next planning session
- decisions.md appended
status: concluded
```

The raw results register as `[S#]`; the targeted `A#` status updates
(`validated (E2)` / `falsified (E2)` / range narrowed); and **every
artifact in the assumption's Used-by list gets walked** — an experiment
whose result changes no file was entertainment, not learning.

## When to hand off to design-thinking

Quantitative "how many / whether" questions live here. When the question
is **why** or **how do users experience it** — usability of a flow,
comprehension of a concept, needs discovery — the design-thinking skill's
Test and Empathize phases are the right instrument (moderated tests,
interview guides, assumption maps with the same discipline). Suggest it
once if not installed; either way, its outputs come back as `[S#]`/`[I#]`
this workspace can cite. Don't run a survey where an interview is needed
just because surveys stay in-house.
