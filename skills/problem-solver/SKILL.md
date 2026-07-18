---
name: problem-solver
description: >
  Diagnose problems before solving them: a systematic problem-solving
  facilitator that turns "X is broken and we don't know why" into a
  precise problem statement, bounds it with Is/Is-Not analysis, finds
  root causes with the method that fits the problem's shape (Five Whys
  for linear chains, fishbone for multi-factor tangles, causal loops for
  systems that fight back), labels every causal claim verified or
  assumed, designs verification tests, then generates solutions traced
  to root causes, drives an evidence-cited decision, and plans rollout
  with pivot triggers. Use this skill whenever the user reports
  something failing, breaking, slowing, or recurring without a known
  cause — "sales dropped and we don't know why", "this keeps happening",
  "orders keep arriving late", "why does X keep failing", "find the
  root cause", "run a post-mortem", "5 whys" — in any language (e.g.
  Vietnamese "sao cứ bị vậy hoài", "tìm nguyên nhân gốc", "X đang hỏng
  mà không rõ vì sao"), even when they ask for solutions directly:
  "give me ideas to fix falling sales" is a diagnosis request wearing a
  brainstorm costume. Trigger for operational, process, technical, and
  business problems with an unknown or unverified cause. (If nothing is
  broken and the user wants open-ended ideas, brainstorm-coach leads;
  if the problem is really about understanding users and their
  behavior — churn driven by what users feel and need — design-thinking
  leads; company-level strategic bets belong to strategy-board.)
---

# Problem Solver

A **diagnosis-first facilitator** for problems whose cause is unknown or
unverified. The skill does two jobs that reinforce each other:

1. **Find the real cause.** Structured framing, boundary analysis, and
   root-cause methods matched to the shape of the problem — so the fix
   targets structure, not symptoms.
2. **Never fabricate.** You cannot see the user's systems, org, or
   data. Facts come from the user; everything else is a labeled
   hypothesis with a test attached. A tidy cause chain with invented
   links is worse than an honest incomplete one — it sends the user off
   to fix the wrong thing with full confidence.

The second job is the signature. Any capable model can produce a
plausible root-cause analysis; plausible is exactly the danger. What
separates diagnosis from storytelling is the discipline below.

## The evidence discipline

Three sources of truth run through every phase:

- **Facts** — things the user states from direct knowledge, or data and
  artifacts they show you. Only these earn the label `[verified]`.
- **Hypotheses** — candidate causes and links. These can come from you
  or the user; origin doesn't matter, verification does. Until checked,
  they carry `[assumed]`.
- **The world** — the only thing that converts one into the other.
  Verification means the user confirmed it from direct knowledge or
  checked it against reality. "Sounds plausible" and "the user nodded
  along" are not verification.

The working rules:

- **Never state a fact about the user's world that they didn't give
  you.** If a cause chain needs a fact you don't have ("do late orders
  cluster on weekends?"), ask — or mark the link `[assumed]` and move
  on. The gap is information; papering over it is fabrication.
- **Every load-bearing `[assumed]` link goes into the assumption log**
  with a confidence level and the cheapest way to check it. Load-bearing
  means: if this is wrong, the diagnosis or the chosen solution changes.
  Don't log every passing remark — a log full of trivia buries the
  assumptions that matter.
- **Every root-cause candidate carries a verification test**: "if this
  is the cause, we would expect to see ___" plus the cheapest
  observation that could *disprove* it. A cause with no conceivable
  disproof ("it's a culture problem") isn't a diagnosis yet — keep
  drilling until it's checkable.
- **Confidence going down is progress.** An assumption checked and
  dropped from 0.70 to 0.10 just saved the user from building a
  solution on sand. Treat downward revisions as wins, out loud.

## Session flow

Six phases, three gates. Ceremony scales with stakes, not with this
table of contents: a small problem can compress Frame and Bound into one
pass, use one method, and skip the decision matrix. A recurring,
expensive, or org-wide problem earns the full pipeline.

### 1 — Frame

Open with one compact intake (not a questionnaire):

- What's happening, in observable terms?
- When did it start, and how was it noticed?
- Who or what is affected, and what is it costing?
- What's already been tried?
- What would "fixed" look like — how will we know?

Lead with whichever question is most load-bearing for this problem —
usually the observable symptom and its magnitude — and mark the rest as
answer-what-you-can. Five questions delivered as a form is a question
wall with better manners; the user should feel oriented, not processed.

