# Diataxis Writer

**Language:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

Diataxis is a documentation framework that separates pages by what the reader needs now: **learn** through practice, **do** a task, **look up** facts, or **understand** a concept. This skill uses that distinction to turn mixed, hard-to-navigate documentation into pages with a clear promise—easier to use and easier to maintain.

## Quick install

```bash
npx skills add tronghieu/agent-skills --skill diataxis-writer
```

## Quick examples

```text
/diataxis-writer Review this getting-started guide. Identify mixed sections and propose a tutorial, how-to, reference, and explanation structure.
```

```text
/diataxis-writer Turn this deployment procedure into a task-focused how-to guide. Keep prerequisites, verification, and recovery guidance.
```

```text
/diataxis-writer Create scannable reference documentation for these CLI options, defaults, constraints, and examples.
```

```text
/diataxis-writer Explain this authentication design for new engineers, including its mental model, tradeoffs, and consequences.
```

## Why not simply ask a chatbot to “improve the docs”?

That broad request can improve wording while leaving the page’s purpose unclear—or mix beginner teaching, task steps, lookup facts, and rationale together. This skill starts with the reader’s job, gives each page one primary promise, and identifies material to keep, move, split, or link. The result is a documentation structure, not just smoother prose.

## Who this is for

Technical writers, developer advocates, documentation owners, product and engineering teams, knowledge managers, and operators maintaining user-facing or internal documentation.

## Use it for

- Onboarding tutorials, help-center articles, and internal process docs
- How-to guides, runbooks, configuration, migration, and troubleshooting docs
- API, command, policy, and configuration reference
- Conceptual explanations, architecture context, and design rationale
- Auditing a confusing page or reorganizing a documentation set

## The four Diataxis quadrants

| Reader intent | Document type | Page promise |
| --- | --- | --- |
| Learn by doing | Tutorial | Follow a guided path toward basic competence. |
| Complete a task | How-to guide | Reach a specific outcome. |
| Look up facts | Reference | Find accurate, complete information quickly. |
| Understand context | Explanation | Understand concepts, decisions, and tradeoffs. |

## How classification and restructuring work

1. Name the reader, their immediate goal, and the page’s implied promise.
2. Classify the existing content by the four reader intents.
3. Choose one primary type for each page; supporting material belongs in a related page or a concise link.
4. Keep, move, split, or rewrite mixed sections, then connect the resulting pages so readers can move between learning, doing, lookup, and understanding.
5. Check that the title, opening, structure, and depth deliver the promised reader job.

For detailed patterns and templates, see [Diataxis patterns](./references/diataxis-patterns.md).

## What to bring and what you receive

Bring the document or documentation set, intended readers, product or process context, and the outcome you want. Existing examples, support questions, and search data can help.

You receive a classification, section-level mixed-purpose findings, a target information architecture, and either a concrete rewrite plan or rewritten content. Reviews also include a verification checklist.

## Complementary skills

- Use [Deep Reader](../deep-reader/README.md) **before this skill** when a large or dense document set needs careful, traceable reading; it establishes the source understanding that a restructure depends on.
- Use [Critical Thinking](../critical-thinking/README.md) when the documentation makes important claims or recommendations; it tests the evidence and reasoning, while Diataxis organizes the reader experience.
- Use [System Prompt Creator](../system-prompt-creator/README.md) when the resulting documentation process must become repeatable behavior in an LLM product; it turns the desired workflow and guardrails into a testable system prompt.
- Use [Humanizer](https://github.com/blader/humanizer) **after this skill** to strip AI writing tells from the finished prose. Diataxis Writer calls it automatically when it is installed and falls back to a shorter built-in checklist when it is not. Install it with `npx skills add blader/humanizer`.

## Limits

Diataxis is useful when documentation’s job is to help people learn, do, look up, or understand. It is not a universal format for marketing copy, sales proposals, legal contracts, press releases, fiction, or other persuasion-first writing. A page can draw on more than one kind of information, but it should still have one dominant reader job.
