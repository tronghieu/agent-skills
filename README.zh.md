# Agent Skills

**语言 / Language / Ngôn ngữ：** [中文](./README.zh.md) | [English](./README.md) | [Tiếng Việt](./README.vi.md)

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
| [brainstorm-coach](#brainstorm-coach) | 为名字、campaign、功能，或任何让你卡住的决定生成真正属于你的想法——你的想法始终排在最前面，AI 只是添砖加瓦，绝不接管。 |
| [critical-thinking](#critical-thinking) | 检查提案、报告或论证是否有扎实证据支撑；在薄弱假设造成高代价决策前发现它们。 |
| [cv-scorer](#cv-scorer) | 按岗位要求公平比较候选人，找出最匹配的人选，并提示值得进一步核实的地方。 |
| [data-scientist](#data-scientist) | 将数据变成可信的答案：解释发生了什么变化，检验结果是否有意义，并说明每项建议的取舍。 |
| [deep-reader](#deep-reader) | 仔细阅读长篇书籍和论文，整理清晰笔记与可靠摘要，方便日后继续提问和使用。 |
| [design-thinking](#design-thinking) | 理解用户真正的需求，将研究转化为有用的洞察，并在投入更多资源前验证可能的解决方案。 |
| [diataxis-writer](#diataxis-writer) | 让帮助文档、指南和知识库更容易理解，使读者在需要时获得恰当的信息。 |
| [fiction-studio](#fiction-studio) | 将一个初步想法发展为打磨完成的故事稿，并为情节、人物、世界设定、对白和编辑提供针对性帮助。 |
| [market-researcher](#market-researcher) | 通过有来源依据的市场规模、竞争对手、需求信号和趋势评估机会，让商业想法更有把握。 |
| [problem-solver](#problem-solver) | 在动手修复之前，先帮你找到问题真正的原因——问对问题，先检查最省事的猜测，并把过程记下来，方便你下次接着做。 |
| [product-manager](#product-manager) | 决定下一步该做什么，把想法变成清晰计划，从客户反馈中学习，并更从容地准备发布。 |
| [project-manager](#project-manager) | 用切实可行的时间安排、透明的风险、明确的责任和诚实的进度更新，推动项目从计划走向交付。 |
| [slidewright](#slidewright) | 制作清晰、有吸引力的演示幻灯片，让坐在房间后排的人也能看清，并帮助演讲者传达重点。 |
| [socratic-questor](#socratic-questor) | 通过启发式提问深入学习，帮助您自己形成理解，而不只是接收现成答案。 |
| [strategy-board](#strategy-board) | 从机会、竞争、财务、执行和风险等多个专业视角审视重大的商业决策。 |
| [system-prompt-creator](#system-prompt-creator) | 明确 AI 助手应如何工作，使它在特定任务上给出更一致、更有用的回应。 |

## 了解每个技能

### brainstorm-coach

一个始终让你的想法排在最前面的头脑风暴伙伴：每一轮都由你先说，你的想法会被原原本本记下来，然后 AI 才加上自己清楚标注的想法——绝不改写或替代你说的话，也绝不在你还在生成想法的阶段评判任何一个想法。

**技能 README：** [brainstorm-coach](./skills/brainstorm-coach/README.zh.md)

**您将获得：**
- Commit-first 流程：你的想法总是先被原原本本记下来，并带有 (user)/(AI) 清楚标注，发散阶段不做任何评判——就连反对意见也会变成一个问题而不是定论，直到后面有结构的批评环节
- 一个约 20 种有名字的方法库（SCAMPER、六顶思考帽、逆向思维、类比思维、question storming、角色扮演、"假如"等），按适合的思维方式分组，agent 会解释为什么选择某个方法
- 一条完整的发散→收拢弧线：先自由生成想法，再归类并给出有理由的排序，最后落在"立即可做/未来发展/大胆设想/洞察"四类
- **Party 模式：** 一个可选的小型多视角评审团（利益相关者、执行者、局外人、挑衅者），在你的想法基础上添砖加瓦，并以一份标注清楚的摘要统一回复，而不是七嘴八舌
- 在合适的时机交棒给系列中的其他 Skill —— problem-solver、design-thinking、market-researcher、strategy-board、critical-thinking

**安装：**
```bash
npx skills add tronghieu/agent-skills --skill brainstorm-coach
```

### critical-thinking

审查任意文件——备忘录、提案、投资分析、董事会文件、文章，或你自己的草稿——的论证逻辑，告诉你哪些站得住、哪些站不住，以及问题具体出在哪一句话里。

**技能 README：** [critical-thinking](./skills/critical-thinking/README.zh.md)

**您将获得：**
- 将文件拆解为其论证骨架——论点、证据、未言明的假设、逻辑漏洞——每个发现都精确对应一句原文引用，绝不含糊指控
- 运行"先表态再揭晓"的教练式循环：先请用户说出自己的判断，再揭示审查结果，并展示用户自己发现了什么、漏掉了什么，让每次审查同时成为一次判断力训练
- 遇到自己判断不了的地方会如实说明，而不是靠猜；并把"论证站不住"和"我个人不认同"区分开，两者都会被如实标注，绝不混为一谈
- 四种模式：快速审查（几分钟内给出最主要问题）、深度审查（面向重大决策）、草稿审阅（在发给挑剔读者之前加固用户自己的论证，检查是否缺少继续/停止的决策标准）、思维进度回顾（在持久化的思维档案中追踪反复出现的盲点及判断把握的准确度）

**安装：**
```bash
npx skills add tronghieu/agent-skills --skill critical-thinking
```

### cv-scorer

根据职位描述（JD）对候选人简历进行百分制评分。

**技能 README：** [cv-scorer](./skills/cv-scorer/README.zh.md)

**您将获得：**
- 按 5 项加权标准对简历评分：JD 匹配度、工作经验、项目与影响力、教育背景、简历质量
- 检测红旗警告：重复内容、数据虚报、信息矛盾
- 输出结构化 JSON，包含各项得分、亮点、红旗及推荐意见（推荐 / 待定 / 淘汰）
- 支持批量处理：独立评分多份简历后进行排名

**安装：**
```bash
npx skills add tronghieu/agent-skills --skill cv-scorer
```

### data-scientist

担任严谨的端到端数据科学家：把一个业务问题界定为数据问题，探索并审查数据集，进行经得起推敲的统计分析，构建并验证预测模型，并把结果转化为可供决策的报告。

**技能 README：** [data-scientist](./skills/data-scientist/README.zh.md)

**您将获得：**
- 通过四级分析阶梯（描述性/诊断性/预测性/指导性）将任何数据问题路由到 6 种流程：Full engagement、Explore、Inquire、Predict、Review、Communicate
- 执行 5 条不可动摇的原则：先看数据、每个数字都来自已运行的代码、先有基线再谈复杂度、每个估计值都带不确定性、相信任何模型指标前先查泄漏清单
- 两个内置脚本：`profile_data.py`（带质量警告的数据集画像）和 `baseline_model.py`（带交叉验证、防泄漏的哑基线 + 线性基线）
- **Review 流程** 扮演对现有分析、notebook 或模型的专业审阅者角色 —— 在任何结论发布前进行一轮对抗式审查
- 建议始终附带量化的取舍；决策权始终交还给负责人 —— 不做完整的优化求解器，不涉及数据工程/MLOps 范畴

**安装：**
```bash
npx skills add tronghieu/agent-skills --skill data-scientist
```

### deep-reader

使用 Adler 的检视/分析/主题阅读法、SQ3R 的 Recite 步骤，以及 Keshav 针对论文的三遍阅读法，深度阅读长篇书籍和论文，并以按页码锚定的笔记作为外部记忆。

**技能 README：** [deep-reader](./skills/deep-reader/README.zh.md)

**您将获得：**
- 按遍数分层阅读——先把握结构，再逐章阅读内容——而不是把整本书塞进一个上下文窗口
- 两种模式：**overview**（检视阅读 + 目标导向的摘要）和 **study**（完整流水线：逐章撰写分析笔记并配合 Recite 核实，再生成层级式综合总结）
- 把一切都外化写入按页码锚定的笔记工作区，让之后的会话能通过查笔记而不是重读全书来回答后续问题
- 机械化核对每一条引文与所引页码是否一致，揪出编造的引文和错误的页码引用

**安装：**
```bash
npx skills add tronghieu/agent-skills --skill deep-reader
```

### design-thinking

一位亲切的设计思维引导者兼思考伙伴，陪您走完完整的 Empathize→Define→Ideate→Prototype→Test 循环，作为一个拥有持久化工作区的多会话项目；AI 设计研究工具和实验方案，综合您带回的真实数据，并始终让每条用户洞察都有据可依。

**技能 README：** [design-thinking](./skills/design-thinking/README.zh.md)

**您将获得：**
- 每条洞察都带有 [I#] 标签，可追溯到已登记的证据 [S#]（访谈记录、转录稿、调查问卷、桌面调研来源），或被标记为 `(hypothesis — needs validation)`，因此模拟数据不会进入证据库
- AI 设计研究工具（讨论指南、观察计划、带有预先设定通过/不通过阈值的测试卡），由用户执行真实的访谈和测试
- Verifier 在各阶段关口运行——Define 之后的洞察复核、Test 之前的假设复核——并公开分享发现
- Ideate 阶段并行展开多个具有不同视角的 ideator 子智能体，然后通过与用户一起完成的 Desirability/Feasibility/Viability 评分进行收敛
- 持久化工作区（phase-state.md、journal.md、sources/insights/personas/hmw/ideas/prototypes/tests）配有重新进入协议和有意为之的回退步骤——并可选择与 market-researcher 技能组合用于更重的市场问题（仅在缺失时提一次，完全可选）

**安装：**
```bash
npx skills add tronghieu/agent-skills --skill design-thinking
```

### diataxis-writer

使用 Diataxis 框架编写、重构、分类和审查文档。

**技能 README：** [diataxis-writer](./skills/diataxis-writer/README.zh.md)

**您将获得：**
- 将文档分类为教程、操作指南、参考资料和解释说明
- 编写和重构 docs、知识库、入职/流程文档，以及产品/API 文档
- 按 Diataxis 匹配度、读者意图、任务流程和缺失上下文审查文档
- 帮助把混杂或混乱的文档整理成更清晰的学习、任务、信息或理解材料

**安装：**
```bash
npx skills add tronghieu/agent-skills --skill diataxis-writer
```

### fiction-studio

一个完整的小说创作工作室，以一支被命名的专家智能体团队的形式运行，引导作者从一个粗略的想法走到打磨完成的书稿。

**技能 README：** [fiction-studio](./skills/fiction-studio/README.zh.md)

**您将获得：**
- 运行一支以文学大师命名的 10 人专家团队，由 **Homer**（编排者）统领：Aristotle（情节）、Fyodor（人物）、Tolkien（世界观）、Scheherazade（起草）、Oscar（对白）、Max（编辑）、Virginia（试读）、Borges（类型）、Bloom（评论）
- 驱动一条端到端流程 — 前提 → 大纲 → 人物 → 世界观 → 场景列表 → 草稿 → 对白 → 编辑 → 试读 → 修订分类 → 润色 → 打包 — 并设有类型、连续性、铺垫呼应与敏感度的质量关卡
- **编剧室（party mode）：** 召集 3-4 位相关专家共同头脑风暴前提或攻克一个创作岔路口，然后把决定记录到文件
- **一致性 QA：** 一个零依赖的连续性检查器（`scripts/continuity_check.py`）加上结构化的 `canon.json` 事实源，让跨多次会话的书稿保持连贯
- 适配长篇、中篇、短篇或系列；包含 Snowflake 大纲变体，并自动匹配作者的语言

**安装：**
```bash
npx skills add tronghieu/agent-skills --skill fiction-studio
```

### market-researcher

具备引用纪律的桌面市场调研（desk research）：快速 go/no-go 市场扫描，以及按模块深入的市场规模测算（TAM/SAM/SOM）、竞品分析、需求信号、趋势与宏观（PESTEL）分析 —— 适用于任意市场。

**技能 README：** [market-researcher](./skills/market-researcher/README.zh.md)

**您将获得：**
- 每一条论断都可追溯到 `[S#]` 来源登记表（URL、发布方、日期、置信等级），或明确标注为假设 —— 不允许出现"市场正在快速增长"这类无引用的断言
- 两种模式：**Quick Scan**（默认，单次会话内完成的 go/no-go 简报）和 **Deep Dive**（可选，按模块分车道 —— 规模测算 / 竞品 / 需求 / 宏观 —— 支持多会话续跑）
- 内置对抗式核查环节，在交付前重新核对每条论断的来源、并重算每个估算的算术
- **组合契约（Composition contract）** 让其他技能（如 strategy-board）可以调用本技能，把带引用的事实直接追加进各自的工作区
- 诚实的边界：桌面调研产出的是需求信号与假设性用户画像，供一手调研去验证 —— 绝不编造"洞察"

**安装：**
```bash
npx skills add tronghieu/agent-skills --skill market-researcher
```

### problem-solver

一个按部就班帮你解决问题的伙伴：在给出任何修复建议之前，它会先帮你弄清楚到底发生了什么，排除错误的解释，确认真正的原因——靠简单的提问和便宜的核实，而不是一个听起来很笃定的猜测。

**技能 README：** [problem-solver](./skills/problem-solver/README.zh.md)

**您将获得：**
- 从不编造关于你情况的事实——它当作真的东西，要么是你自己说的，要么会被清楚标注为"还只是个猜测"，让你随时知道哪些已经确认、哪些还没有
- 根据问题的样子选择合适的追查方式——单一症状就一路问"为什么"追下去，找不到明显链条就把可能的原因都列出来看一遍，反复发作、怎么修都不管用就细看重复出现的规律
- 在真正的核实分出胜负之前，会同时保留不止一种可能的解释，而不是一上来就认定第一个听起来合理的猜测
- 一步步走完整个过程——弄清问题、划定范围、找出原因、想出修复办法、做出选择、规划上线——每一步都会先跟你确认再往下走，原因确认之后再请 **brainstorm-coach** 帮你想出真正多样的修复点子
- 会记住你上次进行到哪里，所以如果某次核实需要真实的时间（比如做一次小规模试验，或者观察一周的数据），你可以之后再回来，从停下的地方接着做

**安装：**
```bash
npx skills add tronghieu/agent-skills --skill problem-solver
```

### product-manager

一个面向持续演进产品的严谨 PM copilot，而非一次性的文档生成器：它把机会点记录为 job story，用 RICE 加敏感性分析（sensitivity analysis）排优先级，用 story map 和可验证的用户故事撰写 PRD，规划 OKR、实验与带回滚（rollback）标准的发布计划，并对反馈进行分诊（triage）——同时拒绝编造数字。

**技能 README：** [product-manager](./skills/product-manager/README.zh.md)

**您将获得：**
- 端到端运行产品的操作闭环 —— 机会点 → RICE 优先级排序 → PRD → story map → OKR → 实验 → 发布计划 → 反馈分诊 —— 全部置于一个持久化的单产品工作区中
- 把机会点记录为 job story，并用 RICE 评分加输入项的敏感性分析来排优先级，让排名不取决于单一凭空猜测的数字
- 用 story map 和可验证（Given/When/Then）的用户故事撰写 PRD；规划 OKR，设计带通过/不通过标准的实验，起草带回滚标准的发布计划
- 拒绝编造数字：每个数字都可追溯到一个已引用的来源、一个标注了区间的假设，或你自己给出的带日期的估计值
- 一轮对抗式审查会在你被要求据此行动之前，核查每份 PRD、优先级排序或发布计划

**安装：**
```bash
npx skills add tronghieu/agent-skills --skill product-manager
```

### project-manager

一个面向持续演进项目的严谨 PM/PMO copilot，而非一次性的时间线生成器：它把章程、计划、估算、风险管理、进度报告与范围变更控制，全部置于一个持久化的单项目工作区中，且每个状态颜色、完成百分比和估算都注明证据。

**技能 README：** [project-manager](./skills/project-manager/README.zh.md)

**您将获得：**
- 端到端运行交付闭环 —— 章程 → 进度表/WBS 或待办列表 → 区间估算 → 风险登记册（ROAM）→ 进度报告 → 范围变更控制关卡 → 干系人沟通 → 复盘 —— 全部置于一个持久化的 `_project/` 工作区中，不绑定特定方法论（预测型、敏捷、混合型）
- 每个 RAG 状态颜色、完成百分比、预测日期和估算都带有证据标签（`EV#`）、已标注的假设（`A#`）或 `(user, 日期)` —— 没有标签的状态颜色被视为一个缺陷，而非一份摘要
- 估算始终是区间而非单一数值，在给出之前会对照项目自身的经验教训或参考类别进行核查，缓冲时间是可见的独立条目，而非藏在任务里的水分
- 范围、日期或预算的变更必须通过关卡 —— 先做影响评估，再交由指定的决策者拍板 —— 且旧的基线始终保留，绝不被覆盖
- 九个以希腊哲学家命名的视角（Plato·Anchor、Aristotle·Frame、Pythagoras·Gauge、Epictetus·Watch、Diogenes·Pulse、Zeno·Gate、Socrates·Bridge、Heraclitus·Loop、Solon·Judge）会根据当下场景自动切换，另外还支持跨多个项目的组合（portfolio）汇总

**安装：**
```bash
npx skills add tronghieu/agent-skills --skill project-manager
```

### slidewright

构建交互式演示网站 —— 投影到房间、由单个演讲者操控的幻灯片。

**技能 README：** [slidewright](./skills/slidewright/README.zh.md)

**您将获得：**
- 两条路线：**无需构建的单个 HTML 文件**（浏览器打开即用，无需安装）或 **Vite + React + TypeScript** 项目 —— 自动为任务选择合适的路线
- 一条命令完成脚手架；React 版本调用官方 Vite 工具并安装**最新**的 React、Tailwind、Framer Motion 与 Lucide（不锁定版本，使每个 deck 都从当前工具链起步）
- 强制投影纪律：字号下限确保从房间后排也能看清、必须有导航滑条 + 幻灯片编号、交互仅限演讲者（无表单、不收集数据）
- 附带版式配方（标题、要点、双栏对比、大数字、引言、全幅图片）、演讲者备注约定，以及导出 PDF 指南

**安装：**
```bash
npx skills add tronghieu/agent-skills --skill slidewright
```

### socratic-questor

苏格拉底式问答伙伴（牛虻），通过对话实现深度学习。

**技能 README：** [socratic-questor](./skills/socratic-questor/README.zh.md)

**您将获得：**
- 通过提问而非讲解来教授任意主题 — 学习者在对话中自己发现理解
- 遵循 Paul & Elder 6 种苏格拉底提问框架：澄清、假设、证据、视角、含义、元问题
- 根据学习者的回答质量自动检测并适应其水平（初学者、中级、高级）
- 遇到困难时降级支持 — 更简单的子问题和具体类比，绝不直接给出答案

**安装：**
```bash
npx skills add tronghieu/agent-skills --skill socratic-questor
```

### strategy-board

一个 C 级战略顾问委员会，以一支被命名的专家智能体团队的形式运行，带领高管从一个原始的战略问题走到一份经得起答辩、可提交董事会的建议方案。

**技能 README：** [strategy-board](./skills/strategy-board/README.zh.md)

**您将获得：**
- 运行一支由 8 位被命名的专家组成的团队，由 **Drucker**（管理合伙人）领导：Porter（市场与竞争）、Christensen（创新与颠覆）、Graham（财务与价值）、Grove（执行与组织）、Wack（情景与不确定性）、Taleb（风险与红队）、Minto（综合与沟通）
- 驱动一套设有关卡的项目推进流程 —— brief → 事实基础 → 分析 → 方案 → 压力测试 → 建议 → 路线图 —— 各关卡要求高管确认问题本身、方向和最终建议
- **Boardroom（圆桌会议模式）：** 召集 3-4 位相关成员就一个尖锐问题展开辩论，先通过并行子智能体各自独立表态（避免群体思维），再交叉讨论，并保留会议记录
- 硬性规则：不编造数字（每个数字都可追溯到有据可查的事实基础，或标注为假设）、提出建议前必须有三个真实方案、上会前必须运行事前验尸、"战略即取舍" —— 每份建议都必须说明应停止做什么

**安装：**
```bash
npx skills add tronghieu/agent-skills --skill strategy-board
```

### system-prompt-creator

为任意 LLM（Claude、GPT、Gemini、开源模型）创建高质量、模型感知的系统提示词。

**技能 README：** [system-prompt-creator](./skills/system-prompt-creator/README.zh.md)

**您将获得：**
- 引导完成结构化五步工作流：访谈、分析、结构化、起草、审查
- 应用源自 Anthropic、OpenAI 和 Google 官方提示工程指南的 12 条通用原则
- 生成模型专属优化（Claude XML 标签、GPT-5 详细度参数、Gemini 温度设置）
- 包含领域模式：操作手册、原始数据保留、置信度评分
- 提供 7 个可直接定制的常见场景模板

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
