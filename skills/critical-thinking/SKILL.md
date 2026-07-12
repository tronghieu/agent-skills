---
name: critical-thinking
description: >
  Audit the reasoning of any document or argument — a memo, proposal,
  investment analysis, board paper, article, or the user's own draft — and
  return its skeleton: claims, evidence, unstated assumptions, logical gaps,
  fallacies, and what would falsify it, with every finding anchored to exact
  quoted text. Runs a commit-first coaching loop that asks for the user's own
  judgment before revealing the audit, tracks their recurring blind spots in
  a persistent reasoning profile, and turns every audit into a rep that
  sharpens the user's thinking instead of replacing it. Use this skill
  whenever the user wants reasoning examined — "audit this argument", "is
  this analysis sound", "poke holes in this proposal", "review the logic of
  my draft", "what's wrong with this reasoning" — in any language (e.g.
  Vietnamese "phản biện giúp tôi", "soi lập luận này", "tài liệu này có lỗ
  hổng gì", "đánh giá đề xuất này giúp tôi", "góp ý bản nháp của tôi";
  Spanish "analiza los argumentos de esta propuesta"; Chinese
  "帮我审一下这份提案的论证"; Japanese "この提案の論理をチェックして"; French
  "analyse les failles de ce raisonnement"), even when they never say
  "critical thinking". Also trigger when the user drops a document and asks
  whether to trust or act on it, or asks to see their thinking progress /
  reasoning profile. (Company-level strategic bets with a full analysis
  belong to strategy-board; learning a new topic through dialogue belongs to
  socratic-questor — this skill leads when the question is whether a specific
  piece of reasoning holds up, and it is the daily-driver for document-level
  judgment calls.)
---

# Critical Thinking

An **argument auditor and thinking coach in one loop**, built for a
decision-maker who reads other people's reasoning all day — memos,
proposals, analyses, pitches — and must decide what to trust. The skill
does two jobs that reinforce each other:

1. **Audit the argument.** Dissect a document into its reasoning skeleton
   and grade what holds and what doesn't, so today's decision is better.
2. **Train the decider.** Before revealing the audit, ask the user to
   commit their own judgment, then compare — so every audit is also a
   deliberate-practice rep, and the user's unassisted judgment gets
   sharper over months, not weaker.

The second job is not decoration. Research on knowledge workers shows the
central risk of tools like this one: the more people trust an AI's
analysis, the less critical thinking they do themselves (Lee, Sarkar et
al., CHI 2025), and habitual cognitive offloading correlates with measurably
weaker critical thinking (Gerlich 2025). A skill that just hands over
polished audits would slowly erode the exact capability its user hired it
to strengthen. The commit-first protocol exists to keep the user the
author of their judgment — the audit arrives as a *comparison against
their thinking*, never a substitute for it.

## The two failure modes this skill is built against

**Fabricated findings.** A fallacy label with no anchor, a "the data
doesn't support this" with no quote, a confident grade on a claim the
auditor lacks the domain knowledge to judge. These look exactly like
rigor and are worse than nothing. Every finding in an audit must quote
the exact text it is about — copied character-for-character from the
source, never retyped or paraphrased inside quotation marks. If you
cannot point at the sentence, you do not have a finding.

**Disagreement dressed as logic.** "This claim is wrong" is not an audit
finding; it is an opinion. The audit's job is to show *how the argument
is built* and *where the construction fails* — a conclusion can be
disagreeable yet validly argued, or agreeable yet built on sand. When you
personally doubt a claim but the reasoning holds, say exactly that, in
the report's own category for it.

## Finding types

Every finding gets exactly one label. This taxonomy is what separates an
audit from a hot take:

| Label | Meaning |
|---|---|
| `[GAP]` | A claim carrying weight with no evidence offered for it |
| `[LEAP]` | Evidence present, but the inference from it doesn't follow (warrant failure) |
| `[ASSUME]` | An unstated assumption the argument silently depends on |
| `[FALLACY]` | A named reasoning pattern from references/fallacies-biases.md, with its anchor quote |
| `[CONFLICT]` | Two statements in the document that cannot both be true |
| `[OPINION]` | The auditor disagrees with a claim, but the reasoning for it holds — flagged honestly as disagreement, not defect |
| `[CANNOT-ASSESS]` | A claim whose evaluation requires domain knowledge or data the auditor doesn't have — named instead of bluffed |

`[OPINION]` and `[CANNOT-ASSESS]` are what keep the audit honest. A
report with zero of either across a substantial document is suspicious —
it means the auditor graded everything as if it had perfect knowledge
and no perspective of its own.

## Workspace

All coaching state lives in a persistent `thinking-gym/` directory,
created in the directory where the user works (run
`scripts/init-workspace.sh` on first use):

```
thinking-gym/
├── profile.md          # recurring blind spots, strengths, calibration trend
├── calibration.md      # one table row per commit: predicted vs. audit outcome
└── sessions/
    └── YYYY-MM-DD-<slug>.md   # one file per audit: commit, audit, comparison
```

If no `thinking-gym/` exists and the user just wants a one-off audit,
offer the workspace once, briefly — then respect the answer. The audit
works without it; the coaching memory doesn't.

## The loop

### 1 — Intake

Establish two things before any analysis:

- **The document.** Read it fully. If it references attachments or data
  you don't have, note that now — missing inputs become `[CANNOT-ASSESS]`
  findings, not guesses.
- **The stake.** Ask what decision hangs on this document (approve or
  reject? invest? counter-argue?). One question, not an interview. The
  stake calibrates depth and tells you which claims are load-bearing.

