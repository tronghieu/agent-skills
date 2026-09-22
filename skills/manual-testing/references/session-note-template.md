---
title: "Session Note Template"
type: reference
status: draft
created: 2026-07-10
updated: 2026-07-10
related:
  - ../SKILL.md
  - bug-report-template.md
tags: [manual-testing, session-note, template, sbtm]
---

# Session Note Template

One file per session. The note is written *during* the session (log as you go), finalized
at debrief. It is the durable record that makes exploration reviewable and hand-off-able —
without it a session is just clicking.

Save to: `{outputs.session_notes_dir}` from `_project/testing/environment.toml`, as
`SESSION-{YYYY-MM-DD}-{slug}.md`. The session's screenshots live in
`{outputs.screenshots_dir}/SESSION-{YYYY-MM-DD}-{slug}/` (same slug — evidence and note
travel together; conventions in `proof-discipline.md` §6) and are referenced from the log
and findings by relative path.

````markdown
---
title: "Session — {short mission phrase}"
type: session-note
mode: exploratory | verification | smoke | assessment | ai-probe
mission: "Explore {target} with {resources} to discover {information sought}"
app: {app name}
date: {YYYY-MM-DD}
environment: {local dev / staging}, seed state: {fresh reset / dirty}
accounts_used: [{email (role)}, ...]
timebox: {planned}
status: complete | cut-short ({reason})
---

# Session — {short mission phrase}

## Log

Chronological, terse. Every entry: what I did → what I saw → what I concluded or asked.
Mark detours with `↪`. Timestamps optional but helpful at direction changes.

- Logged in as {account}; dashboard renders, nav shows {items} — login PASS (token + role nav)
- Created invitation for x@y.com → row in `iam.invitations` confirmed — PASS
- ↪ noticed the expiry field accepts past dates → detour: created invite expiring yesterday…
- …

## Findings

| # | Verdict | Summary | Evidence | Filed as |
| --- | --- | --- | --- | --- |
| 1 | FAIL | {one line} | {screenshot, query, status} | BUG-{date}-{slug}.md |
| 2 | OBSERVATION | {one line} | {screenshot} | — (below) |
| 3 | UNVERIFIED | {what + why not testable} | — | — |

## Observations for human review

Judgment signals — no verdict claimed. For each: what was seen, which HICCUPPS anchor it
tripped, one screenshot.

## Open questions

Things neither PASS nor FAIL — behaviors whose *intended* design is unknown.
Phrase each as a question a PM/dev can answer with one sentence.

## Automation candidates

Findings worth converting into permanent checks (exploration discovers, automation
remembers). For each: the scenario, the deterministic oracle to assert, suggested level
(unit / integration / e2e).

## Coverage map

- **Visited:** {routes/features exercised}
- **Seen, not exercised:** {+ why}
- **Not reached:** {known to exist, never opened}

## Proposed next sessions

Detours that deserve their own session, ranked by risk — include the suggested mode.
````

Keep the log honest and terse — it is evidence, not prose. A reader should be able to
replay the session from it.
