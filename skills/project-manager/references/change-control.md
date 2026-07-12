# Change control — impact before acceptance, baseline integrity

Guides the **control-change** play (Zeno · Gate). This is the
anti-scope-creep weapon: the mechanism that stops "just a small tweak"
from accumulating, unrecorded, until the baseline is a document nobody
believes anymore. Zeno lets nothing pass the gate unexamined. Read
`references/pm-discipline.md` first for the provenance labels this file
assumes throughout.

## What counts as a change

Not everything that comes up mid-project is a `CH#` — but the bar is lower
than intuition suggests, because intuition is exactly what scope creep
exploits. A change is anything that:

- adds or removes scope (a feature, a deliverable, an acceptance
  criterion) against `context/charter.md`,
- moves a **committed** date (internal-target dates can flex without a
  gate, but `charter.md` labels which dates are committed — see
  `references/estimation.md` re-estimation triggers for the difference
  between re-estimating and re-committing),
- moves the budget envelope, or
- changes methodology in a way that changes cadence commitments already
  communicated to stakeholders.

**The "just a small tweak" test:** if it consumes capacity that was
committed elsewhere, or moves any commitment made to a stakeholder, it is
a `CH#` — regardless of how small it feels in the room. "Can we just also
add X, it's tiny" is the most common sentence scope creep is made of,
because it is usually true in isolation and false in aggregate. The gate
exists to catch the aggregate, not to insult the individual request.

What is *not* a change: work that was always in scope but not yet
scheduled, a clarification of an ambiguous requirement that doesn't add
new capability, or an internal-target date moving within slack that
doesn't touch a committed date or another team's plan.

## CH# lifecycle

Four stages, and nothing skips ahead:

```
raised → impact-assessed → decided → propagated
```

1. **Raised.** A row appears in `registers/changes.md` the moment the
   request surfaces — even before it's assessed. A change that exists only
   as a conversation is a change the register doesn't know about yet, and
   an unregistered change is how "we'll just squeeze it in" wins.
2. **Impact-assessed.** Schedule / cost / risk / quality impact, each with
   a labelled basis (below).
3. **Decided.** The named authority (below) makes an explicit accept /
   reject / defer call. **Nothing enters the plan before this stage** —
   not "tentatively," not "let's assume yes and confirm later." The plan
   reflects decisions, not requests.
4. **Propagated.** Every downstream artifact the change touches gets
   updated in the same pass (checklist below) — a decided change that
   only updates one file is a change the registers now disagree about.

**Fast lane for genuinely small changes.** Same four stages, same rigor,
compressed into one exchange with the user rather than a multi-day review
— appropriate for a change with clearly local, clearly small impact (e.g.,
swapping one low-risk task for another of equal size within the same
sprint, no date or budget effect). The fast lane changes the *pace* of
assessment, never the *presence* of it: the row, the impact note, and the
named decision still exist. If the impact assessment turns up anything
non-trivial, it exits the fast lane.

## Impact assessment

Every `CH#` row states impact across all four dimensions — "no impact" is
a valid answer for a dimension, but it has to be stated, not left blank
(a blank cell invites the assumption that nobody checked):

| Dimension | What to state | Basis label |
|-----------|---------------|-------------|
| Schedule | Which milestone(s) move, by how much | `EV#` / `A#` / (user, date) |
| Cost | Budget or effort delta | `EV#` / `A#` / (user, date) |
| Risk | New risks introduced, existing risks' scores changed | cite `R#` rows touched |
| Quality | Scope or acceptance-criteria trade implied | (user, date) usually — this is a judgment call the user owns |

The impact estimate itself follows `references/estimation.md`: a range,
not a point, checked against history where history exists. "This will add
about a week" with no basis is exactly the planning-fallacy failure the
estimate play exists to prevent — a change's impact number is an estimate
like any other.

State the **options**, not just the number, so the decision is a real
choice:

- **Absorb** — eat it inside existing buffer, no plan change.
- **Trade** — drop or defer something else of equal size to make room.
- **Extend** — move a committed date or add budget.
- **Reject** — decline the change; the requester's need goes unmet or
  waits for a future phase.

A `CH#` row that shows only "approved, +1 week" without having named these
options wasn't actually assessed — it was rubber-stamped.

## Decision authority

The decision comes from the authority named in `context/charter.md`, by
name — never inferred, never assumed to be "whoever's in the room." If
`charter.md` doesn't yet name a decision authority for a change of this
size, that is itself a gap to raise with the user before the `CH#` can
move to "decided," not a gap to paper over with a default.

**The skill never accepts a change on the user's behalf.** It can draft
the impact assessment, lay out the options, and recommend — but the
"decided" cell in `registers/changes.md` records a real decision by the
named person, dated. If the user says "sure, let's just do it" in an
offhand way, that is a legitimate decision — the skill still records who
said it and when, so the register stays a real audit trail.

## Re-baselining

A baseline is a promise made under yesterday's information. When enough
`CH#` rows accumulate that the current `plan/baseline-<date>.md` no longer
describes the plan anyone is actually working to, re-baseline:

1. Snapshot the current living plan into a new
   `plan/baseline-<date>.md` (today's date).
2. **Keep the old baseline file** — never overwrite or delete it. The
   sequence of baselines is the project's own slip history, and slip
   history feeds every future estimate and reference-class check.
3. Record the re-baseline as an event in `registers/decisions.md`:
   what changed, which `CH#` rows drove it, who approved the
   re-baseline (same authority discipline as any change), and the
   revisit-trigger.
4. Report the re-baseline in the next status snapshot — a re-baseline
   that happens quietly is the single most effective way to make
   "on track" mean nothing.

Slip history stays visible **across** baselines: a milestone that moved
from baseline-1 to baseline-2 and again to baseline-3 should be traceable
by anyone reading the three files in sequence, not buried by treating each
new baseline as if the project began that day.

## Propagation checklist

A decided change touches every artifact below, in the same pass — a
change that updates the schedule but not the risk register is a change
the registers now contradict each other about:

- [ ] `plan/schedule.md` — dates, dependencies, critical path
- [ ] `plan/estimates.md` — any estimate this change invalidates
- [ ] `registers/risks.md` — new risks from the change itself; existing
      risk scores it shifts
- [ ] Stakeholder communications — anyone in `context/stakeholders.md`
      whose communication plan promised them this wouldn't move
- [ ] The next `status/status-<date>.md` — the change and its rationale
      appear, not just the resulting numbers

## Creep detection sweep

Periodically (cadence set in `context/methodology.md`, or whenever a
status report feels harder to write than it should), sweep work currently
in flight against two questions: does it trace to a scope item in
`context/charter.md`, or to a decided `CH#`? Work that traces to neither
gets flagged — not silently absorbed, not silently stopped, just named in
the next status snapshot and put in front of the user.

This is the delivery-side twin of product-manager's rule that untraceable
work must be *visibly* a bet, not retroactively rationalized. A feature
that traces to nothing might be the right call — bets exist — but the
sweep is what keeps "the plan" and "what people are actually building"
from quietly drifting apart until nobody can say which one is real.
