# Product Manager Skill

**Language / Ngôn ngữ / 语言:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

这个 skill 把你的 AI agent 变成一位有纪律的**产品管理搭档**——不会随手甩给你一张写满编造 reach 数字的 RICE 表，也不会在 PRD 里引用一句客户根本没说过的话，只为了看起来做得很扎实。

## Product Manager Skill 是什么？

让一个普通的聊天机器人帮你"排一下 backlog 优先级"，它几秒钟就能生成一张看起来很自信的 RICE 表——reach、impact、effort 全部填好，排名精确到小数点后两位。但没有一个数字是真的。那只是一个披着分析外衣的合理猜测，一旦放进 PPT，没人分辨得出它和真实数据算出来的表有什么区别。这个 skill 存在的意义，就是让这种失误无处遁形：优先级表里的每一个数字、OKR 里的每一个指标、PRD 里的每一句论断，都带着一个可以点开追溯来源的标签——一个真实来源、一个写明区间的假设，或者你本人给出且记录了日期的估计。如果这个数字还不存在，skill 会问你，或者把它登记成一个诚实的假设，而不是为了让表格看起来齐整就随手填一个数上去。

它也不是一个一次性文档生成器。产品管理不会在 PRD 交付那一刻就结束——backlog 还要持续打理，OKR 要跟进，反馈会不断堆积，上线之后要盯着数据，必要时还得回滚。这个 skill 是作为**一款仍在生长的产品的搭档**运行的：一个工作区，只需初始化一次，你会在接下来的几周、几个月里反复回来使用它。它记得之前决定了什么、为什么这么决定，所以每次开始都是"上次我们聊到这里了"，而不是让你从头再解释一遍产品背景。

产品经理始终是你。产品是你的，用户是你在对话的对象,上线什么由你拍板。这个 skill 的工作是把草稿写好，在你的要求和你自己手头的证据相矛盾时说出来，老老实实做计算，并且把账本记清楚，不让任何事情被悄悄遗忘或者反复翻案。

## 为什么要用它？

- **每个数字都交代来源。** Reach、impact、effort、baseline、转化率——每一个数字都带着标签：`[S#]`（真实来源）、`A#`（登记过的假设，带诚实区间），或者 `(user estimate, <日期>)`（你本人的估计）。没有标签的数字被当作 bug，不是可以省略的细节。
- **排名会被压力测试，而不只是算出来就完事。** 任何依赖假设的优先级排序，都会在每个假设区间的低端和高端各跑一遍，让你看清哪些结论稳如磐石、哪些会因为一个猜测而翻转、哪些其实根本分不出高下——在你把一个季度的资源押上去之前。
- **每个功能都能追溯到一个理由，追溯不到就老实说。** PRD 或 backlog 里的条目，要么指向一个用户问题的真实证据，要么被明确标记为一次押注。不会有事后硬贴上去、看起来像有证据支撑的理由。
- **交给你之前会有人复查一遍。** PRD、优先级排序、上线计划各自都要经过一次带批判性的审查——检查裸露无标签的数字、没验证过的验收标准、缺失的回滚阈值——然后才会请你据此行动。审查发现的问题会写进文档本身，不会被悄悄改掉。
- **工作区替你记住一切，你不必自己记。** 一份持续更新的决策日志就是产品的组织记忆：决定了什么、为什么、否决了什么、又是什么条件会触发你重新考虑它。三个月后回来，skill 会先读完这份日志，再开口说话。

## 五条这个 skill 绝不妥协的原则

1. **不编数字。** 每一个定量输入，要么是真实来源，要么是带区间的登记假设，要么是你本人给出且带日期的估计——绝不是一个装扮成分析结果的合理猜测。
2. **先做 sensitivity，再谈精确。** 建立在假设之上的排名，必须先在其诚实区间内跑一遍测试，才能作为结论呈现——一个建立在瞎猜数字上、精确到小数点后两位的分数，只是精确性的表演。
3. **结果重于产出。** 每一个 opportunity、每一份 PRD 都要追溯到一个真实的用户问题，并说明它应该拉动哪个指标。追溯不到任何证据的工作依然被允许——押注本来就存在——但它必须清楚地标明是一次押注，绝不能被悄悄包装成有依据的决定。
4. **工作区是事实的来源，不是记忆。** 每次动手之前，skill 都会先读决策日志和当前状态，并把现状复述给你听。一处修正要传播到它被重复出现的每一个地方，而不只是你正好在看的那一份文件。
5. **不经复查，不上线。** PRD、优先级排序、上线计划在交到你手上之前都要经过一次独立审查——不论审查发现什么，都会展示给你看，不会被悄悄清理掉。

每一份产出物都要经受住这个问题的考验：**"这个数字究竟从哪来——如果它错了，决定会变吗？"**

## 一套镜头组成的团队

现在每顶帽子都有了名字，但你从来不需要"召唤"谁——始终是同一位 PM 根据工作需要切换帽子，不是一份供你挑选的人设名单。

