# Define: From Evidence to Insight

Define is the pivot from research to design: the Synthesizer takes whatever
landed in `research/raw/` and registered in `research/sources.md` and
compresses it into insights, personas, POV statements, and How-Might-We
questions — the handful of sentences Ideate will actually work from.
Everything here cites `[S#]`/`[I#]` per the schema in
`references/insight-discipline.md`; read that first, since this file
assumes it and doesn't restate it.

## Contents

- [Entry / exit](#entry--exit)
- [Affinity mapping](#affinity-mapping)
- [From clusters to insights](#from-clusters-to-insights)
- [Personas](#personas)
- [POV statements](#pov-statements)
- [HMW questions](#hmw-questions)
- [Gate 1 — insight audit](#gate-1--insight-audit)
- [Loop-back note](#loop-back-note)
- [Failure modes](#failure-modes)

## Entry / exit

**Enter when:** `research/sources.md` has registered evidence and raw files
sit in `research/raw/` — or the user explicitly opted into hypothesis-only
mode in Empathize. A user arriving mid-process with a stack of notes enters
here too, after a light Kickoff registers what they brought.

**Exit when:** insights, personas (if earned), and POVs are written; Gate 1
(insight audit) has run and its report sits in `phase-state.md`; and the
user has picked 3–5 HMWs at the ⛔ gate. The HMW pick is the exit — it sets
Ideate's entire search space.

## Affinity mapping

Affinity mapping done on paper is physical: sticky notes, a wall, hands
moving things until clusters emerge. Working in files reconstructs the same
discipline in two passes instead of one shuffle.

**Pass 1 — extract.** Read every raw source and pull out atomic
observations: one specific thing one person said or did, one per line,
tagged with its source and participant handle. Resist summarizing while
extracting — that's a Pass 2 job, and doing it early smuggles in
interpretation before the evidence is laid out.

One hard rule inside the extract lines: if a line keeps quotation marks,
the words inside are verbatim from the raw file — shorten only with a
marked ellipsis (…), each kept segment word-for-word. To compress, drop
the quotation marks and paraphrase openly instead. A trimmed sentence
still wearing quote marks reads as the participant's exact words, and
working notes don't get a laxer standard: extract lines are exactly what
later files copy from, and the verifier's quote check reads them too.

```markdown
- [S1, Mai] Checked the price three times before the first top-up.
- [S1, Mai] "I signed up in two minutes, then stared at the top-up screen for a week."
- [S5, P2] Asked a friend to test the app first before trying it herself.
- [S6, P3] Compared total cost across three competitors before committing.
- [S6, P3] Didn't read the privacy policy at all.
- [S8, P4] Abandoned checkout once, came back two days later, completed it.
- [S9, P5] Said the free trial made her "less nervous, not more excited."
- [S2, survey] 61% of respondents cited "not sure if this is legit" as a signup concern (n=112).
```

**Pass 2 — cluster bottom-up.** Group observations by the *tension* they
share, not the *topic* they mention. Topic is what the interview guide
already imposed — clustering by topic just hands back the guide's own
structure and calls it synthesis. Tension is the underlying pull: what the
person wants versus what they're guarding against.

```markdown
### Cluster A: Pays for certainty, not speed
Users don't optimize for the fastest path to value — they spend real time
and effort buying confidence that nothing bad will happen.
- [S1, Mai] Checked the price three times before the first top-up.
- [S6, P3] Compared total cost across three competitors before committing.
- [S9, P5] Said the free trial made her "less nervous, not more excited."
- [S2, survey] 61% cited "not sure if this is legit" as a signup concern (n=112).

### Cluster B: Trust is proxied through other people, not the product
When users can't verify safety themselves, they borrow someone else's
verification instead of reading what the product tells them.
- [S5, P2] Asked a friend to test the app first before trying it herself.
- [S1, Mai] "I signed up in two minutes, then stared at the top-up screen for a week."

### Orphans
- [S6, P3] Didn't read the privacy policy at all. — cuts against Cluster A's
  "buying confidence" framing; no clear tension yet, needs more data.
- [S8, P4] Abandoned checkout once, came back two days later, completed it. —
  could belong to Cluster A (deliberation) or be its own thing (a cooling-off
  pattern); not enough support to commit either way.
```

A topic label — "pricing," "trust," "onboarding" — would have swallowed
these eight into two or three buckets and told you nothing the interview
guide didn't already know. The tension label ("pays for certainty, resents
paying for time") is the thing worth building a product decision on.

Keep an explicit **orphans pile**. Forcing an observation into the nearest
bucket to make the wall look tidy destroys information; orphans wait for
more evidence, or just stay orphans — not every observation earns an
insight.

## From clusters to insights

A cluster is raw material; an insight `[I#]` is the claim you're willing to
design against. The test: does it explain *why*, not just *what* — and is
that why non-obvious enough that someone could act on it differently once
they know it?

```markdown
Topic summary (not an insight): "Users care about price."
Insight: "Users pay for certainty, not speed [I2]." — this changes what you'd
build: not a faster checkout, but more visible proof-of-safety at the moment
of payment.
```

Good insights share three properties: they explain **multiple**
observations at once (a single observation is an anecdote, not a pattern —
say explicitly if one is meant to stand alone); they generate a
**different design direction** than the topic summary would (if insight and
topic summary lead to the same feature, dig for the actual why); and they
carry their own **counter-evidence** (if nobody in the data disagreed, say
why that's plausible rather than treating unanimity as automatically true).

Write each insight using the block format from `insight-discipline.md`
(Evidence / Interpretation / Status / Confidence), with contradictory
evidence folded into the block itself:

```markdown
## I2 — Users pay for certainty, not speed
- **Evidence:** deliberation before payment shows up across price-checking,
  competitor comparison, and trust-borrowing behavior [S1][S2][S5][S6][S9].
  "I signed up in two minutes, then stared at the top-up screen for a week"
  [S1, Mai].
- **Interpretation:** the friction users report isn't about how many steps
  the flow has — it's about how reversible the first real-money action
  feels. A faster flow would make the same anxiety happen faster.
- **Status:** evidenced (5 of 6 primary sources; one survey stat as
  secondary support)
- **Confidence:** medium-high. Counter-evidence: P4 didn't read the privacy
  policy at all [S6] — contradicts a "wants proof of safety" reading;
  possible segment split between careful comparers and impulsive testers,
  open question for round 2.
```

Cluster A above maps to this insight directly — the cluster's tension
statement and the insight's interpretation say almost the same thing.
Naming the tension well during clustering does most of the synthesis work
before the insight block is even written.

## Personas

Build a persona only when it earns its keep. The test: **would the
segments answer the top HMW differently?** If a "cautious first-timer" and
a "power user" would both want the same thing from, say, a reversible
top-up flow, they're one persona wearing two labels — merging them is more
honest than the illusion of segmentation. If they'd genuinely diverge (one
wants proof of safety, the other wants speed and finds safety cues
patronizing), the split earns a second persona because it will change what
Ideate produces. Most Define rounds on a small interview set produce **one
persona, or none** — shipping zero because the data doesn't support a split
is a correct, honest outcome, not a failure to synthesize.

Evidence banner and per-attribute citation rules, plus the proto-persona
opt-in for desk-research-only projects, live in `insight-discipline.md`
("Personas: labelled by evidence strength") — follow that schema exactly.
When in doubt about a detail, leave the field blank rather than filling it
in for color: a blank field costs nothing, a fabricated one poisons every
decision built on it.

## POV statements

A point-of-view statement is the Define phase's thesis: user + need +
insight, in one sentence, each part traceable. The madlib:

> `[Persona/segment] needs [need, as a verb] because [insight] [I#].`

```markdown
POV-2: A cautious first-timer [persona] needs to feel reversibility at the
first real-money action [I3], because for her, trust is built by exits, not
promises [I3][I5].
```

**Needs are verbs, not features.** "Needs to feel reversibility" opens a
wide design space — undo, escrow, trial credit, a visible refund path.
"Needs an undo button" has already picked the answer and closed the space
before Ideate gets a turn. If a drafted need reads like a UI element,
rewrite it as the underlying capability the user is actually after.

Write **1–3 POV statements**, no more — ten POVs isn't synthesis, it's
observations with a template wrapped around them. Draft candidates, then
choose the final set *with the user*: which tension deserves the project's
attention is a prioritization call the facilitator surfaces, not one it
makes alone.

## HMW questions

Generate **8–15 HMW candidates per POV**, then select **3–5 with the user**
— this selection is a gate (⛔), not a formality, because the chosen HMWs
define the entire search space Ideate will explore. A narrow HMW set
produces a narrow idea portfolio no matter how creative the ideation lens
gets afterward; get the framing right here.

Every HMW traces to its POV and inherits its citations:

```markdown
HMW-4 (from POV-2): How might we make the first top-up feel as reversible
as window shopping?
```

Three quality checks, applied to every candidate before it's offered to the
user. **Altitude:** too broad reads like a mission statement, nothing to
design against; too narrow reads like a feature spec, the solution's
already picked.

```markdown
Too broad:  HMW build trust in our product?
Too narrow: HMW add a 30-day money-back guarantee banner to the top-up screen?
Good:       HMW might we let users try a real transaction with training wheels on?
```

The good version names the *shape* of a solution space — reversibility,
made tangible before the irreversible moment — without naming the solution.
**No embedded solution:** "HMW add a chatbot to answer trust questions?" has
smuggled the answer in — it will only ever generate chatbot variants; strip
it back out until the question opens options instead of picking one.
**Traceability:** an HMW that doesn't cite a POV is brainstorming
decoration — cut it or trace it back; if a candidate feels important but
traces to nothing, that's a sign a POV is missing, not a reason to keep it
untraceable.

## Gate 1 — insight audit

Before HMW selection, run the verifier's insight audit — the full checklist
(trace check, quote check, status check, leap check, coverage check,
persona fabrication sweep) is in `insight-discipline.md` under "The
verifier gates"; don't duplicate it here. Run it as a separate subagent
when one is available — independence is what makes the audit worth running.

The gate report is appended to `phase-state.md`, and flags go to the user,
not into a silent edit. If the audit downgrades I3 from `evidenced` to
`hypothesis`, that changes what POV-2 and HMW-4 can honestly claim — say so
and let the user decide whether to proceed with the downgrade labelled,
gather more evidence first, or drop that direction. The facilitator's job
is to surface the flag, not to resolve it unilaterally.

## Loop-back note

Define gets re-entered constantly — a new interview round lands, a Test
result falsifies an assumption and sends the project back here, or the user
just wants to revisit a POV after Ideate stalls. On re-entry:

- **Update statuses in place**, don't rewrite history. An insight moving
  from `hypothesis` to `validated (T2)` gets its status line edited;
  evidence and interpretation stay as originally written, with new evidence
  appended if it changes the picture.
- **New insights get new ids.** Never renumber `I3` to fill a gap or reuse
  an id a falsified insight vacated — every existing artifact already cites
  the old numbering.
- **The journal explains the delta.** `journal.md` records what changed
  and why: "round 2 Define: I4 falsified by T2, added I7–I9 from interviews
  7–10, POV-2 unchanged, POV-3 dropped (no longer supported)." A reader
  should reconstruct the project's thinking from the journal alone.

## Failure modes

- **Topic summaries dressed as insights.** "Users want it to be easy" is a
  restatement of the research question, not an insight — if the
  interpretation could apply to almost any product, it hasn't found the
  actual why.
- **Persona fiction.** A vivid, made-up age, city, or job title that no
  source supports. It makes the persona feel real, which is exactly the
  danger — readers stop asking for evidence once something feels true.
- **HMW with a solution hiding inside.** Easy to write, because
  solution-shaped questions feel productive; costly, because they quietly
  cap Ideate's search space before it starts.
- **Forcing every observation into a cluster.** A tidy wall with no orphans
  usually means real signal got bent to fit a convenient bucket.
- **Running the gate as a rubber stamp.** Ticking the insight-audit
  checklist without reopening the raw sources defeats the point of Gate 1
  — it exists to catch exactly the confident, fluent error a checklist
  skimmed at speed will miss.
