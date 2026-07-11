# Platform-vs-Feature: A Structural Bet, Decided on Evidence

The Compass lens. Read `references/pm-discipline.md` first. This decision
is worth its own play because it is expensive in both directions: build a
feature where a platform was needed and you rebuild the same capability
three times; build a platform where a feature was needed and you spend
two quarters on abstraction serving one caller. The output is a
`decisions.md` entry with a revisit-trigger — not a document for its own
sake.

## Contents

- [When this play triggers](#when-this-play-triggers)
- [The signals checklist](#the-signals-checklist)
- [The decision inputs — with provenance](#the-decision-inputs--with-provenance)
- [The default path: feature first, extract later](#the-default-path-feature-first-extract-later)
- [Making and recording the call](#making-and-recording-the-call)

## When this play triggers

- The same capability appears in a second or third opportunity/PRD
  ("notifications again", "another import pipeline").
- Engineering raises extraction ("we're building this the third time").
- The user asks directly, or an external party asks for API access to an
  internal capability.
- A strategy-board recommendation names platform leverage.

## The signals checklist

Evidence for *platform* — each signal cited or registered as `A#`, never
just felt:

- **≥3 concrete use cases exist today** (not "could exist") — named, with
  the `OP#`/PRD each comes from. Two is a shared library; three with
  different owners starts to be a platform.
- **Demand is pulled, not pushed**: other teams/products/customers are
  asking (`FB#`/`[S#]`), versus this being an architect's aesthetic
  preference.
- **The capability is stable**: the underlying job has stopped changing
  shape release-to-release. Platformizing a still-moving target freezes
  the wrong abstraction.
- **Someone would own it**: a platform without an owner decays into the
  worst of both worlds — shared *and* unmaintained.

Signals against: single caller, rapidly evolving requirements, no
candidate owner, or a deadline the feature path meets and the platform
path doesn't.

## The decision inputs — with provenance

A weighted scoring table is optional dressing; the load-bearing inputs
are these, each labelled:

- **Use-case count and breadth** — today's, named ([S#]/OP# links).
- **Cost delta** — platform build vs feature build vs (feature now +
  extraction later), as ranges from engineering
  `(user estimate, <date>)`. Platform estimates run optimistic; say so
  and widen the range.
- **Break-even** — at how many use cases does the platform repay its
  premium? Show the arithmetic inline: if platform ≈ 2.5× feature cost
  and each reuse saves ~70% of a feature build, break-even sits near the
  3rd caller — which is why the ≥3-today signal matters.
- **Risk asymmetry** — cost of being wrong each way, in this specific
  case (rebuild cost vs abstraction-tax cost).

Sensitivity applies as always: if the call flips inside the cost-range or
use-case assumptions, the honest answer is the phased path plus an
experiment (e.g. validate the third use case before committing).

## The default path: feature first, extract later

The phased path is the default recommendation absent strong contrary
evidence, because it converts an irreversible bet into a reversible one:

1. **Build the feature** for the concrete use case in hand — but spend
   the small premium on clean seams (isolate the capability behind an
   internal interface; don't let callers reach into its guts).
2. **Let the second and third real use cases arrive** — they will teach
   you the right abstraction better than any design review.
3. **Extract at the third caller**, when the signals checklist actually
   passes, with an owner named.

Premature platformization is the expensive failure ("build it and they
will come" — for internal infrastructure, they mostly don't). The main
cost of the phased path — some rework at extraction — is usually cheaper
than either wrong bet, *if* step 1's seams were kept. Skipping straight
to platform is justified when the ≥3-today signal already passes, the
capability is stable, and an owner exists.

## Making and recording the call

Present: the signals table (each row labelled), the cost/break-even
arithmetic, the sensitivity note, and a recommendation with confidence.
The user decides. Record in `decisions.md`:

```markdown
## 2026-07-11 — Notifications: feature now, extract at third caller
- **Decision:** phased path; build for OP7 behind internal interface.
- **Alternatives:** full platform now (rejected: 2 use cases today, A9
  cost range flips the call at its high end).
- **Revisit when:** a third caller appears, or OP12 (mobile) is
  prioritized — whichever first.
```

The revisit-trigger is the whole point: platform decisions are not
one-time verdicts but standing bets that new callers re-open. Without the
trigger, "we decided feature" hardens into "we never build platforms".