| 镜头 | 关注点 | 你会在这些时候遇到它 |
|------|---------|------------------------|
| **Sao** (Compass) | 方向——愿景、定位、重大的结构性押注 | 你问"这该做成独立产品还是一个功能？"，或者需要定价方面的建议 |
| **Minh** (Scope) | 定义——把一个问题变成一份规格说明 | 你要一份 PRD、一张 story map，或一批 user stories |
| **Lam** (Scale) | 排序——接下来先做什么，为什么 | 你要求排 backlog 优先级 |
| **Kim** (Gauge) | 度量——"好"看起来是什么样子 | 你要求定义北极星指标或设定 OKR |
| **Mai** (Lab) | 学习——在押注之前先验证一个有风险的判断 | 你要求设计一个 A/B test 或验证某个假设 |
| **Phong** (Ramp) | 上线——安全地把功能推出去 | 你要求做上线计划，附带回滚标准 |
| **Thanh** (Echo) | 倾听——把原始反馈变成信号 | 你丢来一堆客服工单或用户评论，要求整理归类 |
| **Bao** (Judge) | 审计——那双挑剔的第二双眼睛 | 自动触发，在 PRD、优先级排序或上线计划交给你之前 |

只要 agent 能拉起一个独立的 subagent，Judge 就会作为独立的一轮跑起来——自己批改自己的作业没多大意义，所以它刻意不给自己打分。其余的一切，都是同一位 PM 在对话中和你一起推进，全程都在场。

## 你可以提哪些要求

没有固定顺序，也没有"五个阶段走第一步"这种说法——你从当下需要的任何一点切入，skill 会自动路由到合适的镜头：

- **"帮我排一下 backlog 优先级"** —— Scale 镜头：RICE 打分（或者用 Kano 来判断一个功能属于哪种期望类型），每个输入都带标签，并对排名做一次 sensitivity 解读。
- **"给 X 写一份 PRD"** —— Scope 镜头：与证据挂钩的问题陈述、一张 story map、可验证的 user stories、一份明确的 Won't-have 清单。
- **"帮我把这堆客户反馈分类一下"** —— Echo 镜头：原始反馈被整理进 backlog，变成真正的 opportunity，而不只是简单计数。
- **"帮我规划这个季度的 OKR"** / **"我们的北极星指标该定什么？"** —— Gauge 镜头：一棵带明确 baseline 的指标树，而不是一个"听起来不错"就选中的指标。
- **"给...设计一个 A/B test"** —— Lab 镜头：一张测试卡片，pass/fail 的判断标准在测试**开始前**就定好，而不是等结果出来后再往回套。
- **"规划...的上线"** —— Ramp 镜头：一份与实际风险相匹配的推出计划，回滚阈值提前用数字定死。
- **"这该做成平台还是功能？"** / **"这个应该怎么定价？"** —— Compass 镜头：决定后续一切走向的结构性判断。

一次性的请求也会被认真对待、不需要繁文缛节——你不必为了得到一个干净利落的答案而先搭建整个工作区——但即使是快速处理，数字依然会被贴上标签。这个 skill 可以用任何语言与你对话；它止步于成型的 user stories，剩下的交给工程团队。

## 它会生成的工作区

```text
<product-dir>/
  product.md              # 愿景、定位、用户、约束条件——核心事实
  state.md                 # 目前开放的事项，正在等你的事项
  decisions.md              # 只增不改的决策日志——你可以放心离开再回来的原因
  discovery/
    sources.md             # [S#] 所有来源，仅限真实证据
    insights.md             # [I#] 用户洞察，自行登记或从 design-thinking 导入
    feedback-log.md         # FB# 原始反馈，随时间被分类整理
  strategy/
    metrics.md               # 北极星指标 + 指标树 + 护栏指标
    okrs-<period>.md          # 每个 OKR 周期一份文件
  backlog/
    opportunities.md         # OP# 值得解决的问题，以 job story 的形式呈现
    assumptions.md            # A# 登记的假设——内容、依据、诚实区间、状态
    prioritization-<date>.md  # 按日期归档的 RICE/Kano 结果，从不覆盖——这就是你的优先级历史
  specs/                    # prd-<feature>.md —— PRD、story map、user stories
  experiments/               # exp-<slug>.md —— 测试卡片和学到的东西
  launches/                  # launch-<release>.md —— 上线计划、回滚标准、上线后复盘
```

**回来接着做很轻松。** 走进一个已经存在的产品目录，说一声"status"——skill 会先读 `decisions.md` 和 `state.md`，在做任何事之前先把现状说给你听："上次我们定了 Q3 的优先级排序；offline-mode 的 PRD 已经写好，在等你工程团队的 effort 估算；有两个实验正在跑。"它更相信文件，而不是自己的记忆，也不会悄悄重做或覆盖你已经完成的工作。

## 与伙伴 skill 协同工作

