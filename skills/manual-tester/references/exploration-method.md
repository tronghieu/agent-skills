---
title: "Exploration Method — Charters, Sessions, Tours, Oracles"
type: reference
status: draft
created: 2026-07-10
updated: 2026-07-10
related:
  - ../SKILL.md
tags: [exploratory-testing, charter, sbtm, heuristics]
---

# Exploration Method — Charters, Sessions, Tours, Oracles

How to run a disciplined exploratory session. This file is the operating manual; the
theory behind it (testing vs checking, the oracle problem, session-based test management)
is standard exploratory-testing literature, and a project may name its own summary of it
through the adapter's `persistent_facts`.

## Table of contents

1. [The session frame](#1-the-session-frame)
2. [Writing a charter](#2-writing-a-charter)
3. [Idea generators: tours](#3-idea-generators-tours)
4. [Idea generators: attack list](#4-idea-generators-attack-list)
5. [Judging without assertions: HICCUPPS](#5-judging-without-assertions-hiccupps)
6. [Coverage honesty](#6-coverage-honesty)

## 1. The session frame

Exploration is free in its *actions* and disciplined in its *frame*. The frame:

| Element | Rule |
| --- | --- |
| **Charter** | One sentence, written before touching the product. Aims the session. |
| **Timebox** | A budget stated up front (default: the equivalent of ~60–90 human-minutes of ground covered). Stop when spent; propose a follow-up charter instead of overrunning. |
| **Notes** | Log as you go, not from memory afterwards — where you went, what you tried, what you saw, what you skipped. Use the session-note template. |
| **Debrief** | End with: bugs filed, open questions, automation candidates, charters proposed. |

Within the frame, let each observation choose the next experiment. If a field accepts a
minus sign, try a negative number *now*, not after finishing the planned path — the trail
is warm. But log the detour, and return to the charter's mission afterwards. If a detour
grows into its own mission, don't chase it: write it down as a proposed charter for the
debrief.

## 2. Writing a charter

Template (Hendrickson):

> **Explore** *(target)* **with** *(resources / data / tools)* **to discover** *(kind of information sought)*.

A good charter is narrow enough to aim a session and broad enough not to script it.
"Test the login page" is not a charter (no information goal); "click everything" is not a
charter (no target).

**Examples:**

- Explore **invitation acceptance** with **expired, revoked, and double-used invite links** to discover **state-handling and error-message problems**.
- Explore **member profile editing** with **two members editing the same profile concurrently** to discover **lost-update and stale-data problems**.
- Explore **the sign-up flow** with **a fresh browser profile and a device set to the app's secondary locale** to discover **first-run friction and untranslated content**.

**Deriving charters from risk.** When the user gives a story/PR instead of a charter, aim
where uncertainty is highest — that's where exploration pays (automation already guards
the promises). Ask of the change:

1. What does it touch that involves **money, auth, or tenant boundaries**? (highest stakes)
2. What **states** can the new thing be in, and which transitions did nobody mention? (draft/expired/revoked/deleted…)
3. What happens at the **seams** — where this feature hands off to another (navigation away mid-flow, concurrent edits, notifications)?
4. What would a **hurried, non-technical user** do differently from the happy path the developer imagined?

Each answer is a charter candidate. Propose 2–4, pick with the user if they're present;
otherwise pick the highest-stakes one and note the rest in the debrief.

## 3. Idea generators: tours

When mid-session momentum stalls, run a themed pass over the charter's territory:

| Tour | What you do |
| --- | --- |
| **Money tour** | Visit only what touches amounts, balances, totals, prices. Verify every displayed number against the database, not against the UI's own summary. |
| **Saboteur tour** | Deliberately break things: invalid input, killed connection mid-save, double-submit, back-button mid-flow, out-of-order steps, direct URL access to later steps. |
| **Garbage-collector tour** | Methodically visit every corner of the area — every menu item, every state of every list (empty, one item, many, error) — to find dead ends and forgotten screens. |
| **Intern tour** | Do what a rushed first-time user would: skip instructions, click the biggest button, paste instead of type, use the browser back button as "cancel". |
| **Boundary tour** | Every input gets: empty, one char, maximum length, max+1, 0, negative, huge number, emoji/diacritics (`José Nguyễn 🏪`), leading/trailing whitespace, duplicate of an existing value. |

## 4. Idea generators: attack list

Quick error-guessing checklist for any form or flow (each item exists because it finds
real bugs in CRUD web apps):

- Submit twice fast (double-click, or resubmit while the first request is in flight)
- Refresh / back-button immediately after submit
- Open the same record in two tabs, edit in both, save both
- Use a stale page: leave a form open 30+ minutes, then submit
- Direct-navigate to a URL you shouldn't reach (other tenant's resource, later wizard step, owner-only page as member)
- Delete or revoke the thing another flow is currently pointing at
- Non-ASCII text (each locale the app ships, accents, emoji) everywhere text is accepted; long unbroken strings (no spaces) in names
- The empty states: brand-new tenant, member with zero data, list filtered to nothing

## 5. Judging without assertions: HICCUPPS

Exploration has no `expect()`. Judge by consistency — the product should be consistent with:

| Anchor | Question to ask |
| --- | --- |
| **H**istory | Did this behave differently before the change? |
| **I**mage | Does this look/read like the project's quality bar? |
| **C**omparable products | Do similar POS/SaaS apps handle this more gracefully? |
| **C**laims | Does behavior match the story's acceptance criteria and docs? |
| **U**ser expectations | Would a small-shop owner expect this? (destructive actions reversible, money never silently rounded) |
| **P**roduct | Is this consistent with the rest of the app (other lists, other forms, other error messages)? |
| **P**urpose | Does the feature actually accomplish what it's for? |
| **S**tandards | Accessibility basics, platform conventions, legal/format conventions (VND formatting, date formats) |

An inconsistency is a *signal*, not a verdict. Route it through the proof discipline
(`proof-discipline.md`): deterministic signals can become FAIL findings; pure judgment
signals ("this wording feels rude") become **observations** for human review — record
them, never silently drop them, never present them as confirmed bugs.

## 6. Coverage honesty

A session report that lists only what was found implies everything else was checked. It
wasn't. Before concluding, write the coverage map:

- **Visited** — routes/features actually exercised this session
- **Seen but not exercised** — noticed, deliberately skipped (say why: out of charter, no account, time)
- **Not reached** — known to exist, never opened

Never summarize a session as "feature works well" while the coverage map has unvisited
core paths. "No problems found *in the paths visited*" is the honest claim.
