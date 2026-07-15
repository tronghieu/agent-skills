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
| [cv-scorer](./skills/cv-scorer/README.md) | Compare candidates fairly against a role, highlight the strongest matches, and surface concerns that deserve a closer look. |
| [critical-thinking](./skills/critical-thinking/README.md) | Check whether a proposal, report, or argument is supported by sound evidence; reveal weak assumptions before they become costly decisions. |
| [data-scientist](./skills/data-scientist/README.md) | Turn data into trustworthy answers: explain what changed, test whether a result is meaningful, and show the trade-offs behind a recommendation. |
| [deep-reader](./skills/deep-reader/README.md) | Work through long books and papers carefully, creating clear notes and dependable summaries that remain useful for later questions. |
| [design-thinking](./skills/design-thinking/README.md) | Understand people’s real needs, turn research into useful insights, and test possible solutions before committing to them. |
| [diataxis-writer](./skills/diataxis-writer/README.md) | Make help materials, guides, and knowledge bases easier to follow by giving each reader the information they need at the right moment. |
| [fiction-studio](./skills/fiction-studio/README.md) | Develop a story from a rough idea to a polished manuscript, with focused help on plot, characters, setting, dialogue, and editing. |
| [market-researcher](./skills/market-researcher/README.md) | Assess an opportunity with sourced evidence: market size, competitors, demand signals, and trends—so a business idea can be judged with more confidence. |
| [product-manager](./skills/product-manager/README.md) | Decide what to build next, turn ideas into clear plans, learn from customer feedback, and prepare launches with fewer surprises. |
| [project-manager](./skills/project-manager/README.md) | Bring a project from plan to delivery with realistic timelines, visible risks, clear ownership, and honest progress updates. |
| [slidewright](./skills/slidewright/README.md) | Create engaging presentation slides that are clear from the back of a room and support the speaker’s message. |
| [socratic-questor](./skills/socratic-questor/README.md) | Learn deeply through thoughtful questions that help you form your own understanding instead of simply receiving an answer. |
| [strategy-board](./skills/strategy-board/README.md) | Examine a major business decision from several expert viewpoints, including opportunity, competition, finance, execution, and risk. |
| [system-prompt-creator](./skills/system-prompt-creator/README.md) | Define how an AI assistant should behave, so it gives more consistent, useful responses for a specific job. |

## Explore each skill

### cv-scorer

Compare one or many CVs with a job description using the same criteria for everyone. It highlights strong matches, missing requirements, and concerns such as contradictions or inflated claims, so shortlisting is fairer and faster.

```bash
npx skills add tronghieu/agent-skills --skill cv-scorer
```

### critical-thinking

Examine a proposal, report, or argument before acting on it. It separates claims from evidence, finds assumptions and gaps in the reasoning, and points to the exact passages that need attention—helping you make a better-informed decision or strengthen a draft.

```bash
npx skills add tronghieu/agent-skills --skill critical-thinking
```

### data-scientist

Turn data into a clear answer to questions such as “what changed?”, “why did it change?”, or “what may happen next?”. It checks data quality, tests whether a result is meaningful, and explains uncertainty and trade-offs, so decisions are based on evidence rather than a persuasive-looking chart.

```bash
npx skills add tronghieu/agent-skills --skill data-scientist
```

### deep-reader

Read long books, research papers, and reports with care instead of producing a superficial summary. It builds organised notes tied to the source, checks quotations, and creates a dependable overview that you can return to later without starting again from the beginning.

```bash
npx skills add tronghieu/agent-skills --skill deep-reader
```

### design-thinking

Help you understand the people you are designing for before deciding on a solution. It supports interviews, research plans, customer insights, ideas, prototypes, and tests, while clearly distinguishing real evidence from assumptions that still need validation.

```bash
npx skills add tronghieu/agent-skills --skill design-thinking
```

### diataxis-writer

Make documentation easier to use by matching it to the reader’s need: learning something new, completing a task, looking up a fact, or understanding the bigger picture. This helps turn scattered guides and knowledge bases into clear, useful material people can actually follow.

```bash
npx skills add tronghieu/agent-skills --skill diataxis-writer
```

### fiction-studio

Support fiction writing from an early idea to a finished manuscript. It gives focused help with plot, characters, setting, scenes, dialogue, continuity, and editing, so a story stays compelling and coherent as it develops.

```bash
npx skills add tronghieu/agent-skills --skill fiction-studio
```

### market-researcher

Research a market using sources you can check: its size, competitors, demand signals, and relevant trends. It helps you judge whether an opportunity deserves further investment while making clear what is known, what is assumed, and what still needs customer research.

```bash
npx skills add tronghieu/agent-skills --skill market-researcher
```

### product-manager

Help product teams decide what to build and why. It turns customer needs and opportunities into priorities, product plans, experiments, launch plans, and feedback actions, making the reasoning behind each decision clear instead of relying on guesswork.

```bash
npx skills add tronghieu/agent-skills --skill product-manager
```

### project-manager

Keep a project moving from idea to delivery with a realistic plan, estimates, risks, owners, status updates, and controlled changes. It makes progress and problems visible early, so the team can respond before a deadline, budget, or scope gets out of hand.

```bash
npx skills add tronghieu/agent-skills --skill project-manager
```

### slidewright

Create presentation slides that support a talk instead of overwhelming the audience. It helps shape the story, choose clear layouts, and make text and visuals readable across a room, so the speaker’s key message lands.

```bash
npx skills add tronghieu/agent-skills --skill slidewright
```

### socratic-questor

Help you understand a subject by asking well-timed questions rather than simply giving answers. It adapts to your responses, uncovers gaps in understanding, and guides you to reason through the topic yourself—useful for learning that lasts.

```bash
npx skills add tronghieu/agent-skills --skill socratic-questor
```

### strategy-board

Give a major business decision the scrutiny of a well-rounded advisory team. It considers market opportunity, competition, innovation, finance, execution, scenarios, and risk, then helps you compare real options and understand the consequences of each one.

```bash
npx skills add tronghieu/agent-skills --skill strategy-board
```

### system-prompt-creator

Help you describe how an AI assistant should work for a particular job: its role, tone, inputs, limits, tools, and expected outputs. The result is a clearer set of instructions that makes the assistant more consistent and useful in day-to-day use.

```bash
npx skills add tronghieu/agent-skills --skill system-prompt-creator
```

## Installation

### Install all skills

```bash
npx skills add tronghieu/agent-skills
```

### Install one skill manually

Download that skill’s `.zip` file from the [`skills/`](./skills) folder, extract it, and copy the resulting folder to either:

- a project’s `.agents/skills/` or `.claude/skills/` folder; or
- your global `~/.agents/skills/` or `~/.claude/skills/` folder.

On Windows, use `%USERPROFILE%\.agents\skills\` or `%USERPROFILE%\.claude\skills\` for the global folder.

## Contributing

Contributions are welcome. To add or improve a skill, follow the repository’s [contribution guide](./AGENTS.md). Before opening a pull request, make sure the skill has a clear purpose, practical instructions, no sensitive information, and has been tried on realistic work.

## Open Standard

This project follows the open [Agent Skills standard](https://agentskills.io), so these skills can be used in AI tools that support the standard.

## References

- [Agent Skills standard](https://agentskills.io)
- [Claude Code Skills documentation](https://code.claude.com/docs/en/skills)
- [Anthropic Skills](https://github.com/anthropics/skills)
- [Skills CLI](https://github.com/vercel-labs/skills)
- [Skills Marketplace](https://skills.sh)

## License

MIT — use, modify, and distribute freely.
