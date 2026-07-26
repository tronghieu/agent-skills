# Market Researcher

**Languages:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

Make a market decision from fresh, citation-backed desk research—not an uncheckable chatbot answer.

## Install

```bash
npx skills add tronghieu/agent-skills --skill market-researcher
```

Try it:

```text
/market-researcher Is a subscription meal-kit service for solo diners in Germany worth pursuing? Run a quick scan.
```

```text
/market-researcher Estimate the TAM, SAM, and year-3 SOM for B2B expense-management software in Southeast Asia.
```

```text
/market-researcher Who are the direct, substitute, and status-quo competitors for a mid-market accounting SaaS in Canada?
```

```text
/market-researcher Deep dive: what regulation, payment behavior, and trends could make or kill a Vietnamese EV charging business?
```

Unlike a normal chatbot response, factual claims are tied to a registered source, estimates show their inputs and formula, and unresolved conflicts or assumptions stay visible.

## Who it helps

Use it when a founder, product or growth team, strategist, consultant, business-development lead, or analyst needs evidence for a market decision. Typical decisions include whether to build, launch, enter, price, position, or investigate further.

It can focus on one or more areas:

- market definition, TAM/SAM/SOM, and growth ranges;
- direct, indirect, substitute, and status-quo competitors;
- public demand and willingness-to-pay signals; or
- decision-relevant trends, technology, and regulation.

## How the research stays rigorous

First, the agent confirms the decision, target customer, geography, and constraints. It then researches current web and user-provided evidence, records each source with dates and a confidence grade, and distinguishes sourced facts from assumptions.

Sizing uses an explicit market definition and checkable methods such as buyer count × price. A quick scan uses one method plus a sanity check and gives a broad range; a deep dive uses at least two independent methods. Material disagreement is explained—for example, a different year, definition, currency, revenue measure, or GMV—not averaged away.

Competitor work maps the alternatives a buyer can actually choose, including doing nothing. Demand work mines public reviews, communities, job postings, and pricing for signals; it separates frequent complaints from evidence that people spend money on a workaround. Macro and trend work concentrates on the few factors that could change this opportunity, and gives each one a decision implication.

Before delivery, a skeptic pass rechecks the most decision-relevant claims, arithmetic, dates, and source concentration. Remaining uncertainty becomes a caveat, not a hidden gap.

## What to expect

Start with the decision you need to make. If known, include the product or service, buyer, geography, time horizon, constraints, and evidence that would change your mind. The agent defaults to a Quick Scan and confirms the research frame before proceeding.

| Mode | Best for | Scope |
| --- | --- | --- |
| **Quick Scan** (default) | “Is this worth a closer look?” | One-session go/no-go brief: one sizing method with a check, 5–10 competitors, headline demand signals, and 2–3 tailwinds or kill-factors. |
| **Deep Dive** | “What exactly are we walking into?” | A resumable report with only the lanes you choose: sizing, competitors, demand, and/or macro. |

You receive a recommendation with a stated confidence level, the facts that drive it, the largest caveat, and open questions for primary research. The supporting work includes a source register, traceable findings, calculation inputs and assumptions, and the report.

For a demand lane, any personas are explicitly **hypotheses to validate**, never claimed customer facts. Each is tied to available evidence or marked as an assumption, and includes a way to test it.

Where the agent can delegate work, research lanes may run in parallel with separate source-ID ranges; otherwise they run sequentially. Either way, the final synthesis and verification apply the same citation rules.

## Pair it with other skills

- Use [Design Thinking](../design-thinking/README.md) after this research when you need interviews, tests, or prototypes to validate demand hypotheses and willingness to pay that public evidence cannot prove.
- Use [Strategy Board](../strategy-board/README.md) when you need to weigh this market evidence alongside company capabilities, tradeoffs, and strategic options.
- Use [Critical Thinking](../critical-thinking/README.md) when the recommendation is high-stakes and you want to pressure-test its assumptions, reasoning, and evidence limits.

## Limits

This is desk research: it relies on accessible web sources and documents you provide. It does not replace customer interviews, surveys, behavioral observation, or financial and legal advice. Public signals can suggest needs and willingness to pay, but they cannot establish what a specific customer will buy. If current web research is unavailable, the skill should say so rather than substitute memory for evidence.
