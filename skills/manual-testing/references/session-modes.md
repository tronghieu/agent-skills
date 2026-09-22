---
title: "Session Modes — Verification, Smoke, Assessment, AI Probe"
type: reference
status: draft
created: 2026-07-10
updated: 2026-07-10
related:
  - ../SKILL.md
  - exploration-method.md
  - proof-discipline.md
tags: [manual-testing, session-modes, verification, smoke, assessment, ai-probe]
---

# Session Modes — Verification, Smoke, Assessment, AI Probe

The four non-exploratory modes. All share the session spine (preflight → mission → drive
→ verify → report → debrief) and the full proof discipline; what changes is the mission
form and how you drive. The exploratory engine has its own file
(`exploration-method.md`) — read that for charters, tours, and the attack list.

## Verification

**Use when:** the user has a specific claim to check — "the bug is fixed", "story X
behaves as promised" — usually after a fix lands and before (or instead of) an automated
regression test existing.

**Mission form:** one falsifiable claim, plus where its repro steps come from:

> Verify *(claim)* using *(the original bug report's steps / the story's ACs)*.

**How to drive:** the opposite of exploration — follow the script exactly.

1. Reproduce the *original* steps from a clean state, byte-for-byte where possible. The
   original bug report's "Steps to reproduce" is the script; don't improve it, because a
   "better" path that passes proves nothing about the path that failed.
2. Verdict on the claim using the **same triangulated signals that originally failed**
   (if the bug was "row written twice", the oracle is the row count — not the toast).
   Fixed = PASS with positive evidence; still reproduces = FAIL, reference the original
   report; can't reach the state = UNVERIFIED with the blocker named.
3. **Then explore the neighborhood** — reserve the last ~25% of the timebox for a short
   exploratory sweep around the fix: same component in other states, adjacent flows, the
   inputs listed in the original report's "suggested regression check". Fixes cluster new
   bugs nearby; a verification session that skips this is half a session.
   Include one check that the fix did not swallow a legitimate failure: an input that
   should still be refused or still show an error must still do so. "Make the error go
   away" fixes often remove the right errors along with the wrong one.

**Report:** the claim's verdict is the headline of the debrief. Session note still
required; if the fix holds, the strongest deliverable is the **automation candidate** —
this exact scenario is now a proven regression risk and belongs in the permanent suite.

## Smoke

**Use when:** after a deploy, a `db:reset`, a big merge — "is the app breathing?"

**Mission form:** a fixed breadth list of core flows, each run happy-path only. Derive
the list from the adapter's `[apps]` plus each app's one-or-two core actions; if the
adapter grows a dedicated `[smoke]` table of flows, use that as the source of truth
(propose adding it once the project has stable core flows).

**How to drive:** broad and shallow, strictly. One pass per flow, no detours — anything
suspicious gets *logged as a proposed exploratory charter*, never chased now. A smoke
session that goes deep has failed at its own mission: its value is completeness of
breadth inside a tight timebox (the human-equivalent of 15–30 minutes).

**Report:** a table — core flow × verdict. Any FAIL in smoke is by definition severity
High or Critical (it's a core flow). UNVERIFIED rows matter as much as FAILs here: a
smoke pass that couldn't check login has not established the app is breathing.

## Assessment

**Use when:** the user wants judgment-quality review — "is this screen understandable?",
"check the localized copy", "review accessibility basics".

**Mission form:** one lens × one surface set:

> Assess *(screens/flows)* through the *(comprehension | localization | accessibility)*
> lens for *(target persona)*.

Lenses:

- **Comprehension/UX** — walk each screen *in persona* (e.g. a rushed, non-technical
  shop owner): is the next action obvious? Do error messages say what to do? Would they
  know what just happened?
- **Localization** — naturalness in each locale the project ships (word-for-word
  translations, register/formality, pronoun consistency), no raw i18n keys, locale
  format conventions (currency, dates, phone numbers), text overflow from longer
  translations. The adapter (`_project/testing/`) says which locales exist and which
  one is primary.
- **Accessibility** — the judgment half only: keyboard-only walk, focus visibility,
  label/announcement sense. (The rule-checkable half — contrast ratios, missing
  alt/aria — belongs to automated axe-core checks; note it as an automation candidate
  instead of hand-checking.)

**How to drive:** methodical, garbage-collector style — every screen in the set, every
state you can reach (empty, filled, error), screenshot everything you judge.

**Verdict discipline — the defining constraint of this mode:** an agent has no authority
on taste. Almost everything here is an **OBSERVATION** — structured for a human to judge
efficiently: grouped by screen, tagged with the lens and the HICCUPPS anchor it tripped,
one screenshot each. Deterministic catches along the way (raw i18n key, text overflowing
its container, keyboard trap) are still FAILs with evidence, as usual. The mode's value
is a *complete, well-organized set of candidate judgments* — the human spends minutes
deciding instead of an hour hunting.

## AI probe

**Use when:** the product exposes an AI agent/chat surface and the user wants its
answers evaluated. Method fundamentals live in `proof-discipline.md` §5; this section is
the session shape.

**Mission form:** one agent surface × a question set. **Build the entire question set
before sending the first message** — otherwise the agent's own replies steer what you
ask, and your coverage silently narrows to what it's good at. Include:

- **Factual, DB-groundable questions** (the majority) — fill the expected-answer column
  from `verification-queries.md` *before* asking.
- **1–2 multi-turn chains** ending in pronoun references ("và của cô ấy tháng trước?").
- **1–2 out-of-scope questions** it cannot know — correct behavior is admitting so.
- **1 paraphrase pair** — same fact asked two ways; divergent answers are a consistency
  finding.

**How to drive:** run the set in order, capture each full reply verbatim (the reply
bubble, not surrounding page text), then grade against the pre-filled expectations.

**Verdict mapping:** correct = PASS · partially correct = PARTIAL · fluent-but-wrong =
FAIL (accuracy) · no reply/timeout/crash = FAIL (technical — a different bug, say which)
· confident fabrication on out-of-scope = FAIL, severity High (it breaks trust and may
touch money) · tone/helpfulness/naturalness with correct facts = OBSERVATION.

## Blending rules

Sessions blend; the discipline is to make blends visible, not to forbid them:

- Log every mode switch in the session note (`↪ switching to exploratory around the fix`).
- The natural blend is verification → exploratory (built into verification above).
- Never blend *into* smoke — smoke stays shallow or it stops being smoke.
- One session, one primary mode in the note's frontmatter; the log shows the rest.
