# PM Discipline: Number Provenance, Assumptions, Sensitivity, and the Judge Audits

The machinery that makes the non-negotiables enforceable. Read this before
writing any decision artifact — a prioritization, a PRD, an OKR file, a
launch plan. The schema exists because a fabricated input is
indistinguishable from a real one by looks alone: "Reach: 12,000/quarter"
reads identically whether it came from analytics or from thin air.
Provenance labels are the only defense, and one unlabelled number makes
every number in the artifact suspect.

## Contents

- [Number provenance: the three legal labels](#number-provenance-the-three-legal-labels)
- [The registries](#the-registries)
- [The assumption registry: backlog/assumptions.md](#the-assumption-registry-backlogassumptionsmd)
- [Sensitivity analysis](#sensitivity-analysis)
- [The decision log: decisions.md](#the-decision-log-decisionsmd)
- [state.md](#statemd)
- [The Judge audits](#the-judge-audits)
- [The user-facing reply is an artifact too](#the-user-facing-reply-is-an-artifact-too)
- [Self-check before handing off any artifact](#self-check-before-handing-off-any-artifact)

## Number provenance: the three legal labels

Every quantitative input to a decision carries exactly one of:

| Label | Means | Example |
|-------|-------|---------|
| `[S#]` | Traces to a registered source — analytics, a report, raw data | `Reach: 11,400 MAU in segment [S4]` |
| `A#` | A registered assumption with a stated basis and range | `Impact: 1.5 (A3 — no direct evidence, analogous feature moved metric ~40%)` |
| `(user estimate, <date>)` | The user said so, on the record | `Effort: 6 wk (user estimate, 2026-07-11)` |

Rules of use:

- **Missing input → ask or register, never invent.** "I don't have a reach
  figure for this segment — do you have analytics, or shall I register an
  assumption with a range?" is always the right move. Filling the cell with
  a plausible number to keep the table tidy is the exact failure this skill
  exists to prevent.
- **User estimates are legitimate but dated.** A PM's gut estimate is a
  real input; the label keeps it honest and revisitable. If it later proves
  load-bearing, promote it to an `A#` with a range and sensitivity-test it.
- **Derived numbers show their arithmetic inline**, with each input
  labelled: `RICE = (11,400 [S4] × 1.5 (A3) × 0.6 (A4)) / 6 (user
  estimate, 2026-07-11) = 1,710`.
- **Qualitative claims follow the same spirit**: claims about what users
  need or feel cite `[I#]`/`[S#]`/`FB#` or carry
  `(hypothesis — needs validation)`. This skill inherits design-thinking's
  insight rules wholesale; do not relax them because "this is just a
  backlog note".

## The registries

Three registries, shared schemas with the sibling skills so artifacts can
flow between workspaces without translation:

- **`discovery/sources.md`** — `[S#]` rows: `| ID | Source | Publisher |
  Published | Accessed | Confidence | Notes |`. Same schema as
  market-researcher and design-thinking, deliberately: when those skills
  write into this workspace they append and continue the numbering. Never
  renumber or reorder existing rows.
- **`discovery/insights.md`** — `[I#]` insight blocks (Evidence /
  Interpretation / Status / Confidence). When importing from a
  design-thinking workspace, copy the blocks verbatim with their ids and
  note the origin. Locally registered insights follow the same schema and
  the same status ladder (`evidenced` / `hypothesis` / `validated (E#)` /
  `falsified (E#)`).
- **`discovery/feedback-log.md`** — `FB#` rows (schema in
  `references/feedback.md`). Raw feedback the user drops (support exports,
  NPS verbatims, sales notes) also gets an `[S#]` row so quotes from it are
  citable.

## The assumption registry: backlog/assumptions.md

One table, append-only ids:

```markdown
# Assumptions

| ID | Statement | Basis | Range (low–high) | Used by | Status |
|----|-----------|-------|------------------|---------|--------|
| A3 | New onboarding lifts week-1 retention | analogous change at prior company; no local evidence | +10% – +40% | OP2 impact, prd-onboarding | open |
| A4 | ~60% of churn is onboarding-related | support-ticket skim [S6], not coded systematically | 40% – 75% | prioritization-2026-07 | open |
```

- **Statement** is falsifiable — written so an experiment could kill it.
- **Basis** says where the guess comes from; "gut feel" is an acceptable
  basis, but it must say so.
- **Range** is the honest interval, used directly by sensitivity analysis.
  A point value with no range is not a registered assumption; it is an
  invented number wearing a label.
- **Used by** lists every artifact leaning on it — so when an experiment
  settles the assumption, you know exactly what to revisit.
- **Status**: `open` · `validated (E#)` · `falsified (E#)` · `retired
  (reason)`. A falsified assumption triggers a walk through its Used-by
  list; stale statuses corrupt every later decision.

## Sensitivity analysis

Required whenever a ranking or go/no-go rests on `A#` or user-estimate
inputs (non-negotiable 2). The method is deliberately cheap:

1. For each assumption-based input, take the low and high ends of its
   registered range.
2. Recompute the decision output (RICE ranks, break-even, OKR
   feasibility) at both ends — worst-case and best-case per assumption,
   one at a time.
3. Classify each conclusion:
   - **Robust** — holds across all ranges. Say so; this is what makes the
     recommendation trustworthy.
   - **Sensitive** — flips within a plausible range. Name the assumption
     that flips it; this is your highest-value experiment candidate (hand
     to the Lab lens).
   - **Borderline** — items too close to separate. Present as a tie broken
     by strategy, not by fake decimal places.
4. Write the result *in the artifact*, next to the ranking it qualifies —
   not in an appendix nobody reads.

The payoff: sensitivity converts "trust my math" into "here is exactly
which belief your decision depends on" — which is what a good PM owes the
room.

## The decision log: decisions.md

Append-only. Every play that ends in a decision writes an entry:

```markdown
## 2026-07-11 — Q3 priority: onboarding rework over offline mode
- **Decision:** build OP2 (onboarding rework) first; OP5 (offline mode) next.
- **Alternatives considered:** OP5 first (higher enterprise pull [FB12]).
- **Why:** RICE robust across ranges (prioritization-2026-07-11.md);
  onboarding churn is the north-star bottleneck [S4][I3].
- **Against advice / dissent:** none.
- **Revisit when:** E2 (onboarding-churn assumption A4) reports, or
  enterprise deal >$100k ARR blocked on offline mode.
```

- The **revisit-when** line is mandatory — a decision without a
  reversal trigger silently becomes dogma.
- **Dissent is recorded, not erased** — including this skill's own
  disagreement when the user overrules it (Habits: challenge before you
  comply). The log is the product's institutional memory; sanitized logs
  teach nothing.
- On re-entry, the latest entries of this file are the first thing read.

## state.md

Short and current — what is open, not what happened (history lives in
`decisions.md`):

```markdown
# State: <product>

open_plays:
  - write-prd (offline-mode): drafted, waiting on eng estimate from user
  - design-experiment (A4): E2 running, results due ~2026-07-20
waiting_on_user:
  - engineering effort estimate for offline-mode stories S-slice-1
last_session: 2026-07-11 — Q3 prioritization decided (see decisions.md)
```

## The Judge audits

Adversarial, evidence-first, run before the user is asked to act on a PRD,
a prioritization, or a launch plan. Use a separate subagent when available
— the author of an artifact is the worst judge of its provenance. Findings
are appended to the artifact under `## Judge audit — <date>`; nothing is
quietly fixed or quietly dropped, and any fix propagates to every file
repeating the flagged content (grep the workspace for the flagged string
before closing a finding).

### Audit 1 — PRD (before user sign-off)

1. **Problem trace.** Does the problem statement cite `[I#]`/`[S#]`/`FB#`,
   or carry an explicit bet label? A problem statement resting on "users
   want" with no tag fails.
2. **Outcome named.** Is there a target metric from `strategy/metrics.md`
   with a labelled baseline, plus guardrail metrics?
3. **Testable stories.** Sample 5 acceptance criteria: is each observable
   or measurable? "Works smoothly" fails; "loads in <2s on 3G" passes.
4. **Story-map coverage.** Does the map's backbone cover the actual
   evidenced journey, or does it contain invented activities no evidence
   mentions?
5. **Won't list.** Does the release slice have an explicit, dated
   Won't-have list? An empty Won't list means scope was never actually
   decided.
6. **Assumption honesty.** Are load-bearing unknowns registered as `A#`
   and linked, or smuggled in as facts?

### Audit 2 — Prioritization (before the ranking is presented as final)

1. **Provenance sweep.** Every R/I/C/E cell and every Kano label carries
   one of the three legal labels. One naked number fails the whole table.
2. **Sensitivity done.** Ranges applied, robust/sensitive/borderline
   classification present and next to the ranking.
3. **Kano method honesty.** Survey-based labels cite the survey `[S#]`;
   unlabelled gut Kano categories are re-labelled `A#` or removed.
4. **Strategic-adjustment transparency.** Any post-RICE reordering is
   written down with its reason — silent reordering defeats the point of
   scoring.
5. **Denominator check.** Reach figures use the same time window and
   population across rows; mixed windows silently rig rankings.

### Audit 3 — Launch (before the plan is executed)

1. **Rollback criteria are numeric and pre-committed.** Thresholds
   (error rate, metric drop, ticket spike) fixed before launch, with the
   rollback mechanism named. "We'll monitor closely" fails.
2. **Risk class honest.** Does the declared blast radius match the plan's
   weight? A data-migration launch with a lightweight checklist fails.
3. **Stage gates falsifiable.** Each rollout stage has numeric entry/exit
   criteria fixed in advance.
4. **Measurement wired.** The PRD's target metric is instrumented and a
   post-launch review date is set — otherwise the launch can never be
   judged against its promise.

## The user-facing reply is an artifact too

Everything above applies to the message you send the user, not only to
the workspace files — the reply is the artifact most people will ever
read. Concretely:

- **Quote discipline covers the reply.** Any customer speech quoted in
  the reply is verbatim from its source, elisions marked with `…`, id
  attached. A quote trimmed "for the summary table" is a fabricated
  quote.
- **The reply stands alone.** The load-bearing evidence — the decisive
  quotes, the counts with their denominators, the ranking or decision
  itself — lives *in the reply*. Files hold the full detail; they are
  never an excuse for a reply that says "see the files" where the
  substance should be. A reader who never opens the workspace should
  still get the finding, the evidence for it, and the recommendation.
- **Reference files by workspace-relative path** (`backlog/assumptions.md`),
  never by absolute filesystem path.
- **Speak as a PM, not as a methodology.** No "per this skill's rules",
  no naming the machinery to the user. The labels and audits appear in
  the work; the voice is a colleague explaining a recommendation.

## Self-check before handing off any artifact

Thirty seconds, every time:

1. Any number with no `[S#]`/`A#`/user-estimate label? (Ask, register, or cut.)
2. Any `A#` used as a point value with no range? (Add the range.)
3. Any claim about users with no `[I#]`/`[S#]`/`FB#` and no hypothesis label? (Fix or cut.)
4. Any id that doesn't resolve to its registry? (Register it.)
5. Ranking or go/no-go resting on assumptions with no sensitivity pass? (Run it.)
6. Decision made this session not yet in `decisions.md` with a revisit-trigger? (Append it.)
7. Any status an experiment has already changed but a file still shows the old one? (Update, and walk the Used-by list.)
8. Does the reply stand alone — key quotes verbatim with ids, counts with denominators, the recommendation inline; no absolute paths, no methodology talk? (Fix the reply.)
