# Estimation — ranges, reference classes, visible buffers

The Gauge lens (Pythagoras). Read this before running `estimate`. This is
the skill's primary weapon against the **planning fallacy** — the
well-documented tendency to forecast the best case and call it the
estimate. An eager assistant makes this worse by default: asked "how long
will this take," it will happily produce a single confident number from
nothing. Everything below exists to make that number earn its confidence.

## Contents

- [Ranges, never points](#ranges-never-points)
- [Reference-class forecasting](#reference-class-forecasting)
- [Buffer policy](#buffer-policy)
- [Basis labels](#basis-labels)
- [Re-estimation triggers vs. the change gate](#re-estimation-triggers-vs-the-change-gate)
- [Anti-patterns](#anti-patterns)

## Ranges, never points

Every estimate in `plan/estimates.md` is a **low–high range**, never a
single number, because a point estimate collapses uncertainty that is
real and then gets treated as a promise the moment it's written down. State
the range with a confidence shape when one is known — "5–9 days, most
likely 6" — rather than a bare interval with no shape.

When the user (or an engineer) offers a point instead of a range, elicit
the range rather than accepting the point at face value:

> **User:** "The migration script will take 3 days."
> **PM:** "What would make it take twice as long — 6 days? And what's the
> fastest this kind of migration has ever gone on a project you've seen?"
> **User:** "...if the legacy schema has undocumented columns, easily a
> week. Fastest case, maybe 2 days if the schema's clean."
> **Range recorded:** 2–7 days, most likely 3, basis: expert judgment
> `(user estimate, 2026-07-12)`.

The follow-up question ("what would make it take twice as long") works
because it's concrete and non-confrontational — it invites the respondent
to imagine a specific failure mode instead of defending their original
number.

## Reference-class forecasting

The **outside view**: before accepting any estimate, check it against how
similar work has actually gone on *this* project or org — not how this
instance of the work feels like it should go.

1. Search `registers/lessons.md` for `L#` entries whose "Feeds" column
   names this estimate class (e.g., "third-party API integrations").
2. Search old `plan/baseline-<date>.md` files for planned-vs-actual gaps
   on comparable work packages or milestones — the baseline sequence
   preserved by `references/planning.md` is exactly this data.
3. If no reference class exists yet — new project, first estimate of its
   kind — ask the user for organizational history outside this project
   ("has your team built anything like this before, and how did the
   estimate hold up?"). If none is available, register the absence itself
   as an `A#` ("no reference class available for this work type") with a
   wide range, rather than pretending the estimate is tighter than it is.

The **inside view** — "this time is different because we already have the
schema documented" — is allowed, but only in writing, next to the
reference class it's arguing against:

> Reference class: `L4` — last two API integrations on this project ran
> 1.8× the original estimate, both blamed on undocumented auth edge
> cases (`L4`, 2026-05-20). Inside view: this vendor's API is OpenAPI-
> spec'd and reviewed in advance (`EV12`), so the edge-case risk that hit
> `L4` is mitigated here. Range widened only to 1.3×, not 1.8×, with the
> gap recorded as the argument above — not silently dropped.

An inside-view argument that doesn't cite what it's arguing against isn't
an inside view, it's just optimism with a paragraph attached.

## Buffer policy

Buffers absorb the uncertainty the range admits to — they are not a place
to hide padding you're embarrassed to put in the task itself.

- **Visible, named line items** at the plan level — "Schedule buffer:
  vendor API integration uncertainty, 3 days" — never distributed
  invisibly across individual task durations. A task padded "just in
  case" produces Parkinson's-law slack that nobody can see or report on;
  a named buffer can be tracked, burned down, and reported honestly.
- **Owned.** Every buffer names who decides when it's spent — usually the
  PM or a named lead, not "the team."
- **Distinguish contingency from management reserve** when both exist:
  contingency covers *known* uncertainty already reflected in a risk or
  range (quantified, PM-owned); management reserve covers *unknown*
  unknowns (sponsor-owned, drawn on rarely, reported separately).
- **Burn is reported in status**, not silently absorbed — see
  `references/status.md`. A buffer that's 80% burned by the 40% mark is
  itself a status finding, not a detail to bury in an appendix.

## Basis labels

Every row in `plan/estimates.md` (schema fixed by
`scripts/init-project.sh`) states its basis and its provenance label:

| Item | Basis | Low–High | Reference class | Buffer | Label |
|------|-------|----------|------------------|--------|-------|
| M4 payment gateway integration | analogous | 8–14 days | L4 (past API integrations ran 1.8×) | 3 days, owned by PM | A9 (range), L4 (reference class) |

Four basis categories, and each makes a different claim:

- **Bottom-up** — summed from decomposed work packages (`references/planning.md`);
  strongest when the WBS is genuinely countable.
- **Analogous** — scaled from a comparable past item; strength depends on
  how comparable the analogy actually is (state why).
- **Velocity-derived** — story points ÷ historical velocity; **citable
  only when the velocity comes from real sprint data** (`EV#` pointing at
  actual completed sprints), never from a target or aspirational velocity
  the team hasn't hit yet.
- **Expert judgment** — a knowledgeable person's range, elicited per
  above; label `(user estimate, <date>)` and name who.

An estimate with a basis but no provenance label, or a label but no
stated basis, is half-documented — both are required.

## Re-estimation triggers vs. the change gate

Estimates are living documents inside `plan/estimates.md` and get
recalculated when:

- Actuals diverge outside the stated range on a work package still in
  flight.
- A `CH#` lands that changes the scope the estimate covered.
- A `registers/lessons.md` entry names this estimate class in its "Feeds"
  column — the next similar estimate should use the corrected reference
  class immediately, not wait for someone to remember.

Re-estimating the *internal* planning number is routine and doesn't
require permission. But when the estimate underlies a **committed external
date** — one already baselined or promised to a sponsor — changing that
date is not a re-estimation, it's a change, and it goes through
`references/change-control.md`'s gate with an impact assessment and a
named decision-maker. Re-estimation is not a backdoor around the gate; if
the two ever produce different answers about whether a date can move,
the gate wins.

## Anti-patterns

Name these out loud when they show up — naming them is most of the
defense:

- **Anchoring on the wish date.** The sponsor names a date first, and the
  "estimate" quietly becomes a repackaging of it. Test: does the range's
  low end change if the wish date changes? If not, it wasn't an estimate.
- **Precision theater.** "6.25 weeks" built on an input that was a guess.
  Ranges should carry only as much precision as their weakest input
  supports — a guessed reach or an unverified effort figure caps the
  whole calculation's precision, no matter how exact the arithmetic looks.
- **Estimate-under-duress-called-commitment.** An estimate produced in a
  meeting under visible pressure ("just give me a number") gets recorded
  as what it is — a number given under duress, labelled and flagged for
  revisit — not silently promoted to a committed baseline date.
