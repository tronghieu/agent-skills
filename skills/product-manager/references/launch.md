# Plan-Launch: Risk-Scaled Launch Plans with Pre-Committed Rollback

The Ramp lens. Read `references/pm-discipline.md` first. The Judge launch
audit runs before the plan is executed. The through-line of this play:
**decide the abort conditions while you are still calm.** A team watching
a live dashboard at T+2h will rationalize any number it sees; the same
team a week earlier writes honest thresholds.

## Contents

- [Classify first: type × blast radius](#classify-first-type--blast-radius)
- [The launch plan: launches/launch-<release>.md](#the-launch-plan-launcheslaunch-releasemd)
- [Rollout sequencing](#rollout-sequencing)
- [Rollback criteria](#rollback-criteria)
- [Communications](#communications)
- [The post-launch review](#the-post-launch-review)

## Classify first: type × blast radius

Weight the plan to the risk, not to the excitement. Two axes:

- **Type**: new product · major feature · improvement/iteration.
- **Blast radius**: who is exposed (all users? one segment? opt-in?),
  **reversibility** (feature flag off = done? or data
  migration/pricing/API contract that cannot be un-shipped?), and
  external commitments (press, contractual dates).

Classify into three classes and say which:

| Class | Typical shape | Plan weight |
|---|---|---|
| **Low** | flagged improvement, opt-in, instantly reversible | one page: stages, one metric, one rollback trigger |
| **Medium** | major feature, broad exposure, reversible with effort | full plan below |
| **High** | new product, migration, pricing/API change, irreversible parts | full plan + rehearsed rollback + named go/no-go owner per stage |

Irreversibility beats size: a small change to billing data is High; a big
flashy feature behind a flag is Medium at most. If the PRD's launch note
flagged migration or contract changes, the class is already decided.

## The launch plan: launches/launch-<release>.md

```markdown
# Launch: <release>            class: medium · status: planned
prd: specs/prd-onboarding.md · target: 2026-08-05

## What ships & to whom
(one paragraph; flags, platforms, segments)

## Success = the PRD's promise
Target: week-1 activation 22% [S4] → 30% · Guardrails: p95 load,
ticket volume, activation of *existing* cohorts
Instrumentation confirmed: yes/no (a launch that can't measure its
promise fails the audit)

## Rollout stages
(table below)

## Rollback
(triggers + mechanism + owner — below)

## Communications
(internal, external, support — below)

## Readiness checklist
(the short list that is actually checkable: instrumentation live, support
briefed + macros ready, docs updated, flags tested both directions,
rollback rehearsed [High class], legal/compliance if applicable)

## Post-launch review — scheduled <date T+2wk>
(filled in after; see below)

## Judge audit — <date>
```

## Rollout sequencing

Stages with **numeric entry/exit criteria fixed in advance** — a stage
gate you define after seeing the data is a rubber stamp:

```markdown
| Stage | Exposure | Min duration | Advance when | Abort when |
|---|---|---|---|---|
| Internal | staff | 3 days | zero P0/P1 | any P0 |
| Beta | 5% opt-in | 1 week | activation ≥ baseline−2pp, tickets <2/day | ticket spike 3× |
| Ramp | 25% → 50% | 1 week each | guardrails hold at each step | rollback triggers |
| GA | 100% | — | — | rollback triggers |
```

Percentages and durations scale with class; Low class may be
internal → GA. Each stage has one named decision owner — "the team
decides" means nobody decides.

## Rollback criteria

The heart of the plan, and the audit's first check. Three properties:

1. **Numeric and pre-committed.** "Error rate >2% sustained 30min",
   "activation drops >5pp vs holdout for 48h", "P0 affecting >1% of
   sessions". Not "if things look bad".
2. **Mechanism named and tested.** Flag off / staged rollback / data
   restore — with the *actual command or runbook link*, and for High
   class, rehearsed before launch (an untested rollback is a hypothesis,
   and launch day is a bad time for hypotheses).
3. **Owner named.** Who watches, who pulls the trigger, who can veto —
   one name each.

Include a **hold-fix-rollback ladder**: not every trigger means full
rollback — define which triggers pause the ramp, which demand
fix-forward within a time box, and which mean immediate rollback. A
data-corrupting trigger is always immediate.

## Communications

Scale to class; the invariant is **support and sales hear it before
customers do**.

- **Internal**: what changed, who is exposed, where the dashboard is, the
  rollback runbook link, who owns launch-day decisions.
- **Support**: expected questions with answers (macros), known rough
  edges, escalation path with names.
- **External** (when warranted): changelog/announcement matched to
  actual stage exposure — announcing at GA what only 25% can see
  manufactures support tickets.

## The post-launch review

Scheduled in the plan (typically T+2 weeks; High class also T+1 week),
not left to memory. Three questions, written into the launch file:

1. **Did the promise hold?** Target metric vs the PRD's labelled
   baseline, guardrails vs their baselines — numbers with `[S#]` tags to
   the live dashboard/export.
2. **What did we learn?** Assumption statuses updated (`validated (E#)` /
   `falsified`), surprises logged, new feedback routed to
   `feedback-log.md` for the Echo lens.
3. **What now?** Iterate / expand / hold / retire — appended to
   `decisions.md` with a revisit-trigger, and the backlog entry updated.

A launch without its review is a bet nobody settled: the roadmap keeps
paying interest on claims ("onboarding is fixed now") that were never
checked. Close the loop or don't call it shipped.
