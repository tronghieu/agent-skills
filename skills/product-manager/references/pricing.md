# Pricing & Packaging (Light)

The Compass lens. Read `references/pm-discipline.md` first. This play is
deliberately **light**: value metric, packaging, and a disciplined
price-setting process. It does not do full monetization strategy — unit
economics modeling, price-elasticity studies, competitive pricing war
games belong to a strategy-board engagement or a dedicated effort, and
this file says so rather than faking depth.

The fabrication trap here is the worst in the whole skill:
**willingness-to-pay numbers**. "Customers would pay $30/mo" is exactly
the kind of sentence an AI produces fluently and a business bets a year
on. WTP claims follow number provenance with zero exceptions.

## Contents

- [The value metric](#the-value-metric)
- [Packaging: tiers and fences](#packaging-tiers-and-fences)
- [Setting the number](#setting-the-number)
- [Output: pricing.md](#output-pricing-md)
- [Boundary](#boundary)

## The value metric

The unit you charge by — per seat, per run, per 1k records, flat. The
best value metric scales with the value delivered (the north star's
"action" term is the first candidate: if value is "shared runs", per-run
or per-active-team pricing tracks it; per-seat may tax adoption of the
very behavior you want).

Test a candidate: does the customer's bill grow roughly when their value
grows? Can they predict their bill? Does it penalize the usage you want
to encourage? (Charging per message in a collaboration tool taxes
collaboration.)

## Packaging: tiers and fences

Kano categories (from `references/prioritization.md` — with their method
labels riding along) map to packaging almost mechanically:

- **Must-bes go in every tier** — fencing a must-be doesn't upsell, it
  churns; a paywall on table stakes reads as hostage-taking.
- **Performance features fence by quantity** (limits, volume, seats) —
  the natural upgrade path, since more genuinely is better.
- **Delighters fence the upper tiers** — they justify premium without
  crippling the base.
- 2–4 tiers; more choices measurably stall decisions. Name the tier each
  target segment should land in — a tier no segment is *meant* to buy is
  either an anchor (fine, say so) or clutter (cut).

Fence-check against the feedback log: paying customers hitting a fence
they consider must-be shows up as `FB#` anger long before it shows up in
churn data.

## Setting the number

The process is: gather labelled evidence → triangulate → pick → test.

Legal evidence for a price, in descending strength:

1. **Revealed WTP** — actual transactions: pre-orders, paid pilots,
   pricing A/Bs, historical upgrades `[S#]`.
2. **Stated WTP** — surveys (Van Westendorp's four questions are the
   cheap standard), win/loss notes, sales-call reactions `[S#]` — real
   evidence, systematically inflated; label it stated, discount
   accordingly.
3. **Reference prices** — competitor pricing pages, the cost of the
   alternative the product replaces (the "priced against a $150k
   assistant, $30/mo is cheap" anchor) — desk work; hand to
   **market-researcher** when it's more than a couple of lookups; its
   `[S#]` output lands in `discovery/`.
4. **Assumptions `A#`** — allowed, labelled, with ranges, and flagged as
   the thing to test first.

No evidence at all → say so, register the assumptions, and recommend the
cheapest WTP experiment (`references/experiments.md`: pre-order or paid
pilot — stated intent without money at stake is category 2, not proof)
before the number hardens into contracts.

## Output: pricing.md

```markdown
# Pricing: <product>            status: draft · updated <date>

## Value metric
(choice + why, tied to the north star's action term)

## Tiers
| | Base | Pro | Scale |
(features by tier with Kano labels; limits; target segment per tier)

## The number & its evidence
(price points; each supported by labelled evidence rows 1–4 above;
the triangulation shown, disagreements diagnosed not averaged)

## Open assumptions & next tests
(A# links; the WTP experiment queue)
```

Pricing changes are High-class launches (`references/launch.md`) —
existing-customer grandfathering, comms, and rollback get decided before
the announcement, not after the backlash. Record the pricing decision in
`decisions.md` with a revisit-trigger (e.g. "revisit at 100 paying
accounts or first enterprise deal").

## Boundary

This play prices a product that already has evidence of value. Full
monetization strategy — business-model choice, unit-economics modeling
(CAC/LTV), elasticity measurement, multi-product bundling — is out of
scope: recommend a strategy-board engagement (it has the fact-base and
stress-testing machinery such bets deserve) and offer to prepare this
workspace's evidence as its input.
