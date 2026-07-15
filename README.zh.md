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

## 了解每个技能

### cv-scorer

使用同一套标准，将一份或多份简历与岗位要求进行比较。它会标出最匹配的经历、缺失的要求，以及信息矛盾或夸大成就等值得核实的地方，帮助您更快、更公平地筛选候选人。

```bash
npx skills add tronghieu/agent-skills --skill cv-scorer
```

### critical-thinking

在依据一份提案、报告或论证行动前，检查它是否站得住脚。它会区分观点与证据，找出假设和推理漏洞，并指出需要关注的具体段落，帮助您做出更有依据的决定，或在发出前完善草稿。

```bash
npx skills add tronghieu/agent-skills --skill critical-thinking
```

### data-scientist

将数据变成对“发生了什么变化？”“为什么会变化？”或“接下来可能发生什么？”等问题的清晰回答。它会检查数据质量、验证结果是否有意义，并说明不确定性和取舍，让决策建立在证据上，而不是一张看起来很有说服力的图表上。

```bash
npx skills add tronghieu/agent-skills --skill data-scientist
```

### deep-reader

认真阅读长篇书籍、研究论文和报告，而不是只给出浅层摘要。它会建立结构化、紧贴原文的笔记，核对引文，并形成可靠的概览，让您日后可以继续使用，不必从头再读。

```bash
npx skills add tronghieu/agent-skills --skill deep-reader
```

### design-thinking

在决定方案之前，帮助您先理解用户。它支持研究计划、访谈、洞察提炼、创意、原型和测试，并明确区分真实证据与仍需验证的假设。

```bash
npx skills add tronghieu/agent-skills --skill design-thinking
```

### diataxis-writer

根据读者的需要，让文档更容易使用：学习新知识、完成一项任务、查找事实，或理解整体背景。它帮助您把零散的指南和知识库整理成清晰、实用、真正容易跟着做的材料。

```bash
npx skills add tronghieu/agent-skills --skill diataxis-writer
```

### fiction-studio

从最初的想法到完成的稿件，支持您创作小说。它会分别帮助处理情节、人物、世界设定、场景、对白、连贯性和编辑工作，让故事在发展过程中始终引人入胜且前后一致。

```bash
npx skills add tronghieu/agent-skills --skill fiction-studio
```

### market-researcher

用可以核查的来源研究市场：市场规模、竞争对手、需求信号和相关趋势。它帮助您判断一个机会是否值得继续投入，并说明哪些内容已有事实依据、哪些只是假设、哪些仍需要客户研究。

```bash
npx skills add tronghieu/agent-skills --skill market-researcher
```

### product-manager

帮助产品团队决定该做什么，以及为什么要做。它把客户需求和机会转化为优先级、产品计划、实验、发布计划和反馈行动，让每个决定背后的理由清晰可见，而不是依靠猜测。

```bash
npx skills add tronghieu/agent-skills --skill product-manager
```

### project-manager

通过切实可行的计划、估算、风险、负责人、进度更新和变更管理，让项目从想法走向交付。它会尽早暴露进展和问题，使团队能在截止日期、预算或范围失控前及时应对。

```bash
npx skills add tronghieu/agent-skills --skill project-manager
```

### slidewright

制作能帮助演讲者传达内容、而不会让听众不堪重负的演示幻灯片。它帮助组织叙事、选择清晰的版式，并让文字和视觉内容在整个房间里都容易看清，使核心信息真正传达出去。

```bash
npx skills add tronghieu/agent-skills --skill slidewright
```

### socratic-questor

通过恰当的问题帮助您深入理解一个主题，而不只是直接给出答案。它会根据您的回应调整难度，发现理解上的空缺，并引导您自己推理，适合需要长期记住和真正理解的学习。

```bash
npx skills add tronghieu/agent-skills --skill socratic-questor
```

### strategy-board

像让一支多元化顾问团队审视问题一样，检视重大的商业决策。它会考虑市场机会、竞争、创新、财务、执行、不同情景和风险，然后帮助您比较现实的选择及每个选择带来的后果。

```bash
npx skills add tronghieu/agent-skills --skill strategy-board
```

### system-prompt-creator

帮助您为特定工作描述 AI 助手应如何运作：它的角色、语气、输入、限制、工具和预期输出。结果是一套更清晰的指令，让助手在日常使用中给出更一致、更有用的回应。

```bash
npx skills add tronghieu/agent-skills --skill system-prompt-creator
```

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
