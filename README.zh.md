# Agent Skills

**Language / Ngôn ngữ / 语言:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

面向 AI 编程智能体的技能集合。兼容 [Claude Code](https://code.claude.com)、[Cursor](https://cursor.com)、[GitHub Copilot](https://github.com/features/copilot) 以及支持开放标准 [Agent Skills](https://agentskills.io) 的 [20+ 款 AI 工具](https://agentskills.io)。

## 可用技能

### cv-scorer

根据职位描述（JD）对候选人简历进行百分制评分。

**技能 README：** [cv-scorer](./skills/cv-scorer/README.zh.md)

**功能：**
- 按 5 项加权标准对简历评分：JD 匹配度、工作经验、项目与影响力、教育背景、简历质量
- 检测红旗警告：重复内容、数据虚报、信息矛盾
- 输出结构化 JSON，包含各项得分、亮点、红旗及推荐意见（推荐 / 待定 / 淘汰）
- 支持批量处理：独立评分多份简历后进行排名

**触发短语：** "审阅简历"、"筛选候选人"、"给简历打分"、"评估候选人"、"候选人短名单"、"简历与JD匹配"

**安装：**
```bash
npx skills add tronghieu/agent-skills --skill cv-scorer
```

### system-prompt-creator

为任意 LLM（Claude、GPT、Gemini、开源模型）创建高质量、模型感知的系统提示词。

**技能 README：** [system-prompt-creator](./skills/system-prompt-creator/README.zh.md)

**功能：**
- 引导完成结构化五步工作流：访谈、分析、结构化、起草、审查
- 应用源自 Anthropic、OpenAI 和 Google 官方提示工程指南的 12 条通用原则
- 生成模型专属优化（Claude XML 标签、GPT-5 详细度参数、Gemini 温度设置）
- 包含领域模式：操作手册、原始数据保留、置信度评分
- 提供 7 个可直接定制的常见场景模板

**触发短语：** "创建系统提示词"、"编写系统指令"、"提示工程"、"构建聊天机器人提示词"、"设计智能体提示词"

**安装：**
```bash
npx skills add tronghieu/agent-skills --skill system-prompt-creator
```

### socratic-questor

苏格拉底式问答伙伴（牛虻），通过对话实现深度学习。

**技能 README：** [socratic-questor](./skills/socratic-questor/README.zh.md)

**功能：**
- 通过提问而非讲解来教授任意主题 — 学习者在对话中自己发现理解
- 遵循 Paul & Elder 6 种苏格拉底提问框架：澄清、假设、证据、视角、含义、元问题
- 根据学习者的回答质量自动检测并适应其水平（初学者、中级、高级）
- 遇到困难时降级支持 — 更简单的子问题和具体类比，绝不直接给出答案
- 自动匹配学习者的语言

**触发短语：** "教我关于..."、"帮我理解..."、"问我关于..."、"测验我"、"苏格拉底方法"、"Gadfly"

**安装：**
```bash
npx skills add tronghieu/agent-skills --skill socratic-questor
```

### fiction-studio

一个完整的小说创作工作室，以一支被命名的专家智能体团队的形式运行，引导作者从一个粗略的想法走到打磨完成的书稿。

**技能 README：** [fiction-studio](./skills/fiction-studio/README.zh.md)

**功能：**
- 运行一支以文学大师命名的 10 人专家团队，由 **Homer**（编排者）统领：Aristotle（情节）、Fyodor（人物）、Tolkien（世界观）、Scheherazade（起草）、Oscar（对白）、Max（编辑）、Virginia（试读）、Borges（类型）、Bloom（评论）
- 驱动一条端到端流程 — 前提 → 大纲 → 人物 → 世界观 → 场景列表 → 草稿 → 对白 → 编辑 → 试读 → 修订分类 → 润色 → 打包 — 并设有类型、连续性、铺垫呼应与敏感度的质量关卡
- **编剧室（party mode）：** 召集 3-4 位相关专家共同头脑风暴前提或攻克一个创作岔路口，然后把决定记录到文件
- **一致性 QA：** 一个零依赖的连续性检查器（`scripts/continuity_check.py`）加上结构化的 `canon.json` 事实源，让跨多次会话的书稿保持连贯
- 适配长篇、中篇、短篇或系列；包含 Snowflake 大纲变体，并自动匹配作者的语言

**触发短语：** "帮我写一部小说"、"我有一个故事的想法"、"发展我的人物"、"为我的奇幻构建世界"、"列出我的情节大纲"、"修改这个场景"、"我的对白太平淡"、"给我试读读者式的反馈"

**安装：**
```bash
npx skills add tronghieu/agent-skills --skill fiction-studio
```

### slidewright

构建交互式演示网站 —— 投影到房间、由单个演讲者操控的幻灯片。

**技能 README：** [slidewright](./skills/slidewright/README.zh.md)

**技能功能：**
- 两条路线：**无需构建的单个 HTML 文件**（浏览器打开即用，无需安装）或 **Vite + React + TypeScript** 项目 —— 自动为任务选择合适的路线
- 一条命令完成脚手架；React 版本调用官方 Vite 工具并安装**最新**的 React、Tailwind、Framer Motion 与 Lucide（不锁定版本，使每个 deck 都从当前工具链起步）
- 强制投影纪律：字号下限确保从房间后排也能看清、必须有导航滑条 + 幻灯片编号、交互仅限演讲者（无表单、不收集数据）
- 附带版式配方（标题、要点、双栏对比、大数字、引言、全幅图片）、演讲者备注约定，以及导出 PDF 指南

**触发短语：** "构建演示文稿"、"做一套幻灯片"、"交互式演示网站"、"dựng deck / làm slide / bài thuyết trình"、"给我的 deck 加一页"、"把幻灯片导出为 PDF"

**安装：**
```bash
npx skills add tronghieu/agent-skills --skill slidewright
```

### diataxis-writer

使用 Diataxis 框架编写、重构、分类和审查文档。

**技能 README：** [diataxis-writer](./skills/diataxis-writer/README.zh.md)

**功能：**
- 将文档分类为教程、操作指南、参考资料和解释说明
- 编写和重构 docs、知识库、入职/流程文档，以及产品/API 文档
- 按 Diataxis 匹配度、读者意图、任务流程和缺失上下文审查文档
- 帮助把混杂或混乱的文档整理成更清晰的学习、任务、信息或理解材料

**触发短语：** "使用 Diataxis"、"给这篇文档分类"、"重构文档"、"审查这些 docs"、"写一篇操作指南"、"创建 API 参考文档"、"改进入职文档"、"整理知识库"

**安装：**
```bash
npx skills add tronghieu/agent-skills --skill diataxis-writer
```

## 安装

```bash
# 使用 skills CLI（推荐）
npx skills add tronghieu/agent-skills

# 或手动安装到 Claude Code
cp -r skills/cv-scorer ~/.claude/skills/
cp -r skills/system-prompt-creator ~/.claude/skills/
cp -r skills/socratic-questor ~/.claude/skills/
cp -r skills/fiction-studio ~/.claude/skills/
cp -r skills/slidewright ~/.claude/skills/
cp -r skills/diataxis-writer ~/.claude/skills/
```

## 技能结构

```
skills/
  cv-scorer/
    SKILL.md                    # 核心技能（工作流 + 评分标准）
    references/
      scoring-rubric.md         # 5 项标准详细评分指南
      output-format.md          # JSON 输出模板（单份简历 + 批量）
  system-prompt-creator/
    SKILL.md                    # 核心技能（工作流 + 12 项原则）
    references/
      principles.md             # 含示例的详细原则说明
      model-specific.md         # Claude / GPT-5 / Gemini 使用技巧
      templates.md              # 7 个模板（聊天机器人、智能体、提取器等）
  socratic-questor/
    SKILL.md                    # 核心技能（牛虻角色 + 工作流）
    references/
      questioning-framework.md  # Paul & Elder 6 类框架 + 自适应策略
  fiction-studio/
    SKILL.md                    # 核心技能（10 人智能体团队 + 流程 + 编剧室）
    references/                 # agents/、workflow、craft、genres、qa、party-mode
    templates/                  # premise、outline、character、world-bible、canon.json 等
    checklists/                 # plot-structure、continuity、foreshadowing、sensitivity 等
    scripts/
      continuity_check.py       # 零依赖一致性检查器
  slidewright/
    SKILL.md                    # 核心技能（投影思维模型 + 工作流 + 路线选择）
    references/
      design-system.md          # 字号下限、版式配方、动效、配色
      html-track.md             # 无需构建的单文件 HTML deck
      react-track.md            # Vite + React（Deck/Slide/slides）架构
      export-pdf.md             # 导出 PDF + 演讲者备注约定
    scripts/
      new-html-deck.sh          # 生成无需构建的 HTML deck
      new-react-deck.sh         # 生成 Vite + React deck（最新依赖，不锁版本）
      export-deck-pdf.py        # 导出内容完整的 PDF（等待渲染、展开隐藏内容）
  diataxis-writer/
    SKILL.md                    # 核心技能（Diataxis 写作、分类、重构、审查）
    README.md                   # 英文技能 README
    README.vi.md                # 越南语技能 README
    README.zh.md                # 中文技能 README
    references/
      diataxis-patterns.md      # Diataxis 模式、诊断和示例
    scripts/
      classify-doc.sh           # 按 Diataxis 类型分类文档
    evals/
      evals.json                # 评估用例
```

## 贡献

我们欢迎社区贡献！本项目遵循开放的 [Agent Skills 标准](https://agentskills.io)，兼容 30+ 款 AI 编程工具。

### 如何贡献

1. **Fork** 本仓库
2. **创建技能**，遵循以下结构
3. **测试**你的技能，至少使用 2-3 个真实提示词
4. **提交 PR**，清晰描述技能的功能及触发时机

### 创建新技能

```bash
# 初始化新技能脚手架
mkdir -p skills/your-skill-name/references

# 创建必需的 SKILL.md
cat > skills/your-skill-name/SKILL.md << 'EOF'
---
name: your-skill-name
description: 功能 + 触发时机 + 相关关键词
---

# 你的技能名称

技能激活时给智能体的指令。
EOF
```

完整的技能创建指南请参阅 [AGENTS.md](./AGENTS.md)，包括目录结构、命名规范、SKILL.md 格式及打包说明。

### 技能质量清单

提交 PR 前，请确认你的技能：

- [ ] `SKILL.md` 的 frontmatter 中包含 `name` 和 `description`
- [ ] 描述清楚说明**何时**触发（而非仅描述功能）
- [ ] 指令清晰、可执行，并解释规则背后的*原因*
- [ ] 在格式/准确性重要的地方包含示例
- [ ] `SKILL.md` 保持在 500 行以内（详细文档放入 `references/`）
- [ ] 不包含密钥、凭据或敏感数据
- [ ] 已使用真实提示词测试

### 贡献方向

- 特定领域的新技能模板（DevOps、数据科学、移动端等）
- 将现有技能翻译为非英语工作流
- 基于实际使用经验改进现有技能
- 问题修复与文档更新

## 开放标准

本项目基于 [Agent Skills 开放标准](https://agentskills.io) 构建，最初由 Anthropic 开发，现已被 30+ 个 AI 平台采用，包括 Claude Code、Cursor、GitHub Copilot、Codex、Gemini CLI 等。

你在此处创建的技能可在所有支持该标准的平台上使用，无供应商锁定。

| 平台 | 支持情况 |
|------|----------|
| Claude Code | 原生支持 |
| Cursor | 原生支持 |
| GitHub Copilot | 原生支持 |
| Codex (OpenAI) | 原生支持 |
| Gemini CLI | 原生支持 |
| Windsurf, Cline, Roo Code, ... | 原生支持 |

完整列表请访问 [agentskills.io](https://agentskills.io)。

## 参考资料

| 资源 | 链接 |
|------|------|
| Agent Skills 标准 | https://agentskills.io |
| Claude Code Skills 文档 | https://code.claude.com/docs/en/skills |
| Anthropic Skills（官方） | https://github.com/anthropics/skills |
| Skills CLI (Vercel) | https://github.com/vercel-labs/skills |
| Skills 市场 | https://skills.sh |

## 许可证

MIT — 可自由使用、修改和分发。
