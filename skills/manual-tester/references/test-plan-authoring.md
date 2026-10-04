---
title: "Test Plan Authoring — Writing a Manual Test Plan Worth Running"
type: reference
status: draft
created: 2026-10-04
updated: 2026-10-04
related:
  - ../SKILL.md
  - test-plan-intake.md
  - session-modes.md
  - exploration-method.md
  - proof-discipline.md
  - session-note-template.md
tags: [manual-tester, test-plan, authoring, scope, automation]
---

# Test Plan Authoring

Use this when the user asks for a manual test plan, test cases, or a test script to hand to
a tester or another agent. The output is a plan file. Do not drive the app and do not run a
session.

Why this matters: every case costs a tester minutes. A case whose verdict a passing
automated test already decides adds cost and no evidence. A plan full of such cases hides
the few checks only a human can make.

## 1. Start from the classification

1. Read the test design and any prior session notes (`test-plan-intake.md` § 1).
2. Classify every condition into one group (`test-plan-intake.md` § 2). Do not restate the rules here.
3. No test design? Use the feature docs and the list of automated tests in the repo as the
   basis. Map each candidate case to a test by name, then classify the same way.

Only **Manual** conditions become cases by default. Other groups go to the "Out of scope" section (§ 5).

## 2. Filter every candidate case

Ask of each case: *does a passing automated test already decide this verdict?*

- **Yes:** drop it. A refusal, permission, filter, or save rule is decided by its test.
  Checking it "to see the message" is a drop.
- **No:** keep it only if it names what it shows that no automated test can:
  - a real screen on seeded data;
  - copy, layout, or controls as a person reads them;
  - a journey across screens or roles.

Write that "shows" line in the case. A case that cannot fill it in is dropped.

**Zero manual conditions.** Invent no cases. Propose one assessment of the real screens and
a few cross-screen journeys, as in `test-plan-intake.md` ("Zero manual conditions").

## 3. Budget

- Aim for at most 10 cases and a 1-hour timebox.
- More needs a stated reason in the purpose section.
- Merge cases that share setup, actor, or screen into one case with several steps.

## 4. Case format

Each case carries these fields:

| Field | Content |
| --- | --- |
| ID | Short, stable. `MT-01`. |
| Title | The outcome checked. |
| Shows | What no automated test can show here. |
| Actor | Role, then the adapter account that holds it. |
| Precondition | State needed, found by a read-only query. Never a hard-coded generated code. |
| Steps | Numbered. One user action each. Use exact UI labels. |
| Expected | The result, with its oracle source (§ 5). |
| Evidence | For a data-changing step: the row or query that confirms it. A toast does not count. |

Template:

```markdown
### MT-NN — <outcome checked>

- **Shows:** <what no automated test can show>
- **Actor:** <role> → <adapter account>
- **Precondition:** <state>. Find it with Q<n>.
- **Steps:**
  1. <one action>
  2. <one action>
- **Expected:** <result> (oracle: <source>)
- **Evidence:** <screenshot of X>; Q<n> returns <row state>
```

## 5. Plan sections

Write these sections in this order.

1. **Purpose.** One paragraph: the target, the reader, the timebox. Do not claim the plan
   "covers only what automation cannot see". The "Out of scope" table is the proof.
2. **Oracle hierarchy.** Where an expected result comes from, strongest first: acceptance
   criteria, domain docs, mock or design. State that the app's current behavior is never an oracle.
3. **Setup.** Reset or seed steps the user must run, stated as a request to the user. A
   roles table: role, adapter account, what it can reach.
4. **Session rules.** Timebox. Prior evidence to read first. Verdict by row, not by toast
   (`proof-discipline.md`). Stop and report on a blocker, do not work around it.
5. **Read-only queries.** Numbered Q1..Qn, each with its purpose. Cases find codes and IDs
   through these.
6. **Cases.** In the format of § 4. Order by journey, not by screen.
7. **Exploratory charter (optional).** One charter at most (`exploration-method.md`).
8. **Out of scope.** Table of the automated and deferred conditions, by ID or group, each
   with its band. This is the classification proof.

## 6. Hand-off

- Save the plan in the adapter's `[outputs]` directory.
- Tell the user where it is. The user reviews it before anyone runs it.
- The executing session runs intake on the plan again (`test-plan-intake.md` § 2, "A
  hand-written plan is classified too"). A plan's own claims are not evidence.

## 7. Self-check before handing over

- Every case names a "Shows" line that no automated test can match.
- No case duplicates an automated condition. Each out-of-scope ID has a band.
- Case count is at most 10, or the purpose states why not.
- No precondition hard-codes a generated code, ID, or timestamp.
- Every data-changing step has a row or query as evidence.
- Every expected result names its oracle.
- Setup asks the user for reset or seed. The plan does not assume it happened.
