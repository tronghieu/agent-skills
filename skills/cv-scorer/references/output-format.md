# Output Format Templates

## Single CV Output

```json
{
  "candidate_name": "Candidate Name",
  "total_score": 72,
  "recommendation": "Recommend",
  "scoring": {
    "jd_matching": {
      "score": 8,
      "weighted_score": 24,
      "max": 30,
      "comment": "Strong match on must-haves: React, Node.js, TypeScript. Missing AI tools experience."
    },
    "work_experience": {
      "score": 7,
      "weighted_score": 17.5,
      "max": 25,
      "comment": "3 years of full-stack experience, reasonable career progression."
    },
    "project_impact": {
      "score": 6,
      "weighted_score": 9,
      "max": 15,
      "comment": "Relevant projects but metrics lack specificity."
    },
    "education": {
      "score": 8,
      "weighted_score": 12,
      "max": 15,
      "comment": "CS degree from FPT University, GPA 3.8/4.0."
    },
    "cv_quality": {
      "score": 6,
      "weighted_score": 9,
      "max": 15,
      "comment": "Decent structure but significant paragraph repetition across sections."
    }
  },
  "summary": "Candidate has a solid technical foundation for the role. Strengths in frontend skills and full-stack experience. Needs AI tools experience. CV could be more concise.",
  "red_flags": [
    "Repeated content across Work Experience sections",
    "Suspiciously similar project metrics (22% vs 23%)"
  ],
  "highlights": [
    "Strong React/Node.js skills",
    "High GPA"
  ]
}
```

## Recommendation Logic

| Score | Recommendation | Action |
|-------|---------------|--------|
| ≥ 70  | **Recommend** | Invite for interview |
| 50–69 | **Maybe**     | Consider if candidate pool is thin |
| < 50  | **Pass**      | Not a fit |

## Batch Summary Output

```json
{
  "job_title": "Position Title",
  "total_candidates": 10,
  "scored_at": "2026-04-03",
  "ranking": [
    {"rank": 1, "name": "...", "total_score": 85, "recommendation": "Recommend"},
    {"rank": 2, "name": "...", "total_score": 72, "recommendation": "Recommend"}
  ],
  "summary": {
    "recommend": 3,
    "maybe": 4,
    "pass": 3
  }
}
```
