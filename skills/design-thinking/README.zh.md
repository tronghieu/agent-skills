# 设计思维 (Design Thinking)

**Language / Ngôn ngữ / 语言:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

此 Skill 将您的 AI 助手变成一位亲切又自律的**设计思维引导者与思考伙伴 (facilitator and thinking partner)**——陪您走完 Empathize（同理心）→ Define（定义）→ Ideate（构思）→ Prototype（原型）→ Test（测试）的完整循环，这个过程可以跨越多次会话，而且它始终小心，不会替您用户的想法下结论。

## Design Thinking 是什么？

让一个普通聊天机器人"理解您的用户"，它会欣然编造一个用户画像、写出一句听起来很有说服力的引言，甚至勾勒出一个"测试结果"——全都流畅自然、语气笃定，光看内容很难分辨真假。这个 Skill 的存在，就是为了温和地防止这种情况发生。它会帮您设计研究工具——访谈提纲、观察计划、带有清晰通过/未通过标准的实验——由您去收集真实数据，Skill 再仔细地帮您综合：每一条洞察 `[I#]`（一个小小的引用标签，指向它究竟来自哪一场访谈或哪一份文档）都能追溯到 `research/sources.md` 中已登记的证据 `[S#]`。凡是还没有真实数据支撑的内容，都会被清楚标注为 `(hypothesis — needs validation)`（假设——有待验证），而不是当作事实呈现。

这个 Skill 并不打算替您完成设计思维——去访谈用户、去运行可用性测试、去经历每一次真实世界的对话，这些都还是您来做。作为回报，Skill 负责纪律性的部分：帮您保持条理、追踪证据，并提供一个能跨越多次会话延续下去、并能像真实设计思维项目那样自然循环回溯的工作区。

许多通用 AI 工具其实并非刻意如此，只是在没有真实数据可用、又被要求显得"有帮助"时，很容易顺手编造出用户画像和引言。这个 Skill 特别注意避免这一点：任何还没有真实数据支撑的内容，都会被清楚标注为一个有待核实的猜测，而不会被包装成一项正式发现。

## 为什么使用它？

- **每条洞察都带着自己的证据。** 任何关于用户想法、感受、行为的论断，都会带上 `[I#]`/`[S#]` 标签，或被清楚标注为假设，让您随时能查到它的来源。
- **您运行真实世界，Skill 运行严谨性。** 它不会模拟一场访谈，也不会去猜"用户大概会怎么说"。角色扮演式的练习访谈完全没问题——只是会被标注为练习，不会被算作真实证据。
- **桌面研究补充背景，不会替代真实用户。** 二手来源有助于勾勒背景、扫描现有方案；它们可以指出一个值得留意的信号，但不会单靠自己就成为"用户感觉 X"这类洞察的全部依据。
- **每个 Gate 都会有一次复核。** 在 Define 收尾前和 Test 开始前，会有一次独立的、以证据为先的复核检查工作——发现的问题会被公开分享，而不是被悄悄修补。
- **回退一步很正常，而且会被记录下来。** 如果一次测试结果不理想，项目可能会回到 Define 或 Ideate；每一轮及其原因都会被写进 `phase-state.md`，而不是被含糊带过。

## Skill 的五项承诺

1. **不编造用户洞察**——每条洞察 `[I#]` 都追溯到您真正收集到的证据 `[S#]`；其余的一律标注为 `(hypothesis — needs validation)`，而不是当作事实断言。
2. **Skill 负责设计研究，您负责执行**——讨论提纲、访谈问题、实验设计都由 Skill 产出，然后它会耐心等待您带回真实数据。不做模拟访谈，不编造引言。
3. **桌面研究是补充，不是替代**——二手来源提供背景与信号，始终标注 `[S#]`，但绝不能替代倾听真实用户的声音。
4. **每个阶段 Gate 都会有一次新的复核**——Define 结尾的洞察复核，Test 之前的假设复核，两者都保持审慎、以证据为先。
5. **流程本身就是为循环回溯而设计的**——当一个假设站不住脚时，项目会顺理成章地回到 Define 或 Ideate，每一次回溯都会记录轮次编号和原因，让您随时清楚项目走到了哪一步。

