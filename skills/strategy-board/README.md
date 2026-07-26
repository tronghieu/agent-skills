# Strategy Board

**Language:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

Turn a consequential business question into a sourced, stress-tested recommendation that an executive can genuinely choose from.

## Install

```bash
npx skills add tronghieu/agent-skills --skill strategy-board
```

## Start with a decision

Use `/strategy-board` in plain language. For example:

```text
/strategy-board Should we enter Indonesia next year, and if so, through which segment?
/strategy-board Compare building, buying, and partnering for our warehouse-management system.
/strategy-board Stress-test our proposed acquisition before we ask the board to approve it.
/strategy-board We need an annual plan that reallocates resources across our product portfolio.
```

## Why use a board instead of an ordinary chatbot?

An ordinary chat can give a plausible answer in one pass. Strategy Board is designed to make the decision more defensible:

- It establishes a fact base before drawing conclusions; numbers are sourced or explicitly labeled as assumptions.
- It compares at least three genuine, materially different options—not one preferred answer with two strawmen.
- It separates market, innovation, financial, execution, uncertainty, and risk thinking, so optimism in one area does not hide a weakness in another.
- It red-teams the chosen direction before the recommendation, records the risks that remain, and makes the tradeoffs—including what not to do—visible.

## Who it is for

Use it when a founder, executive, business-unit leader, strategy lead, or consultant owns a high-stakes choice: market entry, investment, build-vs-buy, pricing, portfolio priority, transformation, competitive response, turnaround, M&A, or an annual plan. A focused one-off analysis, such as a pre-mortem or opportunity sizing, can also use the relevant specialist without a full engagement.

## How an engagement works

The managing partner first confirms the real decision, scope, success criteria, constraints, risk appetite, and strategic environment. The full engagement then moves through visible review points:

1. **Brief:** frame the decision and confirm the question with the executive.
2. **Fact base:** collect public evidence and the internal facts you provide; register gaps as named assumptions.
3. **Targeted analysis:** use only the lenses the question needs.
4. **Options:** compare three defensible directions on the same criteria; the executive chooses a direction.
5. **Stress test:** test failure paths, scenarios, evidence, and execution dependencies before the recommendation.
6. **Recommendation:** present an answer-first, board-ready case, including rejected options, risks accepted, and explicit sacrifices; the executive approves or revises it.
7. **Roadmap:** translate an approved choice into owners, 90-day actions, output metrics, resource reallocation, signposts, and review triggers.

The board pauses at the brief, option, and recommendation gates. You can refine, go deeper, challenge an analysis, or continue; missing internal information remains an assumption rather than becoming invented certainty.

## What you provide

Bring the decision and deadline, desired outcome, scope, hard constraints, risk tolerance, stakeholders, relevant internal economics and capabilities, prior attempts, and the evidence that could change your mind. The board can research public sources, but it cannot know your internal realities unless you supply them.

## What you receive

- A confirmed decision brief and an evidence/assumption register
- Relevant specialist analyses with implications for the decision
- A like-for-like comparison of strategic options
- A pre-mortem or scenario stress test with warning signs and mitigations
- A board-ready recommendation, decision record, and—after approval—an execution roadmap

For a single analysis, the primary result is one self-contained memo; supporting material is available as appendices rather than required reading.

## The board and Boardroom deliberation

**Drucker** manages the engagement and questions the framing. The specialists represent distinct responsibilities: **Porter** (markets and competition), **Christensen** (innovation and customer jobs), **Graham** (value and downside economics), **Grove** (capabilities and execution), **Wack** (scenarios and uncertainty), **Taleb** (red-team risk), and **Minto** (answer-first synthesis).

For a genuinely contested choice, you can convene a Boardroom session. Three or four relevant members give independent first positions—potentially as separate parallel workstreams—before they see one another’s views. You then experience the points of agreement, the real disagreement, short cross-examination, and recorded dissent; this sequence reduces groupthink and exposes the assumption or tradeoff that actually needs your judgment. The board recommends and records. You remain the executive in the chair.

## Complementary skills

- **Need substantial external evidence?** Use [Market Researcher](../market-researcher/README.md) first or alongside the board for citation-backed market sizing, competitor mapping, demand signals, and macro research; its sourced findings can feed the fact base.
- **Need to present the approved argument live?** Use [SlideWright](../slidewright/README.md) after the recommendation for a presenter-led web slide deck. Strategy Board supplies the argument and source-backed numbers; SlideWright turns that material into presentation visuals.

## Limits

Strategy Board is advisory: it does not decide, approve investments, replace executive judgment, or fabricate facts. Public evidence cannot validate internal capacity or what individual customers will buy. Important decisions still need the appropriate financial, legal, operational, and domain review. The method makes uncertainty, dissent, and remaining risk explicit; it cannot eliminate them.
