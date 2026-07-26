# System Prompt Creator

**Languages:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

Turn a product or workflow brief into a clear, model-aware system prompt and a practical way to test it.

## Install

```bash
npx skills add tronghieu/agent-skills --skill system-prompt-creator
```

## Start with a real job

```text
/system-prompt-creator Create a system prompt for an internal Python code-review assistant. It should explain findings briefly and never expose secrets.

/system-prompt-creator Turn this invoice-extraction brief into a JSON-producing prompt. Preserve each source value, flag uncertainty, and show three test cases.

/system-prompt-creator Design a customer-support agent for order questions and refunds. It can look up orders but must ask before changing an order.

/system-prompt-creator Improve this GPT prompt for a research assistant. Target GPT-5, cite supplied sources, and separate facts from inferences: [paste prompt]
```

Unlike an ordinary chatbot prompt that steers one conversation, a system prompt defines repeatable behavior: scope, decisions, tool use, output contracts, and boundaries that can be evaluated over many inputs.

## Who it helps and when to use it

Use this skill if you build AI products, automate workflows, or need dependable custom instructions. It is useful for assistants and chatbots, code helpers, content tools, data extraction, research workflows, tool-using agents, and prompts that need to move between model families. Bring it in when results are inconsistent, a task needs a structured response, or the system needs defined safety, escalation, and failure behavior.

## How it works

Describe the job in everyday language. The skill interviews you for the target model, users, inputs, outputs, tone, tools, constraints, examples, and likely adjacent requests. When details are missing, it can propose reasonable defaults for you to confirm.

It then sizes the prompt, separates the role, context, instructions, output contract, examples, tool rules, and guardrails, and uses XML or Markdown only where that structure fits. The draft favors explicit intent, compatible rules, positive guidance, and examples that cover normal, edge, and out-of-scope cases. Finally, it supplies validation prompts and revises against the observed failures.

For an agentic prompt, the design can add named operational playbooks, safe/moderate/confirmation-required action tiers, tool-use rules, state handling, and a final verification loop. For a multi-agent design, make responsibilities, handoffs, and when parallel delegation is appropriate explicit; do not assume they emerge from a generic persona.

## What to provide and what you receive

Provide as much as you know:

- Target provider, model, and version; use case; audience; and desired persona.
- Input types, required output format, tone, tools, permissions, hard constraints, and useful examples or known failures.
- For high-impact workflows, representative data and the decisions that require human confirmation.

You receive a copy-ready system-prompt draft, its key assumptions and architecture notes, model-relevant adjustments where justified, plus 3–5 validation prompts with expected behavior. Extraction designs can preserve raw source values and express uncertainty; agent designs can define playbooks and action boundaries.

## Verify for the model you actually deploy

Treat provider-specific recommendations, API parameters, and model behavior as versioned guidance—not permanent facts. Confirm the model name/version and current official provider documentation, then run the included tests (and your own representative or adversarial cases) with the exact deployment settings. Re-test after changing the model, context window, tools, API parameters, or product policy. See the detailed [model notes](./references/model-specific.md), [principles](./references/principles.md), and [templates](./references/templates.md).

## Related skills

- Use [Diataxis Writer](../diataxis-writer/README.md) when the prompt's output must become durable tutorials, how-to guides, reference, or explanation for readers.
- Use [Critical Thinking](../critical-thinking/README.md) when a high-stakes prompt embeds policies, claims, or decisions whose reasoning and evidence need an independent audit.
- Use [Data Scientist](../data-scientist/README.md) when evaluating prompt changes requires analysis of a test set, metrics, or error patterns.
- Use [Design Thinking](../design-thinking/README.md) before the prompt when the real uncertainty is users' needs, behavior, or adoption rather than wording.

## Limits

A well-designed prompt can improve consistency, but it cannot guarantee correctness, safety, compliance, tool success, or identical behavior across models and versions. Prompts do not replace authorization controls, retrieval quality, product policy, human review, or production evaluation.
