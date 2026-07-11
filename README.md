# Agent Skills

**Language / Ngôn ngữ / 语言:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

A collection of skills for AI coding agents. Compatible with [Claude Code](https://code.claude.com), [Cursor](https://cursor.com), [GitHub Copilot](https://github.com/features/copilot), and [20+ other AI tools](https://agentskills.io) that support the open [Agent Skills standard](https://agentskills.io).

## Available Skills

| Skill | What it does |
|-------|---------------|
| [cv-scorer](#cv-scorer) | Score candidate CVs on a 100-point scale against a Job Description |
| [data-scientist](#data-scientist) | Act as a rigorous, end-to-end data scientist — frame, explore, test, model, and communicate |
| [deep-reader](#deep-reader) | Deep-read long books and papers using Adler's method, with page-anchored notes as external memory |
| [design-thinking](#design-thinking) | A friendly design-thinking facilitator that walks you through Empathize→Define→Ideate→Prototype→Test as an ongoing project — it designs the research, you run it, and every insight is backed by evidence |
| [diataxis-writer](#diataxis-writer) | Write, restructure, classify, and review documentation using the Diataxis framework |
| [fiction-studio](#fiction-studio) | A complete prose-fiction writing studio run by a team of named specialist agents |
| [market-researcher](#market-researcher) | Citation-disciplined desk market research — go/no-go scans and deep-dive sizing, competitors, demand, and trends |
| [product-manager](#product-manager) | A disciplined product-manager copilot that runs your product's operating loop — prioritization, PRDs, OKRs, experiments, launches, feedback triage — in a persistent per-product workspace where every number declares where it came from |
| [slidewright](#slidewright) | Build interactive presentation websites — slide decks projected to a room |
| [socratic-questor](#socratic-questor) | Socratic questioning partner (Gadfly) for deep learning through dialogue |
| [strategy-board](#strategy-board) | A C-level strategy advisory board run by named specialist agents — from raw question to defended recommendation |
| [system-prompt-creator](#system-prompt-creator) | Create high-quality, model-aware system prompts for any LLM |

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

### data-scientist

Act as a rigorous, end-to-end data scientist: frame a business question as a data problem, explore and audit datasets, run defensible statistical analysis, build and validate predictive models, and turn results into decision-ready reports.

**Skill README:** [data-scientist](./skills/data-scientist/README.md)

**What it does:**
- Routes any data question through the 4-level analytics ladder (descriptive/diagnostic/predictive/prescriptive) into 6 flows: Full engagement, Explore, Inquire, Predict, Review, Communicate
- Enforces 5 non-negotiables: look at the data first, every number from executed code, baseline before complexity, every estimate carries uncertainty, leakage checklist before any model metric
- Two bundled scripts: `profile_data.py` (dataset profiling with quality warnings) and `baseline_model.py` (leak-safe dummy + linear baselines with cross-validation)
- **Review flow** acts as an expert validator of an existing analysis, notebook, or model — an adversarial pass before any conclusion ships
- Recommendations always come with quantified trade-offs; the decision goes back to the owner — no full optimization solvers, no Data Engineering/MLOps scope

**Trigger phrases:** "analyze this dataset", "what drove this change?", "is this difference significant?", "A/B test", "build a model to predict...", "review this analysis/notebook", "phân tích dữ liệu", "xây model dự đoán", "kiểm định A/B"

**Install:**
```bash
npx skills add tronghieu/agent-skills --skill data-scientist
```

### deep-reader

Deep-read long books and papers using Adler's inspectional/analytical/syntopical method, SQ3R's Recite step, and Keshav's three-pass method for papers, with page-anchored notes as external memory.

**Skill README:** [deep-reader](./skills/deep-reader/README.md)

**What it does:**
- Reads in passes — structure first, then chapter by chapter — instead of loading the whole book into one context window
- Two modes: **overview** (inspectional pass + goal-directed summary) and **study** (full pipeline: analytical notes per chapter with Recite verification, then a hierarchical synthesis)
- Externalizes everything into a page-anchored notes workspace, so a later session answers follow-up questions by searching notes instead of re-reading the book
- Mechanically verifies every quote against its cited page to catch fabricated quotes and wrong page citations

**Trigger phrases:** "read this book for me", "study this PDF", "summarize this textbook", "analyze this paper", "deep-read this thesis", "đọc sách", "tóm tắt sách", "phân tích luận án"

**Install:**
```bash
npx skills add tronghieu/agent-skills --skill deep-reader
```

### design-thinking

A friendly design-thinking facilitator and thinking partner that walks you through the full Empathize→Define→Ideate→Prototype→Test loop as a multi-session project with a persistent workspace; it designs research instruments and experiments, synthesizes the real data you bring back, and keeps every user insight grounded in evidence.

**Skill README:** [design-thinking](./skills/design-thinking/README.md)

**What it does:**
- Every insight carries an [I#] tag tracing to registered evidence [S#] (interview notes, transcripts, surveys, desk sources) or is labelled `(hypothesis — needs validation)`, so simulated data never enters the evidence base
- AI designs the instruments (discussion guides, observation plans, test cards with pre-registered pass/fail thresholds), the user runs the real interviews and tests
- A Verifier runs at phase gates — insight review after Define, assumption review before Test — with findings shared openly
- Ideate fans out parallel ideator subagents with distinct lenses, then converges with Desirability/Feasibility/Viability scoring done with the user
- Persistent workspace (phase-state.md, journal.md, sources/insights/personas/hmw/ideas/prototypes/tests) with a re-entry protocol and deliberate loop-backs — plus optional composition with the market-researcher skill for heavier market questions (mentioned once if absent, fully optional)

**Trigger phrases:** "run design thinking", "understand our users", "design user interviews", "synthesize these interview notes", "build personas", "How might we…", "design an experiment to validate…", "tư duy thiết kế", "nghiên cứu người dùng", "デザイン思考 / 设计思维"

**Install:**
```bash
npx skills add tronghieu/agent-skills --skill design-thinking
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

### market-researcher

Citation-disciplined desk market research: quick go/no-go market scans and modular deep dives — market sizing (TAM/SAM/SOM), competitor analysis, demand signals, and trends/macro (PESTEL) — for any market, in any language.

**Skill README:** [market-researcher](./skills/market-researcher/README.md)

**What it does:**
- Every claim traces to a `[S#]` source registry (URL, publisher, dates, confidence grade) or is labelled an assumption — no uncited "the market is growing rapidly"
- Two modes: **Quick Scan** (default, one-session go/no-go brief) and **Deep Dive** (opt-in, modular lanes — sizing / competitors / demand / macro — multi-session and resumable)
- Built-in adversarial verification pass re-checks claims against their sources and recomputes every estimate's arithmetic before delivery
- **Composition contract** lets other skills (e.g. strategy-board) call it to append cited facts straight into their own workspace
- Honest boundary: desk research produces demand signals and hypothesis personas for primary research to validate — never fabricated "insights"

**Trigger phrases:** "market research for...", "how big is the market for...", "who are the competitors of...", "should I build/launch/sell...", "validate this business idea", "nghiên cứu thị trường", "市場調査 / 市场调研"

**Install:**
```bash
npx skills add tronghieu/agent-skills --skill market-researcher
```

### product-manager

A disciplined product-manager copilot for a living product, not a one-shot document generator: it captures opportunities as job stories, prioritizes with RICE plus sensitivity analysis, writes PRDs with story maps and testable user stories, plans OKRs, experiments, and launches with rollback criteria, and triages feedback — while refusing to invent numbers.

**Skill README:** [product-manager](./skills/product-manager/README.md)

**What it does:**
- Runs the product's operating loop end to end — opportunities → RICE prioritization → PRD → story map → OKRs → experiments → launch plan → feedback triage — inside one persistent per-product workspace
- Captures opportunities as job stories and prioritizes them with RICE scoring plus a sensitivity analysis on the inputs, so ranking never hinges on a single guessed number
- Writes PRDs with story maps and testable (Given/When/Then) user stories; plans OKRs, designs experiments with pass/fail criteria, and drafts launch plans with rollback criteria
- Refuses to invent numbers: every figure traces to a cited source, a labelled assumption with a range, or your own dated estimate
- An adversarial audit checks each PRD, prioritization, or launch plan before you're asked to act on it
- Works in any language; composes naturally with design-thinking (user discovery), market-researcher (market facts), and strategy-board (company-level bets)

**Trigger phrases:** "prioritize our roadmap", "write a PRD for...", "score these features with RICE", "plan OKRs for this quarter", "design an experiment for...", "plan this launch", "triage this feedback"

**Install:**
```bash
npx skills add tronghieu/agent-skills --skill product-manager
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

### strategy-board

A C-level strategy advisory board, run as a team of named specialist agents, that takes an executive from a raw strategic question to a defended, board-ready recommendation.

**Skill README:** [strategy-board](./skills/strategy-board/README.md)

**What it does:**
- Runs a team of 8 named specialists led by **Drucker** (managing partner): Porter (markets & competition), Christensen (innovation & disruption), Graham (finance & value), Grove (execution & organization), Wack (scenarios & uncertainty), Taleb (risk & red team), Minto (synthesis & communication)
- Drives a gated engagement pipeline — brief → fact base → analysis → options → stress-test → recommendation → roadmap — with executive gates confirming the question, the direction, and the final recommendation
- **The Boardroom (party mode):** convenes 3-4 relevant members to debate a sharp question, independent takes first via parallel subagents (to kill groupthink), then cross-talk, with minutes kept
- Hard rules: no invented numbers (every figure traces to a sourced fact base or is labelled an assumption), three genuine options before any recommendation, a mandatory pre-mortem before it ships, and "strategy is choice" — every recommendation states what to stop doing

**Trigger phrases:** "should we invest in / build / buy / enter…", "develop a strategy", "evaluate this opportunity", "stress-test this plan", "run a pre-mortem", "convene the board"

**Install:**
```bash
npx skills add tronghieu/agent-skills --skill strategy-board
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

## Installation

### 1. Using CLI (Recommended)

```bash
npx skills add tronghieu/agent-skills
```

### 2. Manual Installation (For Non-Technical Users)

You can download the ready-to-use `.zip` files for each skill and extract them to your preferred location.

1. **Download:** Go to the `skills/` folder in this repository and download the `.zip` file for the skill you want.
2. **Extract & Copy:** Extract the `.zip` file and copy the skill folder into one of the following directories:

**For a Specific Project:**
Copy the folder to `.agents/skills/` or `.claude/skills/` in your project's root directory.

**Globally (Available for all projects):**
* **Mac / Linux:** `~/.agents/skills/` or `~/.claude/skills/`
* **Windows:** `%USERPROFILE%\.agents\skills\` or `%USERPROFILE%\.claude\skills\` (usually `C:\Users\<YourUsername>`)

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
