---
name: system-prompt-creator
description: Create high-quality, model-aware system prompts for any LLM (Claude, GPT, Gemini, open-source, etc.). Use this skill whenever the user wants to create, write, build, design, draft, or improve a system prompt, system instructions, or custom instructions for any AI model. Also trigger when the user asks about prompt engineering, prompt design, prompt optimization, or wants to define behavior for an AI assistant, chatbot, agent, or any LLM-powered application — even if they don't explicitly say "system prompt". Covers all use cases including chatbots, agentic systems, tool-use workflows, content generation, data extraction, code assistants, and multi-turn conversations.
---

# System Prompt Creator

Build effective system prompts for any LLM using a structured, research-backed process derived from the official prompting guides of Claude (Anthropic), GPT-5 (OpenAI), and Gemini (Google).

This skill guides you through interview, analysis, structuring, drafting, and optimization — producing system prompts that are clear, well-structured, and tailored to the target model.

## Workflow

Follow these 5 steps in order. Each step builds on the previous.

### Step 1: Interview — Gather Requirements

Before writing anything, collect these essentials from the user:

1. **Target model** — Which LLM? (Claude, GPT, Gemini, open-source, or model-agnostic)
2. **Use case** — What will the AI do? (chatbot, agent, content generator, data extractor, code assistant, etc.)
3. **Persona** — Who should the AI be? (role, expertise level, personality traits)
4. **Audience** — Who interacts with it? (developers, end users, internal team, customers)
5. **Input types** — What will users send? (free text, code, documents, images, structured data)
6. **Output format** — What should responses look like? (prose, JSON, markdown, code, tables)
7. **Tone & style** — Formal, casual, technical, friendly? Concise or detailed?
8. **Constraints** — What must it NOT do? (safety rules, topic limits, action restrictions)
9. **Tools & capabilities** — Does it have tool access? (APIs, file system, web search, code execution)
10. **Examples** — Can the user provide examples of good/bad responses?

If the user is vague on some points, suggest reasonable defaults and confirm before proceeding.

**Push for completeness:** After gathering basics, ask "What *else* might users ask about?" Many prompts fail not because they handle their core task poorly, but because they don't anticipate adjacent scenarios. A billing chatbot also gets account access questions, product questions, and complaints. A coding agent needs to handle not just building features but also debugging, refactoring, and project setup. Map the full territory before writing.

### Step 2: Analyze — Determine Complexity & Scope

Based on the interview, classify the prompt complexity:

| Complexity | Characteristics | Typical Length |
|-----------|----------------|---------------|
| **Simple** | Single task, no tools, fixed format | 50-200 words |
| **Moderate** | Multiple behaviors, some tools, varied outputs | 200-800 words |
| **Complex** | Agentic, multi-tool, long-running, safety-critical | 800-2000+ words |

Then determine which sections are needed:

- **Role/Persona** — Almost always needed
- **Context/Knowledge** — When domain expertise or background is required
- **Instructions/Rules** — Always needed
- **Domain Playbooks** — When the system handles multiple distinct operational scenarios (see below)
- **Output Format** — When response structure matters
- **Examples** — When accuracy and consistency matter (3-5 diverse examples)
- **Tool Usage** — When the model has access to tools or APIs
- **Safety/Guardrails** — When actions have real-world consequences
- **Agentic Behavior** — When the model operates autonomously

**Domain Playbooks:** For systems that handle multiple distinct workflows (a coding agent that builds, debugs, refactors, and reviews; a support bot that handles billing, accounts, and technical issues), include named playbooks — concise step-by-step patterns for each operational scenario. These give the model a reliable decision tree for common situations rather than forcing it to derive the approach from general instructions every time. Place playbooks inside the `<instructions>` section, organized by scenario name.

### Step 3: Structure — Apply the Layered Architecture

Organize the prompt using this universal architecture. Include only the sections relevant to the use case.

**XML structure** (preferred for complex prompts):

```xml
<role>
  Who the AI is, expertise, personality
</role>

<context>
  Domain knowledge, background information, constraints
</context>

<instructions>
  Core behavior rules, workflow steps, decision criteria
</instructions>

<output_format>
  Response structure, formatting rules, verbosity guidelines
</output_format>

<examples>
  3-5 diverse input/output pairs covering normal cases and edge cases
</examples>

<tools>
  Tool usage guidelines, when to use each tool, safety thresholds
</tools>

<guardrails>
  Safety boundaries, escalation rules, refusal criteria
</guardrails>
```

**Markdown structure** (suitable for simpler prompts):

```markdown
# Role
...

# Instructions
...

# Output Format
...
```

**Why structure matters:** When a prompt mixes instructions, context, examples, and inputs without clear boundaries, models may confuse which content serves which purpose. Structured tags eliminate this ambiguity and directly improve instruction adherence.

### Step 4: Draft — Apply the 12 Universal Principles

These principles represent the consensus from all 3 major LLM providers on what makes system prompts effective.

#### A. Structure Principles

**P1 — Layered Architecture.** Organize into distinct labeled sections (role, context, instructions, format, examples, guardrails). This directly affects how the model parses and prioritizes information.

**P2 — Consistent Tags.** Use XML tags or markdown headings consistently. Never mix conventions. Nest tags for hierarchical content (documents containing sub-documents).

**P3 — Content Ordering.** Place long reference material at the top. Place the task/query at the bottom. This alone can improve quality by up to 30% on complex multi-document tasks. Use anchoring phrases: "Based on the information above..."

#### B. Content Principles

**P4 — Explicit Intent + Reasoning.** Explain *why* a rule exists, not just *what* it is. Models generalize better from reasoning than from bare commands.

