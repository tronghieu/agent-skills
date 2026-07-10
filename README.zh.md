# Agent Skills

**Language / Ngôn ngữ / 语言:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

面向 AI 编程智能体的技能集合。兼容 [Claude Code](https://code.claude.com)、[Cursor](https://cursor.com)、[GitHub Copilot](https://github.com/features/copilot) 以及支持开放标准 [Agent Skills](https://agentskills.io) 的 [20+ 款 AI 工具](https://agentskills.io)。

## 可用技能

| 技能 | 功能简介 |
|------|----------|
| [cv-scorer](#cv-scorer) | 根据职位描述（JD）对候选人简历进行百分制评分 |
| [data-scientist](#data-scientist) | 担任严谨的端到端数据科学家 —— 界定问题、探索、检验、建模并传达结论 |
| [deep-reader](#deep-reader) | 使用 Adler 的方法深度阅读长篇书籍和论文，以按页码锚定的笔记作为外部记忆 |
| [design-thinking](#design-thinking) | 一位亲切的设计思维引导者，陪您走过 Empathize→Define→Ideate→Prototype→Test 这个持续进行的项目 —— 由它设计研究方案，由您执行，每条洞察都带着自己的证据 |
| [diataxis-writer](#diataxis-writer) | 使用 Diataxis 框架编写、重构、分类和审查文档 |
| [fiction-studio](#fiction-studio) | 一个完整的小说创作工作室，由一支被命名的专家智能体团队运行 |
| [market-researcher](#market-researcher) | 具备引用纪律的桌面市场调研 —— 快速 go/no-go 扫描，以及市场规模、竞品、需求、趋势的深度模块 |
| [slidewright](#slidewright) | 构建交互式演示网站 —— 投影到房间的幻灯片 |
| [socratic-questor](#socratic-questor) | 苏格拉底式问答伙伴（牛虻），通过对话实现深度学习 |
| [strategy-board](#strategy-board) | 由被命名的专家智能体运行的 C 级战略顾问委员会 —— 从原始问题到经过答辩的建议方案 |
| [system-prompt-creator](#system-prompt-creator) | 为任意 LLM 创建高质量、模型感知的系统提示词 |

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

### data-scientist

担任严谨的端到端数据科学家：把一个业务问题界定为数据问题，探索并审查数据集，进行经得起推敲的统计分析，构建并验证预测模型，并把结果转化为可供决策的报告。

**技能 README：** [data-scientist](./skills/data-scientist/README.zh.md)

**功能：**
- 通过四级分析阶梯（描述性/诊断性/预测性/指导性）将任何数据问题路由到 6 种流程：Full engagement、Explore、Inquire、Predict、Review、Communicate
- 执行 5 条不可动摇的原则：先看数据、每个数字都来自已运行的代码、先有基线再谈复杂度、每个估计值都带不确定性、相信任何模型指标前先查泄漏清单
- 两个内置脚本：`profile_data.py`（带质量警告的数据集画像）和 `baseline_model.py`（带交叉验证、防泄漏的哑基线 + 线性基线）
- **Review 流程** 扮演对现有分析、notebook 或模型的专业审阅者角色 —— 在任何结论发布前进行一轮对抗式审查
- 建议始终附带量化的取舍；决策权始终交还给负责人 —— 不做完整的优化求解器，不涉及数据工程/MLOps 范畴

**触发短语：** "分析这份数据集"、"是什么导致了这个变化？"、"这个差异有统计显著性吗？"、"A/B 测试"、"建一个模型来预测……"、"审查这份分析/notebook"、"phân tích dữ liệu"、"xây model dự đoán"、"kiểm định A/B"

**安装：**
```bash
npx skills add tronghieu/agent-skills --skill data-scientist
```

### deep-reader

使用 Adler 的检视/分析/主题阅读法、SQ3R 的 Recite 步骤，以及 Keshav 针对论文的三遍阅读法，深度阅读长篇书籍和论文，并以按页码锚定的笔记作为外部记忆。

**技能 README：** [deep-reader](./skills/deep-reader/README.zh.md)

**功能：**
- 按遍数分层阅读——先把握结构，再逐章阅读内容——而不是把整本书塞进一个上下文窗口
- 两种模式：**overview**（检视阅读 + 目标导向的摘要）和 **study**（完整流水线：逐章撰写分析笔记并配合 Recite 核实，再生成层级式综合总结）
- 把一切都外化写入按页码锚定的笔记工作区，让之后的会话能通过查笔记而不是重读全书来回答后续问题
- 机械化核对每一条引文与所引页码是否一致，揪出编造的引文和错误的页码引用

**触发短语：** "帮我读一下这本书"、"研究一下这份 PDF"、"总结这本教材"、"分析这篇论文"、"深度阅读这篇学位论文"、"tóm tắt sách"、"phân tích luận án"

**安装：**
```bash
npx skills add tronghieu/agent-skills --skill deep-reader
```

### design-thinking

一位亲切的设计思维引导者兼思考伙伴，陪您走完完整的 Empathize→Define→Ideate→Prototype→Test 循环，作为一个拥有持久化工作区的多会话项目；AI 设计研究工具和实验方案，综合您带回的真实数据，并始终让每条用户洞察都有据可依。

**技能 README：** [design-thinking](./skills/design-thinking/README.zh.md)

**功能：**
- 每条洞察都带有 [I#] 标签，可追溯到已登记的证据 [S#]（访谈记录、转录稿、调查问卷、桌面调研来源），或被标记为 `(hypothesis — needs validation)`，因此模拟数据不会进入证据库
- AI 设计研究工具（讨论指南、观察计划、带有预先设定通过/不通过阈值的测试卡），由用户执行真实的访谈和测试
- Verifier 在各阶段关口运行——Define 之后的洞察复核、Test 之前的假设复核——并公开分享发现
- Ideate 阶段并行展开多个具有不同视角的 ideator 子智能体，然后通过与用户一起完成的 Desirability/Feasibility/Viability 评分进行收敛
- 持久化工作区（phase-state.md、journal.md、sources/insights/personas/hmw/ideas/prototypes/tests）配有重新进入协议和有意为之的回退步骤——并可选择与 market-researcher 技能组合用于更重的市场问题（仅在缺失时提一次，完全可选）

**触发短语：** "run design thinking"、"understand our users"、"design user interviews"、"synthesize these interview notes"、"build personas"、"How might we…"、"design an experiment to validate…"、"tư duy thiết kế"、"nghiên cứu người dùng"、"デザイン思考 / 设计思维"

**安装：**
```bash
npx skills add tronghieu/agent-skills --skill design-thinking
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

### market-researcher

具备引用纪律的桌面市场调研（desk research）：快速 go/no-go 市场扫描，以及按模块深入的市场规模测算（TAM/SAM/SOM）、竞品分析、需求信号、趋势与宏观（PESTEL）分析 —— 适用于任意市场、任意语言。

**技能 README：** [market-researcher](./skills/market-researcher/README.zh.md)

**功能：**
- 每一条论断都可追溯到 `[S#]` 来源登记表（URL、发布方、日期、置信等级），或明确标注为假设 —— 不允许出现"市场正在快速增长"这类无引用的断言
- 两种模式：**Quick Scan**（默认，单次会话内完成的 go/no-go 简报）和 **Deep Dive**（可选，按模块分车道 —— 规模测算 / 竞品 / 需求 / 宏观 —— 支持多会话续跑）
- 内置对抗式核查环节，在交付前重新核对每条论断的来源、并重算每个估算的算术
- **组合契约（Composition contract）** 让其他技能（如 strategy-board）可以调用本技能，把带引用的事实直接追加进各自的工作区
- 诚实的边界：桌面调研产出的是需求信号与假设性用户画像，供一手调研去验证 —— 绝不编造"洞察"

**触发短语：** "帮我做市场调研"、"这个市场规模有多大"、"……的竞争对手有哪些"、"要不要做/推出/卖这个"、"验证这个商业点子"、"nghiên cứu thị trường"、"市場調査"

**安装：**
```bash
npx skills add tronghieu/agent-skills --skill market-researcher
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

### strategy-board

一个 C 级战略顾问委员会，以一支被命名的专家智能体团队的形式运行，带领高管从一个原始的战略问题走到一份经得起答辩、可提交董事会的建议方案。

**技能 README：** [strategy-board](./skills/strategy-board/README.zh.md)

**功能：**
- 运行一支由 8 位被命名的专家组成的团队，由 **Drucker**（管理合伙人）领导：Porter（市场与竞争）、Christensen（创新与颠覆）、Graham（财务与价值）、Grove（执行与组织）、Wack（情景与不确定性）、Taleb（风险与红队）、Minto（综合与沟通）
- 驱动一套设有关卡的项目推进流程 —— brief → 事实基础 → 分析 → 方案 → 压力测试 → 建议 → 路线图 —— 各关卡要求高管确认问题本身、方向和最终建议
- **Boardroom（圆桌会议模式）：** 召集 3-4 位相关成员就一个尖锐问题展开辩论，先通过并行子智能体各自独立表态（避免群体思维），再交叉讨论，并保留会议记录
- 硬性规则：不编造数字（每个数字都可追溯到有据可查的事实基础，或标注为假设）、提出建议前必须有三个真实方案、上会前必须运行事前验尸、"战略即取舍" —— 每份建议都必须说明应停止做什么

**触发短语：** "是否应该投资 / 建设 / 收购 / 进入……"、"制定战略"、"评估这个机会"、"给这份计划做压力测试"、"运行事前验尸"、"召集董事会"

**安装：**
```bash
npx skills add tronghieu/agent-skills --skill strategy-board
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

## 安装

### 1. 使用 CLI（推荐）

```bash
npx skills add tronghieu/agent-skills
```

### 2. 手动安装（适合非技术用户）

您可以下载每个技能打包好的 `.zip` 文件，并将其解压到您喜欢的位置。

1. **下载：** 转到此仓库的 `skills/` 文件夹，下载所需技能的 `.zip` 文件。
2. **解压和复制：** 解压 `.zip` 文件，并将技能文件夹复制到以下目录之一：

**针对特定项目：**
将文件夹复制到项目根目录下的 `.agents/skills/` 或 `.claude/skills/`。

**全局安装（所有项目可用）：**
* **Mac / Linux：** `~/.agents/skills/` 或 `~/.claude/skills/`
* **Windows：** `%USERPROFILE%\.agents\skills\` 或 `%USERPROFILE%\.claude\skills\`（通常为 `C:\Users\<YourUsername>`）

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