产品管理天天都会碰到用户研究和市场事实，但这个 skill 并不打算从零开始自己包办这两件事——三个可选的伙伴 skill 各自负责这块领域，每一个都是可选的，且只会被建议一次：

- **[design-thinking](../design-thinking/)** —— 用于深入的用户探索：访谈、实地研究、原型测试，认真验证一个假设性的 job story，而不是靠猜。这个 skill 只消费它产出的洞察（`[I#]` 区块原样导入 `discovery/insights.md`，编号接着往下走）——它自己从不去做实地调研。安装：`npx skills add tronghieu/agent-skills --skill design-thinking` —— 详情：https://github.com/tronghieu/agent-skills#design-thinking
- **[market-researcher](../market-researcher/)** —— 用于超出简单搜索范围的外部市场事实：定价基准、竞品背景、为某个 reach 假设做市场测算。它会直接写入这个工作区的 `discovery/`，接续 `[S#]` 编号，让你的文档可以直接引用它的来源。安装：`npx skills add tronghieu/agent-skills --skill market-researcher` —— 详情：https://github.com/tronghieu/agent-skills#market-researcher
- **[strategy-board](../strategy-board/)** —— 用于超出产品层面的决策：进入一个新市场、build-vs-buy、砍掉一条产品线——这些公司级的押注，不该由一份 PM playbook 独自决定。它的建议会作为输入回流到你的 `strategy/` 文件里，并记入一条决策日志。安装：`npx skills add tronghieu/agent-skills --skill strategy-board` —— 详情：https://github.com/tronghieu/agent-skills#strategy-board

如果某个伙伴 skill 没有安装，这个 skill 只会提一次；如果你不想加装，它会自己用轻量的桌面调研或者明确标注的假设继续往下走。永远不是强制项，主动权在你手里。

## 如何触发

试着让你的 AI agent 处理这样的任务：

```text
Prioritize these 6 features for next quarter using RICE.
```

```text
Write me a PRD for offline mode — here's what we know about the problem.
```

```text
Here's three months of support tickets and app-store reviews — triage this into our backlog.
```

```text
Should this be its own product or a feature of what we already have?
```

```text
帮我把这个季度的 backlog 排一下优先级，并给排在最前面的功能写一份 PRD。
```

```text
今四半期のOKRを一緒に決めたいです。ノーススターメトリクスから考えましょう。
```

在一个已存在的产品工作区里输入 `status`，或者提出任何与产品相关的问题，都会触发这个 skill——你完全不需要说"请扮演产品经理"它才会启动。

## 安装方式

### 1. 使用 CLI（推荐）

```bash
npx skills add tronghieu/agent-skills --skill product-manager
```

### 2. 手动安装（适合不熟悉技术的用户）

1. **下载：** 前往本仓库的 `skills/` 文件夹，下载 `product-manager.zip`。
2. **解压并复制：** 解压 `product-manager.zip`，把 `product-manager` 文件夹复制到以下目录之一：

**针对某个特定项目：**
把 `product-manager` 文件夹复制到项目根目录下的 `.agents/skills/` 或 `.claude/skills/`。

**全局安装（对所有项目生效）：**
* **Mac / Linux：** `~/.agents/skills/` 或 `~/.claude/skills/`
* **Windows：** `%USERPROFILE%\.agents\skills\` 或 `%USERPROFILE%\.claude\skills\`（通常是 `C:\Users\<你的用户名>`）

## 使用示例

> **你：** 帮我用 RICE 给这 6 个功能排优先级——Google 登录、离线模式、深色模式、CSV 导出、团队权限、应用内聊天。
>
> **Agent：** 我可以马上开始算——但目前这几个功能都没有 reach、impact 或 effort 的数据，如果现在打分，基本就是在猜。你手头有没有各功能触及用户数的分析数据？工程团队对哪些功能做过 effort 估算吗？
>
> **你：** effort 还没估过，只有 CSV 导出和团队权限有真实的使用数据。
>
> **Agent：** 明白了——我现在就给全部 6 个打分：CSV 导出和团队权限用真实的 reach 数据 `[S2]` `[S3]`，其余四个用登记过的假设、带诚实区间（`backlog/assumptions.md` 里的 `A1`–`A6`），effort 对全部 6 个都登记为带区间的假设，直到你的开发团队给出意见。
>
> *(搭建 RICE 表，对每个假设的区间跑一遍 sensitivity 测试，把假设和临时排名都记录下来)*
>
> **Agent：** 临时排名结果：**离线模式和 Google 登录是稳的**——我试过的每一个诚实区间里它们都排在最前面。**CSV 导出和深色模式在第 3、第 4 名之间互换位置**，取决于两者实际的 effort，所以这一对在你给我真实估算之前确实还没法定论。我已经把这个作为一条临时决策记进了 `decisions.md`，并附上了重新审视的触发条件——一旦工程团队把 effort 估出来，我会把这份排名从猜测坐实为确定结果。
