# CV Scorer

**Languages:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

Compare one or more CVs with a job description (JD) through a visible 100-point rubric—decision support for a human reviewer, never a hiring decision-maker.

## Install

```bash
npx skills add tronghieu/agent-skills --skill cv-scorer
```

## Try it

```text
/cv-scorer Score this CV against the attached Senior Backend Engineer JD.

/cv-scorer Compare these five CVs with this Product Manager JD, then rank them.

/cv-scorer Review this Data Analyst CV against the JD. Show missing must-haves and facts to verify.

/cv-scorer Score these marketing candidates for this role; apply the same rubric to every CV.
```

Unlike an ordinary chatbot response, CV Scorer makes the criteria, weights, evidence comments, and recommendation label visible so a reviewer can inspect and challenge the result.

## Who it helps

Recruiters, hiring managers, and small hiring teams can use it for a structured first-pass review, a consistent batch comparison, or preparing questions about missing and contradictory information. It is not a substitute for interviews, reference checks, or an employer's hiring process.

## How scoring works

The skill first extracts the JD's must-haves, nice-to-haves, experience, education, and special requirements. It then compares those requirements with facts stated in each CV; it should avoid filling gaps with assumptions. Each criterion receives a 1–10 score and is weighted into a total out of 100.

| Criterion | Weight | Maximum |
| --- | ---: | ---: |
| JD matching | ×3 | 30 |
| Work experience | ×2.5 | 25 |
| Project and impact | ×1.5 | 15 |
| Education | ×1.5 | 15 |
| CV quality | ×1.5 | 15 |

The detailed bands cover JD coverage, relevance and progression, credible project metrics, education or credentials, and CV structure and consistency. Read the complete [scoring rubric](./references/scoring-rubric.md) when you need the exact bands or deductions.

The default labels are **Recommend** (70+), **Maybe** (50–69), and **Pass** (under 50). They are prompts for human review—not automatic interview, rejection, or employment decisions.

## Inputs and results

Provide a complete JD and one or more CVs in text, Markdown, or PDF. The response follows the [output format](./references/output-format.md): a JSON score breakdown, comments for every criterion, summary, highlights, and possible red flags. With several CVs, it scores each independently first, then returns a highest-to-lowest batch ranking. Responses match your language.

Treat a red flag, missing detail, or apparent contradiction as a question to verify, not a finding of dishonesty. Review the cited CV facts behind every score, especially candidates near a threshold.

## Complementary skills

- Use [Critical Thinking](../critical-thinking/README.md) when you need to audit the reasoning in a hiring memo, policy, or recommendation; it separates claims, evidence, assumptions, and gaps with findings anchored to source text.
- Use [Deep Reader](../deep-reader/README.md) for a long hiring policy, portfolio, or supporting document (roughly 50+ pages); its multi-pass notes keep a large document traceable before you rely on it in a review.

## Limits and responsible use

- The same rubric applied consistently does **not** make a score objective or unbiased, and a CV cannot establish future job performance.
- Do not infer or evaluate protected or sensitive attributes—such as age, gender, ethnicity, disability, religion, or other personal factors unrelated to the job.
- Do not reject a candidate solely from a generated score or ranking. A qualified human must review the evidence and make the decision.
- CVs are incomplete, self-reported records; verify material claims through appropriate, lawful hiring steps.
- Follow applicable employment law, privacy obligations, and your organization's policy, including any required documentation or additional review.