## 团队与视角 (Lenses)

默认情况下您与 **Facilitator**（引导者）共事，它每次只切换一种功能性视角——不是有名字的人格，也没有菜单可选。

| 视角 | 阶段 | 做什么 |
|------|-------|--------------|
| **Facilitator**（默认） | 贯穿全程 | 保持阶段状态，切换视角，运行 Gate，与您对话，记录日志 |
| **Research designer** | Empathize | 研究计划、讨论提纲、访谈问题、观察计划——然后等待数据 |
| **Desk researcher** | Empathize → Prototype | 市场背景、现有方案扫描、可行性检查 |
| **Synthesizer** | Define | 亲和图 (affinity mapping)、洞察 `[I#]`、假设性用户画像、POV 陈述、HMW 问题 |
| **Ideators** | Ideate | 并行构思，每个子代理一种视角——真正值得并行展开的唯一环节 |
| **Prototyper** | Prototype | 故事板、纸面原型规格、原型简报，每一个都是为回答某个问题而建 |
| **Test designer** | Test | 假设地图、挑选风险最高的假设、带通过/未通过标准的测试卡 |
| **Verifier** | 阶段 Gate | 洞察复核与假设复核——在有子代理可用时独立运行，以保持复核的公正性 |

只有 Ideate 会展开成并行子代理；Verifier 在各个 Gate 独立运行一次复核。其余环节都是主对话中依次切换视角——引导者理应和您在同一个"房间"里。

## 阶段循环

```
0 Kickoff    → Facilitator       → project.md              ⛔ 用户确认框架
1 Empathize  → Research designer → 研究计划、访谈提纲       ⏸ 等待用户数据 → research/
2 Define     → Synthesizer       → 洞察、用户画像、hmw      ⛔ verifier 洞察复核 + 用户挑选 HMW
3 Ideate     → Ideators (fan-out)→ ideas.md                ⛔ 用户挑选概念
4 Prototype  → Prototyper        → prototypes/*
5 Test       → Test designer     → tests/*                 ⛔ verifier 假设复核 → ⏸ 用户运行测试
↺ Loop       → Facilitator       → journal, phase-state    （记录轮次+原因，重新进入正确的阶段）
```

⛔ 表示一个 Gate：Skill 会先停下来，向您展示产出物，再等待您的决定。⏸ 表示 Skill 已完成它这部分的工作，真实世界的数据收集接下来在您手中——它会明确说明自己在等什么，并在此期间给出有用的并行建议（通常是桌面研究）。

**从流程中途进入完全没问题。** 带着一叠访谈记录来，Skill 就从 Define 开始；带着一个原型来，就从 Test 开始。Kickoff 会轻量运行——确认框架、初始化工作区、把您带来的资料登记为来源——然后直接跳到正确的阶段。

**还没有一手数据？也没关系。** 在 Skill 把这个取舍明确说出口之后，您就可以仅凭桌面研究和声明的假设进入 Define。这样构建的每个用户画像都是明确标注的 **proto-persona**（假设性用户画像），每条洞察都是假设，而 Test 才是现实第一次投票的地方。

## 它产出的工作区结构

```text
<project-dir>/
  project.md        # 项目简报：问题空间、目标用户、范围、约束条件
  phase-state.md    # 当前轮次+阶段、Gate 状态、正在等待用户的事项
  journal.md        # 按会话记录的决策日志——重新进入项目的支柱
  research/
    sources.md      # [S#] 证据登记表（与 market-researcher 使用同一套 schema）
    raw/             # 用户提供的原始数据：笔记、逐字稿、问卷导出
    market/          # market-researcher 的产出落在这里
  insights.md        # [I#] 洞察，每条都追溯到 [S#] 证据
  personas.md        # 用户画像——按证据强度诚实标注
  hmw.md             # POV 陈述与 How-Might-We 问题
  ideas.md           # 已打分的创意组合
  prototypes/        # 每个原型一份规格
  tests/             # 假设地图、测试卡、结果、学习卡
```

