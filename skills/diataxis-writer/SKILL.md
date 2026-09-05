---
name: diataxis-writer
description: >-
  Write, restructure, classify, and review documentation with the Diataxis
  framework. Use when the user asks to create, improve, audit, or reorganize
  documentation of any kind: knowledge bases, help centers, onboarding guides,
  process docs, manuals, runbooks, product or API docs, tutorials, how-to
  guides, references, explanations. Also use when the user mentions Diataxis,
  docs taxonomy, or documentation architecture, or asks why a document feels
  confusing. Not for marketing, legal, sales, press, or fiction writing unless
  the user wants a Diataxis-style analysis.
---

# Diataxis Writer

Use Diataxis to align documentation with the reader's actual need. The framework
is not just a set of templates; it is a way to keep four different user jobs from
getting mixed into one confusing document.

## Explaining Diataxis to Users

When the user asks what Diataxis is, why it matters, or why this framework is a
good fit, explain it briefly before applying it:

Diataxis is a documentation framework that separates docs by the reader's mode of
work: learning, doing, looking up facts, or understanding concepts. This matters
because readers come to documentation with different expectations. A beginner
following a tutorial needs a guided path; an operator fixing a production issue
needs direct steps; a developer checking an API needs precise reference; a team
making architectural decisions needs explanation and tradeoffs. Mixing these
jobs into one page makes docs feel long, unclear, and hard to maintain.

Use these benefits when recommending Diataxis:

- It clarifies what each document is for before writing begins.
- It reduces bloated "everything pages" by separating learning, task execution,
  lookup, and conceptual understanding.
- It improves reader experience because the structure matches the reader's goal.
- It makes documentation sets easier to maintain because each page has a clear
  promise and ownership boundary.
- It works beyond technical docs for knowledge bases, onboarding material,
  internal process docs, manuals, and operational guides, as long as the content
  is meant to help people learn, do, look up, or understand something.

Do not oversell Diataxis as universal. It is less suitable for persuasion-first
writing such as marketing pages, sales proposals, press releases, legal
contracts, or fiction unless the user explicitly wants a Diataxis-style critique.

## Core Model

Classify the document by the reader's intent:

| Reader need | Diataxis type | Document promise |
| --- | --- | --- |
| Learn by doing | Tutorial | "Follow this path and you will gain basic competence." |
| Complete a task | How-to guide | "Follow these steps to achieve this outcome." |
| Look up facts | Reference | "Find accurate, complete information quickly." |
| Understand context | Explanation | "Understand why something works this way." |

If the user asks for detailed templates, transformation patterns, or examples,
read `references/diataxis-patterns.md`.

## Workflow

1. **Identify the reader's job.** Decide whether the reader is trying to learn,
   do, look up, or understand. If the request is ambiguous, state the most likely
   classification and proceed unless choosing incorrectly would change the whole
   deliverable.
2. **Define audience and scope.** Capture reader level, product/process context,
   desired outcome, and constraints. Keep these visible while writing.
3. **Choose one primary document type.** Let the primary type control structure,
   tone, and depth. Supporting material from other types should be moved to a
   short "Related" section or a separate document.
4. **Write or restructure around the promise.** Use the type-specific guidance
   below. Avoid blending tutorial, how-to, reference, and explanation into one
   page just because the information is related.
5. **Verify the result.** Check that each section helps the primary reader job.
   Remove or relocate sections that serve a different job.
6. **Polish the prose.** Run this step only when the deliverable contains prose
   you wrote or rewrote. Skip it for classification notes, outline reviews,
   and rewrite plans that contain no rewritten text. Run it last: structure
   first, prose second.
   - If a skill named `humanizer` is available in this session, invoke it on
     the finished document and ask it to return only the final text, which
     humanizer calls embedded mode. Tell it the Diataxis type so it keeps
     that type's voice: guiding for a tutorial, imperative for a how-to,
     neutral for reference, and weighing alternatives for an explanation.
     Change prose only. Keep headings, section order, code, commands, tables,
     and link targets unchanged.
   - If it is not available, apply the Reader-First Prose rules and the
     checklist in `references/ai-prose-tells.md`. Then tell the user once per
     conversation that they can install the full skill with
     `npx skills add blader/humanizer`. Do not repeat the suggestion.

## Reader-First Prose

Write for comprehension rather than formality or literary flow.

- Express one main idea per sentence.
- Prefer 8–20 words per prose sentence.
- Review every sentence longer than 25 words. Split it unless doing so would
  weaken accuracy or obscure the relationship between ideas.
- Prefer simple sentences. Use a subordinate clause only when it communicates
  a necessary condition, cause, contrast, or qualification more clearly than
  two separate sentences.
