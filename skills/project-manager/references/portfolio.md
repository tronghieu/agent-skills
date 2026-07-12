# Portfolio — roll-ups across projects, capacity, stage gates

This file governs the `portfolio-review` play (lenses **Diogenes · Pulse**
for truth-telling + **Aristotle · Frame** for structure — a PMO view is a
status report stretched across several schedules at once). It activates
when the user manages more than one project, each with its own directory
and its own `_project/` workspace. This is a PMO extension, not a
different skill: the same non-negotiables apply, scaled up — every color
still cites its evidence, every number still names its project.

## 1. Portfolio inputs

The user names the project directories to include — the play never
discovers or guesses which projects belong in a roll-up. For each named
directory:

1. Confirm a `_project/` workspace exists at that path. If not, say so and
   drop it from the roll-up rather than fabricating a status for a
   project that was never initialized.
2. Read that project's own `state.md`, latest `status/status-<date>.md`,
   `registers/risks.md`, and `registers/changes.md`. Nothing about a
   project's status is re-derived or estimated from outside its own
   workspace — the portfolio view is strictly a read-only aggregation.
3. **Staleness is reported, never guessed.** If a project's latest status
   snapshot predates the portfolio's own reporting cadence (e.g., the
   newest `status-<date>.md` is six weeks old against a monthly cadence),
   the roll-up row says "stale — last update `<date>`" and stops there.
   Coloring a stale project green because its last known status was green
   is exactly the watermelon-reporting failure this skill exists to
   prevent, just moved up one altitude.

The roll-up file itself, `portfolio-<date>.md`, is **not** written inside
any single project's `_project/` — doing so would misattribute
cross-project data to one project's workspace. Write it to the location
the user is running the portfolio review from (a shared parent directory,
or wherever they ask), and say so explicitly the first time.

**Cadence is the user's call, not a default.** Some portfolios want a
weekly roll-up, others monthly, others only at gate boundaries (§4). Ask
once at first use and record the answer in the roll-up file's own header
so later reviews can check staleness against it — a project silent for
three weeks is stale against a weekly cadence and unremarkable against a
monthly one.

## 2. Roll-up format

One line per project. Every field that isn't plain description cites the
evidence it came from — from *that project's own* registers, never
inferred:

| Project | Headline | RAG | Top risk | Decision needed |
|---------|----------|-----|----------|------------------|
| Mobile App | On track for M4 beta | Green (`EV14`, mobile-app) | R2: app-store review delay, medium (mobile-app) | none |
| Data Migration | Slipped 3 weeks on schema validation | Amber (status-2026-06-28, data-migration) | R5: legacy export format undocumented, high (data-migration) | sponsor call on 2-week extension vs cutting validation scope — `CH4` pending |
| Vendor Portal | No status update in 5 weeks | **Stale** — last update 2026-05-15 | — | ask project owner for current status before next roll-up |

**Aggregate colors by worst-credible, not average.** A portfolio of five
green projects and one red one is not "yellow overall" — averaging hides
the one project whose failure mode could still hurt the program (a shared
dependency, a shared deadline, a shared budget line). Report the overall
portfolio color as the worst credible color among projects that share
exposure, and name which project is driving it. If the red project is
genuinely isolated (no shared budget, timeline, or team with the rest),
say that explicitly too — isolation is a fact worth stating, not an excuse
to average it away.

## 3. Cross-project capacity conflicts

Read each named project's `context/team.md` roster and capacity. A
conflict exists when the same person or team appears across two or more
projects' rosters at a combined allocation that exceeds their stated
capacity (e.g., 70% on Project A plus 60% on Project B).

Output is a **conflict list with options**, not a resolution — allocation
calls belong to the user (or whoever the projects' charters name as
resourcing authority), not to this play:

> **Conflict:** Priya is allocated 70% to Mobile App
> (`mobile-app/_project/context/team.md`) and 60% to Data Migration
> (`data-migration/_project/context/team.md`) — 130% combined against a
> stated 100% capacity.
> **Options:** (a) reduce Priya's Data Migration allocation and slip M4
> there; (b) reduce Mobile App's beta scope to fit 30% capacity; (c) bring
> in backfill for one project. Decided by: user.

Never resolve the conflict silently by picking one project's plan over
the other's — that is a scope or schedule decision belonging to
`control-change` in the affected project, triggered by whichever option
the user picks here.

## 4. Light stage gates

A gate is a short, evidence-based go/hold/kill checklist run at a
project's natural phase or milestone boundary — light enough to run
often, not a quarterly ceremony:

- Does the charter's success criteria still hold, or has the objective
  drifted since `context/charter.md` was last confirmed?
- Is the current baseline still credible, or has the slip history
  (`registers/lessons.md`, status trend) made the forecast date fiction?
- Is there an unresolved risk at "critical" severity with no viable
  ROAM response?
- Does the budget envelope in `context/charter.md` still cover the
  current forecast?

Each checklist item resolves with a citation — `EV#`, `A#`, or `(user,
date)` — exactly like a status color. A gate is **go**, **hold**
(specific blocking question named), or a **kill recommendation**.

**Kill recommendations escalate, they don't decide.** This play can
surface "Vendor Portal has missed four consecutive milestones with no
credible recovery plan — recommend a kill review" but it does not make
that call. A kill or major re-scope is a portfolio-prioritization
decision above project altitude; hand it to the **strategy-board** skill
with the evidence assembled, and record the referral in the portfolio
roll-up and in the project's own `decisions.md`.

## 5. Cross-project lesson propagation

Lessons registered in one project sometimes belong to every project that
shares its pattern. When a project's `registers/lessons.md` has an `L#`
row whose `Feeds` names something broader than that one project — an
estimate class used elsewhere, a vendor shared across projects, a
methodology tailoring worth adopting — `portfolio-review` flags it for
propagation:

> `L3` in Mobile App ("vendor-gated milestones need an access-confirmation
> precondition") feeds the "third-party API integration" reference class.
> Data Migration also has a pending vendor integration in its next
> estimate — propose importing `L3` into Data Migration's
> `registers/assumptions.md` (origin: Mobile App `L3`) before its next
> `estimate` play runs.

Propagation is proposed, not silently applied — each sibling project's
next `estimate` or `initiate` play should confirm the import the way it
would confirm any imported lesson (§4 of `references/lessons.md`).

## 6. The boundary

**Portfolio prioritization — which projects deserve to exist, how budget
and headcount split across them, whether to fund a new one — belongs to
the strategy-board skill.** This play's job stops at reporting delivery
truth and surfacing the decisions that need to be made; it does not make
investment calls.

Concretely: `portfolio-review` can say "Vendor Portal is red for the
fourth consecutive month against a flat trend with no credible recovery
plan — this is a kill-review candidate" and hand that finding to
strategy-board. It does not itself recommend killing the project,
reallocating its budget to another project, or ranking projects against
each other by strategic value — those are exactly the judgment calls
strategy-board's board-of-lenses is built to make, with delivery truth
from this play as one of its inputs.
