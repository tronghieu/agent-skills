# CV Scorer Skill

**Language / Ngôn ngữ / 语言:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

This skill evaluates candidate CVs (resumes) against a specific Job Description (JD) and provides a structured score out of 100 with clear hiring recommendations.

## What is CV Scorer?

CV Scorer is an intelligent resume screening tool. Instead of manually reading dozens of resumes to find a match, you can feed a Job Description and one or more CVs to the AI. It will analyze the candidate's experience, skills, and qualifications, and output an objective score based on how well they fit the role.

## Why Use It?

- **Saves Time**: Quickly filter through piles of applications.
- **Objective Evaluation**: Uses a consistent, unbiased scoring rubric for all candidates.
- **Finds Red Flags**: Automatically flags potential issues such as unexplained career gaps, exaggerated metrics, or repetitive content.
- **Actionable Recommendations**: Categorizes candidates into *Recommend* (interview), *Maybe* (keep on hold), or *Pass* (not a fit).
- **Supports Batch Processing**: Feed multiple CVs to get a ranked list of the best candidates from highest to lowest score.

## How It Works

1. **Provide Inputs**: You input the **Job Description (JD)** and one or more **CVs** (text, Markdown, or PDF format).
2. **Analysis**: The AI extracts key requirements (must-have vs. nice-to-have skills, experience levels, education) from the JD.
3. **Scoring**: The AI rates the CV out of 100 points based on 5 criteria:
   - **Job Matching (30 pts)**: Alignment of core skills and tools.
   - **Work Experience (25 pts)**: Relevancy of background and seniority.
   - **Project & Impact (15 pts)**: Concrete achievements and metrics.
   - **Education & Certifications (15 pts)**: Relevant degrees or credentials.
   - **CV Quality (15 pts)**: Formatting, clarity, and professionalism.
4. **Recommendation**: Gives a direct verdict (Recommend: $\ge 70$, Maybe: $50-69$, Pass: $< 50$).

## How to Trigger

Ask your AI agent tasks like:

```text
Score these candidate resumes against this job description.
```

```text
Screen this CV and highlight any red flags.
```

```text
Rate the following candidates for the Software Engineer role and rank them.
```
