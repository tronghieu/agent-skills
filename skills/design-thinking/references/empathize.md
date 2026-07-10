# Empathize: Designing Research You Don't Run

Empathize is the phase where the temptation to fabricate is strongest and the
payoff for resisting it is highest — the whole workspace inherits whatever
gets registered here. Read this before writing `research/plan.md`, a
discussion guide, an observation sheet, or anything that lands in
`research/`. The job of the Research designer lens is narrow: design good
instruments, hand them to the user, and wait. Nothing in this file produces
user data — it produces the *means* to collect it.

## Contents

- [Entry / exit](#entry--exit)
- [The core stance](#the-core-stance)
- [Research plan](#research-plan)
- [Discussion guide craft](#discussion-guide-craft)
- [Observation plan](#observation-plan)
- [Surveys](#surveys)
- [Practice interviews and the simulation rule](#practice-interviews-and-the-simulation-rule)
- [Data intake protocol](#data-intake-protocol)
- [Desk research in this phase](#desk-research-in-this-phase)
- [Exit criteria and the gate](#exit-criteria-and-the-gate)
- [Failure modes](#failure-modes)

## Entry / exit

**Enter when:** the Kickoff gate has closed — `project.md` holds a frame the
user confirmed — and the workspace is initialized. Without a confirmed frame,
a research plan optimizes for the wrong question.

**Exit when:** real evidence is registered in `research/sources.md` and the
exit-check questions below pass — or the user explicitly opts into
hypothesis-only mode (everything downstream then carries the label per
SKILL.md). The ⏸ in the middle of this phase — user out collecting data — is
part of the phase, not an exit.

## The core stance

Non-negotiable 2 is the whole phase in one sentence: you design the research,
the user runs it. That split exists because the user has something no amount
of skill can substitute for — actual access to actual users. Your value is
upstream of that: turning a vague "we should understand our users better"
into a plan a person can execute this week, and a guide that surfaces truth
instead of politeness.

Everything you produce here is an instrument, not a finding. A research plan
is not data; a discussion guide is not a transcript; a practice run-through
is not an interview. Hold that line even when a quick "what users probably
think" sketch would be faster — non-negotiable 1 makes that sketch a bug the
moment it's presented as anything but a hypothesis. The phase ends not when
you've written enough, but when the user has collected enough real evidence
to register in `research/sources.md`.

## Research plan

Write `research/plan.md` before touching a discussion guide — the plan
decides which method fits which question, and a guide written before that
decision is usually the wrong instrument wearing the right words.

Derive research questions from `project.md`, specifically from what the team
must *learn*, not what would be nice to *hear confirmed*. "Do users want
this feature" is a pitch in disguise and will produce leading interviews
downstream. "What do users currently do when X happens, and what does that
cost them" is a research question.

```markdown
# Research Plan — round 1

## RQ1: How do first-time users decide whether to trust the app with real money?
- **Method:** 1:1 semi-structured interviews
- **Participants:** used a competing/adjacent product in the last 3 months;
  mix of completed and abandoned onboarding
- **Screener:** "Signed up for a [category] app in the last 3 months? Did
  you finish setup, or stop partway?" — recruit both answers
- **Sample:** 6–8 (see rationale below)
- **What the user does:** recruit via support/waitlist contacts, schedule
  45-min video calls, record with consent, drop transcripts in `research/raw/`

## RQ2: Where do existing users abandon the top-up flow, and why?
- **Method:** support-ticket mining (last 90 days) + 3–4 follow-up interviews
  with churned users
- **What the user does:** export tickets to `research/raw/`, pull a
  churned-user contact list for interview recruiting

## RQ3: How big is the segment that cites "trust" vs "price" as the blocker?
- **Method:** survey — deferred until RQ1/RQ2 themes exist to quantify (see Surveys)
```

**Sample guidance.** Start with 5–8 per distinct segment — not a magic
number, but a reflection of what qualitative interviewing is *for*: finding
the shape of a problem space, not measuring its prevalence. Themes typically
stabilize well before 8, with new participants repeating rather than
introducing (see [Exit criteria](#exit-criteria-and-the-gate)). A bigger n
doesn't fix a bad guide; a smaller n with a sharp one beats a large n with a
leading one. Treat each segment as its own 5–8, not one pooled number.

Name explicitly what the user will physically do — recruit how, schedule
how, record how (with consent), where files land — or "interview users"
leaves the hard parts to improvisation.

## Discussion guide craft

This is the highest-leverage artifact in the phase — a bad guide produces
data that looks like insight and isn't. Write a full guide, not a question
list; pacing matters as much as wording.

```markdown
# Discussion Guide — Round 1, RQ1 (45 min)

## Warm-up (5 min) — put them at ease, get full sentences before it matters
- "Tell me about your day-to-day — what's your phone mostly for?"

## Context (10 min) — establish their relationship to the category
- "Walk me through the last time you tried a new [category] app."
- Probe: "What happened right before you decided to try it?"

## Deep-dive: the trust moment (20 min) — the RQ1 target
- "Tell me about the last time you put real money into an app for the first
  time. Walk me through it, step by step."
- Probe: "What were you thinking right before you tapped confirm?"
- "Was there a moment you almost didn't go through with it?"
- Ladder: "Why did that matter to you?" → "And why does that matter?"
  (2–3 rounds, until answers reach a motivation rather than a surface reason)
- "Show me — do you still have that app? Which screen do you remember
  hesitating on?" (screen-share, if possible)

## Wrap (10 min) — close open loops
- "Anything I should have asked and didn't?"
- "Of everything we talked about, what mattered most to you?"
```

Question-quality rules, each with the reason attached — the reason is what
tells you when a rule bends:

- **Past behavior over speculation.** "Tell me about the last time you
  topped up" beats "Would you use one-tap top-up?" People predict their own
  future behavior badly; they narrate a specific memory with more fidelity.
- **Open over closed.** "What made you hesitate?" beats "Did the fee make
  you hesitate?" A closed question hands over your hypothesis, and a polite
  person will often confirm it rather than correct you.
- **No leading.** "How did that make you feel?" beats "That must have been
  frustrating, right?" A leading question plants the answer inside itself —
  the transcript will look like evidence and be an echo.
- **Never pitch the product.** The guide explores the problem space, not
  enthusiasm for a solution. Describing "our new feature" contaminates every
  answer after it with social desirability.
- **Ladder "why" to reach motivations.** The first "why" answer is usually a
  surface justification; gentle repetition ("and what makes that matter to
  you?") tends to reach the real one. Stop when answers start repeating.
- **Probe, don't prompt.** "What happened next?", "Tell me more", "Show me"
  extend the participant's account without injecting yours. A probe that
  starts "Was it because…" has quietly become a leading question.

Underneath all of it: people are polite (they shade answers toward what
pleases the interviewer), they misremember (feelings especially get
reconstructed to match the outcome), and they predict themselves badly.
Past, specific, unprompted narration routes around all three.

## Observation plan

Watching beats asking wherever the gap between stated and actual behavior
matters — workflow steps people have stopped noticing, workarounds they've
normalized. If RQ1 needs "how do people actually navigate top-up," a
screen-share beats asking someone to recall it from memory. Use a simple
AEIOU sheet per session:

```markdown
# Observation Notes — Session O2
- **Activities:** what the person does, step by step
- **Environments:** device, physical/digital context, competing attention
- **Interactions:** person-to-system, person-to-person moments
- **Objects:** tools, screens, artifacts touched or referenced
- **Users:** who else is present or implicated

## Raw notes — timestamped, verbatim where possible
## Immediate reactions (fill in within the hour) — what surprised you
```

## Surveys

A survey's job here is narrow: quantify a pattern the qualitative work has
already surfaced, once you know what to ask. A survey written before any
interviews mostly measures the author's assumptions — its multiple-choice
options are themselves a hypothesis about the answer space, and that
hypothesis is usually wrong until interviews have shaped it. Default order:
interviews first, survey after, with items lifted from participants' own
language rather than invented from a whiteboard.

## Practice interviews and the simulation rule

Role-playing a participant so the user can rehearse pacing and laddering is
genuinely useful and explicitly allowed by non-negotiable 2. Two rules keep
it safe:

1. **Announce it every time**, before it starts: "I'll play a participant so
   you can practice — this is a rehearsal, not data." Never let it blend
   into a real session's transcript.
2. **Never register it.** A practice interview gets no `[S#]`, no row in
   `research/sources.md`, no place in `research/raw/` — per the "Simulated —
   never evidence" grade in `insight-discipline.md`. If a practice run
   surfaces a good follow-up question, fold it into the *guide*; the
   *evidence base* stays untouched by rehearsal.

## Data intake protocol

When the user brings real data back, run the same sequence every time:

1. **File lands in `research/raw/`** as close to original form as possible —
   don't summarize on intake; summarizing is synthesis and belongs to
   Define, with its own citations.
2. **Register it in `research/sources.md`** immediately: next `[S#]` in
   sequence, participant handle if it's an interview, evidence grade, dates.
3. **Debrief the user** — this catches what never makes it into notes:
   "What surprised you?", "Anything that didn't make it into the notes —
   tone, hesitation, something off-script?", "How did you recruit this
   participant — through what channel, any prior relationship to the
   product?"
4. **Append the debrief to the raw file**, attributed to the user and dated,
   as context rather than new evidence rows. Recruiting bias ("from our beta
   Slack") belongs in the record — it shapes how far the sample generalizes.

## Desk research in this phase

Light desk research is fine for context and existing-signal scanning — how
the category talks about the problem, competitor review complaints,
published research already covering the territory. Cite everything `[S#]`,
grade it Secondary, and keep it supporting: it can suggest what to ask
about, never what the answer is.

When the desk research is scene-setting only, prefer qualitative framing
("industry reports consistently describe onboarding drop-off as
trust-driven [S1]") over copying precise statistics. Every exact figure you
transcribe is a misattribution opportunity — adjacent sources swap numbers
in memory — so register a specific stat only when it will actually bear
weight in a decision, and then re-check it against the fetched page per
`insight-discipline.md`.

Heavier market questions — sizing, competitive landscape, demand-signal
aggregation — belong to the market-researcher skill, not ad hoc searches here
(suggest it once if not installed, respect a "no," per SKILL.md).

## Exit criteria and the gate

Empathize ends when the evidence base is enough to synthesize honestly, or
when the user explicitly opts into hypothesis-only mode (non-negotiable 3 —
everything downstream then carries that label per SKILL.md). Before
recommending the move to Define, check:

1. **Signal saturation** — across the last 2–3 sessions in a segment, are
   new interviews confirming existing themes rather than introducing new
   ones?
2. **Segment coverage** — does every segment in the research plan have a
   minimal evidence base, or is one silent? Silence isn't agreement.
3. **Contradictions surfaced, not buried** — are disagreeing sessions still
   visible in the raw files, not quietly set aside?
4. **The user's explicit call** — has the user said "this is enough" or "I
   want to proceed without more, label it hypothesis"? Don't infer readiness
   from a lull in activity.

## Failure modes

- **Fabricating or "improving" notes** — cleaning up a transcript, filling a
  gap with what someone "probably meant," composing a "representative"
  quote: each is a fabrication per non-negotiable 1.
- **Interviewing only fans or friends** — produces enthusiasm, not evidence;
  flag it in the debrief and in `research/sources.md` Notes.
- **The guide that pitches** — describing the solution before exploring the
  problem contaminates every answer that follows.
- **Treating one loud participant as the market** — a vivid quote is an
  anecdote; insights need "N of M" counts.
- **Skipping the debrief** — the five minutes after a session often holds
  the most honest, least-scripted information.
