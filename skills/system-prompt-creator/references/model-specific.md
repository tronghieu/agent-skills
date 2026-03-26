# Model-Specific Optimization Guide

Detailed tips for tailoring system prompts to each major LLM family. Read this after drafting a prompt to apply model-specific polish.

## Table of Contents

1. [Claude (Anthropic)](#claude-anthropic)
2. [GPT-5 (OpenAI)](#gpt-5-openai)
3. [Gemini (Google)](#gemini-google)
4. [Cross-Model Compatibility](#cross-model-compatibility)
5. [Open-Source Models](#open-source-models)

---

## Claude (Anthropic)

**Current models:** Claude Opus 4.6, Claude Sonnet 4.6, Claude Haiku 4.5

### Strengths to leverage

- **Adaptive thinking** — Claude auto-calibrates reasoning depth based on task complexity. No need to prompt "think step by step" — it decides when deep reasoning helps. Control via the `effort` parameter (low/medium/high/max).
- **Parallel tool calling** — Claude excels at running multiple tool calls simultaneously. Boost to ~100% success with: "If you intend to call multiple tools and there are no dependencies between them, make all independent calls in parallel."
- **Long context** — Strong performance on 200K+ token inputs. Put documents at the top, query at the bottom.
- **XML tag parsing** — Claude parses XML tags exceptionally well. Prefer XML over markdown for complex prompts.

### Quirks to handle

- **Overengineering tendency** — May add unnecessary abstractions, extra files, or defensive code beyond what was asked. Counter with: "Only make changes that are directly requested. Keep solutions minimal and focused."
- **Excessive subagent spawning** — May delegate simple tasks to subagents when a direct approach is faster. Counter with: "Use subagents only when tasks can run in parallel or require isolated context. For simple tasks, work directly."
- **Concise by default** — Claude 4.6 is naturally concise. If you want detailed explanations, ask explicitly: "Provide a detailed explanation including..."
- **Prefill deprecated** — Prefilled assistant responses are no longer supported on 4.6 models. Use direct instructions, structured outputs, or tool calling instead.

### API-specific settings

```python
# Adaptive thinking (recommended)
thinking={"type": "adaptive"}
output_config={"effort": "high"}  # low, medium, high, max

# Control thinking frequency if over-thinking
# Add to prompt: "Extended thinking adds latency and should only be
# used when it meaningfully improves answer quality."
```

### Prompt patterns that work well with Claude

```xml
<!-- Claude responds very well to explained reasoning -->
<instructions>
  Respond in plain prose paragraphs. Avoid markdown formatting.
  (Reasoning: responses are rendered in a chat widget that does
  not support markdown, so raw ** and ## would appear as literal
  characters.)
</instructions>

<!-- Subagent control -->
<delegation>
  Use subagents when tasks can run in parallel or require isolated
  context. For simple tasks (single-file reads, basic searches),
  work directly rather than delegating.
</delegation>
```

---

## GPT-5 (OpenAI)

**Current model:** GPT-5

### Strengths to leverage

- **Surgical instruction following** — The most steerable model. Responds to prompt instructions with high precision on verbosity, tone, and behavior.
- **Responses API** — Persists reasoning between tool calls. Use `previous_response_id` to reuse reasoning context across turns, improving both quality and efficiency.
- **Verbosity parameter** — Separate API control for output length, independent of reasoning depth. Set globally, then override per-context in the prompt.
- **Tool preambles** — Naturally provides progress updates before tool calls. Steer the frequency and style in your prompt.
- **Meta-prompting** — GPT-5 is excellent at optimizing prompts for itself. Use it to iterate on your system prompt.

### Quirks to handle

- **Over-searching at high reasoning** — May call tools excessively to gather context. Counter with explicit search budgets: "Absolute maximum of 2-3 tool calls for context gathering."
- **Contradiction sensitivity** — Contradictory instructions are more harmful here than with other models. GPT-5 spends reasoning tokens trying to reconcile conflicts rather than picking one. Audit prompts carefully.
- **Verbose by default** — Without the `verbosity` parameter or explicit instructions, outputs tend to be long. Set `verbosity: "low"` for concise results.
- **Markdown off by default in API** — Unlike Claude, GPT-5 API does not format in markdown unless instructed. Add markdown instructions if your renderer supports it.

### API-specific settings

```python
# Reasoning effort (default: medium)
reasoning={"effort": "high"}  # low, medium, high, minimal

# Verbosity control
verbosity="low"  # Separate from reasoning effort

# Responses API — reuse reasoning context
response = client.responses.create(
    model="gpt-5",
    previous_response_id=previous_id,  # Reuse reasoning
    ...
)
```

### Prompt patterns that work well with GPT-5

```xml
<!-- Cursor's proven agentic pattern -->
<persistence>
  Keep going until the user's query is completely resolved.
  Only terminate when you are sure the problem is solved.
  Never stop at uncertainty — deduce the most reasonable
  approach and continue.
</persistence>

<!-- Verbosity override per context -->
<code_style>
  Write code for clarity first. Prefer readable, maintainable
  solutions with clear names and comments where needed.
  Use high verbosity for writing code and code tools.
</code_style>
<!-- (While global verbosity is set to "low" for text output) -->

<!-- Effective context gathering control -->
<context_gathering>
  Search depth: moderate.
  Start broad, then focus. Stop searching once you can name
  the exact content to change. If top results converge on
  one area, proceed — don't keep searching.
</context_gathering>
```

---

## Gemini (Google)

**Current models:** Gemini 3 Flash, Gemini 3 Pro

### Strengths to leverage

- **Multimodal native** — Strong on image, video, audio, and document understanding. Combine modalities naturally in prompts.
- **Structured output** — Excellent at JSON, YAML, and schema-conformant output. Use `responseMimeType: "application/json"` for guaranteed JSON.
- **Grounding** — Can be constrained to respond only from provided context with a "strictly grounded assistant" pattern.
- **Thinking levels** — Configurable thinking depth (low/medium/high) for different task complexities.

### Quirks to handle

- **Temperature sensitivity** — Gemini 3 strongly recommends keeping temperature at default 1.0. Lower values may cause looping or degraded performance. This is the opposite of most other models.
- **Knowledge cutoff awareness** — May not know the current date. Add to system prompt: "Remember it is 2026 this year. Your knowledge cutoff date is January 2025."
- **Direct/efficient default** — Less verbose than Claude or GPT-5 by default. If you need detailed responses, ask explicitly.
- **Partial completion** — Gemini responds well to the "completion strategy" — provide the start of the desired format and let the model continue it.

### API-specific settings

```python
# DO NOT lower temperature for Gemini 3
# temperature=1.0 is the recommended default

generation_config = {
    "temperature": 1.0,       # Keep at 1.0 for Gemini 3
    "top_p": 0.95,
    "top_k": 40,
    "max_output_tokens": 8192,
    "response_mime_type": "application/json",  # For structured output
}

# Thinking level
thinking_config = {"thinking_level": "medium"}  # low, medium, high
```

### Prompt patterns that work well with Gemini

```xml
<!-- Grounding pattern for factual accuracy -->
<role>
  You are a strictly grounded assistant. Only use information
  explicitly provided in the context below. If the answer is
  not in the provided context, say "I don't have enough
  information to answer that."
</role>

<!-- Date/knowledge awareness -->
<context>
  Remember it is 2026 this year.
  Your knowledge cutoff date is January 2025.
  For information after that date, rely only on provided context.
</context>

<!-- Planning enhancement -->
<instructions>
  Before responding:
  1. Parse the goal into distinct sub-tasks
  2. Check if input is complete for each sub-task
  3. Create a structured outline
  4. Execute each sub-task
  5. Review output against original constraints
</instructions>
```

---

## Cross-Model Compatibility

When writing prompts that need to work across multiple models:

### Universal safe patterns

1. **XML tags** — Understood by all 3 models. Use `<role>`, `<instructions>`, `<examples>`, `<constraints>`.
2. **Few-shot examples** — Work everywhere. 3-5 examples in `<example>` tags.
3. **Positive framing** — "Write in prose" works better than "don't use markdown" on every model.
4. **Explicit formatting** — "Respond in JSON with these fields: ..." works on all models.
5. **Reasoning explanations** — "Do X because Y" improves all models.

### Things that differ across models

| Feature | Approach |
|---------|----------|
| Thinking/reasoning | Remove model-specific params. Use prompt: "Think through this step by step before answering." |
| Verbosity | Use prompt instructions ("Be concise" / "Be comprehensive") rather than API params |
| Temperature | Default to 1.0 (safe for Gemini, reasonable for others) |
| Tool calling | Describe tools in a model-agnostic format; let the API layer handle formatting |
| Markdown | Don't assume — explicitly state whether markdown is desired |

### Template for cross-model prompts

```xml
<role>
  [Model-agnostic persona definition]
</role>

<instructions>
  [Clear, positive-framed rules with reasoning]
  Think through complex problems step by step before answering.
</instructions>

<output_format>
  [Explicit format specification — never assume defaults]
</output_format>

<examples>
  [3-5 diverse examples with consistent formatting]
</examples>
```

---

## Open-Source Models

For open-source models (Llama, Mistral, Qwen, etc.):

- **Shorter prompts** — Smaller context windows mean every token counts. Prioritize the most impactful sections.
- **More examples needed** — Less capable instruction following means examples do more heavy lifting. Use 5+ examples if possible.
- **Explicit formatting** — Be very specific about output format. Include the exact structure you want.
- **Simpler structure** — Markdown headings may work better than XML tags on some models. Test both.
- **More aggressive prompting** — Unlike frontier models, open-source models often benefit from emphatic language ("You MUST...", "ALWAYS...").
- **Chain-of-thought** — Explicitly ask for step-by-step reasoning: "Think through this step by step, then provide your answer."

The 12 principles still apply, but calibrate P8 (intensity) upward for less capable models.
