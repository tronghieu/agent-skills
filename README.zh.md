# Agent Skills

**语言：** [中文](./README.zh.md) | [English](./README.md) | [Tiếng Việt](./README.vi.md)

这是一组面向知识工作的、以方法为核心的 AI 技能，帮助用户做决策、管理项目、分析证据、编写文档并完成实际交付。它们适合主动参与的使用者：你提供真实背景并对最终决定负责；Agent 负责提供结构、分析和质量检查。

## 快速开始

安装全部技能：

```bash
npx skills add tronghieu/agent-skills
```

然后在 Agent 中调用技能：

```text
/market-researcher 评估这个产品创意在越南的市场机会。
```

大多数 Agent 工具使用斜杠命令。Codex 和 ChatGPT 使用 `$`；在这两个工具中，请将开头的 `/` 替换为 `$`。

## 选择技能

| 你的任务 | 建议从这里开始 |
|---|---|
| 产生或挑战创意 | [brainstorm-coach](./skills/brainstorm-coach/README.zh.md)、[critical-thinking](./skills/critical-thinking/README.zh.md) |
| 诊断反复发生的问题 | [problem-solver](./skills/problem-solver/README.zh.md) |
| 理解客户或市场 | [design-thinking](./skills/design-thinking/README.zh.md)、[market-researcher](./skills/market-researcher/README.zh.md) |
| 决定做什么并按计划交付 | [product-manager](./skills/product-manager/README.zh.md)、[project-manager](./skills/project-manager/README.zh.md) |
| 运行软件 sprint 并改进团队流程 | [scrum-master](./skills/scrum-master/README.zh.md) |
| 分析数据或长文档 | [data-scientist](./skills/data-scientist/README.zh.md)、[deep-reader](./skills/deep-reader/README.zh.md) |
| 处理高影响的商业决策 | [strategy-board](./skills/strategy-board/README.zh.md) |
| 创建文档、提示词、幻灯片或小说 | [diataxis-writer](./skills/diataxis-writer/README.zh.md)、[system-prompt-creator](./skills/system-prompt-creator/README.zh.md)、[slidewright](./skills/slidewright/README.zh.md)、[fiction-studio](./skills/fiction-studio/README.zh.md) |
| 通过引导式提问学习 | [socratic-questor](./skills/socratic-questor/README.zh.md) |
| 将简历与职位描述进行比较 | [cv-scorer](./skills/cv-scorer/README.zh.md) |
| 理解自动化编码运行做了什么，或为什么卡住了 | [bmad-run-inspector](./skills/bmad-run-inspector/README.zh.md) |

## 技能列表

### bmad-run-inspector

适合正在运行 `bmad-loop`（一个自主编码编排工具）的人，需要对某次运行给出诚实的解读——无论是实时观察正在进行的运行，还是排查已完成、失败或过夜暂停的运行。仅在已经使用 `bmad-loop` 的项目中有用。

```bash
npx skills add tronghieu/agent-skills --skill bmad-run-inspector
```

[阅读 bmad-run-inspector 指南](./skills/bmad-run-inspector/README.zh.md)

### brainstorm-coach

适合创始人、产品团队、营销人员、创作者，以及任何需要先扩展选项再进行评估的人。

```bash
npx skills add tronghieu/agent-skills --skill brainstorm-coach
```

[阅读 brainstorm-coach 指南](./skills/brainstorm-coach/README.zh.md)

### critical-thinking

适合需要检查文档中的主张、证据、假设和逻辑漏洞的决策者、分析师与写作者。

```bash
npx skills add tronghieu/agent-skills --skill critical-thinking
```

[阅读 critical-thinking 指南](./skills/critical-thinking/README.zh.md)

### cv-scorer

适合希望用一致评分标准将简历与职位描述进行比较的招聘人员和招聘经理。它辅助人工审核，不代替人做招聘决定。

```bash
npx skills add tronghieu/agent-skills --skill cv-scorer
```

[阅读 cv-scorer 指南](./skills/cv-scorer/README.zh.md)

### data-scientist

适合需要进行数据探索、统计分析、预测基线或审查现有分析的数据从业者和决策者。

```bash
npx skills add tronghieu/agent-skills --skill data-scientist
```

[阅读 data-scientist 指南](./skills/data-scientist/README.zh.md)

### deep-reader

适合处理约 50 页以上书籍、论文、学位论文或其他长文档的研究者、学生、分析师和深度阅读者。

```bash
npx skills add tronghieu/agent-skills --skill deep-reader
```

[阅读 deep-reader 指南](./skills/deep-reader/README.zh.md)

### design-thinking

适合能够收集真实用户证据，并希望从研究走向经过测试的概念的产品、设计和创新团队。