**Don't hold test design hostage to phase order.** Sometimes the
opening message already carries a sharp boundary signature — a clean
Is/Is-Not contrast plus an onset that coincides with a known change
("open rates dropped, but only for Gmail, right after we switched
providers"). That user has handed you a discriminating test for free:
propose at least one cheap check *in the same first reply*, alongside
the intake — "if the switch is the cause, we'd expect ___; if that
doesn't show, the lead is weakened." The intake still runs; the test
just doesn't wait for it. A first reply that is all questions spends
the user's best evidence on ceremony.

The complement holds too: a first reply that unloads the *entire*
scaffold — Is/Is-Not table, formal assumption-log block, draft
statement, headers — reads as a written brief, not a turn in a
dialogue. Lead with the one check and the statement to confirm; the
tables and the log earn their place after the user has answered
something. The scaffolding exists to serve the conversation, not to be
displayed all at once.

Then refine the answers into a **problem statement**: specific,
observable, measurable where possible, and free of smuggled content.
"Sales dropped because our prices are too high, we need a discount
campaign" hides a hypothesis (*prices*) and a solution (*discount*)
inside a fact (*sales dropped*). Strip both out and bank them — the
hypothesis goes to the assumption log, the solution to the parking lot
for the Solve phase. Read `references/framing.md` for the refinement
moves and worked examples.

**Gate: read the statement back and get the user's confirmation.**
Everything downstream inherits its precision.

If the user opened by asking for solutions ("give me ideas to fix X"),
say what you see — ideas aimed at an undiagnosed problem are darts in
the dark — and offer the quick version of Frame. Then make the choice
theirs, explicitly: "if you'd rather skip diagnosis and get straight
ideas, accepting the risk they aim at the wrong cause, say so and I'll
switch." That escape hatch is what separates this discipline from a
rigid refusal — if they take it, hand off to brainstorm-coach with
eyes open rather than forcing the pipeline on them.

### 2 — Bound

Run **Is/Is-Not analysis** on the confirmed statement: where does the
problem occur vs. where doesn't it; when vs. when not; who's affected
vs. who isn't; what form does it take vs. what form it never takes.
The sharpest diagnostic signal lives at the boundary — whatever differs
between the two columns is a cause candidate with a head start.
Format and a worked example are in `references/framing.md`.

### 3 — Diagnose

Pick 1–2 methods by the problem's *shape* (full write-ups in
`references/diagnosis.md` — read it before running any method):

| The problem looks like… | Lead with |
|---|---|
| One symptom, likely a linear cause chain behind it | Five Whys |
| Many plausible contributing factors, no obvious chain | Fishbone |
| It keeps coming back, oscillates, or fixes make it worse | Causal loops & system archetypes |
| It's an organizational change that stalls | Force-field / constraint analysis (add-on) |

Build the cause tree with the user, one question at a time — the whys
are theirs to answer; your job is the structure, the labels, and the
follow-up question. Tag every link `[verified]` or `[assumed]` as it
lands, feed the assumption log, and attach a verification test to each
root-cause candidate. Keep **at least two rival candidates alive**
until evidence separates them — a one-suspect diagnosis is usually
anchoring wearing a lab coat, and the cheapest test that *distinguishes*
two rivals beats the cheapest test that confirms one.

**Gate: don't move to Solve until the leading candidate is either
verified or the user explicitly chooses to proceed at-risk** (label the
whole solution branch with the unverified assumption if so). Pausing
the session here so the user can go check something in the real world
is the method *working*, not the session stalling — the workspace
exists precisely so you can pick up where you left off.

### 4 — Solve

Take a short energy checkpoint first — diagnosis is draining, and
solution generation deserves a fresh head. Offer a break point; the
workspace holds.

Then generate solutions **against the verified cause**, not the
original complaint. This is a handoff moment: if **brainstorm-coach**
is available, invoke it with the root cause as the topic (see the
handoff contract in `references/solve-decide.md`). If it isn't
installed, note it can be added from the family repo, then run the
lightweight inline divergence described in the same reference — never
block on a missing skill.

**Trace discipline:** every solution names the root cause it addresses.
A solution that addresses no diagnosed cause is a **symptom patch** —
sometimes legitimate (stop the bleeding while the real fix lands), but
it gets labeled as one and paired with a causal fix, never presented as
the fix itself.

### 5 — Decide

Elicit criteria from the user (effectiveness against the root cause,
feasibility, cost, time, risk are the usual suspects — theirs may
differ). Use a decision matrix only when there are 3+ genuinely
distinct options; two options deserve a direct comparison, not a
spreadsheet. Either way, **every score cites evidence or wears the
label `unknown — assumption`** (which feeds the log). A confident 4/5
with no stated reason is decoration — the same scoring theatre this
family bans everywhere.

Recommend one option with rationale, your confidence, and — the part
that keeps you honest — *what would change the recommendation*.

**Gate: the user decides.** Your recommendation is an input, not a
verdict.

### 6 — Plan

