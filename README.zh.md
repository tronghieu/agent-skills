# Agent Skills

**语言 / Language / Ngôn ngữ:** [中文](./README.zh.md) | [English](./README.md) | [Tiếng Việt](./README.vi.md)

AI 能帮助处理许多任务，但笼统的建议往往不够一致，也容易漏掉关键检查。这里的技能为 AI 提供清晰、实用的工作方法，帮助您获得更可靠的答案、更好的判断和可以直接使用的成果。

本合集覆盖日常工作中的常见问题：筛选候选人、理解数据和客户、规划产品与项目、准备演示、学习、写作，以及作出重要的商业决策。

## 如何使用技能

先选择一个技能，再用自然语言说明您需要什么。

- **Codex 和 ChatGPT：** 输入 `$`，然后选择技能。例如：`$market-researcher 请帮我评估这个商业想法。`
- **Claude、Antigravity 和 Gemini：** 输入 `/`，选择一个技能后说明您的需求。

除此以外，您不需要学习特殊命令。像平时一样提供目标，以及相关背景、文件或问题即可。

## 可用技能

| Skill | 能为您做什么 |
|---|---|
| [cv-scorer](./skills/cv-scorer/README.zh.md) | 按岗位要求公平比较候选人，找出最匹配的人选，并提示值得进一步核实的地方。 |
| [critical-thinking](./skills/critical-thinking/README.zh.md) | 检查提案、报告或论证是否有扎实证据支撑；在薄弱假设造成高代价决策前发现它们。 |
| [data-scientist](./skills/data-scientist/README.zh.md) | 将数据变成可信的答案：解释发生了什么变化，检验结果是否有意义，并说明每项建议的取舍。 |
| [deep-reader](./skills/deep-reader/README.zh.md) | 仔细阅读长篇书籍和论文，整理清晰笔记与可靠摘要，方便日后继续提问和使用。 |
| [design-thinking](./skills/design-thinking/README.zh.md) | 理解用户真正的需求，将研究转化为有用的洞察，并在投入更多资源前验证可能的解决方案。 |
| [diataxis-writer](./skills/diataxis-writer/README.zh.md) | 让帮助文档、指南和知识库更容易理解，使读者在需要时获得恰当的信息。 |
| [fiction-studio](./skills/fiction-studio/README.zh.md) | 将一个初步想法发展为打磨完成的故事稿，并为情节、人物、世界设定、对白和编辑提供针对性帮助。 |
| [market-researcher](./skills/market-researcher/README.zh.md) | 通过有来源依据的市场规模、竞争对手、需求信号和趋势评估机会，让商业想法更有把握。 |
| [product-manager](./skills/product-manager/README.zh.md) | 决定下一步该做什么，把想法变成清晰计划，从客户反馈中学习，并更从容地准备发布。 |
| [project-manager](./skills/project-manager/README.zh.md) | 用切实可行的时间安排、透明的风险、明确的责任和诚实的进度更新，推动项目从计划走向交付。 |
| [slidewright](./skills/slidewright/README.zh.md) | 制作清晰、有吸引力的演示幻灯片，让坐在房间后排的人也能看清，并帮助演讲者传达重点。 |
| [socratic-questor](./skills/socratic-questor/README.zh.md) | 通过启发式提问深入学习，帮助您自己形成理解，而不只是接收现成答案。 |
| [strategy-board](./skills/strategy-board/README.zh.md) | 从机会、竞争、财务、执行和风险等多个专业视角审视重大的商业决策。 |
| [system-prompt-creator](./skills/system-prompt-creator/README.zh.md) | 明确 AI 助手应如何工作，使它在特定任务上给出更一致、更有用的回应。 |

## 安装

### 安装全部技能

```bash
npx skills add tronghieu/agent-skills
```

### 手动安装单个技能

从 [`skills/`](./skills) 文件夹下载该技能的 `.zip` 文件，解压后将得到的文件夹复制到以下位置之一：

- 项目中的 `.agents/skills/` 或 `.claude/skills/`；或
- 全局 `~/.agents/skills/` 或 `~/.claude/skills/` 文件夹。

在 Windows 上，全局文件夹为 `%USERPROFILE%\.agents\skills\` 或 `%USERPROFILE%\.claude\skills\`。

## 贡献

欢迎贡献。若要新增或改进技能，请参阅本仓库的[贡献指南](./AGENTS.md)。提交 pull request 前，请确认技能目标明确、说明实用、不含敏感信息，并已在真实任务中试用。

## 开放标准

本项目遵循 [Agent Skills 开放标准](https://agentskills.io)，因此这些技能可用于支持该标准的 AI 工具。

## 参考资料

- [Agent Skills 标准](https://agentskills.io)
- [Claude Code Skills 文档](https://code.claude.com/docs/en/skills)
- [Anthropic Skills](https://github.com/anthropics/skills)
- [Skills CLI](https://github.com/vercel-labs/skills)
- [Skills Marketplace](https://skills.sh)

## 许可证

MIT — 可自由使用、修改和分发。
