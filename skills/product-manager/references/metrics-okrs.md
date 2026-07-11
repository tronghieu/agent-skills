# Define-Metrics & Plan-OKRs: North Star, Metrics Tree, OKRs

The Gauge lens. Read `references/pm-discipline.md` first. Metrics work has
its own fabrication trap: **baselines**. An OKR that moves a metric "from
X to Y" where X was never measured is fiction with a progress bar.

## Contents

- [define-metrics: strategy/metrics.md](#define-metrics-strategymetricsmd)
- [Choosing the north star](#choosing-the-north-star)
- [The metrics tree](#the-metrics-tree)
- [Guardrails and anti-vanity rules](#guardrails-and-anti-vanity-rules)
- [plan-okrs: strategy/okrs-<period>.md](#plan-okrs-strategyokrs-periodmd)
- [Scoring and cadence](#scoring-and-cadence)

## define-metrics: strategy/metrics.md

One file, the product's measurement constitution. Everything downstream —
opportunity metric links, PRD outcomes, OKR key results, launch reviews —
points into this file rather than inventing metrics ad hoc.

```markdown
# Metrics: <product>

## North star
Weekly teams reaching a shared working result
= teams (segment) × completed shared run (action) × per week (frequency)
Current: 412/wk [S4, analytics 2026-07] · chosen 2026-07-11 (decisions.md)

## Metrics tree
North star
├─ L1: activation — % of signups reaching first shared run in week 1
│   current: 22% [S4]
├─ L1: habit — median runs per active team per week
│   current: 1.8 [S4]
└─ L1: expansion — invited members converting to active
    current: not instrumented ⚠ (see OKR KR3)

## Guardrails
support tickets / active team · p95 load time · churn rate
(numbers that must not get worse while we push the tree)

## Instrumentation gaps
(what is not measured yet — the honest list)
```

## Choosing the north star

The north star is the **value moment made countable**: the metric that
best proxies "a user got what they came for", leading revenue rather than
lagging it. Work from the job story: what observable event means the job
was done? Test a candidate against four questions:

1. Does it capture delivered value, not just activity? (DAU counts
   presence; it says nothing about progress on the job.)
2. Can teams influence it through shippable work? (Revenue can't be
   directly built; its inputs can.)
3. Is it gameable without helping users? If yes, name the gaming vector
   and pick a guardrail that catches it.
4. Is it measurable *now*? If not, the first metrics decision is an
   instrumentation task, written down as such — not a placeholder number.

Structure it as **segment × action × frequency** so every term is
inspectable. Record the choice and its runners-up in `decisions.md` with a
revisit-trigger — north stars legitimately evolve when the product's value
moment moves.

## The metrics tree

The north star decomposes into 2–4 **input metrics (L1)** — the levers
teams can actually push — each optionally decomposed one more level.
Rules:

- Every L1 carries a **labelled current value** or an explicit
  `not instrumented ⚠`. The tree is where invented baselines would
  otherwise breed; an honest gap is more useful than a plausible number.
- The tree explains *mechanically* how work moves the north star: an
  opportunity that names "week-1 retention" as its metric is claiming a
  specific edge of this tree. If no edge fits, either the tree is missing
  a lever or the opportunity doesn't serve the product's value — both
  worth knowing before building.
- Keep it small. A tree past ~10 nodes is a dashboard, not a decision
  tool.

## Guardrails and anti-vanity rules

- **Guardrails are the metrics you promise not to sacrifice** — quality,
  trust, performance. Every OKR and launch plan names its guardrails; a
  target metric without guardrails invites winning the number and losing
  the product.
- **Vanity check**: cumulative counts ("total signups ever"), metrics
  without a denominator, and metrics nobody would act on differently at
  2x or 0.5x get cut from the tree. The test: "if this number halved
  tomorrow, what exactly would we do?" No answer → not a decision metric.
- Ratios beat absolutes for comparability; pair any rate with its base
  ("22% of 1,850 signups [S4]") so small-denominator noise is visible.

## plan-okrs: strategy/okrs-<period>.md

OKRs commit the period to moving specific edges of the metrics tree.
Prerequisite: `metrics.md` exists with labelled baselines — otherwise run
define-metrics first (or make KR1 the instrumentation itself).

```markdown
# OKRs — 2026 Q3

## O1: New teams reach value in their first sitting
(qualitative, inspirational, worth a quarter of attention)

- **KR1:** week-1 activation 22% [S4] → 35%
  confidence: medium (A5 range +5–12pp — 35% is the stretch end)
- **KR2:** median time-to-first-shared-run 2.1 days [S4] → same-day
- **KR3:** expansion metric instrumented and baselined by wk 4
  (an honest KR when the baseline doesn't exist yet)

## Alignment
(up: which company objective this serves; sideways: dependencies on
other teams, named)

## Risks
(A# links; what falsifies the plan)
```

Rules:

- **Objectives are directions, KRs are measurements.** An objective with a
  number in it is a KR wearing a costume; a KR without a labelled baseline
  is fiction (the `from X` half of "[verb] metric from X to Y" must carry
  `[S#]` or `(user estimate, <date>)`).
- **2–3 objectives, 2–4 KRs each, per period.** More is a todo list that
  will be ignored with extra steps.
- **KRs are outcomes, not shipments.** "Ship onboarding v2" is an
  initiative; the KR is what shipping it should change. Keep an initiative
  mapping (which backlog/PRD items serve which KR) below the OKRs —
  that's where this file meets the prioritization.
- **Target-setting honesty**: targets derive from the baseline plus a
  labelled expected-lift assumption, not from round-number optimism.
  Aspirational targets are fine — the ~70%-attainment norm exists for
  them — but the assumption behind the target is still registered and
  sensitivity applies (would you still commit the quarter at the low end
  of A5's range?).

## Scoring and cadence

- **Weekly**: traffic-light the KRs in `state.md` (on-track / at-risk /
  off-track), one line each. No ceremonies in prose.
- **Mid-period**: one honest checkpoint — anything off-track gets a named
  decision: push harder, change approach, or formally deprioritize (in
  `decisions.md`). Silent target amnesia is the OKR failure mode; the log
  makes it impossible.
- **Period end**: score 0.0–1.0 per KR against the labelled baseline,
  write two lines of learning per objective, and feed the misses into the
  next period's planning. ~0.7 average is healthy for stretch targets;
  1.0 across the board means the targets were sandbagged — say so.
