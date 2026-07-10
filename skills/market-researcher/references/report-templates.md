# Report Templates

Structures for the two deliverable types. Read when synthesizing (workflow
step 3). These are skeletons, not straitjackets: cut sections with nothing
decision-relevant to say — an empty section padded with filler costs the
reader more than a missing one — but never cut the verdict, the assumptions
table, or the open questions.

## Contents

- [Conventions shared by both](#conventions-shared-by-both)
- [Quick Scan brief](#quick-scan-brief)
- [Deep Dive report](#deep-dive-report)
- [state.md](#statemd)

## Conventions shared by both

- Write in the user's language; keep source quotes in their original language.
- Every factual claim tagged per `citation-schema.md`.
- The report file is `report.md` in the research workspace, with YAML
  frontmatter used for resume:

```yaml
---
topic: <topic>
mode: quick-scan | deep-dive
market_definition: <one line>
lanes_completed: [sizing, competitors]
verification: pending | done (YYYY-MM-DD)
verdict: <filled at synthesis>
---
```

## Quick Scan brief

Target 4–8 pages. The reader is deciding whether to spend more time, not
whether to sign a check.

```markdown
# Market Quick Scan: <topic>

## Verdict
Go / no-go / go-with-conditions, confidence (high/medium/low), and the 2–3
sentence reasoning. State the single finding most likely to change the
verdict if it turned out wrong.

## The market
Definition used (category, customer, geography). Size estimate with method
shown and range, per market-sizing.md quick mode. Growth direction with
source.

## Competition
The 5–10 players table: name, what it is, target segment, pricing signal,
traction signal — every cell cited. One paragraph: how contested is the
space, and where the crowding is / isn't.

## Demand signals
The 3–5 strongest signals found (with quotes and citations) and the honest
counter-signals. What desk research could NOT establish about demand.

## Kill-factors and tailwinds
The 2–3 macro items that could kill or make this, each with its "so what".

## Assumptions
| ID | Assumption | Basis | Sensitivity |

## Open questions for primary research
Numbered. For each: the question, why it matters to the decision, and a
concrete way to answer it (who to interview, what to test).

## Verification note
One paragraph: what the skeptic pass checked, what it corrected, what
remains unresolved.
```

## Deep Dive report

Modular: include a chapter per lane actually run. Chapters reuse the lane
findings files but re-cut them around the decision — synthesis is editing
for consequence, not concatenation.

```markdown
# Market Research: <topic>

## Executive summary
Verdict + confidence + reasoning, the five facts that drive it (each cited),
biggest caveat. One page maximum — write it last.

## Research frame
The decision this research serves. Market definition. Mode, lanes run,
period covered, and what was deliberately left out.

## Market size and growth        (sizing lane)
Multi-method estimates, triangulation table, reconciliation of conflicts,
growth drivers/inhibitors. Per market-sizing.md deep mode.

## Competitive landscape         (competitor lane)
Landscape map, deep profiles of top 3–5, feature/pricing comparison,
positioning analysis with the falsifiable gap claim, review-mining insights.

## Demand signals                (demand lane)
Jobs-to-be-done, ranked pains with verbatim evidence, hypothesis personas
(labelled, each with its validation plan), willingness-to-pay signals.

## Environment and trends        (macro lane)
PESTEL findings that carry a "so what", trend classification
(fad/trend/structural), the 1–2 scenario forks that matter.

## Synthesis
Where the lanes agree and disagree — cross-lane contradictions called out
explicitly. Opportunities ranked by size × fit × risk. Risks with mitigations.

## Recommendation
The verdict, expanded: what to do, what NOT to do, what would change the
recommendation, and the first three concrete steps.

## Assumptions
| ID | Assumption | Basis | Sensitivity |

## Open questions for primary research

## Verification note

## Appendix: sources
(Or a pointer to sources.md — don't duplicate the registry by hand.)
```

## state.md

Kept by the skill, read at every re-entry, appended never rewritten:

```markdown
# Research state: <topic>

mode: deep-dive
lanes: sizing, competitors, demand
output: ./research/market/<slug>/

## Log
- 2026-07-10: intake confirmed; sizing lane done (findings-sizing.md, S1–S14)
- 2026-07-10: competitors lane done (findings-competitors.md, S20–S31)
- 2026-07-12: session resumed; demand lane pending — NOTE sizing sources now 2 days old, fine
- 2026-07-12: verification pass: 10 claims checked, 2 corrected (S7 misread year; A2 arithmetic), 1 open caveat shipped
```

Log lines carry the id ranges each lane consumed — that is what makes
parallel-lane source numbering auditable later.
