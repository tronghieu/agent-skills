# Scrum Master

**语言：** [中文](./README.zh.md) | [English](./README.md) | [Tiếng Việt](./README.vi.md)

帮助软件团队专注地运行 sprint，尽早发现问题，并持续跟进每次 retrospective 的改进行动。

## 快速安装

```bash
npx skills add tronghieu/agent-skills --skill scrum-master
```

## 从团队的真实需求开始

用自然语言调用 `/scrum-master`。例如：

```text
/scrum-master 根据这份 backlog、团队 capacity 和最近三个 sprint 的结果，规划下一个 sprint。
/scrum-master 给我今天的 sprint pulse。哪些问题正在威胁 sprint goal？
/scrum-master 准备明天的 retrospective，并检查上次 retro 的 action 是否已经完成。
/scrum-master 这个 blocker 已经存在九天了。请起草 escalation，并说明谁需要采取行动。
```

## 为什么不用普通聊天机器人？

普通聊天可以起草 ceremony 议程，但可能忘记之前的 action，或在缺少可靠数据时判断 sprint 健康度。Scrum Master 让团队的过程历史保持可见：

- Sprint metric 必须关联 tracker、带日期的 export 或明确说明的假设。缺失的数据会保持未知，不会变成看似合理的数字。
- Retrospective action 会保持开放，直到团队完成它或明确决定关闭。
- Sprint 中增加或移除的工作会被记录为 scope change。
- 反复出现的 blocker 和流程问题会跨 sprint 比较，而不是每次都被当成新问题。
- 沟通、协商和 escalation 仍由人来完成。Skill 会起草交接内容，并记录由谁 follow up。

## 适合谁

适合 Scrum Master、engineering manager、tech lead、delivery lead、product owner，以及帮助真实软件团队按 sprint 工作的成员。当团队没有 Scrum Master 时，它可以承担主要的过程记录和提醒工作；已有 Scrum Master 时，它可以作为副驾驶。

团队仍然负责 Scrum 决策、working agreement 和人与人之间的沟通。

## 可以用它做什么

- 接手一个正在运行的团队，并连接现有 Scrum artifact。
- 根据清晰 goal、实际 capacity 和已准备好的工作规划 sprint。
- 生成简短的 sprint pulse，优先说明风险、blocker 和 scope change。
- 用稳定 snapshot 关闭 sprint，方便以后比较。
- 准备并跟进 retrospective，包括未完成的改进行动。
- 跟踪 impediment，起草 escalation，并检查存在时间和 owner。
- 扫描 sprint 历史，发现反复发生的问题和失效的 ceremony。
- 通过小而实际的流程改进来辅导团队。

## 如何保持持续工作的连贯性

对于持续工作，skill 会维护 `_project/scrum-master/` 工作区，其中包含团队背景、sprint 记录、impediment、retrospective action 和带日期的健康报告。下次会话开始时，它会先读取这个工作区，再提出建议。

你可以通过 `_project/tools.md` 连接 Jira、Linear 或 GitHub Projects 等 tracker。如果暂时无法访问 tracker，请提供带日期的 export 或摘要。Skill 仍可准备有用的草案，但会标明假设和缺失事实。

需要时，只需初始化一次工作区：

```bash
bash /mnt/skills/user/scrum-master/scripts/init-scrum.sh "<团队或项目名称>" [parent-dir]
```

## 你需要提供什么，会获得什么

请提供已有信息：sprint goal、backlog、团队 capacity、Definition of Done、tracker export、当前 blocker、近期 sprint 结果和之前的 retrospective action。开始前不必准备齐全所有资料。

根据请求，你会获得 sprint plan、pulse、close summary、retrospective pack、impediment update、escalation 草案或流程健康报告。回复会先给出结论，说明数据来源，并区分事实与假设。

## 配套技能

- [Project Manager](../project-manager/README.zh.md) — 当问题从团队流程转向交付日期、预算、项目风险或利益相关者报告时使用。
- [Product Manager](../product-manager/README.zh.md) — 当问题是做什么、为什么做或如何安排 backlog 优先级时使用。

## 限制

如果你没有提供访问权限或数据，skill 无法观察团队互动，也不知道当前 board 状态。它不会发送消息、处理人际冲突、替团队作出承诺，也不能取代人的判断。它关注 Scrum 流程健康，不负责产品战略、项目预算或交付承诺。

详细运行规则见 [SKILL.md](./SKILL.md)，各项 play 见 [`references/`](./references/)。
