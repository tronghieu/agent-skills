# Framing: intake, problem statement, Is/Is-Not

Frame and Bound decide whether the rest of the pipeline diagnoses the
real problem or a rumor about it. Time spent here is repaid threefold in
Diagnose — and the running example below (a solo-run online bakery whose
deliveries keep arriving late) carries through the other references, so
the phases can be seen connecting.

## The intake

One compact message, five questions:

- What's happening, in observable terms?
- When did it start, and how was it noticed?
- Who or what is affected, and what is it costing?
- What's already been tried?
- What would "fixed" look like — how will we know?

Ask them together — this is orientation, not interrogation — but keep
it light: lead with the most load-bearing question (usually the
observable symptom and its magnitude) and frame the rest as
answer-what-you-can. Expect partial answers and don't push for
completeness yet. "I don't know" is a legitimate answer that becomes a
fact-gap worth writing down; some of the best early verification tasks
are just filling intake gaps ("check what week the complaints actually
started").

**When the opening message already carries a sharp signature, spend it
immediately.** If the user arrives with a clean boundary contrast plus
a coincident change — "late deliveries started the week I switched
couriers, and only on cross-district orders" — they've handed over a
discriminating test before the intake even ran. Propose one cheap check
in the same reply, with both directions spelled out: "if the courier
switch is the cause, cross-district handoff times should have jumped
that week — pull three delivery timestamps from before and after; if
they're flat, the courier lead is weakened and we look elsewhere." The
remaining intake questions ride along in the same message. Deferring
all test design to a later turn wastes the user's best evidence and
reads as ceremony.

Spending the signal doesn't mean spending the whole toolbox: keep that
first reply light. One check with its if-true/if-false framing, the
statement read back for confirmation, and the riding-along questions
are plenty — the full Is/Is-Not table and the formal assumption-log
block land better in the *next* turn, once the user has answered
something and the artifacts have real content to hold.

"What's already been tried" earns its slot twice over: failed fixes are
evidence (each one weakens the hypothesis it targeted), and they reveal
what the user already believes the cause is — a belief that goes
straight into the assumption log, not into the statement.

## Problem statement refinement

A good problem statement is **specific, observable, measurable where
possible — and free of smuggled content**. Users almost always arrive
with a statement that bundles three different things:

- a **fact** (something observed),
- a **hypothesis** (their guess at the cause), and
- a **solution** (what they already want to do).

The refinement move is to unbundle: the fact becomes the statement, the
hypothesis is banked in the assumption log with a confidence level, and
the solution goes to a parking lot for the Solve phase. Nothing is
discarded — the user's guess is often right, and their solution often
returns as an option. It just doesn't get to skip the queue.

**Example 1 — smuggled cause:**
- Before: "Deliveries are late because my courier service got worse."
- After: "Over the last 6 weeks, a growing share of orders arrive after
  the promised delivery window." → assumption log: *"courier service is
  the cause" — user's belief, unverified.*

**Example 2 — smuggled solution:**
- Before: "I need a second delivery person."
- After: "On weekend days, orders arrive late more often than I can
  personally manage responses to." → parking lot: *hire second
  deliverer* (an option for Solve, if diagnosis supports it).

**Example 3 — too vague to diagnose:**
- Before: "My shop is a mess lately."
- After (through follow-ups): "Since early June, roughly 1 in 4 orders
  is delivered late, and two regulars have stopped ordering." Vague
  statements aren't rejected — they're interviewed until something
  observable emerges. "What would I see if I watched your shop for a
  day?" is a reliable un-vaguer.

Numbers beat adjectives wherever the user has them ("1 in 4 orders" vs
"a lot"), but don't stall the session demanding metrics the user
doesn't track — "more often than before, exact rate unknown" is an
honest, usable statement, and *unknown rate* becomes a measurement task.

**Success criteria** come from "what would fixed look like", sharpened
the same way: "late deliveries back under 1 in 20, sustained for a
month" gives the Plan phase its metric for free. Capture them in
`statement.md` next to the statement.

**The gate:** read the refined statement back and get explicit
confirmation before Bound. This is not ceremony — the user regularly
corrects something important at this exact moment ("well, it's not
*all* orders, only the custom cakes…"), and that correction is worth
more before the cause tree exists than after.

## Is/Is-Not analysis

Bound the confirmed problem by contrasting where it lives with where it
doesn't. Four dimensions, two columns each:

| | IS | IS NOT |
|---|---|---|
| **Where** | custom-cake orders; cross-district deliveries | standard-menu items; same-district |
| **When** | since early June; Fri–Sun peaks | before June; weekday orders mostly fine |
| **Who/what** | orders needing >30 min prep | pre-made stock items |
| **What form** | late by 1–3 hours | never wrong item, never no-show |

Fill it with the user — every cell is a fact about their world, so
every cell is theirs to supply. Cells they can't fill are fact-gaps:
mark them `?` and add the cheap ones to the verification list rather
than guessing.

**Reading the boundary.** The diagnostic gold is in the *differences*
between columns. Ask, for each sharp contrast: *what's different about
the IS side?* In the example: custom cakes differ from stock items in
prep time, not in courier handling — which already weakens the user's
courier hypothesis and points at capacity upstream of delivery. "What
form it never takes" earns its keep too: *late but never no-show* means
the pipeline completes, just slowly — a throughput problem, not a
reliability one.

Also note what changed at the time boundary: "since early June" begs
the question *what else started in June?* (menu change? volume growth?
new courier contract?). Changes coincident with onset are prime
hypothesis material — labeled `[assumed]` until checked, like
everything else.

Two cautions:

- **Is/Is-Not sharpens; it doesn't conclude.** The output is a set of
  boundary patterns feeding Diagnose, not a root cause. Resist the
  temptation to declare victory here — "it's the custom cakes!" is a
  *where*, not a *why*.
- **Keep it proportional.** For a small problem, three or four filled
  rows are plenty. An exhaustive 20-cell grid on a minor issue is
  framework tourism.

Write the table into `statement.md` under the statement, and carry the
two or three sharpest boundary patterns forward into Diagnose by name.
