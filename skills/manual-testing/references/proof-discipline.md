---
title: "Proof Discipline — Verdicts, Triangulation, Self-Check"
type: reference
status: draft
created: 2026-07-10
updated: 2026-07-10
related:
  - ../SKILL.md
  - ../../../../_project/testing/verification-queries.md
tags: [manual-testing, verdicts, triangulation, oracles, ai-testing]
---

# Proof Discipline — Verdicts, Triangulation, Self-Check

The most dangerous failure mode of agent-driven testing is not missing a bug — it is
**reporting a bug that isn't one**, because the test runner was in the wrong state,
measured the wrong element, or read a heuristic as a fact. One false FAIL costs more
credibility than ten true ones earn. This file is the guard against that.

## Table of contents

1. [Verdict taxonomy](#1-verdict-taxonomy)
2. [Triangulation](#2-triangulation)
3. [Self-check before any FAIL](#3-self-check-before-any-fail)
4. [Don't conclude X — conclude Y](#4-dont-conclude-x--conclude-y)
5. [Probing AI features](#5-probing-ai-features)
6. [Evidence capture — screenshots](#6-evidence-capture--screenshots)

## 1. Verdict taxonomy

Every finding and every checked behavior gets exactly one of:

| Verdict | Meaning | Proof required |
| --- | --- | --- |
| **PASS** | Behavior verified correct | *Positive* evidence: the expected outcome observed via at least one deterministic signal. "No errors seen" is not a PASS. |
| **FAIL** | The software is defective | Reproduced at least twice + runner state verified (see §3) + evidence captured (screenshot AND a deterministic signal: DB row, HTTP status, console error) |
| **PARTIAL** | Works in some cases, broken in others | Evidence for both sides, with the boundary stated ("works for owner, fails for member") |
| **UNVERIFIED** | Could not be tested | The reason, stated precisely (no account with the needed role, feature gated, environment down, out of timebox). **Never infer anything negative from your own inability to test.** |
| **OBSERVATION** | Judgment signal, not a defect claim | For qualities with no formal oracle: confusing layout, questionable wording, sluggish feel. Describe what you saw and why it triggered the HICCUPPS anchor; leave the verdict to a human. |

"Could not test it" ≠ "it is broken" is the single most important line in this file.

## 2. Triangulation

The UI is a *rendering* of the truth, not the truth. Any significant claim needs **two or
more independent signals** before it becomes PASS or FAIL:

| Signal | How to read it |
| --- | --- |
| **UI state** | Playwright accessibility snapshot (element exists / text present / state correct) — not a screenshot eyeball |
| **Database state** | Read-only SELECT against the local database — see `_project/testing/verification-queries.md`. The strongest oracle available: after any data-changing action, confirm the row. |
| **Network** | Response status + body of the triggering request (4xx/5xx, error payloads, slow responses) |
| **Console** | JS errors/warnings after each significant action |

Canonical pattern for a data-changing action:

```
act (UI) → verify UI shows the result → SELECT the row → check network/console for silent errors
```

Classic catches this makes: UI shows "saved" but no row exists (silent failure);
row exists but UI doesn't refresh (rendering bug); row written twice (double-submit);
row visible from the wrong tenant (isolation breach — always severity Critical).

## 3. Self-check before any FAIL

Before writing FAIL, prove the *runner* — not the software — reached the right state:

- [ ] Am I actually logged in, as the role I think? (Check role-specific nav/content is present — not just "no error shown". SPAs keep the URL and may use localStorage, so "URL didn't change" and "no session cookie" prove nothing.)
- [ ] Am I on the right route/element? (A search box is not a chat input; a preview is not the saved record.)
- [ ] Did the page finish loading? (Wait for a specific element, not just navigation. An empty body right after navigation is usually *my* impatience, not a white-screen bug.)
- [ ] Does it reproduce? (Twice, from a clean state. Once = anecdote.)
- [ ] Could this be seed-data or environment artifact? (Would it happen on freshly reset data?)

If any box can't be ticked, the verdict is UNVERIFIED (with the reason), not FAIL.

## 4. Don't conclude X — conclude Y

| Situation | ❌ Don't conclude | ✅ Conclude |
| --- | --- | --- |
| Login: URL unchanged, no cookie | "Login broken" | Check localStorage/token + role-specific nav; only then verdict |
| Empty page right after navigation | "White screen bug" | Wait for a concrete selector; still empty after wait + no console/network errors → then investigate |
| No account for a role | "Role X is broken" | UNVERIFIED — missing account (and say which account would unblock it) |
| Action shows no toast/confirmation | "Action failed" | SELECT the row — the action may have succeeded silently (that's a *different*, smaller bug: missing feedback) |
| Word "error" appears in page text | "There is an error" | Find the deterministic source: console entry, failed request, or error-state element |
| Feature can't be found in nav | "Feature missing" | Check direct route, other roles' nav, and feature flags before claiming absence |

## 5. Probing AI features

Non-deterministic output defeats exact assertions, but the *probing* can still be
disciplined:

- **Canned-response detection** — send at least two completely different questions. Identical replies → the "AI" is scripted; that's a finding.
- **Ground truth from the database** — when the agent answers about tenant data ("how much does this customer owe?"), SELECT the truth and compare. This turns an oracle-less judgment into a deterministic check.
- **Multi-turn coreference** — follow up with pronouns ("and *hers* from last month?"). Losing the referent is a common, reportable failure. Probe in each locale the product ships — coreference breaks differently across languages.
- **Out-of-scope probe** — ask something the agent cannot know. The correct behavior is admitting ignorance; a confident fabrication is a finding (severity: high — it touches trust and possibly money).
- **Distinguish ERROR from WRONG** — no reply/timeout/crash is a technical FAIL; a fluent wrong answer is an accuracy finding. Different bugs, different owners.
- Reply *quality* (tone, helpfulness, naturalness in the reply's language) with correct facts → **OBSERVATION**, not FAIL.

## 6. Evidence capture — screenshots

A screenshot is the human-readable half of evidence — it never replaces the deterministic
signal (§2); a FAIL still needs both. Capture it **at the moment of observation**, never by
re-navigating later: re-navigation can heal (or worsen) the very state you're claiming.

- **Where:** `{outputs.screenshots_dir}/SESSION-{YYYY-MM-DD}-{slug}/` — one folder per
  session, same slug as the session note, so evidence and note travel together.
- **Naming:** `{NN}_{what-it-shows}.png`, numbered in capture order — e.g.
  `04_invite-accepts-past-expiry.png`. The name states what the image *proves*, not what
  you clicked.
- **Framing:** capture the app's viewport (or the relevant element) via the browser tool —
  never the whole desktop. A capture full of unrelated windows is noise the reader has to
  decode before they can see the defect.
- **When:** every FAIL, PARTIAL, and OBSERVATION gets one; assessment mode screenshots
  every screen it judges. A PASS needs one only when the visual state *is* the evidence.
- **Referencing:** every file is linked by relative path from a log entry, finding, or bug
  report. At debrief, delete captures nothing references — an unreferenced screenshot is
  clutter pretending to be evidence.
- **Lifecycle** — committed to git or ignored, retention, whether some presentation format
  (docx/PDF) is built from the markdown — is the project's call, declared in the adapter's
  "Reporting & evidence" section (`_project/testing/environment.md`). Default when the
  adapter is silent: keep the session folder, never delete referenced evidence.
