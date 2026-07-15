# Agent Skills

**Language / Ngôn ngữ / 语言:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

AI is useful for many tasks, but general advice can be inconsistent or miss important checks. These skills give your AI a clear, practical way to work, so you get more reliable answers, better decisions, and results you can use.

This collection helps with everyday work such as choosing candidates, understanding data and customers, planning products and projects, preparing presentations, learning, writing, and making important business decisions.

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
