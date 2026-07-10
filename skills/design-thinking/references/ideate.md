# Ideate: Diverge Wide, Then Converge Hard

Ideate turns the Define phase's HMWs and POVs into a portfolio of concepts
worth prototyping. The phase has exactly two moods, and the single biggest
way to wreck it is letting them bleed into each other. Everything below
exists to keep divergence honest (grounded in evidence, not just plentiful)
and convergence rigorous (criteria-driven, not a popularity contest).

## Contents

- [Entry / exit](#entry--exit)
- [Diverge, then converge — as separate sittings](#diverge-then-converge--as-separate-sittings)
- [The prep pack](#the-prep-pack)
- [The lens roster](#the-lens-roster)
- [Converge](#converge)
- [ideas.md format](#ideasmd-format)
- [Portfolio pick](#portfolio-pick)
- [Failure modes](#failure-modes)

## Entry / exit

**Enter when:** the Define gate has closed — the user picked 3–5 HMWs — and
the prep pack below is assembled. Ideating before the HMW pick wastes the
divergence on a search space the user hasn't chosen.

**Exit when:** `ideas.md` holds a deduped, scored portfolio built *with* the
user, and the user has picked 1–3 concepts to prototype at the ⛔ gate, with
each pick's open assumptions written down for the Test handoff.

## Diverge, then converge — as separate sittings

Ideate has two modes, and they run in that order, in separate sittings, with
an explicit announcement of which one the room is in:

- **Diverge:** judgment is deferred. Volume and variety matter more than
  quality. A weird idea is not filtered at the point of generation — filtering
  is convergence's job, and doing it early starves convergence of the raw
  material it needs to be useful.
- **Converge:** judgment is ruthless. Every idea earns its place with
  criteria and evidence, not vibes.

Mixing them kills both. Judging while diverging quietly re-selects for
"ideas the facilitator already likes," collapsing variety before anyone
sees what was on the table — the portfolio ends up as one idea wearing
three costumes. Diverging while converging reopens the pool mid-scoring,
so the group re-litigates whether a new idea "counts" instead of finishing
the comparison it started. Say out loud which mode is active — "we're
diverging now, nothing is being filtered" / "we're converging now,
everything on the table gets scored" — so the shift is a decision, not a
drift.

## The prep pack

Before any lens generates a single idea, assemble what every ideator sees.
Skipping this step is the most common way Ideate quietly disconnects from
Empathize and Define — a lens with no prep pack just riffs on the problem
statement, which reinvents whatever the team already knew before starting
the project.

The prep pack:

- **Selected HMWs and POVs** from `hmw.md` — the ones the user picked at the
  Define gate, not the full brainstormed list.
- **Key insights `[I#]`** those HMWs trace back to — enough of the evidence
  chain that a lens can ask "does this idea actually serve the insight, or
  just the surface question?"
- **Personas** from `personas.md`, with their evidence-strength labels
  intact (a proto-persona should read as tentative here too).
- **An existing-solutions scan**, cited `[S#]` in `research/sources.md`:
  desk research on how competitors and adjacent domains already answer
  these HMWs — direct competitors, adjacent-market analogues, the top
  results a user would find searching for the same need. For a real
  competitor lane, use the market-researcher skill if it's installed
  (suggest it once per SKILL.md's rule if it isn't, and respect a no); light
  inline searches with `[S#]` citations otherwise.

Why the scan matters: ideating blind reinvents page one of the app store. A
lens that doesn't know CompetitorX already ships the obvious "reversible
top-up" flow will spend its budget rediscovering that instead of pushing
past it. The scan isn't there to kill ideas that already exist elsewhere —
see [Portfolio pick](#portfolio-pick) — it's there so the team knows, from
the first idea onward, what "past the obvious" looks like.

## The lens roster

This is the one place in the whole skill where parallel subagent fan-out
genuinely pays off. A single mind generating ideas sequentially anchors on
its first few good ones and quietly narrows; independent lenses running in
parallel don't see each other's output until convergence, so they can't
groupthink toward the same three ideas from six different angles. If
subagents are available, run one per lens, each handed the full prep pack
plus its own charter, in parallel. If not, run the lenses one at a time in
separate sittings, finishing and setting aside one lens's output entirely
before opening the next, so lens 2 isn't unconsciously drafting off lens 1.

Pick 3–5 lenses that fit the problem — not all six by default. A B2B
workflow problem may skip Extreme users; a mature category with many
incumbents leans on SCAMPER and Inversion; a genuinely novel need leans on
First-principles and Technology-led.

**First-principles.** Ignore every current solution, including the ones in
the scan. What does the need behind `[I#]` minimally require, stripped of
any assumption about how it's usually delivered?
> *Seed:* "If [persona] had never seen an app do this, what's the smallest
> thing that would satisfy the need in I3?"

**Analogous domains.** Someone, somewhere, has already solved a
structurally similar problem — often nowhere near this industry. Emergency
rooms triage under uncertainty; casinos manage anxious first-time
high-stakes moments; kindergartens onboard total novices into unfamiliar
systems fast.
> *Seed:* "Who else solves 'build trust before an irreversible action from
> a nervous first-timer'? How would a casino cashier handle this moment?"

**SCAMPER on existing solutions.** Take what the scan found and run it
through Substitute / Combine / Adapt / Modify / Put to another use /
Eliminate / Reverse. Systematic transforms of a known solution surface
ideas that pure invention misses.
> *Seed:* "CompetitorX's top-up flow uses a progress bar [S3] — what if we
> Eliminate the commitment step it implies, or Reverse it into a
> withdrawal-first preview?"

**Extreme users.** Design for the edge case already sitting in the
evidence — not a hypothetical edge case, the one a real participant lived:
the overwhelmed, the expert power user, the person on a bad connection.
Solutions built for the edge often work better for the middle than
solutions built for an imagined "average" user.
> *Seed:* "P5 abandoned mid-flow after a dropped connection [S6] — what
> would a top-up flow look like designed first for offline resilience?"

**Inversion / constraint-flip.** How would we make this problem worse on
purpose? List the ways, then flip each one. Separately, take a constraint
everyone treats as fixed (must be one screen, must not require support
contact) and remove or exaggerate it.
> *Seed:* "What's the design that maximizes hesitation at first top-up?
> Now invert every element of it."

**Technology-led.** What do current capabilities — AI, automation, new
platform primitives — newly make cheap that used to be expensive? This
lens is the one most prone to solutionism, so it still starts from `[I#]`,
not from "wouldn't it be cool if."
> *Seed:* "What could real-time fraud-risk scoring make possible for I3
> that a static confirmation dialog couldn't?"

Each lens returns **8–15 ideas**. For every idea: a title, a 2-line
concept, and which HMW/`[I#]` it serves. An idea with no HMW/`[I#]` tag
gets flagged at the door — it's either untethered from the evidence, or
the tag was skipped and needs filling in before it enters the pool.

## Converge

Announce the mode switch, then work the combined pool from every lens in
two steps:

1. **Dedupe and affinity-group.** Multiple lenses will independently land
   near the same concept — that's a signal, not noise (convergent ideas
   from independent lenses are often the strongest candidates). Cluster
   near-duplicates, keep the sharpest phrasing, and note which lenses
   converged on it.
2. **Score the shortlist** on Desirability / Feasibility / Viability, 1–5
   each (worked example in [ideas.md format](#ideasmd-format) below).

Two rules keep the table honest:

- **A Desirability score must cite evidence** — `[I#]` or `[S#]`. A
  Desirability score with no citation is a guess wearing a number; write
  "unknown — assumption A-candidate" instead of inventing a 3.
- **Feasibility and Viability scores get a one-line rationale** or the same
  honest "unknown — assumption A-candidate" — these often *are* unknown
  this early, and that's fine; the table's job is to say so plainly, not to
  paper over it.

Do this scoring **with the user, in conversation** — never generate the
table and hand it over as a verdict. The table is a structure for a
conversation and a way to surface which assumptions are load-bearing, not
a formula that computes a winner. Watch for **scoring theatre**: assigning
crisp numbers to things nobody actually knows just because the table wants
a number. A confident 3.5 built on nothing is worse than an honest
"unknown" — it launders a guess into something that looks measured.

## ideas.md format

```markdown
# Ideas — Round 1

## Shortlist scores

| Idea | Desirability | Feasibility | Viability | Notes |
|------|:---:|:---:|:---:|-------|
| Reversible top-up preview | 4 [I3][S1][S5][S6][S8][S9] | 3 — needs hold/void rail | 3 — unknown, A-candidate | Analogous + SCAMPER |
| Guided first-timer walkthrough | 3 [I3][I5] | 4 — mostly UI work | 3 — unknown, A-candidate | First-principles |

## Concept: Reversible top-up preview

**Serves:** POV-2, HMW-4 · **Persona:** The cautious first-timer

A pre-confirmation screen that shows the exact reversal path (how to void,
how long the hold lasts) *before* the user commits funds, borrowing the
"look before you pay" pattern from [S3] retail checkout flows.

**Evidence for desirability:** 5 of 6 interviewees hesitated specifically
at first top-up, citing fear of an irreversible mistake, not distrust of
the app generally [I3][S1][S5][S6][S8][S9].

**Open assumptions (→ tests/assumption-map.md):**
- A1: A visible reversal path reduces hesitation more than it reduces
  perceived speed/trust (unknown — desirability risk).
- A2: A hold/void payment rail is feasible within the current provider
  contract (unknown — feasibility risk, unconfirmed with backend team).

## Concept: Guided first-timer walkthrough

**Serves:** POV-2, POV-3 · **Persona:** The cautious first-timer

*(same structure: concept, evidence for desirability, open assumptions)*
```

The `Open assumptions` list is the handoff into Test — every assumption
named here should reappear with an `A#` id in `tests/assumption-map.md`.

## Portfolio pick

⛔ **Gate.** The user picks **1–3 concepts** to prototype. A healthy pick
often pairs one safe bet (grounded, feasible, close to what the scan
already showed works) with one bold bet (higher desirability upside,
higher unknowns) — a portfolio of near-identical safe ideas wastes the
divergence work; a portfolio of only bold ideas leaves nothing to fall
back on if Test goes badly.

An idea that already exists in the market is not automatically dead —
most good ideas do. What matters is naming the differentiation or the
execution bet explicitly: is this concept better because of a specific
insight competitors miss (cite `[I#]`), a segment they underserve, or an
execution detail (speed, cost, integration) worth staking the prototype
on? "It's like CompetitorX" is a fine starting point as long as the record
says *why this one, anyway* — otherwise the prototype just re-proves what
the scan already showed.

## Failure modes

- **Converging in the same breath as diverging.** Judging ideas as they're
  generated instead of in a separate sitting — collapses variety before it
  exists.
- **Ideas untethered from any insight.** A concept with no `[I#]`/HMW tag
  is a solution looking for a problem; trace it or cut it.
- **The scan skipped.** No existing-solutions research before generating —
  reinvents what a five-minute search would have surfaced.
- **Scoring theatre.** Crisp numbers assigned to unknowns instead of
  writing "unknown — assumption A-candidate."
- **One mega-idea instead of a portfolio.** Combining every promising
  fragment into a single "does everything" concept defeats the point of
  prototyping — nothing gets tested cheaply, and failure can't localize to
  a specific assumption.
- **Letting the loudest lens win.** A lens that produced the most polished
  writeup isn't automatically the strongest concept — convergence runs on
  the evidence in the table, not on which pitch read best.
