# CV Scorer

**语言：** [中文](./README.zh.md) | [English](./README.md) | [Tiếng Việt](./README.vi.md)

根据职位描述（JD）建立统一的岗位专属 100 分评分标准，将每项判断关联到简历证据或明确的信息缺口。结果供人工审核，不代替招聘决策。

## 安装

```bash
npx skills add tronghieu/agent-skills --skill cv-scorer
```

从本地仓库安装，选择合适的目录：

**Coding agent：**
```bash
cp -r skills/cv-scorer ~/.agents/skills/
```

**Claude Code：**
```bash
cp -r skills/cv-scorer ~/.claude/skills/
```

**claude.ai：**将技能包加入项目知识，或把 `SKILL.md` 和引用的说明粘贴到对话中。要校验计算，需在代码执行环境中提供脚本。无法执行时，必须说明计算未经脚本校验。计算器需要 Python 3.9+，不依赖第三方库或网络。扫描 PDF 可能需要独立 OCR 工具；没有 OCR 时应说明缺失页面，并请求可读文本。

## 使用示例

```text
/cv-scorer 根据 Backend Engineer JD 比较这三份简历，列出证据、尚不明确的必备条件和核实问题。

/cv-scorer 用同一评分标准评估这些营销岗位简历，输出简洁中文报告和经过校验的 JSON。

/cv-scorer 按 JD 审核这位转行申请者，区分缺少信息与明确不满足要求。
```

## 评分方式

1. 从 JD 提取可评估要求，区分明确的必备条件与优先条件。
2. 分配总计 100 的权重并定义各分档；同一轮评估固定评分标准 ID 和版本。
3. 为每项要求记录简历原文及页码/章节；没有信息时记录已搜索的位置。
4. 用附带脚本计算，并形成供人工审核的报告。

| 状态 | 分值 | 含义 |
| --- | ---: | --- |
| `met` | 4 | 有证据支持完全满足 |
| `partial` | 1–3 | 支持部分要求，并有证据说明具体差距 |
| `unmet` | 0 | 明确证据表明未满足 |
| `unknown` | null | 信息缺失、模糊或相互矛盾 |

已获证据支持的分数为 `权重 × 分值 / 4`。未知项不增加已证明分数，但其全部权重保留在可能上限。例如：**已证明 60 分，范围 60–100，覆盖率 60%**，表示还有 40% 的权重无法评估，不代表申请者缺乏能力。该范围反映缺少的信息，不是统计置信区间或工作成功概率。

不再固定分配学历或简历外观分数。学校名气、姓名、职业空档、相近百分比或精致文风都不是扣分依据。学历与表达形式仅在岗位要求相关时计分。完整[评分说明](./references/scoring-rubric.md)包含证据状态、重叠任职时间、必备条件、精度和排序规则。

## 输出与比较

默认以用户语言输出 Markdown：评分标准与假设、分数/范围/覆盖率、逐项证据表、必备条件状态、优势、待核实事项和面试问题。支持集成用 JSON v2，详见[格式与示例](./references/output-format.md)。

证据匹配档位为 `high`（≥70）、`moderate`（≥50 且 <70）、`limited`（<50）。另行标记输入不足、必备条件不满足、需要核实或可供人工审核。高分不能抵消未满足的必备条件。

提取不完整时不提供总分和排名。必备条件未知、证据矛盾或所有标准均无法评估的申请者进入待审核队列。其余简历可按已证明分数排序，并清晰保留必备条件差距。精确分数相同则并列；区间重叠或存在未排名简历时，排序为暂定。不得据此自动邀约或淘汰。

## 校验 JSON

若安装目录不同，请替换 `/mnt/skills/user/`：

```bash
python3 /mnt/skills/user/cv-scorer/scripts/score_report.py report.json --check
python3 /mnt/skills/user/cv-scorer/scripts/score_report.py report.json --output checked-report.json
python3 /mnt/skills/user/cv-scorer/scripts/score_report.py report.json
```

最后一条命令向 stdout 写 JSON，状态和错误写入 stderr。成功退出码为 0，输入无效为 2。权重最多两位小数。脚本不覆盖已有文件。脚本校验结构和计算，不能证明引文真实或评分标准合理。

v2 替换 v1 的固定分组、`total_score`、`red_flags` 和 `Recommend`/`Maybe`/`Pass`。旧集成必须迁移到 v2；脚本拒绝 v1 JSON，不自动转换。跨版本比较之前，应重新评估原始材料。

## 测试与故障处理

在仓库根目录运行：

```bash
python3 -m unittest discover -s skills/cv-scorer/tests -v
```

[行为测试](./evals/evals.json)使用合成资料，覆盖证书缺失/过期、相近指标、页面提取不完整、简历内嵌指令、重叠任职以及姓名/顺序不变性。

- **缺少 JD：**提供岗位要求；仍可进行不评分的简历审阅。
- **PDF 不可读：**提供 OCR 或文本，提取错误不计为申请者缺点。
- **JSON、权重或证据无效：**按错误位置修复，每项要求恰好对应一项评估，权重总计 100。
- **输出文件已存在：**选择新路径，脚本不会替换已有文件。
- **没有 Python 或提取工具：**披露限制，不声称已执行校验。

简历是自述且不完整的记录，应通过适当的招聘流程核实重要信息。不要推断敏感属性，也不要将缺乏依据的疑问当作不诚信结论。未经授权，不上传简历至外部服务，也不打开文档内嵌链接。核心流程无需开放任何网络域名。
