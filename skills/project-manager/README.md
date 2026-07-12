# Project Manager Skill

**Language / Ngôn ngữ / 语言:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

This skill turns your AI agent into a disciplined **project management copilot (PM/PMO)** — the kind of PM who won't hand you a green status report while three milestones quietly slip, or a timeline built from nothing but optimism.

## What Is the Project Manager Skill?

Ask a generic chatbot to "make a project plan" and it will produce a confident-looking timeline in seconds — milestones, dates, dependencies, all filled in, all fiction. Ask it for "this week's status" mid-crisis and it will happily paint the summary green because green is what a status report is supposed to look like. Three failure modes kill more real projects than anything else, and an eager AI assistant makes all three *worse* by default: **planning fallacy** (optimistic estimates presented as commitments), **watermelon reporting** (green outside, red inside — a status color tracing to nobody's evidence), and **scope creep** ("small" additions absorbed silently until the baseline is fiction). This skill is built so none of the three can happen quietly: every status color, every percent-complete, every estimate carries a label you can click through to where it came from — a fact on record, a stated assumption with a range, or your own word on a date. When the evidence isn't there, the skill asks or registers an honest assumption. It never colors a milestone green just to complete a table.

It's also not a one-shot document generator. A project doesn't end when the plan ships — there's a schedule to hold, risks to watch, status to report honestly week after week, scope to defend, meetings to turn into tracked actions, and a retro to run before the same mistake repeats. This skill runs as a **copilot for a living project**: one workspace, initialized once, that you return to across weeks and months. It remembers what was decided and why, so every session starts with "here's where things stand" instead of you re-explaining the project from scratch.

You stay the project manager. You own the schedule, you talk to the sponsor, you make every call on scope and dates. The skill's job is to draft well, push back when your ask contradicts the registers, run the estimates and risk math honestly, and keep the books so nothing gets silently forgotten, overwritten, or re-litigated.

## Why Use It?

- **Every status and number declares its origin.** Each RAG color, percent-complete, forecast date, and estimate is tagged `EV#` (a fact on record), `A#` (a registered assumption with an honest range), or `(user, <date>)`. An unlabelled status color is treated as a bug, not a summary.
- **Estimates confront history before they ship.** Any estimate is a range, not a point, and it's checked against the project's own lessons and past plan-vs-actual before it's offered — an estimate that ignores the last three overruns is not an estimate, it's a wish.
- **Scope changes pass a gate, every time.** Any change to scope, dates, or budget gets an impact assessment and a named decision-maker *before* it's accepted, and the old baseline is kept, never overwritten. "We'll just squeeze it in" doesn't get to happen quietly.
- **A second pass checks the work before you see it.** Baseline plans, status reports, and change decisions each get an adversarial audit before you're asked to act on them. Findings show up in the artifact, not quietly patched away.
- **The workspace remembers, so you don't have to.** An append-only decision log and a state file are the project's institutional memory: what was decided, why, and what's waiting on whom. Come back in three months and the skill reads it before saying a word.

## Five Things This Skill Never Compromises On

1. **Every status and number declares its origin.** Each RAG color, percent-complete, forecast date, and estimate carries `EV#`, `A#`, or `(user, <date>)` — never a color chosen to complete a table.
2. **Estimates confront history before they ship.** Any estimate is a range, names its basis, and is checked against the project's own lessons or an explicit reference class. Buffers are visible line items, never padding hidden inside tasks.
3. **Scope changes pass the gate.** Any change to scope, dates, or budget gets an impact assessment and an explicit decision by the named authority *before* it's accepted. Re-baselining is a recorded event; the old baseline is kept, not overwritten.
4. **The workspace is the truth, not memory.** On entry, the skill reads the state file, the latest status snapshot, and recent decisions before doing anything, and reflects the project state back in the project's own vocabulary — real milestone names, real people.
5. **Nothing ships without a second look.** A baseline plan, a status report, and a change decision each pass an adversarial audit before you're asked to act on them — and whatever it finds is shown to you, not silently cleaned up.

The question every artifact has to survive: **"if the sponsor audited every number in this document, what would not survive — and does the decision change?"**

## The Team of Lenses

Each hat has a name now, but you never have to summon anyone — it's still one PM switching hats as the moment demands, not a roster you pick from. The names are Greek philosophers, chosen for what each one is known for.

| Lens | Concern | You'd meet it when... |
|------|---------|------------------------|
| **Plato** · Anchor | Context — holds the project's ideal form: charter, methodology fit, what "done" means | You kick off a project or need help choosing predictive/agile/hybrid |
| **Aristotle** · Frame | Structure — WBS/backlog, schedule, dependencies, critical path | You ask for a project plan, timeline, or WBS |
| **Pythagoras** · Gauge | Estimation — trusts only numbers with provenance | You ask how long something will take |
| **Epictetus** · Watch | Risk — separates what you control from what you accept (ROAM) | You ask to build or review the risk register |
| **Diogenes** · Pulse | Truth-telling — carries the lamp that finds watermelon reports | You ask for a status report |
| **Zeno** · Gate | Change control — lets nothing pass unexamined | Scope, dates, or budget want to move |
| **Socrates** · Bridge | People — stakeholder map, comms plan, meetings turned into tracked actions, works by dialogue | You need a stakeholder map or want a meeting turned into actions |
| **Heraclitus** · Loop | Learning — knows the plan is a river; retros that feed the next estimate | You ask to run a retro or capture lessons |
| **Solon** · Judge | Audit — writes the law the artifacts must satisfy | Automatically, before a plan, status, or change decision ships |

Judge (Solon) runs as an independent pass whenever the agent can spin up a separate subagent — a self-review of your own homework isn't worth much, so it deliberately doesn't grade itself. Everything else happens as one PM working through the conversation with you, in the room.

## What You Can Ask For

There's no fixed order and no "phase 1 of 5" — you walk in through whatever the moment calls for, and the skill routes to the right lens:

- **"Kick off this project"** — Anchor lens: a charter with objectives, scope in/out, sponsor and decision authority, and help choosing a methodology if you're unsure.
- **"Make a project plan / timeline / WBS"** — Frame lens: a schedule shaped to your methodology — WBS and critical path, a backlog and releases, or a milestone spine with iterative interiors.
- **"Estimate how long this will take"** — Gauge lens: a ranged estimate with a named basis, checked against your own lessons or a reference class, with buffers as visible line items.
- **"Build a risk register"** — Watch lens: probability × impact, ROAM disposition, a named owner per risk, and a pre-mortem when the stakes call for it.
- **"Write this week's status report"** — Pulse lens: a RAG report where every color cites its evidence, bad news travels first, and forecasts confront the slip history.
- **"The deadline slipped, what now"** — Gate lens: an impact assessment across schedule/cost/risk/quality, routed to the named decision authority, with the baseline preserved either way.
- **"Prepare for the steering committee"** / **"Track actions from this meeting"** — Bridge lens: a stakeholder-tiered communication plan, or minutes turned into owned, dated actions.
- **"Run a retro"** / **"Capture lessons from this sprint"** — Loop lens: a lesson that names the estimate class or checklist it should change, not a diary entry.
- **"Review my project portfolio"** — the PMO extension: a roll-up across every project you name, colored by worst-credible evidence, with capacity conflicts and stage-gate recommendations surfaced for your call.

A one-off ask gets served well without ceremony — you don't have to set up a whole workspace just to get one clean status report — but the numbers still stay labelled even in a quick pass.

## The Workspace It Produces

```bash
bash scripts/init-project.sh "<project name>" [parent-dir]
```

The script is idempotent — safe to re-run against a workspace that's been lived in for months, since it never overwrites an existing file. It always creates the workspace at a fixed path: `<parent-dir>/_project/`.

```text
_project/
  context/                # slow-changing truth, filled lazily as plays need it
    charter.md            # why the project exists: objectives, scope in/out, success criteria, sponsor
    methodology.md        # predictive / agile / hybrid — the choice + tailoring + cadences
    team.md                # roster, roles, capacity, RACI
    stakeholders.md        # stakeholder map + communication plan
    environment.md         # tools, calendars, external dependencies, constraints
    glossary.md            # the project's own vocabulary
  registers/              # living books — change weekly
    risks.md               # R# probability × impact, ROAM, owner, trigger
    decisions.md            # append-only decision log — the re-entry backbone
    changes.md              # CH# scope/date/budget changes with impact + decision
    actions.md              # AC# action items with owner, due date, source, status
    assumptions.md          # A# statement, basis, range, used-by, status
    lessons.md              # L# plan-vs-actual lessons that feed future estimates
    evidence.md             # EV# registry of facts: demos passed, exports received, dates hit
  plan/
    schedule.md            # M# milestones, dependencies, critical path
    estimates.md            # ranged estimates with basis labels and reference classes
    baseline-<date>.md      # frozen snapshots — kept at every baseline and re-baseline
  status/
    status-<date>.md        # dated RAG-with-evidence snapshots — kept, never overwritten
  state.md                  # open plays, waiting-on-user, last session
```

**Coming back is easy.** Walk back into an existing `_project/` and ask anything — the skill reads `state.md`, the latest status snapshot, and recent decisions first, and tells you where things stand before doing anything else: "Milestone M3 was reported amber over the vendor API delay (R4, owned by Priya); a change request is waiting on the sponsor's call; three actions are overdue." It trusts the files over its own memory, and it won't quietly redo or overwrite work you've already finished.

## Methodology Is Context, Not Identity

The skill is generic; *your* project has a methodology. `initiate` records the choice — predictive, agile, or hybrid — and every play adapts its artifact shape to it. One skill, three dialects:

| Play | Predictive | Agile | Hybrid |
|------|-----------|-------|--------|
| plan | WBS, Gantt-style schedule, critical path | backlog, releases/sprints, capacity | milestone spine + iterative interiors |
| estimate | bottom-up + reference class | velocity-based + reference class | both, reconciled |
| report-status | milestone/EVM-style | burnup, flow metrics | milestone spine + flow detail |

The non-negotiables never change dialect: an agile burnup with invented velocity is exactly as fake as a Gantt chart with invented dates.

## Works With the Companion Skills

Project delivery touches product decisions and company-level bets constantly, but this skill isn't built to make either call itself — companion skills cover that ground, each optional and only ever suggested once:

- **[product-manager](../product-manager/)** — for the question one altitude up: *what* to build or in what order, not whether committed work will land. Its roadmap and PRDs enter this skill's `context/charter.md` scope and `plan/` as inputs with source labels. Install: `npx skills add tronghieu/agent-skills --skill product-manager`
- **[strategy-board](../strategy-board/)** — for decisions above project altitude: kill/continue, major re-scoping, portfolio-level investment calls that a delivery playbook shouldn't decide alone. The board's recommendation returns as a logged decision and possibly a change request. Install: `npx skills add tronghieu/agent-skills --skill strategy-board`
- **[critical-thinking](../critical-thinking/)** — for when a high-stakes project decision rests on a contested argument: a vendor's claims, a rescue plan's logic. The audit's verdict is cited as evidence in the decision log. Install: `npx skills add tronghieu/agent-skills --skill critical-thinking`

If a companion isn't installed, the skill mentions it once and, if you'd rather not add it, proceeds on its own. Never a requirement, always your call.

## How to Trigger

Ask your AI agent tasks like:

```text
Kick off a new project — mobile app redesign, launching in Q3.
```

```text
Build me a risk register for this migration project.
```

```text
The deadline slipped two weeks — what's the impact and what do I tell the sponsor?
```

```text
Write this week's status report for the steering committee.
```

```text
Quản lý dự án này giúp tôi — chuẩn bị báo cáo tiến độ cho sếp tuần này.
```

```text
プロジェクトのリスクレジスターを作成してください。
```

The skill also triggers whenever a `_project/` directory exists in the working tree and you ask anything about schedule, deadline, risk, status, scope, budget, or stakeholders — you never have to say "act as a project manager" for it to kick in.

## Installation

### 1. Using CLI (Recommended)

```bash
npx skills add tronghieu/agent-skills --skill project-manager
```

### 2. Manual Installation (For Non-Technical Users)

1. **Download:** Go to the `skills/` folder in this repository and download `project-manager.zip`.
2. **Extract & Copy:** Extract `project-manager.zip` and copy the `project-manager` folder into one of the following directories:

**For a Specific Project:**
Copy the `project-manager` folder to `.agents/skills/` or `.claude/skills/` in your project's root directory.

**Globally (Available for all projects):**
* **Mac / Linux:** `~/.agents/skills/` or `~/.claude/skills/`
* **Windows:** `%USERPROFILE%\.agents\skills\` or `%USERPROFILE%\.claude\skills\` (usually `C:\Users\<YourUsername>`)

## Example Usage

> **You:** Write this week's status report — I need to send it to the steering committee this afternoon, and honestly M3 is not looking good.
>
> **Agent:** Before I draft it — the workspace shows M3 was already amber last week over the vendor API delay (`R4`), and there's no evidence yet that the delay resolved. If I write green, that's a watermelon report waiting to happen. Should I report it amber with the vendor risk cited, or is there a fact I'm missing — did the vendor deliver since last Tuesday?
>
> **You:** No, they haven't. Still stuck. Report it honestly.
>
> **Agent:** *(drafts the status: M3 amber, citing `R4` and the last vendor update date as evidence; forecast date pushed out with the basis shown; two other milestones stay green with their own evidence cited; bad news leads the report, achievements follow)*
>
> Here's the draft — M3 leads as amber with the vendor delay and a revised forecast, backed by `R4` and the dated status history. I ran it past the Judge audit: one finding — the forecast slip doesn't yet reflect the pattern in your lessons register (`L2` flagged vendor dependencies as a recurring slip source), so I added that context to the risk note rather than treating this as a one-off. Logged as today's snapshot in `status/`, and the amber call is recorded in `decisions.md` with a trigger to revisit once the vendor responds.
