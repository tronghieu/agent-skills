# Planning — structure, schedule, dependencies, baselining

The Frame lens (Aristotle). Read this before running `plan`. A plan is a
claim about the future wearing evidence, not a Gantt chart wearing hope —
every section below exists to make that claim checkable.

## Contents

- [Decomposition per dialect](#decomposition-per-dialect)
- [Milestone schema](#milestone-schema)
- [Dependencies & critical path](#dependencies--critical-path)
- [Baselining](#baselining)
- [Plan ↔ risk ↔ estimate integration](#plan--risk--estimate-integration)
- [Judge audit hook](#judge-audit-hook)

## Decomposition per dialect

Break the work down until each piece is small enough to be **countable** —
either done or not done, never "80% done" by feel. That single property is
what makes honest status reporting possible later (`references/status.md`);
a work package you can't count is a work package you'll eventually have to
lie about.

The shape of the breakdown follows `context/methodology.md`:

| Dialect | Breakdown | Countability comes from |
|---|---|---|
| Predictive | Work Breakdown Structure (WBS) down to work packages | a package has one owner, a defined output, and a duration short enough that "done" isn't a judgment call |
| Agile | Backlog: epics → stories, grouped into releases/sprints | a story is done when it meets its acceptance criteria, full stop |
| Hybrid | Milestone spine (predictive) with iterative interiors (agile) | milestones are countable by acceptance evidence; the interior work is countable by story/sprint |

**The 100% rule** governs the WBS and its hybrid cousin: at every level, the
children must cover 100% of the parent's scope — no more, no less. Two
failure directions, both common:

- **Under-100%** — work exists that traces to no WBS node. This is the
  planning-side twin of scope creep: effort gets spent, nobody can say
  against what.
- **Over-100%** — a child duplicates work already covered by a sibling.
  Padding disguised as thoroughness; it inflates the estimate silently.

Worked example (Capigo Mobile App, predictive dialect):

```
1.0 Offline sync module
  1.1 Local cache schema           (work package — 1 owner, 3-day duration)
  1.2 Conflict-resolution logic    (work package)
  1.3 Sync-on-reconnect handler    (work package)
  1.4 QA: offline scenario suite   (work package)
```

1.1–1.4 exhaust 1.0's scope with no overlap — a reviewer can check the
100% rule by reading the charter's scope-in list against these four rows
and finding nothing missing and nothing extra.

For agile, the equivalent discipline is: every story traces to an
opportunity or backlog item (never floats free), and a release's story list
is exhaustive against the release goal stated in `context/charter.md`.

## Milestone schema

`plan/schedule.md` holds the living milestone table (schema fixed by
`scripts/init-project.sh`):

| ID | Milestone | Target | Depends on | Status | Evidence |
|----|-----------|--------|------------|--------|----------|
| M3 | Offline sync demo accepted by sponsor | 2026-08-15 (user, 2026-07-01) | M2 | planned | acceptance: EV# citing sponsor sign-off, defined now |

The rule that prevents the most watermelon reports: **acceptance evidence
is defined at planning time, not invented at status time.** Write, for
every milestone, the sentence "M3 is done when \_\_\_" before any work
starts — a demo accepted by a named person, an export received, a test
suite green in CI. A milestone with no acceptance criterion is a
watermelon waiting to happen, because "done" will get negotiated under
deadline pressure instead of checked against a standing definition.

Target dates carry the same label discipline as everything else: a date
the sponsor imposed is `(user, <date>)`; a date derived from the estimate
range is cited to the `plan/estimates.md` row that produced it.

## Dependencies & critical path

Two kinds of dependency, and they get different treatment:

- **Internal** — one work package or milestone waits on another inside
  this plan. Record it in the `Depends on` column.
- **External** — the plan waits on something outside the team's control:
  a vendor delivery, another team's release, a legal approval, an
  environment. Source these from `context/environment.md`. **Every
  external dependency on the critical path auto-suggests a `registers/risks.md`
  entry** — something you don't control, on the path that determines your
  end date, is a risk by definition, not an optional one.

The **critical path** is the longest chain of dependent work from start to
the final milestone — the chain with zero slack, where any slip moves the
end date one-for-one. Identify it explicitly and name it in
`plan/schedule.md`; don't leave it implicit in a Gantt rendering nobody
reads that way. A plan that can't say "the critical path runs
M1→M2→M4→M6" hasn't actually been analyzed, only listed.

Worked example: M4 (payment gateway integration) depends on a vendor
sandbox credential (external, owned by Finance vendor — not this team).
That dependency sits on the critical path, so it auto-suggests
`R7 — vendor sandbox credential delayed past 2026-07-20` in the risk
register, with a trigger and an owner, rather than living only as a date
in a table.

## Baselining

The **living plan** (`plan/schedule.md`) is allowed to drift as reality
comes in — that's what makes it useful day to day. The **baseline** is not
allowed to drift; it is the promise the team made, frozen at the moment of
commitment.

- At commitment (sponsor sign-off, contract signature, whatever your
  charter names as the commitment event — cited as `EV#` or
  `(user, <date>)`), copy the current `plan/schedule.md` into
  `plan/baseline-<date>.md` verbatim. That file does not change again.
- The living plan keeps moving. Track variance by diffing the living plan
  against the *current* baseline, not by editing the baseline to match
  reality — that would erase the very slip you need to see.
- **Re-baselining is a recorded event, not a quiet overwrite.** It
  requires a `CH#` entry (`references/change-control.md`) with the
  accumulated changes that justify it. Create a new
  `plan/baseline-<date>.md`; keep every old one. The sequence of baselines
  *is* the project's slip history, and `references/estimation.md`'s
  reference-class forecasting reads directly from it — delete an old
  baseline and you delete the evidence the next estimate needs.

## Plan ↔ risk ↔ estimate integration

A plan is not ready to baseline just because every row has a date. It
ships only after two integrations are visibly done:

1. **Every milestone-driving estimate carries a basis label** — bottom-up,
   analogous, velocity-derived, or expert judgment, per
   `references/estimation.md` — resolving to `EV#`, `A#`, or
   `(user, <date>)`. A schedule built on unlabelled durations is a wish
   with a Gantt chart drawn over it.
2. **Top-scored risks have schedule reflections.** A risk scored high in
   `registers/risks.md` that has no visible effect on the plan — no
   buffer near it, no alternative path, no contingency milestone — means
   either the risk score is wrong or the plan is lying about how
   confident it is.

The integration runs both directions: a new external dependency discovered
while planning feeds a risk entry (previous section); a risk that
materializes or gets mitigated feeds a plan change through the same
`CH#` gate that governs any other schedule move.

## Judge audit hook

A **baseline** plan — one about to be committed to a sponsor or written
into `plan/baseline-<date>.md` — passes **Judge audit 1** (full checklist
in `references/pm-discipline.md`) first. In short, Solon checks that every
milestone has an owner, a dependency, and a labelled estimate; the
critical path is named; buffers are visible; a pre-mortem
(`references/risk.md`) has been run; charter scope reconciles with plan
scope; and known risks are reflected in the schedule, not just listed
beside it.

Findings ship visibly in the plan itself — as an appended audit section,
not a private note — and nothing gets quietly patched to make the audit
pass. If the user wants to commit externally over an open finding, that's
their call to make with the finding in view, recorded as dissent in
`registers/decisions.md`.
