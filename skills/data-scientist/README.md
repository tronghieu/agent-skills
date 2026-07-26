# Data Scientist

**Language:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

Turn a real business decision and its data into defensible evidence, uncertainty-aware conclusions, and a decision-ready report.

## Install

```bash
npx skills add tronghieu/agent-skills --skill data-scientist
```

## Try it

```text
/data-scientist Explore orders.csv: what is in it, can we trust it, and what hypotheses should we test?
```

```text
/data-scientist Is variant B's conversion lift real? Include the effect size, confidence interval, and sample-size implications.
```

```text
/data-scientist Build a baseline to forecast weekly demand from sales.parquet; errors during stockouts cost more than overstocking.
```

```text
/data-scientist Red-team this churn notebook before leadership sees it: reproduce the key numbers and find leakage or confounders.
```

## Why not use a normal chatbot?

A normal chatbot may jump to a chart, a p-value, or a sophisticated model. This skill starts by establishing the decision, data grain, coverage, and information available at decision time. It requires computed evidence, uncertainty around estimates, a simple baseline before added complexity, and a review that tries to disprove the conclusion. The result is not merely plausible analysis—it is analysis whose caveats and trade-offs are visible to the decision owner.

## Who it is for and when to use it

Use it when you have a CSV, Parquet, Excel file, query result, API extract, notebook, or existing model and need to:

- Explore and audit an unfamiliar dataset before trusting it.
- Diagnose a changed metric, while separating association from cause.
- Design or interpret A/B tests, comparisons, confidence intervals, or sample sizes.
- Build and judge a classification, regression, scoring, segmentation, or forecast baseline.
- Review an analysis, notebook, or model before it informs a decision.
- Translate technical findings into a concise report for stakeholders.

It suits analysts, data scientists, product and business teams, and decision owners who need evidence they can interrogate—not just an attractive narrative.

## How the engagement works

The skill first frames the work as descriptive (what happened), diagnostic (why), predictive (what is likely next), or prescriptive (which trade-off to choose). It confirms the decision at stake, unit of analysis, target definition, timing of usable information, success bar, and cost of each error. If a requested model cannot change an action, it can redirect the work to the more useful question.

Then it follows a rigorous path:

1. **Audit the data.** Confirm provenance, row grain, coverage, keys, definitions, missingness, outliers, target integrity, and whether the data is fit for purpose.
2. **Explore with a question.** Investigate distributions, segments, time structure, and plausible explanations; end with falsifiable, ranked hypotheses rather than a dump of charts.
3. **Analyze or predict.** Use appropriate tests and effect sizes for diagnostic questions, or compare a predictive model with simple baselines using a split that mirrors deployment.
4. **Validate before believing.** Attach confidence intervals or cross-validation spread; check assumptions, multiple comparisons, practical significance, calibration, performance by important segments, and data leakage.
5. **Red-team before sharing.** Deliberately switch from analyst to adversarial reviewer: recheck decisive arithmetic, selection effects, confounders, causal wording, alternative splits or definitions, and what could overturn the result.
6. **Communicate the decision.** Lead with the answer in business units, the uncertainty, evidence, quantified options, and specific limitations. The skill recommends; the decision owner chooses.

## Evidence and uncertainty discipline

Every reported number must trace to executed analysis. Estimates carry a confidence interval, error range, or validation spread. Observational patterns are described as **associations**; causal language is reserved for randomized experiments or a clearly defended causal design. A highly accurate-looking model is treated as suspect until feature timing and validation leakage have been checked.

For predictions, a more complex model must earn its place by outperforming dummy and linear baselines by more than normal validation variation. A threshold is presented as business choices—what is gained, what it costs, and who is affected—not assumed to be 0.5 or selected for you.

## What to provide and how to collaborate

Share the data or its location, the decision or question, target population and period, known definitions or constraints, and relevant context such as a data dictionary. For predictive work, say when a prediction is made, which inputs are legitimately available then, how it will be used, and which error is more costly.

Expect focused clarification before analysis when those choices are unclear. You can also bring an existing notebook or results: the review route independently checks load-bearing numbers and ranks issues as fatal, material, or minor, with concrete fixes.

## What you receive

Depending on the route, the work produces a concise set of reproducible artifacts:

| Artifact | Purpose |
| --- | --- |
| Project brief | Decision, target, grain, success bar, and explicit assumptions |
| Data profile and EDA report | Data-quality verdict, key findings, ranked hypotheses, and leakage watchlist |
| Statistical interpretation | Effect sizes, uncertainty, assumptions, and practical meaning |
| Experiment log and model card | Comparable runs, validation design, baseline comparison, operating trade-offs, and limitations |
| Insight or critique report | Answer first; supporting evidence, recommendation options, and what could change the conclusion |

## Useful companion skills

- [Critical Thinking](../critical-thinking/README.md) — use alongside a high-stakes recommendation when you want a broader challenge to the argument, assumptions, and decision logic.
- [Market Researcher](../market-researcher/README.md) — use when the question also needs cited external market, competitor, or industry evidence; this skill then analyzes the data you have.
- [Diataxis Writer](../diataxis-writer/README.md) — use after the analysis when a durable tutorial, how-to, reference, or explanation document is needed for different readers.

## Limits

This skill does not replace data engineering, production MLOps, domain validation, privacy/security work, or legal and ethical review. It does not make the business decision or build a full pricing or resource-allocation optimizer. Weak, incomplete, biased, or nonrepresentative data may lead to a "not fit for purpose" conclusion; that is a valid outcome, not a reason to overstate certainty.
