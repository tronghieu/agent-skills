# Insight Discipline: Evidence, Insights, and the Verifier Gates

The machinery that makes non-negotiable 1 enforceable. Read this before
writing anything into `research/sources.md`, `insights.md`, `personas.md`,
`hmw.md`, or `tests/`. The schema exists because a fabricated user insight is
indistinguishable from a real one by looks alone — a plausible persona reads
exactly like an evidenced one. Traceability is the only defense, so a break
in the chain anywhere makes the whole workspace untrustworthy.

## Contents

- [The evidence registry: research/sources.md](#the-evidence-registry-researchsourcesmd)
- [Evidence grades](#evidence-grades)
- [Insights: the I# schema](#insights-the-i-schema)
- [Personas: labelled by evidence strength](#personas-labelled-by-evidence-strength)
- [POV statements and HMW questions](#pov-statements-and-hmw-questions)
- [Assumptions and test ids](#assumptions-and-test-ids)
- [The verifier gates](#the-verifier-gates)
- [Self-check before handing off any artifact](#self-check-before-handing-off-any-artifact)

## The evidence registry: research/sources.md

One markdown table, one row per source, ids assigned in order of first use
and never reused or renumbered. Same schema as the market-researcher skill —
deliberately, so that skill can append to this registry when called:

```markdown
# Sources

| ID | Source | Publisher | Published | Accessed | Confidence | Notes |
|----|--------|-----------|-----------|----------|------------|-------|
| S1 | research/raw/interview-01-mai.md | user interview (Mai, 34, freelancer) | 2026-07-08 | 2026-07-10 | High | User-provided notes, 45-min session |
| S2 | research/raw/survey-export.csv | user survey, n=112 | 2026-07 | 2026-07-10 | Medium | Self-selected respondents |
| S3 | [App Store reviews for CompetitorX](https://...) | App Store | current | 2026-07-10 | Medium | 40 reviews read, 1–2★ focus |
| S4 | [SEA e-wallet adoption report](https://...) | Google/Temasek/Bain | 2025-11 | 2026-07-10 | High | Desk source, market context |
```

Rules:

- **Every piece of user-provided data gets registered** the moment it lands
  in `research/raw/` — interview notes, transcripts, survey exports, support
  tickets, analytics screenshots, usability recordings. The "URL" is the file
  path; the publisher notes who/what it came from and when.
- **Interview participants get a stable handle** (name or code — "P3") in the
  Notes so insights can say *who* said what. Respect anonymity if the user
  provides anonymized data; never invent demographic details to fill a gap.
- **Desk sources need a real URL** with both dates (published, accessed) —
  and the claim you register must actually appear on that page. After
  drafting a desk claim, re-open the fetched text and confirm the number is
  there: adjacent sources swap statistics in memory more often than you'd
  think, and a real URL carrying a stat from a *different* page is a broken
  chain that looks perfectly healthy.
- One row per source, even if cited fifty times.
- When the market-researcher skill writes into this registry, it continues
  the numbering — never renumber or reorder existing rows; every artifact in
  the workspace already cites those ids.

## Evidence grades

Grade what the evidence *is*, not how much you like it:

- **Primary-strong** — verbatim transcripts, recordings, raw survey data,
  behavioral analytics, observed usage. What people actually said and did.
- **Primary-medium** — the user's own summarized notes of interviews or
  conversations; secondhand but grounded in real contact.
- **Secondary** — desk sources: reviews of competing products, forum threads,
  published research, market reports. Real people, but not *your* users, and
  selection effects apply. These support demand *signals* and context.
- **Simulated — never evidence** — role-played interviews, "what users would
  probably say", AI-generated personas of imagined users. Useful for
  pressure-testing a discussion guide; forbidden in the registry. If it was
  generated, it doesn't get an `[S#]`.

Map onto the Confidence column as High / Medium / Low; put the grade word in
Notes. Two rules of use:

1. Secondary evidence may support context and hypotheses, never a
   "users need/feel/do X" insight on its own.
2. One loud participant is an anecdote. Note how many independent sources
   support an insight ("4 of 6 interviews") — the count is part of the claim.

## Insights: the I# schema

`insights.md` is a numbered list of insight blocks. An insight is an
*interpretation* — a non-obvious "why" that explains observations — so it
must show both the evidence and the leap:

```markdown
## I3 — Trust breaks at the first real-money moment, not at signup
- **Evidence:** 5 of 6 interviewees described hesitation at first top-up,
  none at registration [S1][S5][S6][S8][S9]. "I signed up in two minutes,
  then stared at the top-up screen for a week" [S5, P2].
- **Interpretation:** onboarding friction is misdiagnosed — the design
  problem is the first irreversible action, not form length.
- **Status:** evidenced
- **Confidence:** medium-high (6 interviews, one segment only)
```

Rules:

- **Status is one of:** `evidenced` (traces to primary evidence) ·
  `hypothesis` (plausible, not yet supported — must be written as
  `(hypothesis — needs validation)` wherever cited) · `validated (T#)` /
  `falsified (T#)` (a test settled it). Desk-only support caps status at
  `hypothesis` for any claim about *your* users.
- **Quotes are verbatim or absent — in every file, working notes included.**
  A quote carries `[S#]` and the participant handle. Never smooth, translate
  without saying so, or compose a "representative" quote — a composed quote
  is a fabricated one. This rule doesn't relax for internal artifacts: an
  affinity-map extract line either quotes verbatim or paraphrases *without*
  quotation marks. To shorten a quote, mark every cut with an ellipsis (…)
  and keep each kept segment word-for-word; silently dropping words from
  inside quotation marks is fabrication in miniature, and it spreads —
  today's working note is tomorrow's copy-paste into the report. Reserve
  quotation marks for text that sits inside quotation marks in the raw
  file (participant speech); the interviewer's own paraphrase lines are
  referenced bare, with just their `[S#]` tag. A "quote" you never open is
  one you can't mis-trim — in practice most trim violations start as
  shorthand quoting of note prose, not of speech.
- Interpretation sentences don't each need a tag, but every observation they
  lean on must be tagged in the Evidence line.
- Contradictory evidence goes *in the insight block*, not in a drawer:
  "P4 explicitly disagreed [S7] — segment difference? open question."
- Downstream artifacts (personas, POV, HMW, ideas, test cards) cite `[I#]`;
  the chain reader must be able to walk `idea → I# → S# → raw file`.

## Personas: labelled by evidence strength

Personas summarize patterns across real participants — they are not
creative writing. Every persona header carries an honesty banner:

```markdown
## Persona: "The cautious first-timer"
> **Evidence base:** 6 interviews [S1][S5][S6][S8][S9][S11] + survey n=112
> [S2]. Built in round 1 Define. Status: evidenced (attitudes), hypothesis
> (willingness to pay — no evidence yet).
```

- Every attribute traces: behaviors and attitudes cite `[I#]` or `[S#]`;
  anything added for narrative color is cut or labelled
  `(hypothesis — needs validation)`.
- **Proto-personas** (built from desk research + assumptions, no primary
  data) are allowed only via the explicit opt-in in SKILL.md, and the banner
  says so: `Status: PROTO-PERSONA — no primary evidence; validate before
  building on this.`
- Demographic details that no evidence supports (age, city, job title
  invented to make the persona vivid) are the classic fabrication vector.
  Leave fields empty rather than filling them beautifully.

## POV statements and HMW questions

Both live in `hmw.md`. A POV (point-of-view) statement is the Define phase's
core output — user + need + insight, each part cited:

```markdown
POV-2: A cautious first-timer [persona] needs to feel reversibility at the
first real-money action [I3], because for her, trust is built by exits, not
promises [I3][I5].
```

How-Might-We questions open a POV into a solution space, and inherit its
citations:

```markdown
HMW-4 (from POV-2): How might we make the first top-up feel as reversible
as window shopping?
```

An HMW that cites no POV/insight is brainstorming decoration — cut it or
trace it. Details on quality (altitude, non-embedded solutions) are in
`references/define.md`.

## Assumptions and test ids

- Anything load-bearing that no evidence supports gets an assumption id
  `A#` in `tests/assumption-map.md` (format in `references/test.md`), with
  the artifact that depends on it.
- Tests get ids `T#`; a test card names the assumptions/insights it targets;
  a learning card updates their statuses (`validated (T2)`,
  `falsified (T2)`) — closing the loop is what makes the ids worth having.

## The verifier gates

The verifier is an adversarial, evidence-first audit — run as a separate
subagent when available (independence keeps it honest), otherwise as a
deliberate, separate sitting. Its output is a **gate report** appended to
`phase-state.md`: what was checked, what passed, what was flagged, what the
user must decide. Findings ship visibly; nothing is quietly fixed or
quietly dropped.

### Gate 1 — insight audit (end of Define)

For every insight in `insights.md`, every persona attribute, every POV:

1. **Trace check.** Does each `[S#]` cited actually exist in the registry,
   and does the underlying raw file actually support the claim? Open the raw
   files for the ~5 most load-bearing insights and re-read.
2. **Quote check.** Take every string in quotation marks from every
   produced file — insights, personas, working notes like the affinity map,
   and the drafted user-facing reply — and search for it in the raw files.
   A quote that doesn't appear verbatim is treated as fabricated until
   fixed. Working notes are in scope because they are what later files
   copy from.
3. **Status check.** Any `evidenced` insight resting only on secondary
   sources, or on a single participant, gets downgraded or re-counted.
4. **Leap check.** Is the interpretation the *only* reasonable reading of
   the evidence? Name one alternative explanation per key insight; if the
   alternative is live, the insight carries it as an open question.
5. **Coverage check.** Which participants/segments are over- and
   under-represented in the insight set? Silence from a segment is not
   agreement.
6. **Persona fabrication sweep.** Any persona detail with no citation and
   no hypothesis label.

One rule for acting on any gate finding: **a fix propagates to every file
that contains the flagged content — the final user-facing reply included.**
Correcting a paraphrase-as-quote in `insights.md` while the same wording
ships in the reply just moves the fabrication to the artifact the user
actually reads. Grep the workspace for the flagged string before closing
the finding.

### Gate 2 — assumption audit (before Test)

1. **Map completeness.** Do the assumption map's `A#` rows cover the chosen
   concept's desirability, feasibility, and viability? The most dangerous
   assumption is usually the one nobody wrote down.
2. **Riskiest first.** Is the test targeting the assumption that is both
   high-impact-if-wrong and low-evidence — or a comfortable one that will
   probably pass?
3. **Falsifiability.** Do pass/fail criteria exist, are they numeric or
   observable, and were they fixed *before* data collection? "Users liked
   it" is not a criterion.
4. **Discrimination.** If the test passes, does that actually support the
   assumption, or would it pass anyway (leading questions, demand
   characteristics, testing on friends)?
5. **Honest cost.** Is this the cheapest test that could falsify the
   assumption, or a disguised full build?

## Self-check before handing off any artifact

Thirty seconds, every time:

1. Any claim about users with no `[S#]`/`[I#]` and no hypothesis label? (Fix or cut.)
2. Any `[S#]` or `[I#]` that doesn't resolve? (Register it.)
3. Any quote you cannot point to in a raw file? (Remove it.)
4. Any persona detail that is narrative decoration? (Cut or label.)
5. Any secondary-only claim posing as user insight? (Downgrade to hypothesis.)
6. Any status that a test has already changed but the file still shows the
   old one? (Update — stale statuses corrupt the next round.)
