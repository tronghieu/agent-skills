# Project Manager

**Language:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

Turn uncertain delivery work into an evidence-backed plan, honest forecast, and clear decision trail.

## Quick install

```bash
npx skills add tronghieu/agent-skills --skill project-manager
```

## Start with a real project need

Use `/project-manager` in plain language. For example:

```text
/project-manager Turn this rough scope into a milestone plan with dependencies, owners, and a credible date range.
/project-manager We missed the integration milestone. Build a risk register, run a pre-mortem, and recommend the next decision.
/project-manager Draft this week's steering-committee status: lead with bad news, label the evidence, and name the decisions needed.
/project-manager Assess this request to add SSO: show the scope, schedule, cost, risk, and quality impact before we accept it.
```

## Why use this instead of an ordinary chatbot?

An ordinary chat can produce a neat plan or a reassuring green report from thin air. Project Manager is designed to make delivery claims auditable:

- Dates, estimates, progress, and RAG status cite evidence, a dated user statement, or an explicit assumption.
- Estimates are ranges, checked against project history or a stated reference class; buffers stay visible.
- Scope, date, and budget changes receive an impact assessment and a named decision authority before the baseline changes.
- Plans, status reports, and change decisions face an adversarial review, so risks and weak evidence are visible before anyone acts.

## Who it is for

Use it if you are a project or program manager, PMO, delivery lead, team lead, or sponsor accountable for landing committed work: scope, schedule, budget, risks, stakeholders, or reporting. It is a copilot for a live project—not a beginner course or a generic task-list generator. You retain the decisions and external commitments.

## What it helps you do

- Start a project with a charter, success criteria, decision authority, and a suitable delivery method.
- Build a WBS or backlog, dependencies, milestone schedule, critical path, and baseline.
- Create range estimates, risk registers, ROAM responses, pre-mortems, and recovery options.
- Produce candid weekly updates, steering packs, stakeholder communication, meeting actions, and decision records.
- Control change, re-baseline transparently, capture lessons, and roll up several projects without averaging away a red one.

## Delivery method and operating discipline

This is a playbook rather than a forced sequence: begin with the problem at hand, then connect the work as needed. A typical delivery loop is:

1. **Orient:** confirm the objective, in/out scope, success criteria, stakeholders, reporting cadence, and authority.
2. **Plan and estimate:** map work and dependencies, choose a forecast range, expose assumptions and buffers, then freeze a baseline when ready.
3. **De-risk and deliver:** review risks, actions, evidence, and actual progress; report the forecast plainly.
4. **Decide and learn:** assess requested changes before approval, preserve prior baselines, and feed plan-versus-actual lessons into the next estimate.

It adapts the artifact shape to the project, not the other way around: predictive work uses a WBS, critical path, and stage gates; agile work uses a capacity-aware backlog, releases or sprints, burnup, and flow measures; hybrid work combines a milestone spine with iterative delivery. The discipline stays the same in every method: do not invent facts, let bad news travel first, record decisions with a revisit trigger, and keep uncertainty visible.

Three review gates protect consequential artifacts. Before a baseline, the plan checks ownership, acceptance evidence, dependencies, buffers, pre-mortem results, scope alignment, and risk treatment. Before a status report, it checks provenance, honest progress, recovery actions, forecast credibility, and consistent executive/team views. Before a change is executed, it checks schedule, cost, risk, and quality impacts; authority; baseline handling; and propagated updates.

## How collaboration works

For ongoing work, the skill maintains a `_project/` workspace with project context, plans, dated status snapshots, and living evidence, assumption, risk, action, change, decision, and lessons registers. When you return, it uses the current state and recent decisions rather than pretending to remember.

It asks only for the missing inputs needed for the current play, calls out conflicts with the record, and can provide a useful assumption-labelled draft when facts are incomplete. It does not make up teammates' views or silently accept a change. The PM switches among focused lenses—charter, structure, estimation, risk, truth-telling, change, stakeholders, learning, and audit. **Solon**, the audit lens, performs a separate adversarial review before a plan, status report, or change decision ships; when separate agents are available, that review can be independent.

## What to bring and what you receive

Bring whatever is available: the objective, current scope, constraints, target dates, team capacity, stakeholders, known dependencies, current progress, source material, prior estimates or actuals, and the person authorized to decide. Missing information is recorded as an assumption or a question, never disguised as fact.

You can receive a charter; schedule or backlog; estimate ranges; a risk, evidence, decision, change, or action register; a status report or steering pack; stakeholder communications; meeting outputs; a recovery recommendation; or a portfolio roll-up. The response leads with the delivery headline, the evidence behind decisive numbers, and the decision or action needed.

## Complementary skills

- Need to decide **what to build, for whom, or in what order** before committing delivery? Use [Product Manager](../product-manager/README.md) for prioritization, PRDs, and product evidence; bring its approved scope into the project plan.
- Need an executive call on **investment, portfolio priority, a kill/continue choice, or major re-scoping**? Use [Strategy Board](../strategy-board/README.md). Project Manager supplies delivery truth; the board evaluates the strategic choice.
- Need to test the reasoning behind a **vendor claim, rescue proposal, or high-stakes decision**? Use [Critical Thinking](../critical-thinking/README.md) to audit the argument, then record its supported findings as project evidence.

## Limits

The skill cannot know actual progress, capacity, vendor commitments, internal politics, or historical performance without the material you provide. It supports and challenges decisions; it does not approve scope, make commitments, replace domain, legal, financial, or people judgment, or guarantee an outcome. Detailed plays, schemas, and evidence conventions are in [`references/`](./references/).