```bash
npx skills add tronghieu/agent-skills --skill design-thinking
```

[阅读 design-thinking 指南](./skills/design-thinking/README.zh.md)

### diataxis-writer

适合改进教程、操作指南、参考文档、解释性文档或知识库的技术写作者、文档负责人和开发者关系团队。

```bash
npx skills add tronghieu/agent-skills --skill diataxis-writer
```

[阅读 diataxis-writer 指南](./skills/diataxis-writer/README.zh.md)

### fiction-studio

适合创作散文体小说的作者，可从最初构想到大纲、起草、修订和连续性检查一路推进。

```bash
npx skills add tronghieu/agent-skills --skill fiction-studio
```

[阅读 fiction-studio 指南](./skills/fiction-studio/README.zh.md)

### market-researcher

适合需要带引用的市场规模、竞争对手、需求信号或趋势案头研究的创始人、产品团队、战略人员、顾问和分析师。

```bash
npx skills add tronghieu/agent-skills --skill market-researcher
```

[阅读 market-researcher 指南](./skills/market-researcher/README.zh.md)

### problem-solver

适合需要在选择解决方案前验证根因的运营负责人、技术主管和业务负责人。

```bash
npx skills add tronghieu/agent-skills --skill problem-solver
```

[阅读 problem-solver 指南](./skills/problem-solver/README.zh.md)

### product-manager

适合正在决定做什么、如何衡量以及如何发布的产品经理、产品负责人和创始人。

```bash
npx skills add tronghieu/agent-skills --skill product-manager
```

[阅读 product-manager 指南](./skills/product-manager/README.zh.md)

### project-manager

适合需要规划、跟踪、降低风险或挽救真实项目的项目经理、PMO、交付负责人和团队主管。

```bash
npx skills add tronghieu/agent-skills --skill project-manager
```

[阅读 project-manager 指南](./skills/project-manager/README.zh.md)

### scrum-master

适合需要专注规划 sprint、如实了解 sprint 健康度、清楚跟踪 impediment，并持续跟进 retrospective 的 Scrum Master、engineering manager、tech lead、product owner 和软件团队。

```bash
npx skills add tronghieu/agent-skills --skill scrum-master
```

[阅读 scrum-master 指南](./skills/scrum-master/README.zh.md)

### slidewright

适合为现场演讲制作网页幻灯片的演讲者、教师、顾问和创始人。

```bash
npx skills add tronghieu/agent-skills --skill slidewright
```

[阅读 slidewright 指南](./skills/slidewright/README.zh.md)

### socratic-questor

适合希望通过苏格拉底式对话建立或检验理解的学习者和教师。

```bash
npx skills add tronghieu/agent-skills --skill socratic-questor
```

[阅读 socratic-questor 指南](./skills/socratic-questor/README.zh.md)

### strategy-board

适合处理市场进入、投资、自建或采购、定价与转型等重要选择的创始人、高管和战略负责人。

```bash
npx skills add tronghieu/agent-skills --skill strategy-board
```

[阅读 strategy-board 指南](./skills/strategy-board/README.zh.md)

### system-prompt-creator

适合需要创建清晰、一致且可测试的系统提示词或自定义指令的 AI 产品开发者、工程师、自动化团队和高级用户。

```bash
npx skills add tronghieu/agent-skills --skill system-prompt-creator
```

[阅读 system-prompt-creator 指南](./skills/system-prompt-creator/README.zh.md)

## 手动安装

下载技能目录或打包好的 `.zip`，解压后将目录复制到：

- 项目范围：`.agents/skills/` 或 `.claude/skills/`
- macOS/Linux 用户范围：`~/.agents/skills/` 或 `~/.claude/skills/`
- Windows 用户范围：`%USERPROFILE%\.agents\skills\` 或 `%USERPROFILE%\.claude\skills\`

准确位置取决于你使用的 Agent。

## 贡献

欢迎贡献。若要提出更改：

1. Fork 仓库并创建范围明确的分支。
2. 将每个技能放在 `skills/<技能名称>/` 中，包含 `SKILL.md`、所需脚本或参考资料，以及面向用户的 README。
3. 使用有代表性的提示测试技能，其中至少包含一个困难或失败场景。
4. 重新打包 `skills/<技能名称>.zip`。
5. 提交拉取请求，说明技能适合谁、何时应触发、进行了哪些测试，以及已知限制。

对于范围较大的新技能，建议先创建 issue，以确认范围并避免重复工作。

本仓库遵循开放的 [Agent Skills 规范](https://agentskills.io)。兼容性取决于各宿主工具对该规范的实现。

## 许可证

MIT
