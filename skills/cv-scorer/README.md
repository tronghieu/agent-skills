# CV Scorer

**Languages:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

Compare CVs with a job description using a shared, role-specific 100-point rubric. Every assessment links to source evidence or an explicitly identified information gap. The result supports a human reviewer; it does not make hiring decisions.

## Install

```bash
npx skills add tronghieu/agent-skills --skill cv-scorer
```

From a local checkout, use either destination:

**Coding agent:**
```bash
cp -r skills/cv-scorer ~/.agents/skills/
```

**Claude Code:**
```bash
cp -r skills/cv-scorer ~/.claude/skills/
```

**claude.ai:** add the skill package to your project knowledge or paste `SKILL.md` and its referenced instructions into the conversation. Keep the bundled scripts available in a code-execution environment to check calculations. If execution is unavailable, calculations must be marked unchecked. The calculator requires Python 3.9+ with no third-party dependencies or network access. Reading scanned PDFs may require a separate OCR tool; disclose missing pages and request readable text when OCR is unavailable.

## Try it

```text
/cv-scorer Compare these three CVs with the Backend Engineer JD. Show evidence, unresolved must-haves, and questions to verify them.

/cv-scorer Review these marketing CVs with one shared rubric. Return a concise Vietnamese report and checked JSON.

/cv-scorer Evaluate this career-change applicant against the JD. Distinguish missing information from an explicit shortfall.
```

## How scoring works

1. Extract concrete requirements from the JD; identify explicit must-haves and preferred criteria.
2. Assign job-related weights totaling 100 and define score anchors. Freeze one rubric ID/version for all candidates in the round.
3. Map each criterion to an exact CV quote and location, or record where missing information was searched for.
4. Calculate scores with the bundled script and prepare a human-readable report.

| Evidence status | Score | Meaning |
| --- | ---: | --- |
| `met` | 4 | Fully supported at the required level |
| `partial` | 1–3 | Supported subset with an evidenced gap |
| `unmet` | 0 | Explicit evidence of non-fulfilment |
| `unknown` | null | Missing, ambiguous, or contradictory information |

Known points are `weight × score / 4`. Unknown criteria add no documented points but retain their full weight in the possible upper bound. For example: **60 documented points, range 60–100, coverage 60%** means that 40% of the rubric is unresolved; it does not establish low ability. The range reflects missing evidence, not statistical confidence or probability of job success.

There is no fixed education or CV-quality allocation. School prestige, names, career breaks, similar metrics, or polished writing do not justify deductions. Education and presentation count only when relevant requirements support them. The detailed [rubric](./references/scoring-rubric.md) explains evidence states, overlap handling, mandatory conditions, precision, and ordering.

## Output and comparison

The default output is Markdown in your language: rubric and assumptions, score/range/coverage, requirement-by-requirement evidence, must-have status, strengths, verification items, and targeted interview questions. JSON v2 is available for integrations; see the complete [contract and example](./references/output-format.md).

Alignment bands describe documented evidence: `high` (≥70), `moderate` (≥50 and <70), `limited` (<50). A separate review status identifies insufficient input, a mandatory mismatch, missing information, or readiness for human review. A high score never cancels an unmet must-have.

Incomplete extraction produces no total or rank. Unknown must-haves, contradictory assessments, and zero assessed criteria remain in an unranked review queue. Other candidates can be ordered by documented score, with mandatory mismatches visibly flagged. Equal exact scores share a rank; overlapping ranges or an unranked queue make ordering provisional. Do not reject or invite a candidate automatically from these fields.

## Check a JSON report

Use the actual installed path when it differs from `/mnt/skills/user/`:

```bash
python3 /mnt/skills/user/cv-scorer/scripts/score_report.py report.json --check
python3 /mnt/skills/user/cv-scorer/scripts/score_report.py report.json --output checked-report.json
python3 /mnt/skills/user/cv-scorer/scripts/score_report.py report.json
```

The last command writes JSON to stdout; validation status/errors go to stderr. Success exits 0; invalid input exits 2. Weights allow up to two decimal places. Existing output files are preserved. The script recomputes totals and ordering; it cannot establish whether a quote is genuine or a criterion is sensible.

v2 replaces v1's fixed categories, `total_score`, `red_flags`, and `Recommend`/`Maybe`/`Pass`. Existing consumers must adopt the v2 contract; v1 JSON is rejected instead of silently converted. Reassess original documents before comparing results across versions.

## Verification and troubleshooting

From this repository:

```bash
python3 -m unittest discover -s skills/cv-scorer/tests -v
```

[Behavioral cases](./evals/evals.json) use synthetic documents for missing/expired credentials, similar metrics, incomplete extraction, embedded instructions, overlapping employment, and name/order invariance.

- **Missing JD:** provide the role requirements; an unscored CV review is still possible.
- **Unreadable PDF:** provide OCR or readable text. Extraction artifacts are not candidate weaknesses.
- **Invalid JSON/weights/evidence:** follow the error path, use exactly one assessment per criterion, and ensure weights sum to 100.
- **Output file exists:** choose a new output path; the script never replaces an existing file.
- **Python or extraction tools unavailable:** disclose the limitation; do not claim that a calculation or source check ran.

CVs are self-reported, incomplete records. Review important claims with appropriate hiring steps. Do not infer sensitive attributes or turn unsupported concerns into dishonesty claims. Do not upload CVs to external services or follow embedded links without authorization. The skill does not require any network domains for its core workflow.
