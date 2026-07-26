# Deep Reader

**Language:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

Read long books, papers, theses, and textbooks with a traceable method instead of asking a chatbot for a one-shot summary.

## Quick install

```bash
npx skills add tronghieu/agent-skills --skill deep-reader
```

## Quick examples

```text
/deep-reader Study this 320-page public-policy book. I am preparing a literature review, so trace the author's causal argument, evidence, and unresolved assumptions.
```

```text
/deep-reader Give me an overview of this management book before Friday. Focus on which recommendations are actionable for a 30-person software company and where the evidence is weak.
```

```text
/deep-reader Compare these three papers on retrieval-augmented generation syntopically. Reconstruct their methods, separate results from interpretation, and show where their terminology hides disagreements.
```

## Who this is for

Deep Reader is for researchers, graduate students, analysts, educators, and serious readers working with documents of roughly 50 pages or more. It is especially useful when you need to understand an argument, retain evidence, compare sources, or return with follow-up questions later.

For a short document that fits comfortably in one conversation, direct reading is usually faster.

## Why use a skill instead of a normal chatbot prompt?

A chatbot asked to “summarize this 500-page book” may compress too early, lose material buried in the middle, or produce a fluent answer that is difficult to trace back to the source. Deep Reader changes the working method:

- It asks what you want from the text before deciding what deserves close reading.
- It reads in passes instead of treating the whole document as one large prompt.
- It keeps page-anchored notes as durable external memory across chapters and sessions.
- It separates the author's claims, arguments, evidence, and the reader's judgment.
- It verifies important quotations and load-bearing claims before presenting the synthesis.

The result is slower than a quick summary, but more reusable, inspectable, and suitable for serious study.

## The reading method

Deep Reader combines three established approaches:

1. **Inspectional reading — Adler:** map the whole work first. Identify its central question, unity, structure, genre, and the chapters most relevant to your purpose.
2. **Analytical reading — Adler:** read each important argument unit closely. Track key terms, leading propositions, premises, conclusions, evidence, tensions, and open questions.
3. **Recite — SQ3R:** after drafting a note, restate the chapter from memory and recheck it against the text. This catches misunderstandings while the chapter is still fresh.
4. **Synthesis — Adler's four questions:** ask what the work is about as a whole, what it says in detail, whether it is true or adequate, and what follows for your actual purpose.
5. **Syntopical reading — Adler:** when the question spans several works, analyze each separately, then compare agreement, disagreement, and terminology without letting one author define the whole debate.

Critical judgment comes only after a fair restatement of the author. The final assessment distinguishes “wrong,” “incomplete,” and “not verifiable” rather than turning disagreement into unsupported opinion.

### For papers, theses, and surveys

Academic works follow Keshav's three-pass rhythm:

- **Pass 1:** read the title, abstract, introduction, headings, conclusion, and references to get the gist.
- **Pass 2:** read carefully, capture key evidence, and mark proofs, derivations, or references that still need attention.
- **Pass 3:** reconstruct the argument or method independently, then compare that reconstruction with the paper. This expensive pass is reserved for sections that matter to your purpose.

For empirical papers, the skill keeps methods, results, and the authors' interpretation separate so a sound result is not confused with an overstated conclusion.

## Choose a depth

- **Overview:** a fast inspectional map plus a purpose-driven summary of the two to four most relevant sections. Best for orientation, triage, or deciding whether a book deserves deeper study.
- **Study:** the complete workflow—analytical notes by chapter or argument unit, Recite checks, cross-chapter terminology, synthesis, concept map, and verification. Best for research, teaching, review writing, or consequential decisions.

If you are unsure, state your purpose and deadline; the skill will propose a mode for you to confirm.

## What the experience looks like

1. You provide the source and explain what you want to learn, decide, teach, or produce.
2. The skill maps the work before reading deeply and proposes a reading plan.
3. In Study mode, it reads coherent argument units and records page-linked notes as it goes.
4. It adapts the method to the genre: arguments for philosophy, sources and viewpoint for history, proofs or experiments for science, characters and themes for literature, and exercises for textbooks.
5. It synthesizes from the verified notes, not from vague memory of one oversized context.
6. On a later question, it searches the existing notes first and returns to the source only when the needed detail is missing.

For very large works, the skill may isolate groups of chapters into separate reading contexts or agents. One lead reader still owns the book map, shared terminology, and final synthesis, so you receive one coherent interpretation rather than disconnected mini-summaries.

## What to provide

- The PDF, EPUB, DOCX, text, or Markdown source
- Your reading purpose or decision to support
- Questions or themes you care about
- Preferred depth, deadline, and output language
- Other works to compare, if you want syntopical reading

## What you receive

- **Overview:** a map of the work's central question, unity, structure, and high-value sections, plus a purpose-driven summary.
- **Study adds:** page-anchored chapter or section notes covering claims, evidence, terms, and open questions; a cross-chapter concept and terminology map; a purpose-specific synthesis answering Adler's four questions; checked quotations and a verification log for important paraphrased claims; and reusable notes for later questions without rereading the entire source.

## Skills you may combine with Deep Reader

These are optional follow-on skills, not requirements:

- Use [Critical Thinking](../critical-thinking/README.md) when you want a dedicated audit of the reasoning in the source or of a decision based on the synthesis.
- Use [Socratic Questor](../socratic-questor/README.md) when you want to turn the notes into a guided learning dialogue, oral-exam practice, or active recall.
- Use [Data Scientist](../data-scientist/README.md) when the source includes datasets or quantitative claims that need reanalysis rather than textual evaluation alone.

## Limits

Page anchors for EPUB, DOCX, text, and Markdown are generated coordinates, not printed page numbers. Extraction quality can also be affected by scans, complex layouts, equations, and tables. Important academic, legal, medical, or publication-ready citations should still be checked against the original edition.

Deep Reader helps you understand and evaluate a source; it does not make the source correct, replace domain expertise, or independently reproduce experiments that require unavailable data.
