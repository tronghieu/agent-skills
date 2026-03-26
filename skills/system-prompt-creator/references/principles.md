# The 12 Universal Principles — Detailed Reference

These principles are distilled from the official prompting guides of Claude (Anthropic), GPT-5 (OpenAI), and Gemini (Google). Each principle includes the rationale, examples from the source guides, and actionable patterns.

## Table of Contents

1. [Layered Architecture](#p1--layered-architecture)
2. [Consistent Structured Tags](#p2--consistent-structured-tags)
3. [Content Ordering](#p3--content-ordering)
4. [Explicit Intent + Reasoning](#p4--explicit-intent--reasoning)
5. [Positive Framing](#p5--positive-framing)
6. [Graduated Autonomy](#p6--graduated-autonomy)
7. [Internal Consistency](#p7--internal-consistency)
8. [Match Intensity to Model Intelligence](#p8--match-intensity-to-model-intelligence)
9. [Few-Shot Examples](#p9--few-shot-examples)
10. [Separate Control Dimensions](#p10--separate-control-dimensions)
11. [State Management](#p11--state-management)
12. [Self-Verification Loop](#p12--self-verification-loop)

---

## P1 — Layered Architecture

**What:** Organize prompt content into distinct, labeled sections.

**Why:** When instructions, context, examples, and inputs are mixed together, models may confuse which content serves which purpose. Layered sections create unambiguous parsing boundaries.

**Evidence:**
- Claude guide: "XML tags help Claude parse complex prompts unambiguously, especially when your prompt mixes instructions, context, examples, and variable inputs."
- GPT-5 guide: Cursor uses `<context_understanding>`, `<persistence>`, `<tool_preambles>` as distinct behavioral blocks.
- Gemini guide: Recommends `<role>`, `<constraints>`, `<context>`, `<task>` as structural elements.

**Standard layer order:**

```
1. Role/Persona       — Who the AI is
2. Context/Knowledge  — Background, domain info, reference material
3. Instructions/Rules — What to do, how to decide
4. Output Format      — Response structure, tone, verbosity
5. Examples           — Input/output pairs
6. Tools              — Available capabilities, usage rules
7. Guardrails         — Safety, escalation, refusal criteria
```

---

## P2 — Consistent Structured Tags

**What:** Use one tagging convention (XML or markdown headings) and apply it consistently throughout the entire prompt.

**Why:** Mixing conventions (e.g., XML tags in some sections, markdown in others, plain text elsewhere) creates ambiguity about where one section ends and another begins.

**Patterns:**

XML (best for complex, multi-section prompts):
```xml
<role>...</role>
<instructions>...</instructions>
<examples>
  <example index="1">...</example>
  <example index="2">...</example>
</examples>
```

Markdown (best for simpler prompts):
```markdown
# Role
...
## Sub-section
...
# Instructions
...
```

**Nesting rule:** Nest tags when content has natural hierarchy. Example for multi-document input:
```xml
<documents>
  <document index="1">
    <source>report.pdf</source>
    <content>{{REPORT}}</content>
  </document>
  <document index="2">
    <source>data.csv</source>
    <content>{{DATA}}</content>
  </document>
</documents>
```

---

## P3 — Content Ordering

**What:** Place long reference material at the top, task/query at the bottom.

**Why:** Claude's guide reports up to 30% quality improvement when queries come after documents rather than before them, especially with complex multi-document inputs. All 3 guides agree on this ordering.

**Pattern:**
```
[Long documents, data, reference material]   ← TOP
[Context and background]                      ← MIDDLE
[Instructions and rules]
[Examples]
[The actual task/query]                       ← BOTTOM
```

**Anchoring technique:** After placing reference material at the top, anchor your instructions to it: "Based on the documents above, ..." or "Using the information provided above, ..."

**Evidence:**
- Claude: "Put longform data at the top... Queries at the end can improve response quality by up to 30%."
- Gemini: "Structure for long contexts — context first, questions at end."
- GPT-5: Implicit in their system prompt designs where context precedes task.

---

## P4 — Explicit Intent + Reasoning

**What:** For every non-obvious rule, explain *why* it exists alongside *what* it requires.

**Why:** Models generalize from reasoning far better than from bare commands. When a model understands the purpose behind a rule, it can handle edge cases the rule didn't explicitly cover.

**Examples:**

| Bad | Good |
|-----|------|
| `NEVER use ellipses` | `Responses are read aloud by TTS, so avoid ellipses — TTS engines cannot pronounce them.` |
| `Always use UTC timestamps` | `Use UTC timestamps because our users span 12+ time zones and local times cause confusion in shared logs.` |
| `Keep responses under 200 words` | `Keep responses under 200 words — they appear in a mobile notification panel with limited space.` |

**Evidence:**
- Claude: "Providing context or motivation behind your instructions... can help Claude better understand your goals and deliver more targeted responses. Claude is smart enough to generalize from the explanation."
- GPT-5 (Cursor): Found that explaining product behavior (Undo/Reject code, user preferences) "helped reduce ambiguity by clearly specifying how GPT-5 should behave."
- Gemini: Context examples show that including reasoning behind speech instructions (breaks for pause, hook, joke) produced dramatically better outputs.

---

## P5 — Positive Framing

**What:** State desired behavior rather than prohibited behavior.

**Why:** A model performs better when given a clear target to hit rather than a minefield to avoid. Negative constraints leave the space of acceptable behavior undefined.

**Examples:**

| Negative (avoid) | Positive (prefer) |
|---|---|
| Do not use markdown | Write in smoothly flowing prose paragraphs |
| Don't be verbose | Be concise — lead with the answer, then explain if needed |
| Never make assumptions | When uncertain, ask a clarifying question before proceeding |
| Don't use jargon | Use plain language that a non-technical reader can follow |

**Evidence:**
- Claude: "Tell Claude what to do instead of what not to do."
- GPT-5: Cursor moved from "don't produce code-golf" to "Write code for clarity first. Prefer readable, maintainable solutions."
- Gemini: Goals and rules examples show positive framing producing better adherence.

**When negative framing IS appropriate:** Safety guardrails and hard boundaries ("Never execute code that deletes user data without confirmation") are legitimate uses of negative framing. The key: pair them with a positive alternative ("Instead, present a preview of what would be deleted and ask for explicit confirmation").

---

## P6 — Graduated Autonomy

**What:** For agentic systems, explicitly define which actions are safe, moderate, and risky.

**Why:** Without guidance, models may either be too cautious (asking permission for everything) or too aggressive (taking irreversible actions without confirmation). Explicit tiers solve both problems.

**Pattern:**
```xml
<action_tiers>
  <safe>
    Actions the agent can take freely without asking:
    - Read files, search codebase, run tests
    - Fetch documentation, check status
  </safe>
  <moderate>
    Actions the agent should proceed with but mention to the user:
    - Edit files, create branches, install packages
  </moderate>
  <risky>
    Actions that require explicit user confirmation before proceeding:
    - Delete files/branches, force-push, post to external services
    - Modify shared infrastructure, send messages on behalf of user
  </risky>
</action_tiers>
```

**Evidence:**
- Claude: Detailed safety protocol with reversibility classification.
- GPT-5: "Define safe versus unsafe actions... the checkout and payment tools should have a lower uncertainty threshold than the search tool."
- Gemini: "Risk Assessment — exploratory vs. state-changing actions."

---

## P7 — Internal Consistency

**What:** Ensure every instruction in the prompt can be followed simultaneously without contradiction.

**Why:** Contradictions are actively harmful with modern models. GPT-5's guide specifically warns that "poorly-constructed prompts containing contradictory or vague instructions can be more damaging to GPT-5 than to other models, as it expends reasoning tokens searching for a way to reconcile the contradictions."

**Common contradiction patterns:**

1. **Action vs. restriction:** "Never schedule without consent" + "Auto-assign immediately without contacting patient"
2. **Scope vs. exception:** "Always look up the patient first" + "In emergencies, skip lookup and act immediately" (without explicitly resolving which wins)
3. **Format vs. content:** "Be concise" + "Include comprehensive details"

**Fix:** When rules have priorities, state them explicitly:
```
If these rules conflict, apply this priority order:
1. User safety (highest)
2. Data accuracy
3. Response speed
4. User convenience (lowest)
```

---

## P8 — Match Intensity to Model Intelligence

**What:** Calibrate prompting aggressiveness to the model's capability level.

**Why:** Modern models (Claude 4.6, GPT-5, Gemini 3) are significantly more capable and proactive than their predecessors. Aggressive prompting designed for older models causes overtriggering, over-searching, and wasted reasoning tokens.

**Migration pattern:**

| Old (for previous-gen models) | New (for current-gen models) |
|---|---|
| `CRITICAL: You MUST use this tool when...` | `Use this tool when...` |
| `Be THOROUGH when gathering information. Make sure you have the FULL picture.` | `Gather enough context to act, then proceed.` |
| `If in doubt, use [tool]` | `Use [tool] when it would enhance your understanding` |
| `ALWAYS check every file before...` | `Check relevant files before...` |

**Evidence:**
- Claude: "If your prompts were designed to reduce undertriggering on tools or skills, these models may now overtrigger."
- GPT-5 (Cursor): Had to remove "THOROUGH" and "FULL picture" language. "While this worked well with older models... they found it counterproductive with GPT-5."
- Gemini: Defaults to "direct/efficient" — over-prompting is less necessary.

---

## P9 — Few-Shot Examples

**What:** Include 3-5 well-crafted input/output examples that demonstrate desired behavior.

**Why:** Examples are the single most reliable way to steer output format, tone, and decision-making. They can sometimes replace explicit instructions entirely.

**Best practices:**

1. **Diverse:** Cover normal cases, edge cases, and boundary conditions
2. **Relevant:** Mirror actual use cases, not toy examples
3. **Consistent format:** Use the same structure across all examples
4. **Tagged:** Wrap in `<example>` tags to separate from instructions

**Pattern:**
```xml
<examples>
  <example index="1">
    <input>Customer email: "I've been waiting 3 weeks for my order #12345"</input>
    <output>I'm sorry about the delay with order #12345. Let me look that up right away. [lookup_order(12345)] Based on the tracking info, your package is currently [status]. I'll [action] to resolve this.</output>
  </example>
  <example index="2">
    <input>Customer email: "Your product is terrible and I want a refund NOW"</input>
    <output>I understand your frustration. I'd like to help make this right. Could you share your order number so I can process the refund? In the meantime, could you tell me what went wrong? Your feedback helps us improve.</output>
  </example>
</examples>
```

**Caveat from Gemini:** Too many examples can cause overfitting — the model may match patterns too literally rather than generalizing. 3-5 is the sweet spot.

---

## P10 — Separate Control Dimensions

**What:** Recognize that reasoning depth, output verbosity, and output diversity are independent axes — control each one separately.

**Why:** Conflating "think harder" with "write more" or "be creative" leads to unintended behavior. A model can think deeply and produce a concise answer, or think briefly and produce a long response.

**The three axes:**

| Dimension | What it controls | How to control it |
|---|---|---|
| **Reasoning depth** | How hard the model thinks about the problem | Claude: `effort` param. GPT-5: `reasoning_effort`. Gemini: thinking level. |
| **Output verbosity** | How long/detailed the response is | Prompt instructions ("be concise", "comprehensive detail"). GPT-5 also has `verbosity` param. |
| **Temperature/diversity** | How creative/varied the outputs are | API `temperature` param. Gemini 3: keep at 1.0 default. |

**Key insight from GPT-5 (Cursor):** Set `verbosity: low` globally for concise status updates, then override with "Use high verbosity for writing code" in the prompt — getting concise communication with readable code.

---

## P11 — State Management

**What:** For long-running or multi-turn agentic tasks, define explicitly how the agent should track progress and manage state.

**Why:** Without guidance, agents either lose track of what they've done (repeating work) or fail to persist critical information across context boundaries.

**Recommended approaches:**

| State type | Format | Example |
|---|---|---|
| Task progress | Plain text | `progress.txt` with session notes |
| Structured data | JSON | `tests.json` with pass/fail status |
| Checkpoints | Git | Commits at meaningful milestones |
| Configuration | Structured | `.env`, `config.json` |

**Pattern for multi-context-window agents (from Claude guide):**
```
First context window: Set up framework (write tests, create scripts)
Subsequent windows: "Review progress.txt, tests.json, and git logs.
Run integration tests before implementing new features."
```

---

## P12 — Self-Verification Loop

**What:** Include explicit verification steps before the model finalizes output.

**Why:** Self-checking reliably catches errors, especially in code, math, and structured data. All 3 guides recommend this pattern.

**Patterns:**

Simple verification:
```
Before finalizing your response, verify:
1. All code compiles without errors
2. All required fields are present in the JSON
3. No sensitive data is exposed in the output
```

Rubric-based verification (from GPT-5):
```
Before responding, create a quality rubric with 5-7 categories.
Score your draft against each category. If any category scores
below "excellent", revise before delivering.
```

Iterative verification:
```
After completing the task:
1. Re-read the original requirements
2. Compare your output against each requirement
3. If any requirement is unmet, fix it before responding
```

**Evidence:**
- Claude: "Ask Claude to self-check. 'Before you finish, verify your answer against [test criteria].' This catches errors reliably."
- GPT-5: Self-reflection rubric pattern for zero-to-one app generation.
- Gemini: "Review your generated output against the user's original constraints."
