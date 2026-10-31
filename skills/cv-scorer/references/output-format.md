# Report contract (v2)

## Human-readable report

Use the user's language. Show the rubric ID/version, assessment date, criteria/weights, and assumptions first. For each candidate show documented score **with range and coverage**, extraction limits, mandatory status, then a table of requirement / status / CV quote and location / rationale. End with strengths, verification items, and targeted interview questions. A batch adds evidence ordering and an unranked review queue; explain provisional ranks. Do not turn alignment bands into hiring instructions.

## JSON input for the calculator

UTF-8 JSON object, `schema_version: "2.0"`. All listed fields are required unless called optional. Stable keys/enums stay English; prose follows the user's language. Unknown fields are rejected to catch typos and stale v1 fields.

- `assessment_date`: ISO date used for ongoing experience and validity checks.
- `rubric`: `id`, `version` (nonempty strings), `job_title`, `source` (JD filename/identifier), `assumptions` (string list), `criteria` (nonempty list).
- Each criterion: `id` (unique), `description`, `importance` (`must_have`/`preferred`), `weight` (positive number with at most two decimal places; total 100), `jd_evidence` (`quote`, `location`), `anchors` (object with nonempty text for keys `0`–`4`).
- `candidates`: nonempty list. Each candidate: `id` (unique), `name` (name or anonymous ID), `source`, `extraction` (`status`: `readable`/`partial`/`unreadable`, `limitations`: string list), `assessments` (one per criterion), `summary`, `highlights` (string list), `verification_items` and `interview_questions` (lists below).
- Each assessment: `criterion_id`, `status`, `score`, `evidence` (list of `quote`/`location` objects), `searched_locations` (string list), `rationale`, `contradiction` (boolean). Known statuses need evidence; unknown needs searched locations. Contradiction requires unknown and at least two quotes. Partial/unreadable extraction requires at least one limitation.
- Each verification item: `criterion_id`, `issue`, `question`. The linked assessment holds the source evidence or searched locations.
- Each interview question: `criterion_id`, `question`. Use actual unresolved criteria or assessable follow-up questions, not generic interview lists.

### Complete example

This two-criterion example is intentionally small; real JDs generally warrant more detail.

```json
{
  "schema_version": "2.0",
  "assessment_date": "2026-10-31",
  "rubric": {
    "id": "backend-delivery",
    "version": "1",
    "job_title": "Backend Engineer",
    "source": "jd.md",
    "assumptions": ["Weights reflect JD emphasis on delivery over tuning."],
    "criteria": [
      {
        "id": "api",
        "description": "Deliver and operate a production Python API",
        "importance": "must_have",
        "weight": 60,
        "jd_evidence": {"quote": "Required: deliver and operate production Python APIs.", "location": "Requirements, bullet 1"},
        "anchors": {
          "0": "Explicitly no Python API delivery experience",
          "1": "Only tutorial API work; explicitly no production work",
          "2": "Production delivery but explicitly no operation responsibility",
          "3": "Delivery and limited operation, with an explicit scope gap",
          "4": "Production delivery and operation both described"
        }
      },
      {
        "id": "sql",
        "description": "PostgreSQL query tuning",
        "importance": "preferred",
        "weight": 40,
        "jd_evidence": {"quote": "Preferred: PostgreSQL query tuning.", "location": "Requirements, bullet 2"},
        "anchors": {
          "0": "Explicitly no query tuning experience",
          "1": "Training-only tuning; explicitly no production application",
          "2": "One production tuning task with an explicit scope limitation",
          "3": "Several production tuning tasks with a stated remaining gap",
          "4": "Production query analysis, changes, and outcomes described"
        }
      }
    ]
  },
  "candidates": [
    {
      "id": "candidate-a",
      "name": "Candidate A",
      "source": "cv-a.md",
      "extraction": {"status": "readable", "limitations": []},
      "assessments": [
        {
          "criterion_id": "api",
          "status": "met",
          "score": 4,
          "evidence": [{"quote": "Built and operated a production Python API, including on-call.", "location": "Experience, Atlas project"}],
          "searched_locations": [],
          "rationale": "Delivery and production operation are explicitly stated.",
          "contradiction": false
        },
        {
          "criterion_id": "sql",
          "status": "unknown",
          "score": null,
          "evidence": [],
          "searched_locations": ["Skills", "Experience", "Projects"],
          "rationale": "The CV does not describe tuning; ability remains unknown.",
          "contradiction": false
        }
      ],
      "summary": "Production Python delivery is documented; tuning needs clarification.",
      "highlights": ["Delivery and on-call responsibilities are described."],
      "verification_items": [{"criterion_id": "sql", "issue": "No tuning example in the CV.", "question": "Have you tuned a PostgreSQL query in production? Describe your role and outcome."}],
      "interview_questions": [{"criterion_id": "sql", "question": "How did you identify a query bottleneck and check the effect of your change?"}]
    }
  ]
}
```

## Derived output

The script preserves valid source fields and adds each assessment's `weighted_points` (null for unknown), plus each candidate's `calculation`:

```json
{
  "documented_score": 60.0,
  "possible_score": 100.0,
  "coverage_percent": 60.0,
  "score_range": [60.0, 100.0],
  "alignment_band": "moderate",
  "mandatory_status": "met",
  "unmet_must_haves": [],
  "unknown_must_haves": [],
  "review_status": "needs_verification",
  "rank_eligible": true,
  "unranked_reasons": []
}
```

For partial/unreadable extraction, `documented_score`, `possible_score`, `coverage_percent`, `score_range`, and `alignment_band` are null. Mandatory findings remain visible with review status `insufficient_input`.

Top-level `batch` contains `ordering_provisional`, `ranking` (rank, candidate_id, documented_score, score_range, mandatory_status, review_status), and `unranked` (candidate_id, reasons). Incomplete extraction, unknown must-haves, any contradictory assessment, or zero assessed criteria excludes a candidate from ranking (`no_assessed_criteria` for the last case). Explicit mandatory mismatches stay marked `criteria_review`. Equal unrounded scores share a competition rank; ID sorting within a tie is display-only. Ranges touching or overlapping make ordering provisional, as does an unranked queue; exact tied points alone do not imply uncertainty.

The script overwrites derived fields on reruns and exits 0 on success, 2 on invalid input. JSON goes to stdout or `--output`; `--check` validates without writing. Status/errors go to stderr. `--check` and `--output` are mutually exclusive. Existing output files are never overwritten. The calculator validates shape and arithmetic, not source authenticity or human judgment.

## Migration from v1

v2 replaces fixed-category `scoring` and `total_score` with per-JD criteria and score ranges. `red_flags` becomes criterion-linked `verification_items`. `Recommend`/`Maybe`/`Pass` becomes descriptive alignment bands plus separate review status. v1 payloads are rejected; rebuild rubric/evidence from original JD/CVs. Do not compare v1 totals with v2 scores.