- Bad: `NEVER use ellipses`
- Good: `Responses are read aloud by TTS, so avoid ellipses — TTS engines cannot pronounce them.`

**P5 — Positive Framing.** State what TO do, not what NOT to do.

- Bad: `Do not use markdown`
- Good: `Write in smoothly flowing prose paragraphs`

**P6 — Graduated Autonomy.** For agentic systems, define action tiers explicitly:

- **Safe** (do freely): read files, search, run tests
- **Moderate** (proceed carefully): edit files, create branches
- **Risky** (must confirm): delete, force-push, post publicly

**P7 — Internal Consistency.** Contradictions are actively harmful. Modern models waste reasoning tokens trying to reconcile conflicting rules. If rules have priorities, state them: "If rules conflict, prioritize user safety over task completion."

#### C. Calibration Principles

**P8 — Match Intensity to Model Intelligence.** Modern models are significantly more capable. Aggressive prompting from older models ("CRITICAL: You MUST...") causes overtriggering. Use natural language.

**P9 — Few-Shot Examples.** The strongest steering mechanism available. Include 3-5 diverse examples covering edge cases. Wrap in `<example>` tags to separate from instructions. Examples can sometimes replace explicit instructions entirely.

**P10 — Separate Control Dimensions.** Three independent axes exist: reasoning depth (how hard the model thinks), output verbosity (response length), and temperature (output diversity). Use the appropriate control for each — don't conflate them.

#### D. Agentic Principles

**P11 — State Management.** For long-running tasks, define how the agent tracks state. Use structured formats (JSON) for schema-bound data, plain text for progress notes, and git for restorable checkpoints.

**P12 — Self-Verification Loop.** End critical sections with: "Before finalizing, verify your output against [specific criteria]." This reliably catches errors in code, data extraction, and structured output.

#### E. Domain-Specific Patterns

**Raw Data Preservation (for extraction/transformation systems).** When designing schemas that normalize or transform input data, always include a field for the original raw value alongside the normalized one. For example, a price extraction should store both `"price": 12.50` (normalized) and `"price_raw": "$12.50"` (as-is from the source). This enables downstream verification and debugging without re-processing the original input.

**Confidence + Notes (for uncertain outputs).** For systems that process messy or ambiguous inputs (OCR, handwriting, noisy data), include per-item `confidence` (high/medium/low) and `notes` fields. This makes the system self-documenting — downstream consumers know which outputs to trust and which to flag for human review. Silent confidence is worse than explicit uncertainty.

**Operational Playbooks (for multi-scenario systems).** When a system handles several distinct workflows, define named patterns with concise steps for each. A coding agent might have: Build Feature, Fix Bug, Refactor, Debug, Setup Project. A support bot might have: Answer Question, Process Refund, Escalate to Human, Handle Complaint. Playbooks reduce the model's decision space and improve consistency across similar requests.

> For full principles with detailed examples from all 3 guides, read `references/principles.md`.

### Step 5: Review & Optimize

Run through this checklist before delivering:

**Structure & Format:**
- [ ] Clear structure — sections delineated with consistent tags or headings
- [ ] Correct ordering — long reference material at top, task at bottom
- [ ] Lean — every section pulls its weight; nothing redundant

**Content Quality:**
- [ ] No internal contradictions — every instruction can be followed simultaneously
- [ ] Positive framing — rules state what to do, not just what to avoid
- [ ] Reasoning attached — every non-obvious rule has a "why"
- [ ] Calibrated intensity — no unnecessary CAPS or MUST unless truly critical

**Completeness:**
- [ ] Domain coverage — all operational scenarios the system will encounter are handled (not just the primary use case, but adjacent situations too)
- [ ] Examples included — 3-5 diverse examples covering normal cases, edge cases, and failure modes
- [ ] Edge case handling — the prompt addresses what to do when input is ambiguous, malformed, or out-of-scope
- [ ] Playbooks included — for multi-scenario systems, named step-by-step patterns for each workflow

**Model & Validation:**
- [ ] Model-appropriate — accounts for target model's strengths and quirks
- [ ] Testable — someone could verify whether it produces desired behavior
- [ ] Test prompts — 3-5 validation prompts included with expected behavior

> For model-specific optimization tips, read `references/model-specific.md`.

## Quick Reference: Model Comparison

| Aspect | Claude 4.6 | GPT-5 | Gemini 3 |
|--------|-----------|-------|---------|
| Thinking | Adaptive (auto-calibrates) | `reasoning_effort` param | Thinking levels (low/med/high) |
| Structure | XML tags preferred | XML tags or structured specs | XML or Markdown headings |
| Verbosity | Naturally concise | `verbosity` API param | Defaults to direct |
| Parallel tools | Excellent, promptable to ~100% | Good, Responses API helps | Not emphasized |
| Risk | May overengineer | May over-search context | May loop at low temperature |
| Unique strength | Subagent orchestration | Tool preambles, meta-prompting | Grounding, multimodal |

> **Read reference files selectively** — don't read all of them every time:
> - `references/model-specific.md` — Read when the user specifies a target model or needs cross-model support
> - `references/templates.md` — Read when you need a starting template for the use case
> - `references/principles.md` — Read when you need deeper guidance on a specific principle
>
> For simple prompts where you already know the model and use case, the guidance in this SKILL.md is often sufficient.

## Output Format

When presenting the final system prompt to the user, include:

1. **The system prompt** — in a fenced code block, ready to copy-paste
2. **Architecture notes** — brief explanation of why you chose this structure
3. **Model-specific notes** — any adjustments for the target model (API params, known quirks)
4. **Test prompts** — 3-5 prompts the user can use to validate the system prompt works as intended
