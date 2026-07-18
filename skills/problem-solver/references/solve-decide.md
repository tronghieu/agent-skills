# Solve and Decide

Diagnosis earns the right to generate solutions; this reference covers
spending that right well — divergence aimed at the verified cause, then
a decision the user makes with evidence in view.

## Entering Solve

Take an energy checkpoint first. Diagnosis is mentally expensive, and
solution generation done tired produces the first three obvious ideas
and a shrug. Offer the break honestly — the workspace holds the state,
and "resume tomorrow at Solve" is a fine outcome.

Then set the target: solutions address **the verified root cause**, not
the original complaint. The bakery's problem statement was "1 in 4
orders late"; its Solve prompt is *"prep capacity: custom cakes take
~50 minutes against 30-minute slots"* — a different, better question.

## The brainstorm-coach handoff

Divergent ideation is brainstorm-coach's home turf — if it's
available, invoke it rather than half-running it. Pass a clean brief:

- **Topic** — the root cause, phrased generatively: not "prep capacity
  problem" but "how might a solo baker absorb 2× custom-cake demand
  without late orders?"
- **Constraints** — from statement.md and the diagnosis (solo
  operation, no storefront, weekend peaks), plus success criteria.
- **Seed ideas** — the parking lot from Frame (the user's original
  smuggled solutions, e.g. *hire a second deliverer*) enters as
  `(user)` ideas, first-class citizens of the session.
- **The trace rule** — ask the session to note, per idea, which cause
  it addresses; ideas addressing none are welcome during divergence
  and get the symptom-patch label at converge (below).

brainstorm-coach's converge output (Immediate / Future / Moonshots /
Insights, user's top 3) flows back in as the option set for Decide.

**If brainstorm-coach isn't installed:** say it exists in this family
(github.com/tronghieu/agent-skills), then run a lightweight inline
divergence — same user-first spirit, two or three rounds, not a
firehose:

1. Invite the user's ideas first — including the parked ones — captured
   verbatim, tagged `(user)`.
2. Run 2–3 techniques suited to cause-directed ideation: **assumption
   busting** (list what the current setup takes for granted — "every
   cake is made after the order" — and flip each), **what-if
   scenarios** ("what if weekend customs required 48h pre-order?"),
   **resource constraints** ("what would you do if you could hire
   nobody and spend nothing?").
3. Build on the user's ideas with labeled `(AI)` additions, 2–4 per
   round, then converge into a shortlist together.

Never block the pipeline on the missing skill, and never let the
fallback quietly become an AI idea-dump — the family's commit-first
rule (user generates first, AI builds after, everything labeled)
applies inline too.

## Trace discipline

In `solutions.md`, every option names its target:

```markdown
- Pre-order window for custom cakes (48h) — (user) → addresses A2
  (prep-slot mis-estimate) by making demand schedulable
- Batch-prep base layers on Thursdays — (AI) → addresses A2 by cutting
  per-cake marginal time
- Discount code for late deliveries — (user, parked) → SYMPTOM PATCH:
  addresses customer anger, not lateness. Pair with a causal fix;
  see also the fixes-that-fail loop risk in diagnosis.md.
```

Symptom patches are legitimate — sometimes the bleeding must stop
before the surgery — but they're *labeled*, paired with a causal fix,
and never presented as the fix. An unlabeled symptom patch is how the
same problem gets "solved" three times.

## Decide

**Criteria come from the user.** Offer the usual suspects —
effectiveness against the root cause, feasibility, cost, time, risk —
then ask what actually matters here; a solo owner may rank "doesn't
consume Sundays" above cost. Three to five criteria; more turns
judgment into arithmetic.

**Right-size the apparatus.** Two real options → a direct comparison in
prose (strengths, weaknesses, the one deciding difference). Three or
more distinct options → a decision matrix. Never build the matrix for
show.

**Every score cites evidence or confesses ignorance.** The rule that
kills scoring theatre:

| Option | Effectiveness | Feasibility |
|---|---|---|
| 48h pre-order window | high — directly converts the timed 50-min finding into schedulable slots | high — Instagram order form already supports it `[verified — user]` |
| Hire weekend helper | high — adds capacity where the tree says it's short | `unknown — assumption`: no candidate identified, cost unknown → log A5 |

Scores of `unknown — assumption` are honest entries, and they feed the
assumption log — a decision made on three unknowns should *look* like
one.

**Recommend, then step back.** Give one recommendation with: the
rationale in terms of the diagnosis, your confidence, and **what would
change it** ("if the timed preps had come back at 35 minutes, the
helper option would lead instead"). That last clause is the honesty
mechanism — a recommendation that nothing could change wasn't reasoning,
it was preference.

**The gate: the user decides.** Record their decision and its rationale
in `decision.md` — including where they diverged from your
recommendation, without relitigating it. Options not chosen stay in the
file with a one-line note on what would revive them; the pivot triggers
in Plan may send the user back here.
