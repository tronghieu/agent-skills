# Agent Skills

**Language / Ngôn ngữ / 语言:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

A collection of skills for AI coding agents. Compatible with [Claude Code](https://code.claude.com), [Cursor](https://cursor.com), [GitHub Copilot](https://github.com/features/copilot), and [20+ other AI tools](https://agentskills.io) that support the open [Agent Skills standard](https://agentskills.io).

## Available Skills

### cv-scorer

Score candidate CVs on a 100-point scale against a Job Description.

**Skill README:** [cv-scorer](./skills/cv-scorer/README.md)

**What it does:**
- Scores CVs across 5 weighted criteria: JD Matching, Work Experience, Project & Impact, Education, CV Quality
- Detects red flags: repetitive content, inflated metrics, contradictory information
- Outputs structured JSON with per-criterion scores, highlights, red flags, and a recommendation (Recommend / Maybe / Pass)
- Supports batch processing: scores multiple CVs independently then ranks them

**Trigger phrases:** "review CV", "screen resume", "score candidate", "rate candidates", "shortlist applicants", "match resume to JD"

**Install:**
```bash
npx skills add tronghieu/agent-skills --skill cv-scorer
```

### system-prompt-creator

Create high-quality, model-aware system prompts for any LLM (Claude, GPT, Gemini, open-source).

**Skill README:** [system-prompt-creator](./skills/system-prompt-creator/README.md)

**What it does:**
- Walks you through a structured 5-step workflow: Interview, Analyze, Structure, Draft, Review
- Applies 12 universal principles derived from the official prompting guides of Anthropic, OpenAI, and Google
- Produces model-specific optimizations (Claude XML tags, GPT-5 verbosity params, Gemini temperature settings)
- Includes domain patterns: operational playbooks, raw data preservation, confidence scoring
- Provides 7 ready-to-adapt templates for common use cases

**Trigger phrases:** "create a system prompt", "write system instructions", "prompt engineering", "build a chatbot prompt", "design an agent prompt"

**Install:**
```bash
npx skills add tronghieu/agent-skills --skill system-prompt-creator
```

### socratic-questor

Socratic questioning partner (Gadfly) for deep learning through dialogue.

**Skill README:** [socratic-questor](./skills/socratic-questor/README.md)

**What it does:**
- Teaches any topic by asking questions, never by explaining — the learner discovers understanding through dialogue
- Follows the Paul & Elder 6-type Socratic questioning framework: Clarification, Assumptions, Evidence, Perspectives, Implications, Meta-questions
- Adapts difficulty based on learner level (novice, intermediate, advanced) detected from response quality
- Scaffolds down when learners are stuck — simpler sub-questions and concrete analogies, never direct answers
- Matches the learner's language automatically

**Trigger phrases:** "teach me about...", "help me understand...", "ask me questions about...", "quiz me", "Socratic method", "Gadfly"

**Install:**
```bash
npx skills add tronghieu/agent-skills --skill socratic-questor
```

### fiction-studio

A complete prose-fiction writing studio, run as a team of named specialist agents, that guides an author from a bare idea to a polished manuscript.

**Skill README:** [fiction-studio](./skills/fiction-studio/README.md)

**What it does:**
- Runs a team of 10 specialists named after literary masters, led by **Homer** (orchestrator): Aristotle (plot), Fyodor (character), Tolkien (world), Scheherazade (drafting), Oscar (dialogue), Max (editing), Virginia (beta read), Borges (genre), Bloom (critique)
- Drives an end-to-end pipeline — premise → outline → characters → world → scene list → draft → dialogue → edit → beta read → revision triage → polish → package — with quality gates for genre, continuity, foreshadowing, and sensitivity
- **Writers' Room (party mode):** convenes 3-4 relevant specialists to brainstorm a premise or work through a creative fork together, then captures the decision to a file
- **Consistency QA:** a zero-dependency continuity checker (`scripts/continuity_check.py`) plus a structured `canon.json` source of truth keep a multi-session manuscript coherent
- Adapts to novel, novella, short story, or series; includes the Snowflake outline variant and matches the author's language

**Trigger phrases:** "help me write a novel", "I have an idea for a story", "develop my characters", "build a world for my fantasy", "outline my plot", "fix this scene", "my dialogue feels flat", "give me beta-reader feedback"

**Install:**
```bash
npx skills add tronghieu/agent-skills --skill fiction-studio
```

### slidewright

Build interactive presentation websites — slide decks projected to a room and driven by one presenter.

**Skill README:** [slidewright](./skills/slidewright/README.md)

**What it does:**
- Two tracks: a **zero-build single HTML file** (open it in a browser, no install) or a **Vite + React + TypeScript** project — picks the right one for the job
- Scaffolds with one command; the React scaffold runs the official Vite tool and installs the **latest** React, Tailwind, Framer Motion and Lucide (no pinned versions, so each deck starts on current tooling)
- Enforces projection discipline: a typography floor so text reads from the back of a room, a required navigation slider + slide number, and presenter-only interaction (no forms, no data collection)
- Ships layout recipes (title, bullets, two-column compare, big stat, quote, full-bleed image), a speaker-notes convention, and PDF export guidance

**Trigger phrases:** "build a presentation", "make a slide deck", "interactive presentation website", "dựng deck / làm slide / bài thuyết trình", "add a slide to my deck", "export slides to PDF"

**Install:**
```bash
npx skills add tronghieu/agent-skills --skill slidewright
```

### diataxis-writer

Write, restructure, classify, and review documentation using the Diataxis framework.

**Skill README:** [diataxis-writer](./skills/diataxis-writer/README.md)

**What it does:**
- Classifies docs into tutorials, how-to guides, references, and explanations
- Writes and restructures docs, knowledge bases, onboarding/process docs, and product/API docs
- Reviews documentation for Diataxis fit, audience intent, task flow, and missing context
- Helps turn mixed or messy docs into clearer learning, task, information, or understanding material

**Trigger phrases:** "use Diataxis", "classify this doc", "restructure documentation", "review these docs", "write a how-to guide", "create API reference docs", "improve onboarding docs", "organize a knowledge base"

**Install:**
```bash
npx skills add tronghieu/agent-skills --skill diataxis-writer
```

## Installation

```bash
# Using the skills CLI (recommended)
npx skills add tronghieu/agent-skills

# Or manually for Claude Code
cp -r skills/cv-scorer ~/.claude/skills/
cp -r skills/system-prompt-creator ~/.claude/skills/
cp -r skills/socratic-questor ~/.claude/skills/
cp -r skills/fiction-studio ~/.claude/skills/
cp -r skills/slidewright ~/.claude/skills/
cp -r skills/diataxis-writer ~/.claude/skills/
```

## Skill Structure

```
skills/
  cv-scorer/
    SKILL.md                    # Core skill (workflow + scoring rubric)
    references/
      scoring-rubric.md         # Detailed 5-criterion rubric with scoring guides
      output-format.md          # JSON output templates (single CV + batch)
  system-prompt-creator/
    SKILL.md                    # Core skill (workflow + 12 principles)
    references/
      principles.md             # Detailed principles with examples
      model-specific.md         # Claude / GPT-5 / Gemini tips
      templates.md              # 7 templates (chatbot, agent, extractor, etc.)
  socratic-questor/
    SKILL.md                    # Core skill (Gadfly persona + workflow)
    references/
      questioning-framework.md  # Paul & Elder 6-type framework + adaptive strategies
  fiction-studio/
    SKILL.md                    # Core skill (team of 10 agents + pipeline + Writers' Room)
    references/                 # agents/, workflow, craft, genres, qa, party-mode
    templates/                  # premise, outline, character, world-bible, canon.json, ...
    checklists/                 # plot-structure, continuity, foreshadowing, sensitivity, ...
    scripts/
      continuity_check.py       # Zero-dependency consistency checker (names, attrs, setups)
  slidewright/
    SKILL.md                    # Core skill (projection mental model + workflow + track selection)
    references/
      design-system.md          # Typography floor, layout recipes, motion, palette
      html-track.md             # Plain-HTML single-file deck
      react-track.md            # Vite + React (Deck/Slide/slides) architecture
      export-pdf.md             # PDF export + speaker-notes convention
    scripts/
      new-html-deck.sh          # Scaffold a zero-build HTML deck
      new-react-deck.sh         # Scaffold a Vite + React deck (latest deps, unpinned)
      export-deck-pdf.py        # Content-complete PDF export (waits for render, reveals hidden content)
  diataxis-writer/
    SKILL.md                    # Core skill (Diataxis writing, classification, restructuring, review)
    README.md                   # English skill README
    README.vi.md                # Vietnamese skill README
    README.zh.md                # Chinese skill README
    references/
      diataxis-patterns.md      # Diataxis patterns, diagnostics, and examples
    scripts/
      classify-doc.sh           # Classify documentation by Diataxis type
    evals/
      evals.json                # Evaluation cases
```

## Contributing

We welcome contributions from the community! This project follows the open [Agent Skills standard](https://agentskills.io) and is compatible with 30+ AI coding tools.

### How to contribute

1. **Fork** this repository
2. **Create a skill** following the structure below
3. **Test** your skill with at least 2-3 realistic prompts
4. **Submit a PR** with a clear description of what the skill does and when it triggers

### Creating a new skill

```bash
# Scaffold a new skill
mkdir -p skills/your-skill-name/references

# Create the required SKILL.md
cat > skills/your-skill-name/SKILL.md << 'EOF'
---
name: your-skill-name
description: What it does + when to trigger + relevant keywords
---

# Your Skill Name

Instructions for the agent when this skill is activated.
EOF
```

See [AGENTS.md](./AGENTS.md) for the full skill creation guide, including directory structure, naming conventions, SKILL.md format, and packaging instructions.

### Skill quality checklist

Before submitting a PR, make sure your skill:

- [ ] Has a `SKILL.md` with `name` and `description` in frontmatter
- [ ] Description is specific about **when** to trigger (not just what it does)
- [ ] Instructions are clear, actionable, and explain the *why* behind rules
- [ ] Includes examples where format/accuracy matters
- [ ] Keeps `SKILL.md` under 500 lines (use `references/` for detailed docs)
- [ ] Does not contain secrets, credentials, or sensitive data
- [ ] Has been tested with realistic prompts

### Contribution ideas

- New skill templates for specific domains (DevOps, data science, mobile, etc.)
- Translations of existing skills for non-English workflows
- Improvements to existing skills based on real-world usage
- Bug fixes and documentation updates

## Open Standard

This project is built on the [Agent Skills open standard](https://agentskills.io), originally developed by Anthropic and now adopted by 30+ AI platforms including Claude Code, Cursor, GitHub Copilot, Codex, Gemini CLI, and more.

Skills you create here work everywhere the standard is supported. No vendor lock-in.

| Platform | Support |
|----------|---------|
| Claude Code | Native |
| Cursor | Native |
| GitHub Copilot | Native |
| Codex (OpenAI) | Native |
| Gemini CLI | Native |
| Windsurf, Cline, Roo Code, ... | Native |

Full list at [agentskills.io](https://agentskills.io).

## References

| Resource | URL |
|----------|-----|
| Agent Skills Standard | https://agentskills.io |
| Claude Code Skills Docs | https://code.claude.com/docs/en/skills |
| Anthropic Skills (official) | https://github.com/anthropics/skills |
| Skills CLI (Vercel) | https://github.com/vercel-labs/skills |
| Skills Marketplace | https://skills.sh |

## License

MIT — use, modify, and distribute freely.
