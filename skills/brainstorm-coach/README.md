# Brainstorm Coach

**Language:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

Turn an uncertain prompt into original, traceable options and practical next steps without handing your thinking over to AI.

## Install

```bash
npx skills add tronghieu/agent-skills --skill brainstorm-coach
```

## Try it

```text
/brainstorm-coach Help me name a privacy-first finance app.
/brainstorm-coach Explore launch ideas for a neighborhood tool-lending library; we have $200 and one weekend.
/brainstorm-coach Party mode: give my career-change ideas different angles, then red-team the shortlist.
```

## Why use this instead of ordinary chatbot prompting?

An ordinary prompt often returns a polished list before you have had a chance to think. Brainstorm Coach treats the session as a collaboration: you contribute first, your words are preserved, and the AI adds a small, clearly labeled set of builds. It keeps judgment out of the exploratory phase, uses a technique suited to the shape of the question, and only then helps you cluster, test, and choose directions. The result is not just more ideas; it is a record of where they came from and why the promising ones survived.

## Who it helps

Use it when you are exploring a name, feature, campaign, event, product direction, creative project, or career move. It suits founders, product and marketing teams, designers, writers, and anyone who wants fresh possibilities without becoming an audience to an AI idea dump.

It is especially useful when the topic is open-ended, stale, or full of half-formed hunches. Bring a narrow brief or a loose question; both are valid starting points.

## The method: choose a mode that fits the question

The coach can recommend a technique, show a short relevant menu, surprise you, or lead a progressive flow from broad exploration to narrowing. It stays with one technique while it is productive rather than mechanically running through a checklist.

Examples of the available approaches include:

- **Open the space:** What-if scenarios, analogical thinking, reversal, and first-principles thinking challenge the obvious frame.
- **Add structure:** SCAMPER improves a concrete product or process; Six Thinking Hats separates perspectives; mind mapping organizes connected threads.
- **Build momentum or breadth:** Yes-and building, brainwriting round-robin, and random stimulation help when energy is low or one idea is anchoring everything.
- **Go deeper or sharper:** exploratory Five Whys finds the underlying want; morphological analysis combines dimensions; provocation, assumption reversal, role playing, constraints, metaphors, and question storming unsettle a stuck frame.

A full session may use two to four techniques, but one good technique is better than a shallow tour of many.

## How the conversation works

1. **Frame the session.** Share the topic, any hard constraints, and whether you want broad exploration or a narrow answer.
2. **Generate together.** Each round uses one prompt. You answer first; your idea is captured verbatim as `(user)`. The AI then offers a few extensions or new directions as `(AI)`.
3. **Check the energy.** After a few rounds, decide whether to continue, change technique, or converge. During divergence, ideas are not ranked or dismissed.
4. **Converge deliberately.** Group related ideas, preserve their origin tags, and give any ranking a reason you can challenge.
5. **Commit to next moves.** Pick your top three before the coach offers its own picks; each gets a smallest next action and a way to learn whether it is worth pursuing.

## Party mode: perspectives, not theatre

Party mode is optional: request it directly, use it when the session is becoming samey, or ask for a red-team pass on a shortlist. It casts three or four topic-specific **role-lenses**—for example, a particular customer, the operator who must deliver the idea, an outsider, and a provocateur.

These are short working viewpoints, not named characters with backstories or a simulated panel conversation. You still go first. The coach combines the lenses into one compact digest, labeling additions such as `(AI:operator)` and keeping the total small. During exploration, a skeptical lens turns objections into generative questions; during convergence, a red-team pass identifies the strongest objection, what would disprove an idea, and the cheapest way to de-risk it.

## What to bring, what you receive

Bring a topic, desired outcome, constraints, and any existing ideas—rough notes are welcome. You can also say whether you want a session document.

You receive a traceable idea record, clusters, four practical buckets (immediate opportunities, future innovations, moonshots, and insights), your top three, next steps, and a parking lot for useful tangents. If you keep a document, it records the topic, constraints, mode, techniques used, ideas, categories, and next actions.

## Use alongside these skills

- Start with [Problem Solver](../problem-solver/README.md) when something is failing and the cause is still unknown; diagnose before generating fixes.
- Use [Design Thinking](../design-thinking/README.md) when the key uncertainty is what people need and you need user-centered research.
- Use [Market Researcher](../market-researcher/README.md) when a promising idea needs demand, competitor, or market-size validation.
- Use [Strategy Board](../strategy-board/README.md) when the choice has become a company-level strategic bet.
- Use [Critical Thinking](../critical-thinking/README.md) when you have turned the ideas into a proposal and want its reasoning stress-tested.

## Limits

Brainstorm Coach generates and organizes possibilities; it does not establish market demand, conduct user research, diagnose root causes, or make the final decision for you. It does not preserve every wild idea by pretending all ideas are equally ready—evaluation happens after divergence and should be supported by stated reasons and tests.
