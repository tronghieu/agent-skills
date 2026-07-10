# Test: Designing Falsification, Not Confirmation

Test is where the whole workspace finally meets reality. Everything upstream —
insights, personas, POVs, the chosen concept, the prototype — has been
disciplined about evidence, but discipline about evidence is not the same
thing as being right. Read this before writing `tests/assumption-map.md` or
any `tests/T#-*.md` file. The job of the Test designer lens is narrow, same
shape as Empathize's: design an instrument sharp enough to fail, hand it to
the user, and wait. A test the concept cannot fail isn't a test — it's a
ritual that produces the feeling of validation without the substance.

## Contents

- [Entry / exit](#entry--exit)
- [The stance](#the-stance)
- [The assumption map](#the-assumption-map)
- [The test card](#the-test-card)
- [Method menu](#method-menu)
- [Gate 2 — assumption audit](#gate-2--assumption-audit)
- [While the user runs the test](#while-the-user-runs-the-test)
- [The learning card](#the-learning-card)
- [The loop decision](#the-loop-decision)
- [Failure modes](#failure-modes)

## Entry / exit

**Enter when:** at least one prototype spec meets the hand-off bar in
`references/prototype.md` (named question, real-vs-faked line, behavioral
signals), and the hypothesis labels accumulated across the workspace are
available to harvest. A user arriving mid-process with a built prototype
enters here after a light Kickoff registers it.

**Exit when:** Gate 2 (assumption audit) has run, the user has executed the
test, the learning card is written with every touched status updated, and
the loop decision — persevere / iterate / pivot / stop — is recorded in
`phase-state.md` and `journal.md`. The ⏸ while the user runs sessions is
part of the phase; an unrecorded loop decision means the phase isn't done.

## The stance

Non-negotiable 2 applies here exactly as it does in Empathize: you design the
experiment, the user runs it. You pick the method, write the script, set the
threshold, and build the results template — but you never generate, simulate,
or extrapolate what a test participant would say or do and present it as a
result. A "predicted result" belongs in the test card as a stated hypothesis,
clearly labelled as a prediction; it never migrates into the learning card as
if it were data.

The goal of a test is falsification, not confirmation. A well-designed test
gives the concept a real chance to lose — a fake-door page that gets no
clicks, a usability test where nobody completes the task, a pricing probe
where nobody pre-orders. If you can't picture what a *failed* version of this
test looks like, the test isn't finished yet — you've written a demo, not an
experiment. A test that cannot fail costs the same time and money as one that
can, and returns nothing but false confidence.

## The assumption map

Before picking a test, write `tests/assumption-map.md` — every load-bearing
assumption the chosen concept depends on, harvested from three places: the
concept's block in `ideas.md`, the prototype specs in `prototypes/`, and any
`(hypothesis — needs validation)` label that has accumulated in `insights.md`
or `personas.md`. Missing one of these sources is how the riskiest assumption
ends up nowhere on the map — it's usually sitting in a prototype spec's
"assumes..." line, not in the idea's headline pitch.

```markdown
# Assumption Map — round 1, concept: "Reversible top-up flow"

| A# | Assumption | Depends on | Evidence today | Impact if wrong | Uncertainty |
|----|-----------|-----------|-----------------|------------------|-------------|
| A1 | Users will trust a "hold, don't charge" first top-up more than a standard one | Idea-3, Prototype P1 | [I3] (hypothesis) | H | H |
| A2 | Users can find and understand the "hold" state without explanation | Prototype P1 screens 3–4 | none | M | H |
| A3 | The feature is technically buildable within a 2-week hold window per payment provider terms | Idea-3 | S4 (desk, provider docs) | H | L |
| A4 | Users who complete a held top-up convert to a real one within 48h | Idea-3 business case | none | H | H |
| A5 | "Reversible" framing doesn't read as untrustworthy on its own ("why would they let me undo this?") | Prototype P1 copy | I5 (hypothesis) | M | M |
```

Rules: one row per assumption, phrased as a falsifiable claim ("users will
X"), not a feature description ("the hold feature"). **Depends on** links
back to the idea/prototype so a reader can trace why it matters. **Evidence
today** cites `[S#]`/`[I#]` or says `none` honestly — most assumptions worth
mapping have thin or no evidence, that's why they're here and not already
`evidenced` in `insights.md`. **Impact** and **uncertainty** are each H/M/L,
judged independently — impact is "how much of the concept collapses if this
is false," not "how much would it hurt to hear."

**Pick the riskiest, not the comfortable one.** Riskiest = high impact ×
high uncertainty — above, that's A1 or A4, not A3 (already fairly well
evidenced by desk research) and not A2 (real but lower stakes: a confusing UI
is fixable, a wrong trust hypothesis is not). The classic error is testing
A3 first because it's easy and comes back looking good — teams gravitate
toward the assumption they're least afraid of, which is exactly the one
least likely to teach them anything. Say the riskiest assumption out loud
and name why before writing the test card.

## The test card

One file per test, `tests/T<#>-<slug>.md`. The card is a pre-registration:
everything in it is fixed before a single participant is run, because a
threshold set after seeing the data isn't a threshold, it's a rationalization.

```markdown
# T1 — Reversible top-up: usability + trust signal

**Targets:** A1, A2 (assumption-map.md)
**Hypothesis:** Users shown the "hold, don't charge" first top-up will
complete it without hesitation-abandonment, and will describe it
unprompted as more trustworthy than a standard top-up. [I3, hypothesis]

**Method:** Moderated usability test with prototype P1 (see Method menu)

**Participants:**
- Who: adults who have used a competing or adjacent payment app in the
  last 3 months, never used our product
- How many: 5 (see Method menu — usability tests saturate fast)
- How recruited: a recruiting panel or the support/waitlist list, **not**
  friends, colleagues, or the internal beta Slack — a friend already wants
  you to succeed and reads intent generously; the point is people with no
  stake in a "yes"

**Procedure (script for the user):**
1. "I'm going to show you a prototype of a payment app. Think out loud as
   you go — say whatever you're thinking, even if it seems obvious."
2. Task, read verbatim: "Imagine you just downloaded this app and want to
   add $20 to try it out. Show me how you'd do that."
3. Do not say: "top up," "the hold feature," "reversible," or anything that
   names the mechanism before they find it — naming it hands them the
   answer and contaminates the trust question.
4. After completion (or 3 min): "What did you think was happening when you
   saw [the state they landed on]?" Then: "How does this compare to how
   [competitor] handles this?"
5. Debrief per the [Data intake protocol](empathize.md#data-intake-protocol).

**Metric:** (a) task completion without abandonment, (b) unprompted mention
of trust/safety/reversibility in the post-task question

**Pass/fail threshold (fixed before data collection):**
- Pass: 4 of 5 complete without abandoning, AND ≥3 of 5 mention trust/safety
  unprompted in step 4
- Fail: either condition falls below threshold — inconclusive is not a
  category here; a short number on either metric is a fail, and the
  learning card carries the nuance

**Duration / cost cap:** 5 sessions × 30 min, no incentive above $25/session,
complete within 1 week
```

Derive the sample floor from the threshold instead of asserting a round
number: at your pass threshold, how many conversions do you *expect* from N
observations, and is that count large enough that pass vs. fail isn't
noise? A workable rule of thumb is to size N so the threshold implies at
least ~10 expected successes, and to show that arithmetic in the card — "we
need ≥300 qualifying visitors because 3% of 300 ≈ 9–10 deposits" reads very
differently from "300 visitors (default)".

Write scripts, not bullet points — "show me how you'd do that" gets
behavior, "would you know how to do that?" gets a guess. The "do not say"
line matters because it's the part a well-meaning moderator breaks first,
usually by explaining the feature to help a struggling participant — the
moment that happens, the session stops measuring discoverability and starts
measuring politeness.

## Method menu

Pick the cheapest method that can actually falsify the target assumption —
not the most impressive one.

- **Usability test with a prototype** answers "can people use this, and does
  it work the way we think." Five participants surface most usability
  problems in a given flow — a widely cited heuristic, not a law of nature,
  and it degrades fast with a heterogeneous user base (run 5 per segment,
  not 5 total across three). It cannot tell you whether people will *pay*
  for the thing they just used successfully.
- **Solution interview** walks someone through the prototype anchored in
  their own past behavior ("show me the last time you did this the old
  way") — good for whether the concept fits an existing workflow or fights
  it. Weaker than a usability test for pure discoverability, since
  narration and doing diverge.
- **Fake door / landing page** measures demand before anything is built —
  a page with a real call-to-action (waitlist, buy button, "notify me"),
  tracking clicks-to-commitment. A real signal only if traffic is real and
  the offer is specific; tested on the team's own followers or a
  friends-and-family list, it measures enthusiasm for the team, not demand
  for the product — vanity traffic in, vanity numbers out. Confirm the
  traffic is actually the target segment (a qualifying question at the CTA,
  or a targeting audit), otherwise off-segment clicks dilute the
  denominator and the conversion rate measures your ad targeting, not
  demand.
- **Concierge / Wizard-of-Oz** delivers the value of the service manually (a
  human doing what the eventual feature would automate) to test whether
  people want the *outcome* before investing in the *mechanism*. Strong for
  desirability; says nothing about whether the automated version will work
  at scale.
- **Preference / comparison test** puts two prototypes in front of the same
  or split sample and asks for a choice plus reasoning — useful once you
  already believe in the *category* of solution and are choosing between
  concrete executions, not before.
- **Pricing probe** — commitment beats stated willingness every time. "Would
  you pay $10/month?" produces optimistic noise; a pre-order, refundable
  deposit, or signed letter of intent produces a real number, because it
  costs the participant something to say yes. Pricing questions without a
  commitment mechanism are hypothesis-generators, not tests.

## Gate 2 — assumption audit

Before the test card goes to the user, the Verifier runs Gate 2 — the
assumption audit — exactly as specified in
["The verifier gates"](insight-discipline.md#the-verifier-gates) in
insight-discipline.md: map completeness, riskiest-first, falsifiability,
discrimination, honest cost. Run it as a separate subagent when available —
independence keeps the audit from rubber-stamping a test the same lens just
wrote. Findings land as a gate report appended to `phase-state.md`, visibly,
before the card is handed over; don't silently tighten a weak threshold and
move on.

## While the user runs the test

⏸ Once the card is handed off, the real-world part belongs to the user —
same posture as Empathize. Useful parallel work while waiting:

- Prepare the results template (`tests/T<#>-results.md` skeleton, pre-filled
  with the pre-registered threshold so nobody has to remember it later).
- Light desk research on adjacent questions the test won't answer (e.g.,
  what similar products' onboarding metrics look like, cited `[S#]`,
  Secondary grade).
- Tidy the workspace — check `phase-state.md` and `journal.md` are current,
  confirm the next-riskiest assumption is queued in case this one passes
  clean and the project wants to keep moving.

What the user should capture during the session: raw notes or a recording
per session, saved to `research/raw/`, one file per session — same intake
discipline as Empathize. On return, each session is registered as its own
`[S#]` in `research/sources.md`, and the
[Data intake protocol](empathize.md#data-intake-protocol) debrief runs the
same way. A test session is a research session; it doesn't get a lighter
evidence bar for being late in the process.

## The learning card

`tests/T<#>-results.md` closes the loop the card opened. Write what was
predicted before looking at what happened — resist the pull to reread the
threshold "in light of" the data.

```markdown
# T1 — Results: Reversible top-up usability + trust signal

**Predicted (pre-registered):** Pass = 4/5 complete without abandonment AND
3/5 mention trust/safety unprompted.

**What happened:**
- Completion: 3 of 5 completed without abandonment [S14][S15][S16]; 2
  abandoned at the same screen, both citing confusion about what "held"
  meant [S13][S17]
- Trust mention: 2 of 5 mentioned trust/safety unprompted [S14][S16]; one
  participant said "I don't get why they'd let me undo this, feels like a
  trick" [S17, P4]

**Verdict against pre-registered threshold: FAIL.** Both conditions fell
short (3/5 < 4/5 completion; 2/5 < 3/5 trust mentions). Not written up as
inconclusive — the threshold was clear and both numbers missed it.

**Status updates:**
- A1 (assumption-map.md): `falsified (T1)` — reversibility framing did not
  read as more trustworthy in this sample; one participant read it as
  actively suspicious
- A2: `falsified (T1)` — 2 of 5 could not interpret the held state without
  explanation
- I3 (insights.md): status updated from `hypothesis` to
  `falsified (T1)` for the specific claim "reversibility signals trust
  at first top-up" — the underlying trust-matters insight I3 rests on
  stays `evidenced`, only this narrower prediction is falsified

**Decision:** pivot — see Loop decision below.
```

An honest learning card writes the fail plainly and updates every status it
touches. A falsified assumption with a clean writeup is the process
succeeding, not the project failing — say that to the user directly if the
result stings; the alternative ("mixed results, let's proceed") is how
teams quietly validate anything.

## The loop decision

Every learning card ends in one of four moves, recorded in `phase-state.md`
with the round number and reason, and echoed in `journal.md`:

- **Persevere** — the assumption held. Move to the next-riskiest row on the
  assumption map, or ship the learning forward if the map is clear.
- **Iterate** — the prototype was wrong but the underlying insight wasn't
  (A2 above: people didn't understand the *interface* for reversibility,
  which says nothing about whether they value reversibility itself). Loop
  back to **Prototype**.
- **Pivot** — the insight itself was wrong (A1: the trust hypothesis
  didn't hold, and P4's "feels like a trick" reaction suggests the
  mechanism cuts against trust, not for it). Loop back to **Define** — the
  POV needs revisiting, not just the prototype. That distinction (interface
  wrong vs. insight wrong) is what separates iterate from pivot, and it's
  worth spelling out in `journal.md` rather than leaving it implicit.
- **Stop** — the honest option when the evidence says the need isn't there.
  Not a failure state to soften; a real outcome, worth stating in the
  journal as plainly as a pass.

## Failure modes

- **Testing on friends, colleagues, or the internal beta list.** Produces
  enthusiasm data with a trust-test-shaped wrapper — flag it in the card's
  recruiting section and don't let it happen twice.
- **Setting the threshold after seeing the data.** The single fastest way a
  team convinces itself of something untrue; if the learning card's
  threshold doesn't match the test card verbatim, that's a red flag, not a
  rounding error.
- **"Users liked it" as a result.** Not a metric — liking isn't a proxy for
  completing, converting, or committing. If a metric can't be counted or
  observed, the card isn't finished.
- **Demand characteristics.** Participants performing helpfulness — praising
  the prototype because the moderator built it and is standing right there.
  The script's "do not say" lines and past-behavior anchoring both exist to
  blunt this; watch for it in the debrief too.
- **Reporting only the sessions that went well.** Every session run gets
  registered and counted, including the ones that embarrass the concept —
  a learning card built from a subset is a fabrication with extra steps.
- **Treating inconclusive as pass.** If the threshold wasn't met and wasn't
  clearly failed either, write "inconclusive" honestly and design a
  sharper follow-up test — never round an ambiguous result up to validated.
- **Skipping the loop-back because momentum feels good.** A falsified
  assumption buried under "let's keep building, we'll revisit later" is the
  process breaking exactly where non-negotiable 5 says it can't.