**重新进入很轻松。** 当项目目录已存在时，Skill 会先读取 `phase-state.md` 和 `journal.md`，在做任何其他事情之前先把当前状态反馈给您——"上次会话结束在 Define，第 2 轮；洞察复核标记 I4 证据不足；正在等待您剩下的三场访谈。"它信任文件，而不是记忆，也不会悄悄重做或覆盖您已经完成的工作。

## 与 Market-Researcher Skill 配合使用

设计思维在多个节点都需要市场背景——为 Empathize 和 Define 打底，在 Ideate 之前扫描现有方案，在 Prototype 之前检查可行性。对于超出几次快速搜索范围的工作（市场规模测算、竞争对手深度剖析、需求信号挖掘），如果已安装 **[market-researcher](../market-researcher/)**，此 Skill 会将其作为研究引擎调用：按照组合契约 (composition contract) 调用它，指向 `<project-dir>/research/market/`，market-researcher 会追加写入 `research/sources.md`，**延续已有的 `[S#]` 编号**——这样洞察和创意就能直接引用它的来源。

如果尚未安装 market-researcher，此 Skill 只会提一次——可从 https://github.com/tronghieu/agent-skills#market-researcher 安装（`npx skills add tronghieu/agent-skills --skill market-researcher`）——并完全尊重"不"的答复：它会转而在对话中进行轻量级的桌面研究，所有论断依然按同一套 `[S#]` schema 引用，只是不会做完整的规模测算或竞争对手深度分析。这是一个可选的搭档，绝非前提条件。

## 如何触发

让 AI 执行如下任务：

```text
Our users are churning and we don't know why — help us figure out what's going on.
```

```text
Here are 12 interview transcripts from our onboarding research — synthesize them into insights and personas.
```

```text
We picked a concept — design an experiment to test whether people will actually pay for it.
```

```text
Chúng tôi muốn hiểu vì sao khách hàng bỏ giỏ hàng — bắt đầu một dự án tư duy thiết kế giúp tôi.
```

```text
先週インタビューした5人分のメモがあります。インサイトとペルソナにまとめてください。
```

在已有的项目目录中输入 `status` 也会触发此 Skill，从上次停下的地方精确接续——不需要特意说出"design thinking"这几个字。

## 安装

### 1. 使用 CLI（推荐）

```bash
npx skills add tronghieu/agent-skills --skill design-thinking
```

### 2. 手动安装（适合非技术用户）

1. **下载：** 转到此仓库的 `skills/` 文件夹下载 `design-thinking.zip` 文件。
2. **解压和复制：** 解压 `design-thinking.zip` 并将 `design-thinking` 文件夹复制到以下目录之一：

**针对特定项目：**
将 `design-thinking` 文件夹复制到项目根目录下的 `.agents/skills/` 或 `.claude/skills/`。

**全局安装（所有项目可用）：**
* **Mac / Linux：** `~/.agents/skills/` 或 `~/.claude/skills/`
* **Windows：** `%USERPROFILE%\.agents\skills\` 或 `%USERPROFILE%\.claude\skills\`（通常为 `C:\Users\<YourUsername>`）

## 使用示例

> **您：** 我们的用户在使用第一周后就流失了，我们不知道原因。您能帮我们弄清楚发生了什么吗？
>
> **Agent：** 我会把这当作一个设计思维项目来运行，从 Empathize 开始。先确认一下框架：您说的"流失"是指注销账户，还是只是不再使用但没有注销？另外您目前是否已经有一些用户接触渠道（访谈权限、客服工单、数据分析），还是我们要从零开始？
>
> *（确认问题框架，初始化项目工作区，起草研究计划和针对第一周流失现象的半结构化访谈提纲，将您提供的客服工单导出数据登记为 `research/sources.md` 中的 `[S1]`–`[S6]`）*
>
> **Agent：** 研究计划和讨论提纲已经准备好，放在 `research/` 中。我从您现有的客服工单里提取了三个早期信号 [S2][S4]——不过这些还只是桌面研究信号，不是已验证的洞察，所以我把它们标注为假设。我不会去猜测您的用户在访谈中可能会说什么。等您完成 5–6 场这样的对话并把记录放进 `research/raw/` 后，我会综合出真实的洞察，我们再一起进入 Define 阶段。
