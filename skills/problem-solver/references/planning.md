# Planning and session continuity

A decision without a plan is a wish; a plan without pivot triggers is a
wish with a Gantt chart. This phase turns the decision into committed
actions — and builds in the admission that the diagnosis might still be
wrong.

## Rollout strategy

Pick with the user, based on cause-confidence and cost-of-being-wrong:

- **Pilot** — the default whenever cause-confidence is below high, or
  reversal is expensive. A pilot is the *final verification test
  wearing work clothes*: small scope, fixed window, explicit success
  metric. Bakery: run the 48h pre-order window for custom cakes only,
  two weekends, target zero late customs.
- **Phased** — confidence is high but the change touches many parts;
  sequence by risk, earliest phases carrying the most learning.
- **Big-bang** — only when confidence is high *and* the change is
  cheap to reverse. Rare that both hold; say so if the user reaches
  for it out of impatience.

## The plan's parts

Keep `plan.md` compact — five sections, most a few lines:

1. **Actions with owners.** Each action: smallest first step, who owns
   it, what unblocks it. For a solo user "owner" still matters — it
   distinguishes *my task* from *waiting on the courier company*.
2. **Success metrics — inherited, not invented.** Wire directly back to
   the success criteria captured in Frame ("late orders back under 1 in
   20, sustained a month"). Inventing fresh metrics at plan time is a
   quiet way to move the goalposts onto easier ground.
3. **Pivot triggers.** Generate them with a quick **pre-mortem**: "it's
   three months from now and the fix failed — what killed it?" Each
   credible answer becomes a pivot trigger or a new assumption-log
   entry. Then, for each metric: *if it hasn't moved by checkpoint X,
   the diagnosis was wrong — return to Diagnose, starting from the
   surviving `[assumed]` links and the not-chosen options in
   decision.md.* Concrete: "if ≥2 custom orders are still late in
   pilot weekend two, capacity wasn't the (whole) cause — re-open the
   prep-start-time branch." A plan without pivot triggers assumes the
   diagnosis is infallible, which the assumption log says it isn't.
4. **Assumption validation plan.** Sweep `assumptions.md`: every still
   -open entry either gets a check scheduled inside the plan, or the
   user marks it an accepted risk — explicitly. No entry left silently
   dangling.
5. **Review point.** One named moment (end of pilot, day 30) where the
   user looks at metrics against triggers and decides: close, extend,
   or pivot.

If the plan is growing into a real multi-week project — several
workstreams, stakeholders, standing reviews — that's the
**project-manager** handoff moment (family rule as usual: invoke if
installed, otherwise name it, point to the family repo, and keep this
plan as the lightweight version).

## Closing a phase, closing a problem

When the plan is set, offer a two-minute lessons pass — not ceremony,
three questions: what did the diagnosis reveal about the system that
outlives this problem? which check gave the most information per effort?
what would we check *first* next time? Append to `plan.md` under
`## Lessons`. Skip it without guilt on small problems.

A problem is *closed* at the review point when metrics hold — record
that in `plan.md` too. Problems have a way of being declared solved at
the moment of decision; the workspace stays honest about the
difference.

## Re-entry protocol

Problems outlast sessions by design — checks take days, pilots take
weeks. On return:

1. **Read the workspace first** (`statement.md` → `diagnosis.md` →
   `assumptions.md` → whatever exists downstream). Don't ask the user
   to re-brief you on what the files already say.
2. **Restate the state in 2–3 lines**: which phase, what's pending,
   what the session is waiting on. "Last time: leading candidate A2
   (prep-slot mis-estimate), you were going to time five preps over
   the weekend."
3. **Collect what reality answered.** Update assumption confidences,
   promote or demote tree labels, record verification-test results —
   *before* generating anything new. New evidence may reshuffle the
   leading candidate, and that's the system working.
4. **Continue from the phase the workspace says you're in.** Re-running
   Frame on a returning user wastes their trust; the gate they passed
   stays passed unless the new evidence broke it — if it did (the
   statement turned out mis-scoped), say so plainly and re-gate.

The re-entry summary is also the moment to celebrate downward
revisions from homework: an assumption that died over the weekend cost
nothing and saved the plan. That framing — verification as progress,
not delay — is what keeps users coming back to finish diagnoses instead
of jumping to the nearest fix.
