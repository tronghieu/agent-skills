# Problem Solver

**Languages:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

Turn an unexplained operational, technical, process, or business failure into a testable diagnosis and a plan that targets its cause.

## Install

```bash
npx skills add tronghieu/agent-skills --skill problem-solver
```

## Start with a real problem

```text
/problem-solver Orders started arriving late after June; only cross-district custom orders are affected. What should we check first?
```

```text
/problem-solver Our conversion rate fell 18% this month. We changed pricing, onboarding, and ad targeting; help us separate the causes.
```

```text
/problem-solver The production incident keeps returning after each hotfix. Run a root-cause diagnosis before we propose another fix.
```

## Why not ask an ordinary chatbot for fixes?

An ordinary chat can make a confident, plausible story from missing facts. Problem Solver keeps what you observed separate from what is only suspected, asks for the cheapest check that could disprove a leading explanation, and does not treat an attractive fix as proof of a cause. That means a failed test is useful progress—not an inconvenience hidden by a polished answer.

## When it helps

Use it when something is failing, slowing, recurring, or changing and the cause is unknown or unverified: a late-order pattern, a metric drop, a recurring incident, a stalled change, or a post-mortem that needs to end in action. It suits operators, engineers, product and process leads, managers, and owners who can supply observations or check the real world.

It is not the first choice for open-ended idea generation when nothing is broken, or for a question that is fundamentally about understanding users' needs and behavior.

If you ask for fixes before a cause is known, it explains that those ideas may target the wrong thing, offers a quick Frame pass, and lets you explicitly skip diagnosis with that risk understood; choosing to skip switches the work to Brainstorm Coach.

## The mental model: diagnosis before solution

The skill works from three sources of truth:

- **Facts** supplied directly by you or by data/artifacts you check are `[verified]`.
- **Hypotheses**, including your hunches and the facilitator's, remain `[assumed]` until reality confirms them.
- **Verification** happens only when you check the world; agreement that something sounds plausible does not count.

Load-bearing assumptions get a confidence level, impact if wrong, and the cheapest test. Each root-cause candidate must predict what should be observable and name a cheap observation that could disprove it. At least two rival explanations stay alive until evidence separates them.

## What happens in a session

1. **Frame** — clarify the observable symptom, onset, impact, attempted fixes, and how “fixed” will be known; separate facts from embedded causes and preferred solutions.
2. **Bound** — compare where, when, who/what, and what form the problem **is** versus **is not**. The differences supply the strongest leads.
3. **Diagnose** — use one or two methods that fit the shape: Five Whys for a likely chain, fishbone for several contributors, causal loops for recurring or self-defeating patterns, and force-field/constraint analysis as an organizational-change add-on.
4. **Solve** — generate options against the verified cause, tracing every option to the cause it addresses. A necessary short-term symptom patch is labeled and paired with a causal fix.
5. **Decide** — compare two options directly, or use a matrix for three or more; every score cites evidence or says `unknown — assumption`. You make the decision.
6. **Plan** — choose a pilot, phased rollout, or rarely a reversible big-bang change; name owners, inherited success metrics, open-assumption checks, review point, and pivot triggers.

The conversation scales to the stakes: small problems can compress the early phases, while expensive or recurring ones earn the full pipeline. If your opening already contains a sharp boundary and a coincident change, it can propose a cheap discriminating check in its first response instead of making you complete a questionnaire.

## Checkpoints, people, and collaboration

There are exactly three gates: you confirm the refined problem statement; the leading cause is verified—or you explicitly accept the risk of proceeding; and you make the final decision. The skill does not role-play stakeholders or invent what they would say. Perspective questions may broaden a fishbone analysis, but you remain the source of facts.

During Solve, it hands off to [Brainstorm Coach](../brainstorm-coach/README.md) when available for cause-directed divergent ideation. Otherwise it continues with a lightweight, user-first ideation pass; it does not block on a missing companion skill. It does not define a standing multi-agent panel or party.

## Your experience and deliverables

Bring whatever you know: the observable symptom and magnitude, timing, affected and unaffected cases, recent changes, prior attempts, data/artifacts, constraints, and what success looks like. “I don’t know” is a valid answer and becomes a fact gap to check.

For problems that outlast one conversation, the skill normally maintains a compact workspace holding the statement and boundary, diagnosis and tests, assumption log, cause-traced options, decision, and plan. On return it reads that state first, summarizes the pending check, updates labels and confidence from new evidence, and resumes the current phase rather than restarting. For a quick problem, the same structure can stay in the conversation.

Expect a confirmed problem statement; an Is/Is-Not boundary; a labeled cause tree with rival candidates and verification tests; an assumption log; options traced to causes; an evidence-aware recommendation; and a rollout plan with metrics and pivot triggers.

## Related skills

- [Brainstorm Coach](../brainstorm-coach/README.md) — after a cause is verified, for broader solution generation.
- [Design Thinking](../design-thinking/README.md) — when the real uncertainty is users’ needs, feelings, adoption, or behavior.
- [Critical Thinking](../critical-thinking/README.md) — to audit the reasoning in a diagnosis or decision.
- [Strategy Board](../strategy-board/README.md) — when the chosen fix becomes a company-level strategic bet.
- [Market Researcher](../market-researcher/README.md) — when a cause or option depends on market facts you do not have.
- [Project Manager](../project-manager/README.md) — when the plan becomes a multi-week project with workstreams and stakeholders.

## Limits

Problem Solver cannot inspect your systems or verify facts you have not provided or checked. It will not manufacture a tidy causal chain, guarantee that a chosen intervention works, or replace domain, safety, legal, or operational judgment. You can choose to act before verification, but the affected branch remains explicitly at-risk and the plan should use a reversible pilot and pivot trigger.
