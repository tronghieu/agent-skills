# Building and applying the rubric

## One role, one version

Build criteria from the JD, not from candidates. Give each criterion a stable ID, a description, a JD quote and location, importance (`must_have` or `preferred`), a positive weight, and anchors for all five integer scores 0–4. Weights total exactly 100. Use one frozen rubric ID/version across the hiring round.

The old fixed categories (JD matching, experience, impact, education, CV quality) are replaced by role-specific requirements. They often overlap and can reward the same achievement repeatedly. Group related JD statements into one criterion; make scoring dimensions distinct. One project may support several distinct capabilities, but the same outcome must not earn duplicate points for the same capability.

Prefer a small set of assessable criteria, typically 4–8. For example, an engineering JD could allocate 35 to backend delivery, 25 to database work, 20 to operating production systems, and 20 to collaboration, if the JD supports that emphasis. These weights are illustrative, not a universal preset. Other roles need their own criteria. Do not create a degree, GPA, prestige, years-of-service, or visual-format criterion merely because those fields appear in a CV.

A must-have is an explicit JD/user requirement, not an inference from importance or a high weight. Preferred criteria still need a JD source; cite user clarifications when they add requirements. Identify alternatives such as “degree OR equivalent experience” in the same criterion. If the JD has no assessable job-related requirements, request clarification instead of fabricating a numeric rubric.

## Evidence states and anchors

| Status | Score | Meaning |
| --- | --- | --- |
| `met` | 4 | CV explicitly supports the full criterion at its stated level |
| `partial` | 1, 2, or 3 | Explicit evidence supports some of the criterion; explain the gap using its anchors |
| `unmet` | 0 | Explicit evidence shows the criterion is not satisfied |
| `unknown` | null | Missing, ambiguous, or contradictory evidence prevents assessment |

Write criterion-specific anchors before scoring. General pattern: 0 = explicit non-fulfilment; 1 = small supported subset; 2 = meaningful subset; 3 = most requirements supported with a concrete gap; 4 = all requirements supported. Define subsets in job terms rather than “weak/good/excellent.” Unknown is outside the scale. Do not assign 0 just because a skill was not mentioned, and do not award full points to keywords without scope/context.

Every known result needs at least one exact CV quote plus a page or section location. Partial/unmet results need evidence of the specific gap, not just a related strength. For example, “2 years commercial Python” can demonstrate a shortfall against an explicit three-year requirement; silence about Python cannot. When some subrequirements are supported but the rest are silent, use unknown and explain the supported subset until clarified, rather than treating silence as proven failure. Split independently important requirements at rubric-building time when useful.

Unknown results need searched locations and a reason. For contradictions, retain both quotes and set `contradiction: true`. Quotes are self-reported claims, not independent verification. Use brief quotations sufficient for checking; avoid copying full CVs or unrelated personal data.

## Calculation

For criterion i with weight w and known score s:

`documented_points_i = w × s / 4`

Unknown criteria contribute no *documented* points. This is an evidence accounting convention, not a finding of zero ability. Always report these together:

- `documented_score`: sum of known points, out of the full 100.
- `possible_score`: documented score plus the weights of unknown criteria.
- `coverage_percent`: sum of weights of known criteria.
- `score_range`: [documented score, possible score], reflecting missing evidence only.

Do not renormalize to known-only weights. The range is not a statistical confidence interval; scores do not estimate job-success probability. Model judgment can vary even when coverage is 100%.

Use decimal arithmetic. Keep full precision through summation; round final displayed values to two decimals, half-up. Compute bands and ranks on unrounded totals: `high` at ≥70, `moderate` at ≥50 and <70, `limited` below 50. These describe documented alignment, replacing v1's `Recommend`/`Maybe`/`Pass`; they are not hiring actions. All totals/bands are null when extraction is partial or unreadable.

## Mandatory conditions and review status

Derive mandatory status separately:

- `not_applicable`: no explicit must-haves.
- `unmet`: at least one must-have is explicitly partial or unmet. Also show any unknown must-haves.
- `unknown`: none partial/unmet, but at least one unknown.
- `met`: every must-have is supported in full.

Review status precedence:

1. `insufficient_input`: partial/unreadable extraction; no numeric total or rank.
2. `criteria_review`: a must-have is partial/unmet; a human reviews the mismatch.
3. `needs_verification`: any unknown criterion; a human obtains missing information.
4. `ready_for_human_review`: all criteria assessed; still requires human judgment.

Batch ranking includes only readable CVs with at least one assessed criterion and no unknown must-haves or contradictory criteria. Candidates with an explicit mandatory mismatch may appear in the evidence ordering, clearly marked `criteria_review`; their score never overrides that status. Sort by unrounded documented score descending, use competition ranks (1, 1, 3), and use stable candidate IDs only for display within ties. Mark ordering provisional when ranked score ranges overlap or any candidates remain unranked. Never compare different rubric versions.

## Verification instead of red-flag deductions

Record a concern only with source evidence and job relevance. Similar percentages, repeated phrases, employment gaps, and AI-like prose are not proof of fabrication. Repeated text can be a PDF extraction artifact; check before interpreting it. Count overlapping periods once; overlapping roles alone do not establish misconduct.

Turn actual ambiguity into a question: “These two sections give different certification expiry dates; which is current?” An expired mandatory credential is an evidenced mismatch when the assessment date establishes expiry. A missing expiry date is unknown. Do not label an applicant dishonest or deduct an extra, unbounded penalty on top of the criterion assessment.
