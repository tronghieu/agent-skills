# Agent Skills

**Language / Ngôn ngữ / 语言:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

AI is useful for many tasks, but general advice can be inconsistent or miss important checks. These skills give your AI a clear, practical way to work, so you get more reliable answers, better decisions, and results you can use.

This collection helps with everyday work such as choosing candidates, understanding data and customers, planning products and projects, preparing presentations, learning, writing, and making important business decisions.

## Use a skill

Start by selecting a skill, then describe what you need in your own words.

- **Codex and ChatGPT:** Type `$`, then choose a skill—for example, `$market-researcher Help me assess this business idea.`
- **Claude, Antigravity, and Gemini:** Type `/`, choose a skill, then describe your need.

You do not need to learn special commands beyond that. Share your goal and any useful context, files, or questions as you normally would.

## Skills

| Skill | How it helps |
|---|---|
| [cv-scorer](#cv-scorer) | Compare candidates fairly against a role, highlight the strongest matches, and surface concerns that deserve a closer look. |
| [brainstorm-coach](#brainstorm-coach) | Generate real ideas for a name, a campaign, a feature, or anything you're stuck on — your ideas come first, the AI builds on them without taking over. |
| [critical-thinking](#critical-thinking) | Check whether a proposal, report, or argument is supported by sound evidence; reveal weak assumptions before they become costly decisions. |
| [data-scientist](#data-scientist) | Turn data into trustworthy answers: explain what changed, test whether a result is meaningful, and show the trade-offs behind a recommendation. |
| [deep-reader](#deep-reader) | Work through long books and papers carefully, creating clear notes and dependable summaries that remain useful for later questions. |
| [design-thinking](#design-thinking) | Understand people’s real needs, turn research into useful insights, and test possible solutions before committing to them. |
| [diataxis-writer](#diataxis-writer) | Make help materials, guides, and knowledge bases easier to follow by giving each reader the information they need at the right moment. |
| [fiction-studio](#fiction-studio) | Develop a story from a rough idea to a polished manuscript, with focused help on plot, characters, setting, dialogue, and editing. |
| [market-researcher](#market-researcher) | Assess an opportunity with sourced evidence: market size, competitors, demand signals, and trends—so a business idea can be judged with more confidence. |
| [product-manager](#product-manager) | Decide what to build next, turn ideas into clear plans, learn from customer feedback, and prepare launches with fewer surprises. |
| [project-manager](#project-manager) | Bring a project from plan to delivery with realistic timelines, visible risks, clear ownership, and honest progress updates. |
| [slidewright](#slidewright) | Create engaging presentation slides that are clear from the back of a room and support the speaker’s message. |
| [socratic-questor](#socratic-questor) | Learn deeply through thoughtful questions that help you form your own understanding instead of simply receiving an answer. |
| [strategy-board](#strategy-board) | Examine a major business decision from several expert viewpoints, including opportunity, competition, finance, execution, and risk. |
| [system-prompt-creator](#system-prompt-creator) | Define how an AI assistant should behave, so it gives more consistent, useful responses for a specific job. |

## Explore each skill

### cv-scorer

Score candidate CVs on a 100-point scale against a Job Description.

**Skill README:** [cv-scorer](./skills/cv-scorer/README.md)

**What you get:**
- Scores CVs across 5 weighted criteria: JD Matching, Work Experience, Project & Impact, Education, CV Quality
- Detects red flags: repetitive content, inflated metrics, contradictory information
- Outputs structured JSON with per-criterion scores, highlights, red flags, and a recommendation (Recommend / Maybe / Pass)
- Supports batch processing: scores multiple CVs independently then ranks them

**Install:**
```bash
npx skills add tronghieu/agent-skills --skill cv-scorer
```

### brainstorm-coach

A brainstorming partner that puts your ideas first: every round, you go first and your idea is captured verbatim, then the AI adds clearly-labeled ideas of its own on top — never rewording or replacing what you said, and never judging an idea while you're still generating.

**Skill README:** [brainstorm-coach](./skills/brainstorm-coach/README.md)

**What you get:**
- Commit-first flow: your idea is captured first and verbatim with (user)/(AI) attribution, no judgment during divergence — even pushback becomes a question, not a verdict, until the structured critique pass later
- A library of ~20 named techniques (SCAMPER, Six Thinking Hats, reversal, thinking by analogy, question storming, role playing, "what if," and more), grouped by the kind of thinking they're good for, with the agent explaining why it picked one
- A full diverge→converge arc: open generation, then grouping and reasoned ranking, ending in Immediate/Future/Moonshots/Insights
- **Party mode:** an opt-in small panel of role-lenses (stakeholder, operator, outsider, provocateur) that builds on your ideas and replies as one labeled digest instead of a flood of separate voices
- Hands off to the rest of the skill family at the right moment — problem-solver, design-thinking, market-researcher, strategy-board, critical-thinking

**Install:**
```bash
npx skills add tronghieu/agent-skills --skill brainstorm-coach
```

### critical-thinking

Audit the reasoning of any document — memo, proposal, investment analysis, board paper, article, or your own draft — and get back what holds, what doesn't, and exactly which sentences the problems live in.

**Skill README:** [critical-thinking](./skills/critical-thinking/README.md)

**What you get:**
- Dissects a document into its reasoning skeleton — claims, evidence, unstated assumptions, logical gaps — with every finding anchored to an exact quoted sentence, never a vague accusation
- Runs a commit-first coaching loop: asks for the user's own read before revealing its audit, then shows what they caught and what they missed, so every audit doubles as deliberate practice for the user's own judgment
- Names what it can't judge instead of bluffing, and separates "the reasoning fails" from "I personally disagree" — both are labelled honestly, never blurred together
- Four modes: quick audit (minutes, top issues), deep audit (load-bearing decisions), draft review (fortifies the user's own writing before a tough audience, checks for missing go/no-go criteria), and progress review (tracks recurring blind spots and calibration over time in a persistent reasoning profile)

**Install:**
```bash
npx skills add tronghieu/agent-skills --skill critical-thinking
```

### data-scientist

Act as a rigorous, end-to-end data scientist: frame a business question as a data problem, explore and audit datasets, run defensible statistical analysis, build and validate predictive models, and turn results into decision-ready reports.

**Skill README:** [data-scientist](./skills/data-scientist/README.md)

**What you get:**
- Routes any data question through the 4-level analytics ladder (descriptive/diagnostic/predictive/prescriptive) into 6 flows: Full engagement, Explore, Inquire, Predict, Review, Communicate
- Enforces 5 non-negotiables: look at the data first, every number from executed code, baseline before complexity, every estimate carries uncertainty, leakage checklist before any model metric
- Two bundled scripts: `profile_data.py` (dataset profiling with quality warnings) and `baseline_model.py` (leak-safe dummy + linear baselines with cross-validation)
- **Review flow** acts as an expert validator of an existing analysis, notebook, or model — an adversarial pass before any conclusion ships
- Recommendations always come with quantified trade-offs; the decision goes back to the owner — no full optimization solvers, no Data Engineering/MLOps scope

**Install:**
```bash
npx skills add tronghieu/agent-skills --skill data-scientist
```

### deep-reader

Deep-read long books and papers using Adler's inspectional/analytical/syntopical method, SQ3R's Recite step, and Keshav's three-pass method for papers, with page-anchored notes as external memory.

**Skill README:** [deep-reader](./skills/deep-reader/README.md)

**What you get:**
- Reads in passes — structure first, then chapter by chapter — instead of loading the whole book into one context window
- Two modes: **overview** (inspectional pass + goal-directed summary) and **study** (full pipeline: analytical notes per chapter with Recite verification, then a hierarchical synthesis)
- Externalizes everything into a page-anchored notes workspace, so a later session answers follow-up questions by searching notes instead of re-reading the book
- Mechanically verifies every quote against its cited page to catch fabricated quotes and wrong page citations

**Install:**
```bash
npx skills add tronghieu/agent-skills --skill deep-reader
```

### design-thinking

A friendly design-thinking facilitator and thinking partner that walks you through the full Empathize→Define→Ideate→Prototype→Test loop as a multi-session project with a persistent workspace; it designs research instruments and experiments, synthesizes the real data you bring back, and keeps every user insight grounded in evidence.

**Skill README:** [design-thinking](./skills/design-thinking/README.md)

**What you get:**
- Every insight carries an [I#] tag tracing to registered evidence [S#] (interview notes, transcripts, surveys, desk sources) or is labelled `(hypothesis — needs validation)`, so simulated data never enters the evidence base
- AI designs the instruments (discussion guides, observation plans, test cards with pre-registered pass/fail thresholds), the user runs the real interviews and tests
- A Verifier runs at phase gates — insight review after Define, assumption review before Test — with findings shared openly
- Ideate fans out parallel ideator subagents with distinct lenses, then converges with Desirability/Feasibility/Viability scoring done with the user
- Persistent workspace (phase-state.md, journal.md, sources/insights/personas/hmw/ideas/prototypes/tests) with a re-entry protocol and deliberate loop-backs — plus optional composition with the market-researcher skill for heavier market questions (mentioned once if absent, fully optional)

**Install:**
```bash
npx skills add tronghieu/agent-skills --skill design-thinking
```

### diataxis-writer

Write, restructure, classify, and review documentation using the Diataxis framework.

**Skill README:** [diataxis-writer](./skills/diataxis-writer/README.md)

**What you get:**
- Classifies docs into tutorials, how-to guides, references, and explanations
- Writes and restructures docs, knowledge bases, onboarding/process docs, and product/API docs
- Reviews documentation for Diataxis fit, audience intent, task flow, and missing context
- Helps turn mixed or messy docs into clearer learning, task, information, or understanding material

**Install:**
```bash
npx skills add tronghieu/agent-skills --skill diataxis-writer
```

### fiction-studio

A complete prose-fiction writing studio, run as a team of named specialist agents, that guides an author from a bare idea to a polished manuscript.

**Skill README:** [fiction-studio](./skills/fiction-studio/README.md)

**What you get:**
- Runs a team of 10 specialists named after literary masters, led by **Homer** (orchestrator): Aristotle (plot), Fyodor (character), Tolkien (world), Scheherazade (drafting), Oscar (dialogue), Max (editing), Virginia (beta read), Borges (genre), Bloom (critique)
- Drives an end-to-end pipeline — premise → outline → characters → world → scene list → draft → dialogue → edit → beta read → revision triage → polish → package — with quality gates for genre, continuity, foreshadowing, and sensitivity
- **Writers' Room (party mode):** convenes 3-4 relevant specialists to brainstorm a premise or work through a creative fork together, then captures the decision to a file
- **Consistency QA:** a zero-dependency continuity checker (`scripts/continuity_check.py`) plus a structured `canon.json` source of truth keep a multi-session manuscript coherent
- Adapts to novel, novella, short story, or series; includes the Snowflake outline variant and matches the author's language

**Install:**
```bash
npx skills add tronghieu/agent-skills --skill fiction-studio
```

### market-researcher

Citation-disciplined desk market research: quick go/no-go market scans and modular deep dives — market sizing (TAM/SAM/SOM), competitor analysis, demand signals, and trends/macro (PESTEL).

**Skill README:** [market-researcher](./skills/market-researcher/README.md)

**What you get:**
- Every claim traces to a `[S#]` source registry (URL, publisher, dates, confidence grade) or is labelled an assumption — no uncited "the market is growing rapidly"
- Two modes: **Quick Scan** (default, one-session go/no-go brief) and **Deep Dive** (opt-in, modular lanes — sizing / competitors / demand / macro — multi-session and resumable)
- Built-in adversarial verification pass re-checks claims against their sources and recomputes every estimate's arithmetic before delivery
- **Composition contract** lets other skills (e.g. strategy-board) call it to append cited facts straight into their own workspace
- Honest boundary: desk research produces demand signals and hypothesis personas for primary research to validate — never fabricated "insights"

**Install:**
```bash
npx skills add tronghieu/agent-skills --skill market-researcher
```

### product-manager

A disciplined product-manager copilot for a living product, not a one-shot document generator: it captures opportunities as job stories, prioritizes with RICE plus sensitivity analysis, writes PRDs with story maps and testable user stories, plans OKRs, experiments, and launches with rollback criteria, and triages feedback — while refusing to invent numbers.

**Skill README:** [product-manager](./skills/product-manager/README.md)

**What you get:**
- Runs the product's operating loop end to end — opportunities → RICE prioritization → PRD → story map → OKRs → experiments → launch plan → feedback triage — inside one persistent per-product workspace
- Captures opportunities as job stories and prioritizes them with RICE scoring plus a sensitivity analysis on the inputs, so ranking never hinges on a single guessed number
- Writes PRDs with story maps and testable (Given/When/Then) user stories; plans OKRs, designs experiments with pass/fail criteria, and drafts launch plans with rollback criteria
- Refuses to invent numbers: every figure traces to a cited source, a labelled assumption with a range, or your own dated estimate
- An adversarial audit checks each PRD, prioritization, or launch plan before you're asked to act on it

**Install:**
```bash
npx skills add tronghieu/agent-skills --skill product-manager
```

### project-manager

A disciplined project-management copilot (PM/PMO) for a living project, not a one-shot timeline generator: it runs charter, planning, estimation, risk management, status reporting, and scope-change control inside a persistent per-project workspace where every status color, percent-complete, and estimate declares its evidence.

**Skill README:** [project-manager](./skills/project-manager/README.md)

**What you get:**
- Runs the delivery loop end to end — charter → schedule/WBS or backlog → ranged estimates → risk register (ROAM) → status reports → scope-change gate → stakeholder comms → retro — inside one persistent `_project/` workspace, methodology-agnostic (predictive, agile, hybrid)
- Every RAG color, percent-complete, forecast date, and estimate carries an evidence tag (`EV#`), a labelled assumption (`A#`), or `(user, <date>)` — an unlabelled status color is treated as a bug, not a summary
- Estimates are ranges, not points, checked against the project's own lessons or a reference class before they ship, with buffers as visible line items instead of padding hidden inside tasks
- Scope, date, or budget changes pass a gate — impact assessment plus a named decision authority before acceptance — and the old baseline is preserved, never overwritten
- Nine lenses named after Greek philosophers (Plato·Anchor, Aristotle·Frame, Pythagoras·Gauge, Epictetus·Watch, Diogenes·Pulse, Zeno·Gate, Socrates·Bridge, Heraclitus·Loop, Solon·Judge) switch automatically as the moment calls for them, plus a portfolio roll-up across multiple projects

**Install:**
```bash
npx skills add tronghieu/agent-skills --skill project-manager
```

### slidewright

Build interactive presentation websites — slide decks projected to a room and driven by one presenter.

**Skill README:** [slidewright](./skills/slidewright/README.md)

**What you get:**
- Two tracks: a **zero-build single HTML file** (open it in a browser, no install) or a **Vite + React + TypeScript** project — picks the right one for the job
- Scaffolds with one command; the React scaffold runs the official Vite tool and installs the **latest** React, Tailwind, Framer Motion and Lucide (no pinned versions, so each deck starts on current tooling)
- Enforces projection discipline: a typography floor so text reads from the back of a room, a required navigation slider + slide number, and presenter-only interaction (no forms, no data collection)
- Ships layout recipes (title, bullets, two-column compare, big stat, quote, full-bleed image), a speaker-notes convention, and PDF export guidance

**Install:**
```bash
npx skills add tronghieu/agent-skills --skill slidewright
```

### socratic-questor

Socratic questioning partner (Gadfly) for deep learning through dialogue.

**Skill README:** [socratic-questor](./skills/socratic-questor/README.md)

**What you get:**
- Teaches any topic by asking questions, never by explaining — the learner discovers understanding through dialogue
- Follows the Paul & Elder 6-type Socratic questioning framework: Clarification, Assumptions, Evidence, Perspectives, Implications, Meta-questions
- Adapts difficulty based on learner level (novice, intermediate, advanced) detected from response quality
- Scaffolds down when learners are stuck — simpler sub-questions and concrete analogies, never direct answers

**Install:**
```bash
npx skills add tronghieu/agent-skills --skill socratic-questor
```

### strategy-board

A C-level strategy advisory board, run as a team of named specialist agents, that takes an executive from a raw strategic question to a defended, board-ready recommendation.

**Skill README:** [strategy-board](./skills/strategy-board/README.md)

**What you get:**
- Runs a team of 8 named specialists led by **Drucker** (managing partner): Porter (markets & competition), Christensen (innovation & disruption), Graham (finance & value), Grove (execution & organization), Wack (scenarios & uncertainty), Taleb (risk & red team), Minto (synthesis & communication)
- Drives a gated engagement pipeline — brief → fact base → analysis → options → stress-test → recommendation → roadmap — with executive gates confirming the question, the direction, and the final recommendation
- **The Boardroom (party mode):** convenes 3-4 relevant members to debate a sharp question, independent takes first via parallel subagents (to kill groupthink), then cross-talk, with minutes kept
- Hard rules: no invented numbers (every figure traces to a sourced fact base or is labelled an assumption), three genuine options before any recommendation, a mandatory pre-mortem before it ships, and "strategy is choice" — every recommendation states what to stop doing

**Install:**
```bash
npx skills add tronghieu/agent-skills --skill strategy-board
```

### system-prompt-creator

Create high-quality, model-aware system prompts for any LLM (Claude, GPT, Gemini, open-source).

**Skill README:** [system-prompt-creator](./skills/system-prompt-creator/README.md)

**What you get:**
- Walks you through a structured 5-step workflow: Interview, Analyze, Structure, Draft, Review
- Applies 12 universal principles derived from the official prompting guides of Anthropic, OpenAI, and Google
- Produces model-specific optimizations (Claude XML tags, GPT-5 verbosity params, Gemini temperature settings)
- Includes domain patterns: operational playbooks, raw data preservation, confidence scoring
- Provides 7 ready-to-adapt templates for common use cases

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
