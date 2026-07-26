# Agent Skills

**Language:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

A collection of method-driven skills for people who use AI to make decisions, run projects, analyze evidence, create documents, and produce finished work. These skills are designed for active collaborators: you provide the real context and remain responsible for the decision; the agent supplies structure, analysis, and quality checks.

## Quick start

Install the full collection:

```bash
npx skills add tronghieu/agent-skills
```

Then invoke a skill in your agent:

```text
/market-researcher Assess the market for this product idea in Vietnam.
```

Most agent tools use slash commands. Codex and ChatGPT use `$`; in those tools, replace the leading `/` with `$`.

## Choose a skill

| Your job | Start with |
|---|---|
| Generate or challenge ideas | [brainstorm-coach](./skills/brainstorm-coach/README.md), [critical-thinking](./skills/critical-thinking/README.md) |
| Diagnose a recurring problem | [problem-solver](./skills/problem-solver/README.md) |
| Understand customers or markets | [design-thinking](./skills/design-thinking/README.md), [market-researcher](./skills/market-researcher/README.md) |
| Decide what to build and deliver it | [product-manager](./skills/product-manager/README.md), [project-manager](./skills/project-manager/README.md) |
| Analyze data or long documents | [data-scientist](./skills/data-scientist/README.md), [deep-reader](./skills/deep-reader/README.md) |
| Make a high-stakes business decision | [strategy-board](./skills/strategy-board/README.md) |
| Create documentation, prompts, slides, or fiction | [diataxis-writer](./skills/diataxis-writer/README.md), [system-prompt-creator](./skills/system-prompt-creator/README.md), [slidewright](./skills/slidewright/README.md), [fiction-studio](./skills/fiction-studio/README.md) |
| Learn through guided questions | [socratic-questor](./skills/socratic-questor/README.md) |
| Compare CVs with a job description | [cv-scorer](./skills/cv-scorer/README.md) |

## Skills

### brainstorm-coach

For founders, product teams, marketers, creators, and anyone who needs to generate options before evaluating them.

```bash
npx skills add tronghieu/agent-skills --skill brainstorm-coach
```

[Read the brainstorm-coach guide](./skills/brainstorm-coach/README.md)

### critical-thinking

For decision-makers, analysts, and writers who need to inspect the claims, evidence, assumptions, and logical gaps in a document.

```bash
npx skills add tronghieu/agent-skills --skill critical-thinking
```

[Read the critical-thinking guide](./skills/critical-thinking/README.md)

### cv-scorer

For recruiters and hiring managers who want a consistent, rubric-based comparison of CVs against a job description. It supports human review; it does not make hiring decisions.

```bash
npx skills add tronghieu/agent-skills --skill cv-scorer
```

[Read the cv-scorer guide](./skills/cv-scorer/README.md)

### data-scientist

For data practitioners and decision-makers who need defensible exploration, statistical analysis, predictive baselines, or a review of an existing analysis.

```bash
npx skills add tronghieu/agent-skills --skill data-scientist
```

[Read the data-scientist guide](./skills/data-scientist/README.md)

### deep-reader

For researchers, students, analysts, and serious readers working with books, theses, papers, or other documents of roughly 50 pages or more.

```bash
npx skills add tronghieu/agent-skills --skill deep-reader
```

[Read the deep-reader guide](./skills/deep-reader/README.md)

### design-thinking

For product, design, and innovation teams that can collect real user evidence and want a disciplined path from research to tested concepts.

```bash
npx skills add tronghieu/agent-skills --skill design-thinking
```

[Read the design-thinking guide](./skills/design-thinking/README.md)

### diataxis-writer

For technical writers, documentation owners, developer advocates, and teams improving tutorials, how-to guides, references, explanations, or knowledge bases.

```bash
npx skills add tronghieu/agent-skills --skill diataxis-writer
```

[Read the diataxis-writer guide](./skills/diataxis-writer/README.md)

### fiction-studio

For authors developing prose fiction—from a first premise through outline, drafting, revision, and continuity review.

```bash
npx skills add tronghieu/agent-skills --skill fiction-studio
```

[Read the fiction-studio guide](./skills/fiction-studio/README.md)

### market-researcher

For founders, product teams, strategists, consultants, and analysts who need cited desk research on market size, competitors, demand signals, or trends.

```bash
npx skills add tronghieu/agent-skills --skill market-researcher
```

[Read the market-researcher guide](./skills/market-researcher/README.md)

### problem-solver

For operators, technical leads, and business owners who need to verify a root cause before choosing a fix.

```bash
npx skills add tronghieu/agent-skills --skill problem-solver
```

[Read the problem-solver guide](./skills/problem-solver/README.md)

### product-manager

For working product managers, product leads, and founders deciding what to build, how to measure it, and how to launch it.

```bash
npx skills add tronghieu/agent-skills --skill product-manager
```

[Read the product-manager guide](./skills/product-manager/README.md)

### project-manager

For project managers, PMOs, delivery leads, and team leads planning, tracking, de-risking, or recovering a real project.

```bash
npx skills add tronghieu/agent-skills --skill project-manager
```

[Read the project-manager guide](./skills/project-manager/README.md)

### slidewright

For speakers, educators, consultants, and founders building web-based slides for a live presentation.

```bash
npx skills add tronghieu/agent-skills --skill slidewright
```

[Read the slidewright guide](./skills/slidewright/README.md)

### socratic-questor

For learners and teachers who want to build or test understanding through a guided Socratic dialogue.

```bash
npx skills add tronghieu/agent-skills --skill socratic-questor
```

[Read the socratic-questor guide](./skills/socratic-questor/README.md)

### strategy-board

For founders, executives, and strategy leaders working through consequential choices such as market entry, investment, build-versus-buy, pricing, or transformation.

```bash
npx skills add tronghieu/agent-skills --skill strategy-board
```

[Read the strategy-board guide](./skills/strategy-board/README.md)

### system-prompt-creator

For AI product builders, developers, automation teams, and power users creating testable system prompts and custom instructions.

```bash
npx skills add tronghieu/agent-skills --skill system-prompt-creator
```

[Read the system-prompt-creator guide](./skills/system-prompt-creator/README.md)

## Manual installation

Download a skill directory or its packaged `.zip`, then copy the extracted directory to:

- Project scope: `.agents/skills/` or `.claude/skills/`
- User scope on macOS/Linux: `~/.agents/skills/` or `~/.claude/skills/`
- User scope on Windows: `%USERPROFILE%\.agents\skills\` or `%USERPROFILE%\.claude\skills\`

The exact location depends on the agent you use.

## Contributing

Contributions are welcome. To propose a change:

1. Fork the repository and create a focused branch.
2. Place each skill in `skills/<skill-name>/` with a `SKILL.md`, any required scripts or references, and user-facing README files.
3. Test the skill with representative prompts, including at least one difficult or failure case.
4. Rebuild `skills/<skill-name>.zip`.
5. Open a pull request explaining who the skill is for, when it should activate, what you tested, and any known limitations.

For substantial new skills, opening an issue first can help confirm scope and avoid overlapping work.

This repository follows the open [Agent Skills specification](https://agentskills.io). Compatibility depends on each host tool's implementation of that specification.

## License

MIT
