---
name: deep-reader
description: >-
  Read, study, and answer questions about long books and papers without loading
  the whole text into one context window, keeping page-anchored notes as a
  reusable workspace. Use whenever the user asks to read, study, summarize,
  analyze, review, or answer questions about a long book, textbook, PDF, EPUB,
  thesis, dissertation, survey paper, or any document of roughly 50+ pages, in
  any language (Vietnamese "đọc sách", "tóm tắt sách", "phân tích luận án").
  Also use when a `<slug>-notes/` workspace from a previous session sits next to
  a source file and the user asks a follow-up question about that book. Not for
  short documents (under ~30 pages) that fit in context; read those directly.
---

# Deep Reader

Read long books and papers the way a careful human researcher does: skim for
structure first, read deeply chapter by chapter with notes as you go, then
synthesize from the notes — never the raw text — at the end. The method comes
from Adler's *How to Read a Book*, SQ3R's Recite step, and Keshav's three-pass
method for papers.

## Why multi-pass, why notes

An LLM's attention dilutes over long contexts, and it loses track of material
buried in the middle of a big prompt ("lost in the middle"). Loading a
500-page book into one context and asking questions about it produces answers
that quietly forget chapter 3 by the time you're discussing chapter 12.

The fix is the same one human researchers use: never hold the whole book in
working memory at once. Read it in passes — first for structure, then chapter
by chapter for content — and externalize what you learn into note files as you
go. The notes become the durable memory; the book itself only needs to be
back in view when you're actively reading a specific chapter or verifying a
specific claim. Page numbers are the coordinate system that makes every claim
traceable back to the source, in this session or a later one.

## Two modes

- **overview** — Adler's inspectional pass only: a book map plus a
  goal-directed summary of the chapters that matter most to the reader's
  purpose. Fast, no per-chapter notes.
- **study** — the full pipeline: reading purpose → inspectional map →
  chapter-by-chapter analytical notes with Recite verification → hierarchical
  synthesis answering Adler's four questions → mechanical quote verification.

The user picks (or you propose one from `mode_hint` + their stated purpose —
see Step 1).

## Workspace layout

Everything the pipeline produces lives in a workspace directory, by default a
sibling of the source file, so it survives across sessions:

```
<slug>-notes/
├── source.txt          # full text with [[page N]] markers — the coordinate system
├── chapters.tsv        # confirmed structure: chNN<TAB>from<TAB>to<TAB>title
├── chapters/           # per-chapter files cut by split-chapters.sh
│   └── ch01-<slug>.txt
├── map.md              # inspectional pass output
├── terms.md            # key-terms ledger, cross-chapter
├── notes/
│   └── ch01-<slug>.md  # one analytical note per chapter (papers: sec01-<slug>.md)
└── synthesis.md        # final synthesis + verification log
```

