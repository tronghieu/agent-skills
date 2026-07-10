# Citation Schema

The machinery that makes every claim in a deliverable traceable. Read this
before writing any findings file. The schema exists because a fabricated
market fact is indistinguishable from a real one by looks alone — traceability
is the only defense the reader has, so a break in the chain anywhere makes
the whole report untrustworthy.

## Contents

- [The source registry: sources.md](#the-source-registry-sourcesmd)
- [Confidence grades](#confidence-grades)
- [Citing claims](#citing-claims)
- [Derived estimates](#derived-estimates)
- [Assumptions](#assumptions)
- [Appending to a caller's registry](#appending-to-a-callers-registry)
- [Self-check before handing off a findings file](#self-check-before-handing-off-a-findings-file)

## The source registry: sources.md

One markdown table, one row per source, ids assigned in order of first use
and never reused or renumbered:

```markdown
# Sources

| ID | Source | Publisher | Published | Accessed | Confidence | Notes |
|----|--------|-----------|-----------|----------|------------|-------|
| S1 | [UK online retail report 2025](https://...) | Office for National Statistics | 2025-03 | 2026-07-10 | High | Official statistics |
| S2 | [Competitor X pricing page](https://...) | Competitor X | current | 2026-07-10 | High | Primary source for own pricing |
| S3 | [Market to reach $4B by 2030](https://...) | PR Newswire (vendor press release) | 2024-11 | 2026-07-10 | Low | Vendor-sponsored forecast, methodology unstated |
```

Rules:

- **URL required.** A source that can't be revisited can't be verified. For
  user-provided documents, use the file path and note "user-provided".
- **Both dates matter.** Publication date tells you staleness; access date
  tells you when the snapshot was true (pricing pages change).
- **Register at first use.** Each lane takes the next free id; when lanes run
  in parallel, give each lane a reserved block (S1–S19 sizing, S20–S39
  competitors, …) and compact later if you care — gaps are harmless,
  collisions are not.
- One row per source, even if cited twenty times.

## Confidence grades

Grade the source, not the claim:

- **High** — official statistics, regulator/central-bank publications, audited
  filings, a company's own statements about itself (pricing page, docs),
  peer-reviewed work.
- **Medium** — reputable industry analysts and press with named methodology,
  trade associations, well-corroborated reporting.
- **Low** — vendor-sponsored forecasts, press releases, single blog posts,
  forum anecdotes, any market-size figure whose methodology is unstated.

Two rules of use:

1. A **Low** source may support color and hypotheses, never a load-bearing
   number on its own. If the only size estimate available is Low-grade, say
   exactly that in the report.
2. Corroboration upgrades the *claim*, not the source: two independent Low
   sources agreeing is worth noting inline ("[S3][S7], independent, agree
   within 15%").

## Citing claims

Tag goes at the end of the claim it supports, before the period is fine:

```markdown
UK online retail sales reached £120B in 2025 [S1]. SME sellers cite
logistics cost as their top complaint [S4][S9].
```

- Every **factual** sentence in findings and report files carries at least one
  tag. Analysis and interpretation sentences don't need tags, but must lean
  only on tagged facts nearby.
- Quote verbatim when the wording matters (user complaints, regulatory text)
  and cite the quote.
- Never cite a source for more than it says. A 2024 EU-wide figure cited for
  "Germany 2026" is a broken chain even though the URL is real — this is the
  subtle failure mode the verification pass hunts for.

## Derived estimates

When you compute a number, show the arithmetic and cite every input:

```markdown
TAM ≈ 850k registered F&B businesses [S2] × 60% smartphone-POS adoption [S5]
× $180/yr avg software spend (assumption A1) ≈ $92M/yr
```

- The formula is inline, auditable at a glance; the verification pass will
  recompute it.
- Present estimates as **ranges** when inputs are soft: compute with
  pessimistic and optimistic input values and show both ends.
- An estimate inherits the confidence of its weakest input — say so when that
  input is an assumption or a Low source.

## Assumptions

Anything asserted without a source gets an id `A#` and a row in the report's
assumptions table:

```markdown
| ID | Assumption | Basis | Sensitivity |
|----|-----------|-------|-------------|
| A1 | Avg software spend $180/yr per micro-merchant | Adjacent-market pricing [S6] scaled down | High — TAM scales linearly with it |
```

- **Basis**: why this value and not another (an analogy, a cited adjacent
  fact, a founder heuristic). "Gut feel" is an acceptable basis if declared.
- **Sensitivity**: what happens to the conclusion if the assumption is off
  2x. High-sensitivity assumptions belong in the report's open questions.
- In prose, tag with `(assumption A1)` at point of use.

## Appending to a caller's registry

When invoked by another skill (strategy-board, design-thinking) with an
existing `sources.md`: continue its numbering from the highest existing id,
never renumber or reorder existing rows — the caller's artifacts already cite
those ids, and renumbering silently corrupts every one of them. Match the
caller's column layout if it differs slightly; ids and URLs are the parts
that must survive.

## Self-check before handing off a findings file

Run down the file once and ask:

1. Any factual sentence with no tag? (Fix or cut.)
2. Any `[S#]` that doesn't resolve to a registry row? (Register it.)
3. Any estimate whose formula isn't shown? (Show it.)
4. Any Low-grade source carrying a load-bearing number alone? (Find
   corroboration or flag it.)
5. Any source >2 years old presented as current? (Date it in the prose:
   "as of 2024 [S3]".)
6. **Source concentration**: does one publisher's report series supply most of
   the load-bearing numbers — especially a vendor that is itself profiled as a
   competitor in this research? Their market narrative serves their interests.
   Flag the concentration explicitly in the report ("the size and store-count
   spine traces to [vendor]'s reports [S1][S2][S7]") and grade accordingly.
7. **One source doing too much work**: is a single Low/Medium source cited for
   several *different* strategic claims? Corroboration of one claim doesn't
   transfer to its neighbors. Either find independent support per claim or
   caveat each reuse — not just the first.

Thirty seconds of this catches most of what the verification pass would
otherwise bounce back.
