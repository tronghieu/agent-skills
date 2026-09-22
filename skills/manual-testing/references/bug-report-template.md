---
title: "Bug Report Template"
type: reference
status: draft
created: 2026-07-10
updated: 2026-07-10
related:
  - ../SKILL.md
  - session-note-template.md
tags: [manual-testing, bug-report, template, severity]
---

# Bug Report Template

One file per FAIL/PARTIAL finding. A bug that cannot be reproduced from the report alone
can rarely be fixed — write for a developer who was not in the session.

Save to: `{outputs.bug_reports_dir}` from `_project/testing/environment.toml`, as
`BUG-{YYYY-MM-DD}-{slug}.md`

````markdown
---
title: "BUG: {specific one-line defect statement}"
type: bug-report
severity: critical | high | medium | low
app: {app}
route: {/path}
date: {YYYY-MM-DD}
session: SESSION-{YYYY-MM-DD}-{slug}.md
status: open
---

# BUG: {specific one-line defect statement}

## Environment

| Field | Value |
| --- | --- |
| App / route | {app} — `{route}` |
| Account | {email} ({role}) |
| Seed state | {fresh reset / dirty} |
| Reproduced | {n}/{n} attempts |

## Steps to reproduce

1. {numbered, from a known clean state, exact inputs — anyone can follow}
2. …

## Expected

{What should happen — cite the AC/story/consistency anchor that says so.}

## Actual

{What happens instead. Exact error text, exact wrong value.}

## Evidence

- Screenshot: {relative path into `{outputs.screenshots_dir}/SESSION-…/`}
- Deterministic signal: {DB query + result / HTTP status + payload / console error — at least one}

```sql
-- verification query used, with its actual result pasted below
```

## Root-cause hypothesis (optional)

{Only if the evidence points somewhere — clearly labeled a hypothesis, not a finding.}

## Suggested regression check

{The one-line scenario + oracle that would catch this permanently, and at what level
(unit / integration / e2e). This feeds the automation loop.}
````

## Severity guide

Severity = impact (how bad), independent of priority (how soon — that's a human call).

| Severity | Criteria | Examples |
| --- | --- | --- |
| **Critical** | Data loss/corruption, money wrong, security or tenant-isolation breach, core flow dead | Debt recorded twice; member sees another tenant's data; login broken |
| **High** | A feature fails with no workaround | Invitation cannot be accepted; save silently drops data |
| **Medium** | Fails with a workaround, or misleads the user | Filter broken but search works; stale data until manual refresh |
| **Low** | Cosmetic, minor friction | Typo, misalignment, missing empty-state text |

When in doubt between two levels and money/auth/tenancy is involved, pick the higher.
