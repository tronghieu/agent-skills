---
title: "Assessment Rubric"
type: reference
status: draft
created: 2026-10-04
updated: 2026-10-04
related:
  - session-modes.md
  - session-note-template.md
  - exploration-method.md
  - test-plan-intake.md
tags: [manual-tester, assessment, rubric, ux, accessibility]
---

# Assessment Rubric

Every assessment finding cites one ID from this page. "Usual class" is a starting point.
The classification rules in `session-modes.md` § Assessment decide.

Oracles are named by role. The adapter (`_project/testing/`) says where each lives: the
**design spec** (look and feel), the **experience spec** (behavior, states, access), the
**locale files**, and the feature docs.

Thresholds marked _team default_ are heuristics, not spec. Cite them as such in an
IMPROVEMENT. Never use one to raise a FAIL.

## Func — what the screen shows the user

Automated tests normally decide business rules, database writes, tenant scope and double
submits. A manual session does not re-check them (`test-plan-intake.md`). Those four are
listed last, record-only.

| ID | Criterion | Oracle | Usual class |
| --- | --- | --- | --- |
| F3 | Invalid input is refused, with a message that says how to fix it | Feature doc | FAIL if accepted; IMPROVEMENT if the message is vague |
| F4 | Empty, loading, error and offline states exist and are correct | Experience spec state table | FAIL if missing where the spec names it; IMPROVEMENT if bare |
| F5 | A missing capability hides the control; it is never only disabled | Experience spec access model | FAIL |
| F7 | Money, quantities and dates are exact and locale-formatted | Feature doc | FAIL |
| F9 | Refresh, Back and navigation keep, or safely discard, the user's work | Experience spec; persona walk | OBSERVATION if data is lost silently and no source covers it; IMPROVEMENT otherwise |

Automated-owned, record only if seen:

| ID | Criterion | Note |
| --- | --- | --- |
| F1 | Behavior matches the business rule | Seen in passing: FAIL with evidence. Do not hunt. |
| F2 | A write lands as the UI claims | Same. |
| F6 | No other tenant's data appears | Same. Always critical. |
| F8 | A double submit creates one record | Same. |

## UI/UX — can the persona finish without hesitation

| ID | Criterion | Oracle | Usual class |
| --- | --- | --- | --- |
| U1 | Layout, spacing, color and type follow the design spec | Design spec | IMPROVEMENT; FAIL only where the spec states the rule |
| U2 | The primary action is obvious, and there is one per view | Experience spec; persona walk | IMPROVEMENT |
| U3 | Labels, button order and placement match across screens | Other screens in the same app | IMPROVEMENT |
| U4 | Every action shows feedback within 1 s (_team default_) and disables while busy | Persona walk; network timing | IMPROVEMENT; FAIL when a duplicate record follows |
| U5 | Error and empty-state copy says what happened and what to do next | Locale files; experience spec | IMPROVEMENT |
| U6 | Forms are grouped and have sane defaults and the right input types | Persona walk | IMPROVEMENT |
| U7 | Touch targets are at least 24×24 px; comfortable where the persona works fast | WCAG 2.2 SC 2.5.8; experience spec | IMPROVEMENT |
| U8 | No overflow, clipping or overlap at each declared viewport | Overflow check; screenshots | FAIL if content is unreachable; IMPROVEMENT otherwise |
| U9 | No raw i18n keys; natural copy in each shipped locale; the project's domain terms; no overflow from longer translations | Locale files; glossary | FAIL for raw keys or overflow; IMPROVEMENT for wording |
| U10 | Keyboard walk works; focus is visible; controls have names; the declared scan passes | Scan output; experience spec | See the scan rules in `session-modes.md` |
| U11 | A wait over 1 s shows progress; a load over 3 s is flagged (_team default_) | Load-time check | IMPROVEMENT |

## Exploratory — what breaks off the happy path

Exploratory findings are FAIL or OBSERVATION only. Tours and attack list:
`exploration-method.md`.

| ID | Probe |
| --- | --- |
| E1 | Boundary inputs: empty, very long, non-ASCII text, emoji, negative, zero, max |
| E2 | Interrupted flows: leave mid-form, session expiry, a second tab on the same record |
| E3 | Order of operations: steps out of order, deep links into mid-flow |
| E4 | Concurrency: two users or two tabs acting on the same record |
| E5 | Degraded dependencies: slow, failing or offline |
| E6 | Seams between features: data made on one screen, used on another |