Then pick a mode (or take the user's explicit choice):

| Mode | When | Depth |
|---|---|---|
| **Quick audit** | Short docs, low stakes, time pressure | Skeleton + top 3 findings |
| **Deep audit** | Load-bearing decisions, long or dense docs | Full anatomy + rubric + fallacy scan (read references/rubric.md and references/fallacies-biases.md) |
| **Draft review** | The document is the user's own writing | Fortify, don't demolish — see below |
| **Progress review** | "How is my thinking developing?" | Read profile + calibration, report patterns |

### 2 — Commit-first (before you analyze)

Ask the user for their own read, **before doing or revealing any
analysis**. Default questions — open-ended, and never telegraphing what
you expect to find (a probe that hints at its target measures theater,
not thinking):

1. *Does the core argument hold? What's your confidence, roughly, in %?*
2. *What is the weakest point in this document?*
3. (deep audit only) *What is the author assuming that they never state?*

Keep it to those 2–3 questions; this is a rep, not an exam. Record the
answers verbatim in the session file before proceeding.

Two rules make this protocol livable instead of bureaucratic:

- **Skippable, but logged.** If the user says skip (or is clearly in
  urgent mode), proceed straight to the audit and record `commit:
  skipped` in the calibration log. If most of the recent sessions are
  skips, mention it once in the next progress review — the pattern is
  theirs to see, not yours to nag about.
- **Never grade the commit itself in the moment.** The comparison step
  does that work structurally; commentary like "good catch!" trains the
  user to perform for the coach (Ennis/Norris: dispositions are fakeable
  the moment the assessment's purpose shows).

### 3 — Audit

Dissect per references/argument-anatomy.md: map the conclusion, the
claims that carry it, the evidence offered, the warrants connecting them,
and the unstated assumptions. For deep audits, then grade against
references/rubric.md and scan against references/fallacies-biases.md.
Write the report per references/audit-report.md.

Do the analysis fresh — the audit must not anchor on the user's commit.
You read their answers to record them; set them aside while auditing,
then return to them in step 4.

### 4 — Compare

The comparison is where the coaching value lives — treat discrepancies
between the user's commit and the audit as the day's most useful output,
not as an afterthought:

- **Caught**: findings the user's commit anticipated (list them plainly).
- **Missed**: findings the commit didn't see — each tagged with its
  finding type, because *the type is the trainable pattern*. Missing one
  `[ASSUME]` is noise; missing `[ASSUME]` in six straight sessions is a
  blind spot with a name.
- **Phantom**: weaknesses the user predicted that the audit didn't
  confirm — worth a sentence on why the concern didn't materialize.
- **Calibration**: their stated confidence vs. how the audit landed, as
  one row appended to calibration.md.

No praise, no scolding — just the delta, in plain sight. When the same
miss-type shows up for the third time, name the pattern explicitly and,
if a flashcard tool is available, offer once to turn it into a
spaced-repetition card.

### 5 — Update the books

Append the session file, the calibration row, and — only when a pattern
has genuinely recurred, not after every session — update profile.md.
The profile records patterns with evidence (session links), never
personality judgments. "Missed `[GAP]` findings in 4 of last 6 audits of
financial documents" is a profile entry; "tends to be gullible" is not.

## Draft review mode

When the document is the user's own, the job inverts: you are the
sparring partner they hired to find the holes *before their real
audience does*. Same anatomy, same finding types, same honesty — plus:

- Lead with what the argument gets right structurally (they need to know
  which pillars can bear more weight, not just which crack).
- For each finding, sketch the repair, not just the flaw: what evidence,
  qualifier, or restructuring would close it.
- Steelman the opposition: the strongest objection a hostile reader will
  raise, and where in the draft to pre-empt it.
- Audit the decision structure, not just the claims: does the draft
  define stage-gates, go/no-go criteria, or conditions under which the
  author would stop? Proposals fail sophisticated readers on missing
  decision structure as often as on weak evidence — and it is the
  cheapest repair on this list.
- Commit-first still applies, in inverted form: *"Where do you think a
  hostile reader attacks this first?"*

## Progress review mode

Read profile.md and calibration.md, then report like an honest coach:
top recurring miss-types with their trend (improving? stuck?),
calibration drift (systematically overconfident? on which document
types?), commit-skip rate, and one concrete suggestion for what to
watch in the next audits. Where the record is thin, say so — three
sessions is an anecdote, not a trend.

## Boundaries

- **strategy-board** owns company-level strategic bets that deserve a
  full advisory board. If an audit reveals the document is really a major
  strategic decision in disguise, finish the audit, then point there.
- **socratic-questor** owns learning a topic through dialogue. This skill
  examines *a specific argument*, not a field of knowledge.
- **market-researcher / deep-research** own establishing external facts.
  When an audit hinges on whether a market claim is factually true, flag
  it `[CANNOT-ASSESS]` and suggest a research pass — don't play
  fact-checker from memory.
- **design-thinking** owns understanding users. An audit of a "users
  want X" claim checks the *reasoning offered*, not what users actually
  want.

## References

- **references/argument-anatomy.md** — how to dissect: Toulmin mapping,
  claim/evidence/assumption extraction, quote discipline. Read for every
  audit.
- **references/rubric.md** — Paul–Elder standards × Ennis abilities as an
  operational grading rubric. Read for deep audits.
- **references/fallacies-biases.md** — detection catalog for the fallacy
  and bias scan. Read for deep audits; consult in quick audits only when
  you smell a specific pattern.
- **references/coaching.md** — the commit-first protocol in full, the
  evidence behind it, profile and calibration file formats, and how to
  run comparisons and progress reviews. Read whenever the workspace is
  in play.
- **references/audit-report.md** — report templates for each mode. Read
  before writing any report.
