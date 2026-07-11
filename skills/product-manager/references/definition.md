# Write-PRD: Problem Framing, Story Mapping, Stories, and MoSCoW

The Scope lens. Read `references/pm-discipline.md` first. A PRD is the
artifact engineers and designers will act on for weeks — which makes it
the most expensive place in the workspace for an untraceable claim to
hide. The Judge PRD audit runs before user sign-off.

## Contents

- [When this play runs](#when-this-play-runs)
- [The PRD: specs/prd-<feature>.md](#the-prd-specsprd-featuremd)
- [Problem statement: JTBD framing](#problem-statement-jtbd-framing)
- [The story map](#the-story-map)
- [User stories and acceptance criteria](#user-stories-and-acceptance-criteria)
- [MoSCoW: drawing the release line](#moscow-drawing-the-release-line)
- [PRD hygiene](#prd-hygiene)

## When this play runs

Ideally after prioritize has picked the opportunity (`OP#` status
`prioritized`), so the PRD inherits a traced problem and a target metric.
When the user arrives asking for a PRD cold ("write me a PRD for X"),
serve it — but run a two-minute orient first: what problem, what evidence
exists, what metric should move. If the answers are "none yet", write the
PRD anyway with the problem statement honestly labelled
`(hypothesis — needs validation)` and say what that costs: the spec
becomes a bet, and the launch plan should treat it as one.

## The PRD: specs/prd-<feature>.md

```markdown
# PRD: <feature>            status: draft | in-review | approved | shipped
opportunity: OP2 · owner: <user> · updated: <date>

## Problem
(job story + evidence — see below. Non-goals: what this PRD deliberately
does not address, so scope creep has to argue with a written sentence.)

## Outcome
Target metric: week-1 retention 22% [S4] → 30% (A5: expected lift range
+5–12pp). Guardrails: activation time, support ticket volume — numbers
that must NOT get worse.

## Solution overview
(2–4 paragraphs; the shape of the solution and why this shape beats the
alternatives considered. Cite ideas/prototypes if they came from a
design-thinking workspace.)

## Story map
(see below — the backbone, the walking skeleton, the release slices)

## Stories
(per slice, with acceptance criteria)

## Scope — MoSCoW (this release)
(all four tiers visible: Must / Should / Could per story or slice, then
the Won't list below — Could-haves are in-scope-if-cheap and must not be
conflated with Won'ts)

### Won't have — this release
(explicit, dated — see MoSCoW)

## Non-functional requirements
(performance, security, accessibility, data — only the ones with teeth:
each testable, each with a reason)

## Risks & assumptions
(A# links; what falsifies this spec and which experiment E# is watching it)

## Launch note
(risk class guess for the Ramp lens; anything with migration/irreversibility
flagged early)

## Open questions
(what's unresolved and who owns resolving it)

## Judge audit — <date>
(findings shipped visibly)
```

## Problem statement: JTBD framing

Write the problem as a job story — situation, motivation, outcome:

> When I sign up to evaluate the product on company time **[FB4, FB9]**, I
> want to reach a working result in one sitting, so I can justify adopting
> it before my trial attention runs out **[I3]**.

- Each clause traces to `[I#]`/`FB#`/`[S#]` or the whole statement carries
  the hypothesis label. The job story is inherited from the backlog entry
  when one exists — don't re-derive what `opportunities.md` already holds.
- The job story keeps the PRD honest about *progress the user is trying to
  make*, which is what protects the solution section from becoming a
  feature checklist. Functional, emotional, and social dimensions of the
  job all matter — an evaluation flow is also about looking competent to
  the boss who approved the trial.
- **Non-goals are part of the problem statement.** Adjacent jobs
  deliberately not served, segments deliberately not targeted — written
  down, so every future "while we're at it" has to argue with a sentence
  instead of a vacuum.

## The story map

Story mapping (Patton) turns the chosen opportunity into structure before
stories are written — it is the bridge between "problem worth solving"
and "tickets someone can build". Build it in the PRD as a table:

```markdown
| Backbone → | Discover value | Set up | First real use | Share result |
|---|---|---|---|---|
| Walking skeleton | sample project on signup | one-field setup | guided first run | copy-link export |
| Slice 2 | — | import own data | templates | PDF export |
| Later | — | team invites | automation | scheduled reports |
```

- **The backbone** is the user's activity sequence for the job, left to
  right — and it must cover the *evidenced* journey. An activity no
  interview, feedback entry, or analytics funnel ever mentioned is a
  fabricated step (the Judge audit checks this); either find the evidence
  or mark it as an assumption.
- **The walking skeleton** (top row) is the thinnest end-to-end path that
  delivers the job — every backbone column represented, nothing gold-plated.
  Slicing horizontally (release = a thin path through *all* activities)
  beats slicing vertically (release = one activity built deep): a user can
  finish the job badly, then better — never half a job.
- Rows below the skeleton are subsequent slices in rough priority order;
  the release line is drawn with MoSCoW, next.

## User stories and acceptance criteria

Stories are cut from the map's cells — the map is the source of truth for
coverage; a story that maps to no cell is scope creep in ticket form.

```markdown
### S-2.3 — Import own data (slice 2)
As an evaluating team lead, I want to import my existing CSV, so that the
first real use runs on my numbers, not the sample's.

Acceptance:
- Given a CSV ≤ 50MB with headers, when imported, then columns are
  auto-mapped and a preview shows before commit.
- Given a malformed row, when imported, then the row is skipped and
  reported by line number — the import never fails wholesale.
- Import completes in < 30s for 100k rows on the reference plan.
```

- Keep INVEST as the bar (independent, negotiable, valuable, estimable,
  small, testable) — "testable" carries most of the weight: every
  acceptance criterion is observable or measurable. "Works smoothly" is
  not a criterion; it is a hope.
- Given/When/Then is the default format because it forces a concrete
  scenario; drop the ceremony for constraints that read better as plain
  bounds (the < 30s line above).
- Acceptance criteria are where the PRD's guardrail metrics reach the
  ticket level — if the PRD promises "activation time must not get
  worse", some story's criteria must enforce it.

## MoSCoW: drawing the release line

MoSCoW scopes **one release of one feature** — it never ranks the
portfolio (that was RICE's job, one altitude up; see
`references/prioritization.md`).

- **Must** — the release is pointless or dishonest without it. The walking
  skeleton is usually all-Must by construction.
- **Should** — real value, painful to cut, survivable.
- **Could** — opportunistic; first overboard when estimates slip.
- **Won't (this release)** — explicit, dated, with one line of reasoning
  each.

The **Won't list is mandatory and is the whole point**: an empty Won't
list means scope was never actually decided, just deferred to the first
crunch — and the crunch will decide worse than you would have. (Same
spirit as strategy-board's "what we will not do".) Musts deserve
suspicion: when more than ~60% of the release is Must, the release is
probably a bundle of two releases wearing one name — re-slice the map.

## PRD hygiene

- **The PRD inherits, it doesn't restate.** Link `OP#`, cite `[I#]`/`[S#]`
  ids; don't paraphrase evidence into new uncited sentences — paraphrase
  drift is how fabrication sneaks into specs.
- **Status discipline.** `draft → in-review → approved → shipped`; the
  Judge audit runs at `in-review`; approval is the user's, recorded in
  `decisions.md` with a revisit-trigger ("revisit if E2 falsifies A5").
- **Update, don't fork.** Post-approval changes edit the PRD with a
  changelog line, so there is exactly one truth per feature. When the
  feature ships, mark the backlog entry `shipped` and hand the target
  metric to the launch plan's post-launch review.