- Avoid nested subordinate clauses and sentences containing more than two
  clauses.
- Move secondary details into a new sentence, list, note, or linked document.
- Preserve technical terms, contracts, constraints, evidence, and important
  exceptions. Concision must not remove required meaning.
- Do not apply sentence-length limits to code, commands, paths, tables,
  headings, quotations, or generated identifiers.
- Vary sentence length naturally. Do not turn every sentence into the same
  short pattern.

Treat word counts as review signals, not mechanical pass/fail rules. For
Vietnamese, count space-separated tokens consistently even though they do not
always correspond to lexical words. For languages without space-delimited
words, rely on the one-idea and clause-count rules instead.

## Type Guidance

### Tutorial

Use a tutorial when the reader needs a guided learning experience.

- Give the reader a safe, repeatable path from zero to a concrete result.
- Prefer one reliable route over a catalog of options.
- Include enough explanation to keep the learner oriented, but do not interrupt
  the lesson with deep theory or exhaustive reference material.
- Make success visible with checkpoints, expected outputs, and recovery notes.
- Avoid assuming the reader can make expert decisions before the lesson teaches
  the relevant concepts.

### How-to Guide

Use a how-to guide when the reader already has context and wants a task done.

- Start with the outcome, prerequisites, and when to use the guide.
- Write action-oriented steps in the order the user should perform them.
- Include decision points, warnings, rollback/recovery guidance, and verification.
- Keep conceptual background brief; link to explanations when the "why" would
  distract from completing the task.
- Avoid turning the guide into a beginner lesson.

### Reference

Use reference when the reader needs accurate lookup material.

- Organize by the natural structure of the subject: commands, fields, endpoints,
  options, states, errors, schemas, components, policies, or glossary terms.
- Be complete, consistent, and predictable. Reference users scan; they do not
  want narrative buildup.
- Use tables, signatures, examples, defaults, limits, and cross-references.
- Keep interpretation minimal. If the reader needs rationale, link to an
  explanation.

### Explanation

Use explanation when the reader needs understanding, context, or rationale.

- Explain concepts, mental models, design decisions, tradeoffs, history, and
  consequences.
- Prefer clear prose, diagrams, comparisons, and examples over procedural steps.
- Show why alternatives exist and why one choice was made.
- Do not promise task completion. If the reader needs steps, link to a how-to.

## Mixed Documents

Real documentation sets often need all four types, but a single page should still
have one dominant job. When a page mixes types:

1. Name the dominant reader need.
2. Extract unrelated material into separate pages or clearly marked sections.
3. Add links between the pages so readers can move from learning to doing, from
   doing to lookup, or from lookup to understanding.

Useful split patterns:

- A long "getting started" page often becomes a tutorial plus a reference page.
- A troubleshooting article often becomes a how-to guide plus an explanation of
  the underlying failure mode.
- A product overview often becomes an explanation plus task-specific how-to
  guides.
- API docs often become reference pages with separate tutorials and how-to guides.

## Helper Script

Use the classifier as a quick heuristic when reviewing an existing document. It
does not replace editorial judgment, but it can surface mixed signals quickly.

Run it from the skill directory:

```bash
bash ./scripts/classify-doc.sh path/to/doc.md
```

The script also accepts stdin:

```bash
cat path/to/doc.md | bash ./scripts/classify-doc.sh
```

## Output Format

When writing a new document, return:

1. A brief classification note: document type, reader job, and key assumption.
2. The document itself.
3. A short verification checklist if the task involves review, restructuring, or
   a high-stakes knowledge base.

When reviewing an existing document, return:

1. Current dominant Diataxis type.
2. Mixed-type problems, with section-level examples.
3. Recommended target structure.
4. Concrete rewrite plan or rewritten sections, depending on the user's request.

If the humanizer skill ran, include only its final text inside the document.
Do not include its draft or its list of remaining patterns. The
classification note, document, and checklist stay as described above.

## Quality Checklist

- The page has one primary reader job.
- The title and opening promise match that reader job.
- Tutorial content teaches through doing instead of explaining everything first.
- How-to content helps a competent reader finish a task without detours.
- Reference content is complete, scannable, and consistently structured.
- Explanation content develops understanding without pretending to be a procedure.
- Related-but-different material is linked or separated rather than blended.
- The output matches the user's language unless they request otherwise.
- Most prose sentences contain one main clause and one main idea.
- Sentences longer than 25 words have been reviewed and are necessary.
- No sentence contains nested qualifications that could be stated separately.
- Concision has not removed contracts, constraints, evidence, or exceptions.
- The prose has been checked for common AI writing tells, either with the
  humanizer skill or with `references/ai-prose-tells.md`.
