# Initiation — staged intake, context schemas, and the charter

Runs the `initiate` play (Plato · Anchor). The goal is a workspace that
tells the truth about a project on day one — not a fully populated
`context/` folder. A charter with three fabricated success criteria looks
more finished than an honest one with two confirmed and a question mark,
and it is worse, because everything downstream (estimates, status colors,
change decisions) inherits its fiction. Read this before running
`initiate`, and again whenever a context file needs a genuine update, not
just a touch-up.

## Staged intake

Round one gets the **minimum viable context** in a single exchange — not
an interrogation:

1. Project name and objective, in the user's own words.
2. Methodology — already chosen, or help choosing now
   (`references/methodology.md`).
3. Reporting cadence and audience — who needs to hear what, how often.
4. What already exists — a charter, a plan, a Jira board, nothing at all.

That is the whole first exchange. The anti-pattern to name explicitly and
avoid is the **twenty-question wall**: asking for a RACI matrix, a full
stakeholder map, and a risk appetite statement before the user has said
what the project even is. Everything else in `context/` fills lazily, each
file elicited by the play that first needs it — `assess-risks` asks for
`team.md` roles when it needs an owner, `report-status` asks for
`stakeholders.md` when it needs an audience list. A field sitting empty in
a template is fine; a field asked for before any play needs it is friction
with no payoff.

## Register what the user brought

Most projects arriving at this skill are not starting from zero. Handle
imports as first-class, not as an afterthought:

- **An existing charter or plan** → copied into `context/charter.md` or
  `plan/` with a source label ("imported from `project-brief.docx`, user,
  2026-07-11") on the fields that came from it. Never retype numbers by
  hand — copy them, then verify (`references/pm-discipline.md`,
  copy-never-retype).
- **An existing tracker (Jira, Asana, a spreadsheet)** → the export or a
  screenshot becomes an `EV#` row in `registers/evidence.md` ("EV1 —
  Jira export, 42 stories across 3 epics, 2026-07-11"), and the plan or
  backlog is built from that export, not from a fresh guess at scope.
- **Continuing numbering, not resetting it.** If the user is migrating
  from another PM tool or a prior document that already used `R#`, `A#`,
  or milestone codes, continue that sequence rather than renumbering —
  renumbering breaks every reference the user's team already has memorized
  in meetings and emails.
- **What can't be verified yet stays labelled as such.** A verbal "we're
  about 60% done" from the kickoff call is `(user, <date>)`, not silently
  promoted to a fact — it gets promoted to `EV#` only when an export or
  sign-off backs it.

## Context file schemas

Every file in `context/` follows the same discipline: each entry carries
an **origin label** (where the fact came from) and the file as a whole
carries a **revisit-trigger** (the event that makes its content stale).
`init-project.sh` creates the skeletons; this section is what fills them
in correctly.

| File | Required fields | Revisit when |
|------|-----------------|---------------|
| `charter.md` | objective + measurable success criteria, scope In/Out, sponsor, decision authority, key dates & budget (labelled committed vs internal target) | sponsor changes, objective renegotiated, re-baseline |
| `methodology.md` | choice (predictive/agile/hybrid) + rationale, cadences, tailoring notes | delivery consistently misses cadence, team or scope shifts shape |
| `team.md` | roster, role, capacity; RACI filled only when a play needs it | roster changes, capacity shifts materially |
| `stakeholders.md` | stakeholder map (interest/influence/attitude), communication plan (audience/content/cadence/channel/owner) | a new stakeholder gains influence, a report recipient changes |
| `environment.md` | tools/sources of record, external dependencies, constraints & calendar | a tool changes, a new external dependency appears |
| `glossary.md` | project-specific terms and their meaning here | a term's meaning drifts or a new one enters common use |

**Staleness rule.** A context entry is not trusted forever just because it
was true once. If the file's revisit-trigger event has plausibly occurred
(a status report mentions a new sponsor; a stakeholder map is six months
old on a project with monthly milestones) and the file hasn't been
touched, flag it at the next re-entry rather than silently relying on it:
"`stakeholders.md` hasn't been updated since the sponsor changed in May —
want to confirm it's still accurate before I draft this comms plan?"

## Charter elicitation

The charter (`context/charter.md`) is the one context file worth genuine
elicitation effort in round one, because it is the reference point every
later change and every status color gets checked against.

- **Success criteria are measurable, not aspirational.** "Improve customer
  onboarding" is a direction, not a criterion. Push once for the
  measurable version: "time-to-first-value under 5 minutes, measured from
  signup event to first successful export (user, 2026-07-11)." If the user
  can't yet make it measurable, register that gap explicitly rather than
  inventing a number to fill the cell.
- **The Out-of-scope list is explicit and dated.** This is the project's
  first scope-creep defense — every later "can we just also..." gets
  checked against this list before it becomes a `CH#`. An empty Out list
  means scope was never actually decided, only implied.
- **Decision authority is a name, not a role description.** "The sponsor
  decides go/no-go; Jonas Bekker approves any `CH#` over 1 week of schedule
  impact" is usable by `control-change` later. "Management approves
  changes" is not — it names nobody `control-change` can escalate to.

Worked example (a charter excerpt, every entry labelled):

```markdown
## Objective & success criteria
- Cut support-ticket volume for onboarding issues by 30% (user, 2026-07-11)
- Time-to-first-value under 5 min, measured signup → first export
  (target set at kickoff; baseline not yet measured — registered as A1,
  range 8–15 min based on support-team estimate, used by plan/estimates.md)

## Scope
### In
- Redesigned onboarding flow, web only (user, 2026-07-11)
### Out (explicit — the Won't list)
- Mobile app onboarding (explicitly deferred to Q4, per sponsor, 2026-07-11)
- SSO integration (out of budget envelope, user, 2026-07-11)

## Sponsor & decision authority
- Sponsor: Omar Haddad (go/no-go)
- CH# approval over 1 wk schedule impact: Omar Haddad; under 1 wk: PM discretion
```

## Behaviorally-anchored intake scales

Some initiate-time questions are inherently fuzzy — "how healthy is this
project," "how mature is this team," "how engaged is the sponsor" — and
asking the user to "rate 1–5" produces a number with no shared meaning
across projects or re-raters. Use descriptive anchors instead, so a 2
means the same thing every time it's used:

**Sponsor engagement**

| Level | Anchor |
|-------|--------|
| 1 | Sponsor unreachable or uninterested; decisions stall for weeks with no escalation path |
| 2 | Sponsor responds when chased; no proactive involvement; go/no-go calls take multiple follow-ups |
| 3 | Sponsor attends scheduled reviews; responds within the reporting cadence; makes decisions when asked |
| 4 | Sponsor proactively flags risks and blockers; decisions come back faster than the cadence requires |
| 5 | Sponsor actively unblocks across other teams; treats this project's asks as their own priority |

**Team delivery maturity**

| Level | Anchor |
|-------|--------|
| 1 | No shared estimate history; every estimate is a fresh guess; no retro habit |
| 2 | Some estimate history exists but isn't consulted; retros happen but don't change behavior |
| 3 | Estimates check against `registers/lessons.md` when someone remembers to; retros produce actions sometimes acted on |
| 4 | Reference-class checking is routine; most retro actions get done |
| 5 | Estimate accuracy is tracked over time and visibly improving; lessons demonstrably change future plans |

Record the level with its anchor text, not just the number — "sponsor
engagement: 2 (responds when chased, no proactive involvement) (user,
2026-07-11)" — so a future reader doesn't have to guess what a bare "2"
meant six months later.

## Brownfield start

Initiating mid-project (the team has been running for months before this
workspace existed) is common, and it tempts a clean-looking fake history:
a baseline that was never actually frozen, an evidence trail that was
never actually kept. Don't fake it:

- **Reconstruct honestly, and label the reconstruction.** A milestone
  believed complete based on team recollection is `A#` ("A1 — team recalls
  M1 shipped early June; no export confirms the exact date"), not a
  fabricated `EV#`.
- **The first real baseline is dated today, not backdated.** `plan/
  baseline-<today>.md` reflects the plan as understood *now*; it is not
  dressed up as the original commitment if no record of the original
  exists.
- **Ask for whatever record does exist** — old status emails, a Slack
  history, a prior spreadsheet — before reconstructing from memory alone;
  each becomes an `EV#` row citing its source, even if informal.
- **State the gap plainly to the user**: "I can rebuild a working plan
  from what you've told me, but the history before today will carry `A#`
  labels, not `EV#` — there's no record to point to. That's fine for
  planning forward; it means slip analysis before today is soft."
