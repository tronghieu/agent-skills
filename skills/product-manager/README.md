# Product Manager

**Language:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

Turn product evidence into a defensible decision, the artifact to act on, and a record your team can return to.

## Install

```bash
npx skills add tronghieu/agent-skills --skill product-manager
```

## Try it now

```text
/product-manager Prioritize these opportunities and show which ranks change when assumptions change.
/product-manager Write a PRD for offline mode from this feedback and make the release boundary explicit.
/product-manager Design a launch plan for this billing change, including pre-committed rollback criteria.
/product-manager Turn these support tickets into product opportunities and tell me what decision they challenge.
```

## Why this instead of an ordinary chatbot?

An ordinary chatbot can make a polished RICE table or PRD from plausible-sounding guesses. This copilot keeps the uncertainty visible: every decision number is tied to a source, a ranged assumption, or your dated estimate; assumption-led conclusions receive sensitivity analysis; and work that lacks evidence is labelled as a bet. A PRD, prioritization, or launch plan receives a visible adversarial check before you act on it.

## Who it is for

Use it if you own product decisions: product managers, product leads, product owners, and founders working with users, engineering, design, support, sales, and business stakeholders. You remain accountable for the calls; the copilot frames the choice, challenges contradictions in the available evidence, and maintains the decision trail.

Typical use cases include:

- Turn raw feedback into evidence-linked opportunities rather than a feature-request list.
- Prioritize independent opportunities with RICE and sensitivity analysis; use Kano to challenge expectation type, not to fake a ranking.
- Define the chosen problem in a PRD with a job story, story map, testable acceptance criteria, and an explicit Won't-have release boundary.
- Define a north-star metric, metrics tree, guardrails, and outcome-led OKRs.
- Design an experiment whose pass, fail, and next action are set before results arrive.
- Plan risk-scaled rollouts, numeric stage gates, rollback criteria, and post-launch review.
- Decide platform versus feature or make a light, evidence-led pricing and packaging call.

## The PM discipline

This is a playbook, not a fixed phase model: enter through the decision you need now. For continuing work, it returns to the current state and past decisions before proceeding; for a one-off request, it delivers the artifact without making you set up a ceremony.

The loop is: capture evidence and feedback → frame the user job and opportunity → prioritize → specify and scope → measure → test the riskiest belief → launch safely → feed learning back into the next decision. The product workspace keeps the evidence registry, assumptions, opportunities, metrics, artifacts, decision log, and current state together across sessions. Decisions record their rationale, dissent where relevant, and a trigger for revisiting them.

Each framework works at its own altitude: job stories frame the problem; RICE compares opportunities; story mapping decomposes the chosen opportunity; MoSCoW draws the release line; Kano tests the type of expectation. Missing inputs are requested or registered as honest assumptions with ranges, never silently completed.

## The lenses and quality gates

One PM switches lenses as the work demands:

| Lens | Responsibility |
| --- | --- |
| Sao — Compass | Direction, positioning, platform-versus-feature, pricing |
| Minh — Scope | PRDs, story maps, user stories, release scope |
| Lam — Scale | Opportunities, RICE, sensitivity, Kano |
| Kim — Gauge | North star, metric tree, OKRs |
| Mai — Lab | Experiments that can falsify assumptions |
| Phong — Ramp | Risk-scaled launches and rollback |
| Thanh — Echo | Feedback triage and voice of customer |
| Bao — Judge | Adversarial checks of PRDs, prioritizations, and launch plans |

Bao audits provenance, traceability, testability, scope, sensitivity, and launch safeguards before the relevant artifact is presented for action. When a separate agent is available, Bao runs independently; otherwise the audit remains explicit and its findings stay in the artifact. The other lenses proceed sequentially with you in the conversation.

## What to bring, and what you receive

Bring whatever you have: product context, intended users, feedback, research, analytics, business constraints, engineering estimates, and the decision at hand. You do not need complete data. The copilot distinguishes evidence from hypotheses and names the information that would change the recommendation.

Depending on the play, you receive an evidence-linked opportunity backlog; a sensitivity-qualified priority order; a PRD and story map; metric definitions or OKRs with labelled baselines; a frozen experiment card; a launch plan with rollback conditions; or a recorded platform, feature, or pricing decision. The response states the recommendation and caveats directly rather than hiding the conclusion in the workspace.

## Complementary skills

These are optional, not prerequisites:

- [design-thinking](../design-thinking/README.md) — use when you need deep discovery: interviews, field research, prototype testing, or to understand why and how users experience a problem. Its evidence can inform this product workspace.
- [market-researcher](../market-researcher/README.md) — use when an external fact base is needed: competitor context, market sizing, pricing benchmarks, or sourced willingness-to-pay evidence beyond a few quick checks.
- [strategy-board](../strategy-board/README.md) — use when the decision is above product altitude, such as entering a market, build-versus-buy, or retiring a product line.

## Limits

It does not invent user research, market facts, analytics, engineering estimates, experiment results, or customer quotes. It designs experiments but does not simulate their outcomes; primary discovery belongs with design-thinking, and broader company strategy belongs with strategy-board. It supports product decisions and handoff, not implementation.

For the detailed play references and schemas, see [`references/`](./references/).
