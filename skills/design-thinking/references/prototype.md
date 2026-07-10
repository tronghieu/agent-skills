# Prototype: Building Just Enough to Learn Something

The Prototype phase turns a chosen concept from `ideas.md` into something a
user can react to. Read this before writing anything into `prototypes/`. The
discipline here is narrower than it looks: a prototype is not a preview of
the product, it is an instrument built to answer one named question as
cheaply as possible. Everything below exists to stop the natural drift toward
building more than the question requires — the drift that turns a two-hour
paper mock into a week of polish nobody asked for.

## Contents

- [Entry / exit](#entry--exit)
- [A prototype answers a question](#a-prototype-answers-a-question)
- [The fidelity ladder](#the-fidelity-ladder)
- [The prototype spec](#the-prototype-spec)
- [What the agent can build itself](#what-the-agent-can-build-itself)
- [Competing prototypes](#competing-prototypes)
- [Hand-off to Test](#hand-off-to-test)
- [Failure modes](#failure-modes)

## Entry / exit

**Enter when:** the Ideate gate has closed — the user picked 1–3 concepts,
each with a concept block in `ideas.md` naming its open assumptions. A user
arriving mid-process with an existing concept enters here after a light
Kickoff records it.

**Exit when:** every spec passes the hand-off test at the bottom of this
file — named question, explicit real-vs-faked line, behavioral signals —
so the Test designer can write pass/fail criteria without asking what the
prototype is for. Polish is not an exit criterion.

## A prototype answers a question

Every prototype spec opens with a question, not a description. "A concierge
booking flow for busy parents" is a description; "will a parent trust a
human-run waitlist enough to hand over their card details?" is a question.
If you cannot write the question as the spec's first line, stop — you are
about to build, not prototype, and building without a question produces
inventory, not learning.

The question names one or more candidate assumptions from the idea. These
become formal `A#` entries when the Test designer builds the assumption map
in `tests/assumption-map.md` (see `references/test.md` and the "Assumptions
and test ids" section of `references/insight-discipline.md`), but the
prototype spec names its candidates up front, in plain language, so the link
is never reconstructed after the fact:

```markdown
Question: will a parent trust a human-run waitlist enough to hand over their
card details before seeing a confirmed sitter?
Assumption candidates: parents will pay before matching (desirability);
a manual matching process feels fast enough to not break trust (feasibility,
perceived).
```

A prototype that answers a question nobody asked is worse than no prototype —
it produces confident-sounding signal about the wrong thing, and that signal
gets cited later as if it settled something it never touched.

## The fidelity ladder

Fidelity is not a quality dial, it is a cost dial — every rung up multiplies
build time and, more dangerously, multiplies attachment to the artifact
itself. The rule is simple and easy to violate under pressure: **choose the
lowest rung that can actually answer the question.** A question about
whether the flow makes sense does not need working code; a question about
whether the payment integration behaves under real load does not get
answered by a sketch.

- **Sketch / storyboard** — hand-drawn or lightweight digital frames of the
  key moments. Answers: does the *flow* make sense, to us and then to a
  user walking through it out loud? Cannot answer: whether real copy,
  layout, or interaction details work.
- **Paper or clickable wireframe** — low-fidelity screens, tappable but not
  visually finished. Answers: can a user navigate the moment that matters
  without getting lost? Cannot answer: whether they'd actually rely on or
  pay for the service behind the screen.
- **Wizard-of-Oz / concierge** — the interface (or a human standing in for
  it) looks real; a person manually does the work behind the curtain.
  Answers: is the *service* valuable when delivered, even badly, by a human
  pretending to be the system? Cannot answer: whether the automated version
  is technically buildable at the quality or cost the business needs.
- **Landing page / fake door** — a real page describing the offer with a
  genuine call to action. Answers: does anyone want this enough to take a
  real action, unprompted, outside a research session? Cannot answer:
  whether the thing they signed up for works once delivered.
- **Functional slice** — a narrow, real, working implementation of the one
  technically risky part. Answers: does the risky technical bit actually
  work end to end? Cannot answer: desirability at scale.

Ethical care on fake doors: never take real money for something that
doesn't exist yet unless the user has explicitly decided to (and can fulfil
or refund honestly), and tell people afterward, where appropriate, that
they were part of a test — silently taking signups you'll never honor burns
trust the project may need later.

## The prototype spec

One file per prototype: `prototypes/<n>-<slug>.md`. The spec must be
complete enough that someone who wasn't in the room can build it, and that
the Test designer can write pass/fail criteria against it without asking
what it's for.

```markdown
# Prototype 3 — Concierge waitlist

**Question this prototype answers:** will a parent trust a human-run
waitlist enough to hand over card details before seeing a confirmed sitter?

**Assumption(s) targeted:** parents will pay before matching (desirability);
manual matching feels fast enough not to break trust (feasibility,
perceived). [Formalized as A4, A5 once tests/assumption-map.md exists.]

**Concept embodied:** "Concierge sitter matching" — concept block in
ideas.md, serving [I7].

**Fidelity rung:** Wizard-of-Oz. Chosen over a landing page because the
question is about trust *during* a multi-step interaction, not click intent
— a fake door can't carry that.

**What's real vs. faked:**
- Real: the signup form, the card-details step (Stripe test mode, no live
  charge), a WhatsApp number that reaches an actual team member.
- Faked: "matching algorithm" — a human reads submissions and replies within
  30 minutes acting as if a system produced the match.

**Storyboard:**
1. Parent lands on signup page, describes the sitting need.
2. Parent is asked for card details "to hold the match" — the moment under
   test.
3. Parent receives a WhatsApp message within 30 minutes with a "matched"
   sitter profile (hand-picked by the team, not algorithmically matched).
4. Parent confirms or declines the match.

**Build notes:** Typeform for signup + Stripe test-mode card capture; team
member monitors submissions and replies manually via WhatsApp. Agent drafts
the Typeform copy and the WhatsApp script; a human runs the concierge side
live.

**Signals to watch:** completion rate through the card-details step (not
just page views); time-to-abandon if they drop at that step; unprompted
questions asked over WhatsApp about how matching works; whether anyone asks
for a refund/cancellation before being matched.

**Done when:** at least 15 parents have reached the card-details step and
the drop-off point is legible enough to write a pass/fail number against.
```

Keep "signals to watch" behavioral, not evaluative — "abandoned at card
step" is a signal; "seemed hesitant" is an opinion waiting to be
rationalized after the fact. Behaviors are what the Test designer can turn
into numeric or observable pass/fail criteria; opinions can't be falsified.

## What the agent can build itself

Several rungs are cheap enough for the agent to build directly when the user
agrees: sketch/storyboard text and layout descriptions, landing-page HTML,
clickable mocks (static HTML with linked screens), concierge scripts and
reply templates, Wizard-of-Oz operating instructions. Offer to build these
when they're this cheap — it moves the project forward without waiting on
design tools or engineering time.

But building is not testing. A finished landing page sitting on a server
with nobody sending traffic to it, or a clickable mock nobody has walked
through, is inventory — it cost effort and produced zero learning. A built
prototype only starts earning its cost once it has a test card attached
(`tests/`) and a real person's reaction against it. Don't let "I built the
thing" read as progress on its own; the phase isn't done until someone has
reacted to it.

Before committing to a heavier rung, run a quick desk feasibility check when
the question is about whether something *exists* or is *possible* in
principle — "does an API/service/technology for this exist" — cited `[S#]`
in `research/sources.md` like any other desk claim. This is a fast sanity
check, not a substitute for the deeper market or feasibility research that
belongs to the market-researcher skill per SKILL.md's desk-research rules;
route anything beyond a quick check there.

## Competing prototypes

When two concepts, or two takes on the same concept, are both cheap to build
at a low rung, build both rather than one. A single artifact tends to get
polite praise — a user reacting to it alone has nothing to compare against
and defaults to agreeableness. Two artifacts side by side give the user
something to react *against*: "I liked A more because..." surfaces the actual
deciding factor in a way "yes, this seems fine" never does. Reserve this for
rungs where doubling the build is genuinely cheap (sketches, wireframes,
landing-page copy variants) — don't double a Wizard-of-Oz or functional
slice just for comparison's sake; the cost stops being trivial well before
that rung.

## Hand-off to Test

The Prototype phase is finished, not when the artifact looks polished, but
when the Test designer can pick up the spec and write pass/fail criteria
without coming back to ask what the prototype was for. That means, by the
time a spec is marked done, it carries:

- a named question and assumption candidate(s) the test card will formalize
  as `A#`,
- an explicit real-vs-faked line so the test doesn't accidentally validate
  the faked part,
- behavioral signals to watch, phrased so a criterion like "≥40% of
  submissions complete the card-details step" can be written directly
  against them.

If any of these three is missing or vague, the spec isn't done — send it
back rather than letting Test invent the missing piece, which is how a test
ends up measuring something the prototype was never built to answer.

## Failure modes

- **Gold-plating.** Polishing visuals, copy, or interactions well past what
  the question needs — usually procrastination in the costume of diligence.
  Ask whether the next hour of polish changes what the user will learn.
- **The drifting prototype.** Scope creeps mid-build ("while we're at it,
  let's also show...") until the artifact answers three vague questions
  instead of one sharp one. Reread the spec's first line before adding
  anything.
- **Specs too vague to build from.** "A mock of the onboarding flow" with no
  storyboard, no real-vs-faked line, no signals — unbuildable and
  untestable at once. The worked example above is the bar.
- **Testing the polish, not the assumption.** A high-fidelity mock draws
  feedback on font size and color instead of the underlying question. If
  users keep commenting on visuals when the question is about trust or
  demand, the rung was chosen too high.
- **Falling in love with the artifact.** The team defends the prototype
  instead of treating it as disposable. One that survives a failed test
  unchanged, propped up by "but it looks so good," has stopped serving the
  process — every rung is meant to be thrown away once it has answered its
  question.
