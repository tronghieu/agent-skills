# Scrum Master

**Language:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

Help a software team run focused sprints, surface problems early, and turn each retrospective into visible follow-up.

## Quick install

```bash
npx skills add tronghieu/agent-skills --skill scrum-master
```

## Start with a real team need

Use `/scrum-master` in plain language. For example:

```text
/scrum-master Plan our next sprint from this backlog, team capacity, and the last three sprint results.
/scrum-master Give me today's sprint pulse. What is putting the sprint goal at risk?
/scrum-master Prepare tomorrow's retrospective and check whether actions from the last retro were completed.
/scrum-master This blocker has been open for nine days. Draft an escalation and tell me who needs to act.
```

## Why use this instead of an ordinary chatbot?

A normal chat can draft a ceremony agenda, but it may forget previous actions or describe sprint health without reliable data. Scrum Master keeps the team's process history visible:

- Sprint metrics are linked to a tracker, a dated export, or an explicit assumption. Missing data stays unknown instead of becoming a plausible number.
- Retrospective actions remain open until the team completes or deliberately closes them.
- Work added to or removed from a sprint is recorded as a scope change.
- Recurring blockers and process problems are compared across sprints, not treated as new every time.
- Conversations, negotiation, and escalation stay with people. The skill drafts the handoff and records who should follow up.

## Who it is for

Use it if you are a Scrum Master, engineering manager, tech lead, delivery lead, product owner, or software team member helping a real team work through sprints. It can act as the team's Scrum Master of record when no one holds the role, or as a copilot to a human Scrum Master.

The team still owns Scrum decisions, working agreements, and conversations with people.

## What it helps you do

- Adopt an existing team and connect its current Scrum artifacts.
- Plan a sprint around a clear goal, realistic capacity, and ready work.
- Run a short sprint pulse that leads with risks, blockers, and scope changes.
- Close a sprint with a stable snapshot for later comparison.
- Prepare and follow up retrospectives, including unfinished improvement actions.
- Track impediments, draft escalations, and check their age and ownership.
- Scan sprint history for recurring problems and ceremony decay.
- Coach the team toward small, practical process improvements.

## How ongoing work stays consistent

For ongoing work, the skill keeps a `_project/scrum-master/` workspace with team context, sprint records, impediments, retrospective actions, and dated health reports. On the next session, it reads that workspace before making recommendations.

You can connect a tracker such as Jira, Linear, or GitHub Projects through `_project/tools.md`. If the tracker is unavailable, provide a dated export or summary. The skill can still prepare a useful draft, but it labels assumptions and missing facts.

Initialize the workspace once when needed:

```bash
bash /mnt/skills/user/scrum-master/scripts/init-scrum.sh "<team or project name>" [parent-dir]
```

## What to provide and what you will receive

Share whatever is available: sprint goal, backlog, team capacity, Definition of Done, tracker export, current blockers, recent sprint results, and previous retrospective actions. You do not need to prepare everything first.

Depending on the request, you will receive a sprint plan, pulse, close summary, retrospective pack, impediment update, escalation draft, or process health report. The response states the bottom line first, names data sources, and separates facts from assumptions.

## Companion skills

- [Project Manager](../project-manager/README.md) — use when the question moves from team process to delivery dates, budget, project risks, or stakeholder reporting.
- [Product Manager](../product-manager/README.md) — use when the question is what to build, why it matters, or how to prioritize the backlog.

## Limits

The skill cannot observe team dynamics or know the current board state unless you provide access or data. It does not send messages, resolve conflicts, make commitments, or replace human judgment. It supports Scrum process health; it does not own product strategy, project budget, or delivery commitments.

See [SKILL.md](./SKILL.md) for the operating rules and [`references/`](./references/) for the detailed plays.
