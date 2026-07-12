# Argument Anatomy — how to dissect a document

This is the dissection procedure behind every audit. The output of this
procedure — the argument map — is what makes an audit checkable: anyone
reading the report can follow each finding back to exact text and judge
for themselves. An audit whose findings can't be traced is just a second
opinion with better formatting.

## Quote discipline (read this first)

Every element you extract gets an anchor: the exact source text, **copied
character-for-character, never retyped**. Retyping "from memory" is how
paraphrases sneak inside quotation marks and findings drift from what the
document actually says. Practical rules:

- Copy the shortest span that fully carries the meaning — a clause or
  sentence, not a paragraph.
- If you must trim, mark elisions with `[...]` — never silently bridge.
- If a claim is spread across distant sentences, quote each fragment with
  its location; do not stitch a composite "quote".
- Locate every quote: section heading, page, or paragraph number —
  whatever the document offers.
- If you notice you cannot find text supporting an element you were sure
  was there, that *is* the finding (`[GAP]` or `[ASSUME]`), and a
  valuable one. The discipline is working.

## Step 1 — Find the conclusion

What is this document asking the reader to believe or do? Usually one
sentence, often in the executive summary or the last paragraph, sometimes
never stated (which is itself worth reporting — a document that implies
its conclusion without stating it is harder to argue with, and authors
know that).

Distinguish the **decision ask** ("approve the budget") from the
**belief claim** it rests on ("this market will grow 30%"). Documents
often argue hard for the belief and let the decision ride in unexamined.

## Step 2 — Extract the load-bearing claims

List the claims that, if false, would collapse the conclusion. Typically
3–7. Ignore decoration — background, hedged asides, throat-clearing.
For each claim record:

```
C1: "<exact quote>" (location)
    carries: <what part of the conclusion rests on this>
```

The test for load-bearing: delete the claim and ask whether the
conclusion still stands. If yes, it's decoration; don't audit decoration.

## Step 3 — Map each claim with Toulmin

For each load-bearing claim, fill the Toulmin frame:

- **Grounds** — what evidence does the document offer? Quote it. Note
  the *kind*: data, anecdote, authority, analogy, definition, nothing.
  When the grounds compare across a time window, run the **clock check**,
  and run it as a sweep, not a search: list every plausible alternative
  driver the window contains before judging the claim — seasonality and
  holidays (Tết, year-end), the choice of baseline itself (a low opening
  month makes any later month look like growth), one-off events, a
  concurrent campaign or price change. Finding one alternative driver is
  not the finish line; the finding should name all of them, because the
  author gets to rebut the one you name and keep the rest. A window that
  quietly includes a high season is a confound until the document rules
  it out, and authors rarely pick their comparison windows innocently.
- **Warrant** — why would the grounds support the claim? This is usually
  unstated; state it yourself in one sentence, because the warrant is
  where most bad arguments break. ("Grounds: revenue grew 40% in the
  pilot city. Warrant: the pilot city is representative of the other
  markets." — now the weakness is visible.)
- **Qualifier** — how strongly does the document itself claim it
  ("will" / "should" / "could potentially up to")? Mismatches between
  qualifier strength and evidence strength are findings.
- **Rebuttal handling** — does the document acknowledge conditions under
  which the claim fails? Absence of any rebuttal in a contested matter
  is a finding, usually `[ASSUME]` (the author assumes no serious
  counter-case exists).

Format per claim:

```
C1: "<claim quote>" (location)
  grounds:  "<evidence quote>" (location) — kind: data
  warrant:  <your one-sentence statement of the implicit warrant>
  qualifier: "<quoted hedging or certainty language>"
  rebuttal: <quoted, or "none offered">
  verdict:  holds / [GAP] / [LEAP] / [ASSUME] / [FALLACY:name] / [CONFLICT] / [CANNOT-ASSESS]
```

## Step 4 — Surface the silent assumptions

Beyond per-claim warrants, ask what the *whole argument* needs to be true
but never argues:

- **Continuity assumptions** — current trends persist, competitors don't
  react, key people stay.
- **Representativeness assumptions** — the sample, pilot, or reference
  case generalizes.
- **Incentive assumptions** — who wrote this and what do they gain if
  it's approved? Not an accusation — a lens. A sales-led forecast and a
  finance-led forecast of the same deal deserve different priors, and
  the audit may say so under `[ASSUME]` (the document assumes its own
  neutrality).
- **Base-rate assumptions** — "we will succeed where most fail" requires
  arguing *why this case beats the base rate*, not just describing the
  plan. Silence about the base rate is an assumption that it doesn't
  apply.

Rank assumptions by fragility × load: an assumption that is both likely
to be false and load-bearing leads the report.

## Step 5 — The falsifiability question

For the conclusion and each surviving claim, ask: **what observable
evidence would show this is wrong, and did the author look for it?**
Three grades:

- The document names its own kill-criteria (rare, excellent — say so).
- Falsifying evidence exists and is checkable, but the document didn't
  engage with it — a finding, and a concrete next step for the user.
- The claim is constructed so nothing could count against it ("the
  market is ready for disruption") — the finding is that this is not a
  claim at all, but positioning language wearing a claim's clothes.

## What NOT to do

- Don't audit every sentence. The map covers load-bearing claims;
  exhaustiveness on decoration buries the signal a decision-maker needs.
- Don't restate the document's structure as if it were the argument's
  structure. Sections are packaging; the argument map is yours to draw.
- Don't let fluency stand in for grounds. Confident, well-written prose
  with no evidence is a `[GAP]` exactly as much as clumsy prose — more
  dangerous, in fact, and research on AI-era reading shows
  authoritative-feeling text measurably reduces readers' willingness to
  engage critically. You are the counterweight to that effect.
- Don't skip the warrant step when the evidence "obviously" supports the
  claim. Obvious warrants are where representativeness and continuity
  assumptions hide.
