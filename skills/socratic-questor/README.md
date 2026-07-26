# Socratic Questor

**Languages:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

Learn by thinking aloud with Gadfly, a Socratic partner who helps you discover and test an idea through questions rather than lectures.

## Install

```bash
npx skills add tronghieu/agent-skills --skill socratic-questor
```

## Start a dialogue

```text
/socratic-questor Help me understand opportunity cost through questions.
/socratic-questor Quiz me on the argument in this article: [paste the text].
/socratic-questor I think remote work improves productivity. Challenge my reasoning.
/socratic-questor Ask me questions until I can explain photosynthesis in my own words.
```

## Why not an ordinary chatbot?

An ordinary chatbot often gives you a polished answer to consume. Gadfly makes your current model visible, then tests its assumptions, evidence, alternatives, and consequences. The result is practice in reasoning—not just another explanation to remember.

## Who it is for and when to use it

Use Socratic Questor if you are a student, self-directed learner, teacher, mentor, or domain expert who wants to examine understanding in dialogue. It is especially useful when you want to:

- learn a concept by articulating it yourself;
- check whether you can explain a topic or a source text in your own words;
- challenge a claim before you commit to it; or
- explore assumptions, evidence, competing viewpoints, and implications.

## The questioning method

Gadfly follows the Paul & Elder Socratic framework as a flexible funnel:

```text
Clarification → Assumptions → Evidence → Perspectives → Implications → Meta-reflection
```

It opens with clarification so it can hear your framing first. From there, it follows what your answer makes useful: vague answers may need another clarification; unsupported claims invite evidence; one-sided arguments invite another perspective. The sequence is a compass, not a script. See the detailed [questioning framework](./references/questioning-framework.md).

## What the learning interaction feels like

Gadfly is friendly, curious, and slightly provocative—the named persona comes from Socrates’ “gadfly of Athens.” It briefly acknowledges a useful point, then asks one or two genuine questions and gives you room to answer. It matches the language you use.

The dialogue continuously adapts to the quality of each response:

- **New to the topic:** slower clarification, smaller or more concrete questions, and more scaffolding.
- **Some grounding:** gentle contradictions and closer attention to assumptions and evidence.
- **Strong grounding:** faster movement to counterarguments, implications, and reflection on your reasoning.

If you get stuck, Gadfly narrows or rephrases the question, or uses a concrete scenario or analogy. It still does not give the answer; that preserves the learning-by-discovery contract.

## Bring this; expect this

| Bring | Expect |
| --- | --- |
| A topic to explore, such as a concept, decision, or claim | A paced sequence of one or two questions at a time |
| Or a text/document you want to understand | Brief affirmations followed by probes that build on your response |
| Honest, even partial answers | Questions calibrated to the reasoning you demonstrate, not a label you claim |

## Complementary skills

- Use [Critical Thinking](../critical-thinking/README.md) when you need a structured audit of an argument after the dialogue; it helps turn the claims and evidence you surfaced into a deliberate evaluation.
- Use [Deep Reader](../deep-reader/README.md) when the starting material is a long book or paper; it provides a systematic reading process before or alongside Socratic discussion.
- Use [Diataxis Writer](../diataxis-writer/README.md) when your goal is to turn what you learned into clear documentation; it separates learning, task guidance, reference, and explanation for the intended reader.

## Limits

Gadfly teaches by asking rather than by direct exposition. It is not the right fit when you need an immediate factual answer, a worked solution, or fact verification. Treat claims that arise in the conversation as prompts for further checking, especially in high-stakes contexts.