This workspace, not the SKILL.md scripts, is what makes a later session able
to answer a follow-up question without re-reading the book (see "Answering
from existing notes" below).

## Scripts at a glance

All seven scripts live in `scripts/` under this skill. Run them either as
`bash ./scripts/<name>.sh ...` from the skill directory, or as
`bash /mnt/skills/user/deep-reader/scripts/<name>.sh ...` on claude.ai — both
forms invoke the same script, use whichever matches where you're running.

| Script | Arguments | Purpose |
| --- | --- | --- |
| `prepare-text.sh` | `<input-file> [workspace-dir]` | Convert source to paged `source.txt`, create the workspace |
| `extract-structure.sh` | `<source.txt>` | Heuristic outline seed (a starting guess, not ground truth) |
| `read-pages.sh` | `<source.txt> <from> [to]` | Print a page or page range, with `[[page N]]` markers intact |
| `search-book.sh` | `<source.txt> <pattern> [context-lines]` | Grep the whole book, page-annotated results |
| `split-chapters.sh` | `<source.txt> <chapters.tsv>` | Cut confirmed chapters into standalone files |
| `build-diagram.sh` | `<workspace-dir> [--append]` | Mechanical Mermaid mindmap of the structure |
| `verify-quotes.sh` | `<workspace-dir>` | Catch fabricated quotes and wrong page citations |

## Step 0 — Prepare

Locate the source file, then convert and page it:

```bash
bash ./scripts/prepare-text.sh path/to/book.pdf
# or on claude.ai:
bash /mnt/skills/user/deep-reader/scripts/prepare-text.sh path/to/book.pdf
```

This is idempotent — re-running it on a workspace that already has
`source.txt` reports existing stats instead of reconverting, so it's safe to
call at the start of every session on the same book.

Read the JSON it prints. `pages` and `est_tokens` tell you the book's size;
`mode_hint` gives a starting recommendation (small/medium/large); if
`synthetic_pages` is true (EPUB/DOCX/TXT/MD sources have no real page numbers)
remember that page citations in notes still point into `source.txt`'s own
paging — verifiable, just not the printed page numbers a reader with the
physical book would see.

Two branches before you go further:

- **A workspace with notes already exists** for this book (check
  `<slug>-notes/notes/` for files) — skip straight to "Answering from
  existing notes" below instead of restarting the pipeline.
- **Exit code 2** (missing `pdftotext`/`pandoc`) — fall back to reading the
  PDF/EPUB directly with the Read tool in page batches. You lose
  `verify-quotes.sh`'s mechanical check in this fallback; compensate with
  more frequent manual re-reads of anything you quote.
- **Scripts misbehaving?** Run `bash ./scripts/self-test.sh` — it distinguishes
  an environment problem (missing/broken dependencies) from a usage problem.

## Step 1 — Reading purpose

If the user hasn't said why they're reading this book, ask one question:
"What do you want out of this book?" Purpose isn't a formality — it decides
which chapters get a deep pass and which get skimmed, and it's the yardstick
Step 4's synthesis is judged against.

Once you know the purpose, propose a mode using `mode_hint` plus that purpose
(e.g. a 40k-token book read for one narrow question can stay in overview even
though it would technically fit; a 200k-token book read to write a literature
review needs study mode regardless of size). Let the user confirm or override.

If the source is a paper, thesis, or survey rather than a book, read
[references/paper-mode.md](references/paper-mode.md) now — it maps Keshav's
three-pass method onto this same pipeline and tells you when the full
workspace apparatus is worth the overhead versus when passes 1–2 belong
inline in the conversation.

## Step 2 — Inspectional pass (both modes)

Build a seed, then confirm it against the real book:

```bash
bash ./scripts/extract-structure.sh <workspace>/source.txt
```

Treat its output as a noisy first guess, not ground truth — cross-check it
against the table of contents. Then:

1. Use `read-pages.sh` on the table of contents, preface/introduction,
   conclusion/final chapter, and index if present.
2. Skim first and last paragraphs of 2–3 sampled chapters.
3. Write `map.md` using the template in
   [references/note-templates.md](references/note-templates.md).
4. Once `map.md`'s classification field is filled in, read the matching
   section of [references/genre-strategies.md](references/genre-strategies.md)
   before starting the analytical pass — practical books, imaginative
   literature, history, science and math, philosophy, and textbooks/reference
   works each shift the reading in ways that are cheap to apply up front and
   expensive to retrofit into notes you've already written.

With the structure confirmed, make it durable and cut it into pieces:

```bash
# id  from  to  title  — one line per chapter, tab-separated
printf 'ch01\t9\t34\tThe Activity of Reading\n' > <workspace>/chapters.tsv
bash ./scripts/split-chapters.sh <workspace>/source.txt <workspace>/chapters.tsv
bash ./scripts/build-diagram.sh <workspace> --append
```

`split-chapters.sh` gives every chapter a self-contained file — useful for the
analytical pass and essential if you fan out to subagents. `build-diagram.sh
--append` drops a Mermaid `mindmap` of the confirmed structure into `map.md`
under a `## Structure diagram` heading; it's re-runnable without duplicating
the block.

**Overview mode stops here**: deep-skim only the 2–4 chapters most relevant to
the reading purpose (openings, closings, key sections), extend `map.md` with a
goal-directed summary, present it to the user, done. No per-chapter notes, no
synthesis, no verification pass.

**Study mode continues to Step 3.**

## Step 3 — Analytical pass (study mode)

Loop over chapters in `chapters.tsv` order. If the book is composed of many
micro-chapters (1–10 pages each), don't write one note per micro-chapter —
group them by the author's own part/section divisions instead. The target is
one note per coherent argument unit, not one per heading; a 67-chapter book
might correctly merge down to 16 part-level notes. For each resulting unit:

1. Read the chapter — from `chapters/chNN-*.txt`, or `read-pages.sh` /
   Read-tool in batches if you skipped splitting.
2. Write `notes/chNN-<slug>.md` using the template in
   [references/note-templates.md](references/note-templates.md): the question
   this chapter answers, key terms (also mirror each into the cross-chapter
   `terms.md` ledger), leading propositions, arguments (premises →
   conclusion), evidence offered, quotes with `(p. N)`, tensions or links to
   other chapters, and open questions.
3. **Recite** (the SQ3R step): with the note drafted, re-skim the chapter and
   check every proposition and quote against the text before moving on. Fix
   the note now, while the chapter is still fresh — not later during
   synthesis. Once the note passes this check, let the chapter leave working
   memory; the note is the memory from here on.

**Fan-out option**: if subagents are available and `mode_hint` flagged the
book as large, you may spawn subagents instead of looping sequentially. Group
chapters into batches per subagent — balance each batch's word count rather
than assigning strictly one chapter each — and give each subagent: its
batch's page range(s), the reading purpose, the note template path, and the
scripts path. Have each subagent return its `terms.md` rows in its final
message rather than writing them directly, so you (the orchestrator) merge
all contributions into `terms.md` centrally — parallel subagents writing the
same file directly is a race. You keep ownership of `map.md`, the merged
`terms.md`, and the Step 4 synthesis — don't delegate those. Sequential
reading is the default and works everywhere; fan-out pays off even when
subagents can't run in parallel, because the benefit is context isolation —
each batch gets a fresh context window — not just speed.

## Step 4 — Synthesis

Read the notes now — not the book. Write `synthesis.md` answering Adler's four
questions, each claim carrying a page cite:

1. What is the book about as a whole?
2. What is being said in detail, and how?
3. Is it true, in whole or in part?
4. What of it? — answered specifically against the user's stated reading
   purpose, not in the abstract.

Alongside the four questions, hand-author a Mermaid `graph` — a concept and
argument map showing which key terms and propositions feed which conclusions,
across chapters — built from `terms.md` and the chapter notes. This is
intelligence work, not mechanical: it's the argument-level counterpart to the
structural mindmap `build-diagram.sh` drew in Step 2, and no script can
produce it because it requires judging which ideas actually depend on which.

## Step 5 — Verify

Run the mechanical check first:

```bash
bash ./scripts/verify-quotes.sh <workspace>
```

For every `FAIL` or `NEAR` line, re-open the cited pages with `read-pages.sh`
and fix either the quote text or the page number, then re-run until it exits
0. This catches fabricated quotes and off-by-a-page citations, but it can only
check quotes — it can't check paraphrase.

So finish by hand: pick the 5–10 most load-bearing paraphrased claims in
`synthesis.md` and re-verify them by targeted re-reading of the cited pages.
Mark each `✓ verified` in a short verification log at the bottom of
`synthesis.md`, per the template.

## Answering from existing notes

In a later session, or mid-session after synthesis, don't re-read the book to
answer a question. Search the workspace first — `grep` across `terms.md` and
`notes/` — and answer from what's there. Only when the notes don't cover the
detail, follow the page anchors they carry into `source.txt` with
`read-pages.sh` or `search-book.sh`. The whole point of the workspace is that
one follow-up question shouldn't cost a full re-read.

## Critical judgment

Adler's etiquette for the "is it true" question: don't judge before you can
fairly restate the author's position — that's exactly what the Recite check
in Step 3 is for. Then keep three verdicts distinct:

- "The author is wrong here" — backed by page-cited reasons.
- "The author is incomplete" — a gap, not an error.
- "I cannot verify this" — say so rather than guessing.

Disagreement without a page-cited reason isn't criticism, it's opinion — don't
present it as the former.

## Syntopical reading

For a question spanning multiple books or papers, run the pipeline once per
work — each gets its own workspace and `synthesis.md`. Then write a
comparative synthesis across those `synthesis.md` files: where the works
agree, where they conflict, and a neutral terminology for the shared topic
that doesn't privilege any single author's vocabulary.

## Communication

Work in the language the user used to ask. The deliverable is the synthesis
(or, in overview mode, the goal-directed summary) placed directly in the
conversation — the workspace files are the durable byproduct, worth pointing
to but not a substitute for answering in-chat.
