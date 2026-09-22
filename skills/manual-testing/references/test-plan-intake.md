---
title: "Test Plan Intake — Scoping a Session from an Assigned Test Design"
type: reference
status: draft
created: 2026-09-17
updated: 2026-09-17
related:
  - ../SKILL.md
  - session-modes.md
  - proof-discipline.md
tags: [manual-testing, test-design, intake, scope, automation]
---

# Test Plan Intake

Run this when the user hands you a test design, test plan, or a list of test-case IDs
instead of a plain target. A test design has already decided *which evidence proves each
condition*. Some conditions belong to automated suites, and some belong to a human
session. Your job is to test the second group, not to redo the first.

Why this matters: a manual session that walks through automated conditions spends the
whole timebox re-checking what CI already checks. It then reports those re-checks as
coverage, while the conditions only a human can judge go untested.

## 1. Read the prior evidence first

Before classifying, look for what earlier work already established about this target:

- earlier session notes and bug reports in the adapter's `[outputs]` directories;
- the project's accepted-risk or deferred-work records, if a persistent fact or the
  adapter names them;
- any retrospective or gate record for the same epic or story.

Use them to aim the session at what is still open, and to avoid re-filing known findings
as new bugs.

Every claim you make about earlier work must come from a file you actually opened. If you
only saw it summarized elsewhere (a retro quoting a session note), say so and name the
summary as the source: "per the retro, not checked against the session note". A
second-hand PASS presented as first-hand is the same error as trusting a toast.

## 2. Classify every condition

Read the design's allocation fully: the coverage tables, any "manual", "exploratory",
or "deferred" section, the traceability notes, and the evidence-allocation table.
Put each condition ID into exactly one group:

| Group | Meaning | Default scope |
| --- | --- | --- |
| **Manual** | Allocated to human evidence: a charter, a review, a judgment check | In scope |
| **Automated, UI-observable** | Allocated to unit/integration/e2e, but its outcome can be seen and triangulated by driving the app | Out of scope unless the user opts in |
| **Automated, not UI-observable** | Allocated to unit/integration, with no outcome a user action can show or a read-only query can confirm | Out of scope; cannot be tested by hand |
| **Deferred / unknown** | Explicitly deferred, or allocated nowhere, or allocated inconsistently | Out of scope; list as an open question |

Classify from what the design says, not from the condition's wording. A condition that
reads like a UI check but is allocated to an integration band is still automated.
If the design contradicts itself about a condition, put it in **Deferred / unknown**
and quote both places. If it contradicts itself elsewhere (a summary count that
disagrees with its own tables), count from the tables and raise the mismatch as an
open question for the design's owner. Do not fix the design.

**UI-observable is decided by the outcome, not by the band.** Ask: after driving the app
as a user, can the condition's expected result be seen in the UI or confirmed with a
read-only query? If yes, it is UI-observable, whichever band owns it. E2e conditions
almost always are. Integration conditions often are, for example a refusal, a status
change, or a row written by a user action. Not UI-observable: behavior reachable only
through an elevated database connection, pure functions, internal event emission, and
races a single tester cannot produce. Put every automated ID in a group by name, not by
estimate. QA sets scope from these counts, so they must be auditable.

## 3. Ask before driving

Show the user the classification compactly: counts per group with the IDs, every Manual
ID, and the Deferred / unknown IDs with their reason. Then ask one question:

> Test only the manual conditions, or also re-test the UI-observable automated conditions
> independently? You can also name specific IDs. Without an answer I test only the manual
> conditions.

Wait for the answer. The choice changes the timebox and the mission, so it is the
user's to make.

**No one to ask** (running unattended, or as a subagent): take the default, manual only.
Record that decision and the reason in the session note.

## 4. Rules for an independent re-test

Independence is the only value of re-testing an automated condition by hand. Protect it:

- Drive the app as a user would. Do not run, read, or copy the automated spec or its
  fixtures. A re-test that follows the spec's steps inherits the spec's blind spots.
- Derive the expected result from the test basis (acceptance criteria, domain docs,
  mock), not from the automated assertion.
- Triangulate as usual (`proof-discipline.md`). A matching toast proves nothing a
  passing spec did not already prove.
- A disagreement between your observation and a green automated result is a finding in
  itself. Report both, with evidence.

## 5. Record the scope in the session note

Every classified ID appears in the note's coverage map with a status:

- tested conditions get their verdict;
- out-of-scope automated conditions get the project's "not run" status, with the reason
  "automated evidence, allocated to <band>";
- deferred or unknown conditions get the same status and the open question.

Never report an automated condition as passed from a manual session you did not run on
it. Never report a manual condition as covered because an automated suite is green.