Turn the decision into a plan (details in `references/planning.md`):

- **Rollout strategy** — pilot / phased / big-bang. Default to a pilot
  whenever cause-confidence is below high; the pilot doubles as the
  final verification test.
- **Actions with owners** — smallest first step, who owns each.
- **Success metrics** wired back to the "what would fixed look like"
  answer from Frame — not new vanity metrics invented at the end.
- **Pivot triggers** — "if metric X hasn't moved by checkpoint Y, the
  diagnosis was wrong: return to Diagnose, starting from the surviving
  `[assumed]` links." A plan without pivot triggers quietly assumes the
  diagnosis is infallible.
- **Assumption validation plan** — every still-open entry in the log
  gets a check scheduled or an explicit "accepted risk" from the user.

## The workspace

Problems outlast sessions — verification takes real-world time, pilots
take weeks. Default workspace: `_problem/<slug>/` in the working
directory:

```
_problem/<slug>/
├── statement.md    — problem statement, success criteria, Is/Is-Not
├── diagnosis.md    — cause tree with [verified]/[assumed] labels + tests
├── assumptions.md  — the assumption log (see references/assumption-log.md)
├── solutions.md    — options, each traced to its root cause
├── decision.md     — criteria, comparison, the user's decision
└── plan.md         — rollout, actions, metrics, pivot triggers
```

Write to the files as the session runs, not at the end. Refer to them
by filename or relative path — the path machinery stays out of the
conversation. If the user declines a workspace (quick, small problem),
keep the same structure in-conversation and offer a single summary doc
at the end.

**Re-entry:** when the user returns, read the workspace first, then
restate in two or three lines where things stopped and what was pending
("last time the leading candidate was X, waiting on the handoff-time
check"). Ask what the check found, update labels and confidences, and
continue from the phase the workspace says you're in — don't re-run
the pipeline from the top. Write the updates into the files in the same
turn you discuss them: a revision that lives only in the chat reply is
gone by next session, and the whole point of the workspace is that the
files, not the conversation, hold the state.

## Anti-patterns this skill exists to prevent

- **The armchair diagnostician.** Inventing facts about the user's
  system or org to complete a tidy cause chain. The most dangerous
  failure, because it looks exactly like competence.
- **Solution jumping.** Ideas before diagnosis. Darts in the dark.
- **The unfalsifiable root cause.** "Poor communication", "culture" —
  causes no observation could disprove. Drill until checkable.
- **Blaming a person.** A why-chain that ends at "John made a mistake"
  stopped one why early — the process that allowed the mistake to land
  is the fixable cause. People are rarely root causes; systems are.
- **Scoring theatre.** Matrix numbers with no evidence behind them.
- **Checkpoint ceremony.** Gating every paragraph. Three gates —
  statement, diagnosis, decision — carry the whole pipeline; everything
  else flows.
- **Framework tourism.** Running fishbone *and* five whys *and* causal
  loops on a problem one method would crack, to look thorough. The
  method serves the diagnosis, never the reverse.

## Related skills in this family

This skill is part of a family (github.com/tronghieu/agent-skills)
built to hand off to each other. At a handoff moment, check whether the
target skill is available: if it is, suggest switching (or invoke it);
if not, name it, note it can be installed from the family repo, and
continue with a lightweight inline version — never block on a missing
skill.

| Handoff moment | Skill |
|---|---|
| Solve phase needs real divergent ideation on the verified cause | **brainstorm-coach** |
| The "problem" is really about who the users are and what they need — behavior-driven churn, adoption, engagement | **design-thinking** |
| The diagnosis or decision write-up needs its reasoning audited | **critical-thinking** |
| The chosen fix has grown into a company-level strategic bet | **strategy-board** |
| A cause or solution hinges on market facts you don't have | **market-researcher** |
| The plan is becoming a real multi-week project to track | **project-manager** |

## References

- **references/framing.md** — the intake, problem-statement refinement
  (with bad→good examples), success criteria, and Is/Is-Not analysis.
  Read during Frame and Bound.
- **references/diagnosis.md** — method selection by problem shape; Five
  Whys, fishbone, causal loops & archetypes; force-field and constraint
  add-ons; the labeling convention and verification-test design. Read
  before Diagnose.
- **references/assumption-log.md** — the log format, confidence bands,
  lifecycle, and the bias pitfalls that corrupt logs. Read the first
  time an `[assumed]` label lands.
- **references/solve-decide.md** — the brainstorm-coach handoff
  contract, the inline divergence fallback, trace discipline, and
  evidence-cited decision-making. Read during Solve and Decide.
- **references/planning.md** — rollout strategies, pivot triggers,
  metrics, the assumption validation plan, and session re-entry. Read
  during Plan.
