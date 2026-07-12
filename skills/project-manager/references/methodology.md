# Methodology — choosing and tailoring predictive, agile, or hybrid

The skill itself is methodology-agnostic; the *project* has a methodology.
This file is the selector `initiate` uses when the user hasn't already
chosen one, and the tailoring reference `plan` and `report-status` consult
when a project's dialect needs adjusting mid-flight. The choice, and any
tailoring, get recorded in `context/methodology.md` with rationale — never
assumed silently from the tools the team happens to already use.

## The selector

Ask about the work, not about preference — a team that loves Scrum
ceremonies still needs predictive rigor for a fixed-date regulatory
filing. Five decision factors, weighed together rather than any one
deciding alone:

| Factor | Leans predictive | Leans agile |
|--------|-------------------|-------------|
| Requirements stability | Scope is well-understood and unlikely to change (a known migration, a compliance filing) | Scope will genuinely evolve as users see working increments |
| Feedback availability | No real user/customer feedback loop available during delivery | Regular access to real users who can react to increments |
| Contract/compliance shape | Fixed-price, fixed-scope contract, or a regulatory deadline with a hard external date | Internal product work, or a contract that explicitly buys capacity, not a scope list |
| Team distribution | Distributed, part-time, or multi-vendor team where synchronous ceremonies are costly | Co-located or well-synced team that can sustain short iteration cadences |
| Delivery risk profile | High cost of being wrong late (physical construction, hardware, irreversible migrations) | Low cost of change; increments can be revised cheaply |

Score honestly rather than picking a favorite: a project with stable
scope, no user feedback loop, and a hard regulatory date is predictive
even if the team's instinct is "we do agile here." Record the choice and
the rationale in `context/methodology.md` — the rationale matters more
than the label, because it is what a later re-evaluation checks against.

## Predictive dialect

**Wins when:** scope is genuinely fixed or externally mandated, the cost
of late change is high, and there is no meaningful feedback loop to
iterate against during delivery.

**Artifact shapes:**
- `plan` → WBS with the 100% rule, a Gantt-style schedule, a named
  critical path, stage gates.
- `estimate` → bottom-up, reconciled against a reference class.
- `report-status` → EVM-lite (planned value / earned value where the data
  supports it) or milestone-percent-complete with a countable denominator.

**Classic failure:** change resistance — scope changes get absorbed
silently to avoid the friction of a formal change request, until the
baseline is fiction and nobody can say what was actually committed.

**The counter:** a change gate that is fast for genuinely small changes
(`references/change-control.md` — same rigor, one exchange, still a row)
so raising a `CH#` is never slower than staying silent about scope creep.

## Agile dialect

**Wins when:** requirements will genuinely evolve, real users or
customers are available to react to increments, and the cost of revising
a shipped increment is low.

**Artifact shapes:**
- `plan` → backlog with releases/sprints, capacity-based, not date-based
  at the story level.
- `estimate` → velocity-derived, reconciled against a reference class
  the same way a bottom-up estimate is — velocity is not exempt from
  scrutiny just because it's a team-generated number.
- `report-status` → burnup charts and flow metrics (cycle time, WIP).

**Classic failure:** velocity theater and scope-creep-by-backlog — a
velocity number massaged to look stable regardless of what actually
shipped, and scope that grows one "small" backlog item at a time with no
release-level gate ever triggered.

**The counter:** velocity is only citable as `EV#` when it comes from real
sprint data (a sprint report export, not a recalled average), and each
release still passes through the same scope gate a predictive project's
baseline does — the release commitment is the agile project's baseline.

ROAM (Resolved / Owned / Accepted / Mitigated — `references/risk.md`)
is dialect-neutral and reads the same in both worlds; it lives in the risk
reference, not duplicated here.

## Hybrid dialect

**Wins when:** the external commitment structure needs predictive-style
milestones (a client date, a regulatory checkpoint) while the work inside
each milestone benefits from iteration (uncertain implementation detail,
a team that wants to show increments to a subset of stakeholders).

**Shape:** a **milestone spine** — predictive-style `M#` milestones with
dates and dependencies — with **iterative interiors**, where the work
between milestones runs as sprints or short cycles with their own backlog
and burnup.

**Reconciling the two status views without double-counting:** the
milestone spine reports RAG against the external commitment (has the
milestone's acceptance evidence landed, on schedule); the interior burnup
reports flow inside the current milestone window. A status report cites
both, but the RAG color is driven by the spine, not by interior velocity
looking healthy — a green burnup inside a milestone that is about to miss
its external date is still an amber or red milestone.

## Tailoring rules

Cadence, artifact weight, and ceremony detail bend to fit the project;
the **five non-negotiables never do** (`SKILL.md`): every number
declares its origin, estimates confront history, scope changes pass the
gate, the workspace is the truth, and Judge audits run before artifacts
ship. An agile burnup with an invented velocity number is exactly as fake
as a predictive Gantt chart with invented dates — the dialect changed, the
discipline didn't.

What may bend, with the tailoring recorded in `context/methodology.md`
alongside its rationale:
- Reporting cadence and format detail (a two-line Slack update vs a full
  status document) — but never the provenance labels inside it.
- Ceremony frequency (weekly vs biweekly risk review) — but never skipping
  the sweep silently instead of recording a deliberate cadence change.
- Which artifact shapes get used at what depth (a two-week internal
  project may skip a formal WBS and go straight to a milestone list) —
  but the acceptance-evidence-per-milestone rule still applies at
  whatever granularity is chosen.

## Switching mid-project

A methodology switch — predictive to hybrid because a client now wants
visibility into increments, or agile to predictive because a regulatory
deadline just landed — is not a vibe shift the team quietly starts doing
differently in standup. It is a `CH#` in `registers/changes.md` with an
impact assessment (`references/change-control.md`): what it costs to
re-shape the plan and estimates, what risk it introduces during the
transition, and who decided. `context/methodology.md` records the new
choice and rationale only *after* the change is decided, not before —
recording it early implies the switch already happened when it's still a
proposal.
