# Engagement Workflow

The full pipeline from raw question to approved roadmap. Drucker leads it;
each phase is one specialist's pass, reading the previous artifacts and
writing its own. Three gates require the executive's explicit go-ahead —
never advance through a gate silently.

```
0 Brief        → Drucker              → brief.md          ⛔ GATE 1: question confirmed
1 Fact base    → cast by question     → fact-base.md
2 Analysis     → specialists by lane  → analysis/*.md
3 Options      → Drucker + board      → options.md        ⛔ GATE 2: direction chosen
4 Stress-test  → Taleb (+ Wack)       → boardroom/pre-mortem…md
5 Recommend    → Minto                → recommendation.md ⛔ GATE 3: approved
6 Roadmap      → Grove                → roadmap.md
```

Not every engagement needs every phase at full depth. A build-vs-buy call may
compress Phase 2 into one Graham pass plus one Grove pass; a market entry
study needs the full spread. Drucker proposes the plan at Phase 0 and the
executive trims it. What never gets trimmed: sourcing discipline, three
options, the pre-mortem, and the gates.

## Phase 0 — Brief (Drucker)

Elicit, don't assume. Fill `templates/engagement-brief.md` *with* the
executive: what decision this informs, why now, scope, horizon, constraints,
risk appetite, who else has a stake, and what "good" looks like. Drucker's
special duty: test whether the stated question is the real one — "should we
build a data platform?" frequently decodes to "why can't we trust our
numbers?". Reframe before spending analysis on the wrong question.

Once the question stands, diagnose the environment with the **Strategy
Palette** (`references/frameworks/strategy-palette.md`): how predictable is
this market on this horizon, can we shape it, is survival at stake? The
resulting approach — Classical, Adaptive, Visionary, Shaping, or Renewal —
goes into `brief.md` and sets the casting weights and the recommendation's
default shape (e.g. Adaptive engagements default to staged experiments with
kill criteria; a Renewal read puts Graham's diagnosis first and borrows the
crisis playbook's compression). Guard the trap named in that file: assuming
a plannable, Classical world without evidence.

**Gate 1:** read the brief back. The executive confirms the question, or
corrects it. Log the framing in `decision-log.md`.

## Phase 1 — Fact base (cast 1–2 members by question)

Research before frameworks. Use real sources: web search for market data,
competitor moves, benchmarks, vendor information; the user's own documents
and internal numbers for everything inside the company. Record each fact in
`templates/fact-base.md` with a numbered source `[S#]`, its date, and a
reliability note. What cannot be sourced gets written as a named
`(assumption)` with an owner and a plan to verify — or it doesn't get used.

Where facts must come from the executive (internal costs, team capacity,
political constraints), ask directly — a short numbered list of questions, at
most once per phase. Run `checklists/fact-base-quality.md` before advancing.

## Phase 2 — Analysis (specialists by lane)

Drucker casts only the lanes the question needs (see the framework selection
table in `SKILL.md`). Each specialist reads `brief.md` + `fact-base.md`, runs
the tools from their working file *with the rigid output formats those files
define*, and writes `analysis/<member>-<topic>.md`. Every analysis ends with
a **So what** section — 2–4 sentences on what this changes about the decision.
An analysis that doesn't move the decision gets summarized in one line and
set aside, not padded.

Independent workstreams (e.g. Porter's market pass and Graham's baseline
economics) may run as parallel subagents; dependent ones run in sequence.

## Phase 3 — Options (Drucker convenes the board)

Build `options.md` from `templates/options-analysis.md`: **three genuine
options** a reasonable board member could defend — different in kind (e.g.
build vs buy vs partner-then-decide), not three dosages of the same idea.
Where honest, include "do nothing / wait" as one of them; its cost of delay
must be stated like any other cost. Each option gets the same table: what it
is, what must be true, investment and returns (Graham's numbers), capability
demands (Grove), main risks, reversibility.

This is the natural moment for a **Boardroom session** (`references/boardroom.md`)
— offer it, especially when the specialists' analyses point different ways.

**Gate 2:** the executive picks a direction (or sends the board back with a
new constraint). Log the choice *and the rejected options with reasons* —
future-you will ask "why didn't we just buy?" and `decision-log.md` should
answer.

## Phase 4 — Stress-test (Taleb, usually with Wack and Grove)

Run the pre-mortem session on the chosen direction (protocol in
`references/boardroom.md`, checklist in `checklists/pre-mortem.md`). Wack
wind-tunnels it across scenarios if futures diverge; Grove checks the
capability assumptions. Output: the 2–3 credible failure paths, early-warning
signposts, mitigations adopted, and risks the executive consciously accepts.

The point is not to relitigate Gate 2 — it is to make the accepted risks
explicit and cheap mitigations real. If the pre-mortem uncovers something
that genuinely breaks the choice, that goes to the executive plainly, with
the evidence; reopening the decision is theirs to call.

## Phase 5 — Recommendation (Minto)

Minto compresses the engagement into `recommendation.md`
(`templates/recommendation.md`): SCQA opening, answer first, MECE support,
the numbers traced to `[S#]`, the surviving risks stated, the rejected
options acknowledged, and — non-negotiable — **what we will not do**. Run
`checklists/recommendation-quality.md`. If the executive needs a deck or a
one-pager instead of a memo, Minto's `storyline` and `one page` commands
produce them from the same pyramid.

**Gate 3:** the executive approves the recommendation (often after a revision
round). Log it.

## Phase 6 — Roadmap (Grove)

Turn the approved recommendation into `templates/roadmap.md`: phases with
owners, dates, and output metrics; the 90-day plan with quick wins; resource
reallocation (what is being *defunded* to pay for this — Grove will insist);
governance and review cadence; and Wack's signposts wired to explicit
revisit-triggers.

Close the engagement as Drucker: summarize what was decided, what is assumed,
what gets reviewed when — one final entry in `decision-log.md`.

## The decision log

`decision-log.md` is the engagement's memory: one dated entry per decision —
the choice, the alternatives rejected and why, the load-bearing assumptions,
and any recorded dissent. On every session resume, Drucker reads it first
(`status`). It is also the honesty mechanism: dissent that is written down
keeps both the board and the executive straight when results come in.

Every entry opens with a dated state line in the form `[YYYY-MM-DD] Phase N
started|done — <one line>`; gate entries record the gate outcome the same
way, e.g. `[date] Gate 2 passed — direction: <option>`. This makes the log
the single source of truth for where the engagement stands: on resume, the
current phase is read directly from the log's last state line, never
inferred from which files happen to exist in the folder.

## Single-analysis engagements

When the request is shape 2 ("size this market", "pre-mortem this plan"),
skip the pipeline scaffolding: create the folder, write a three-line
`brief.md` (question, scope, deadline), build the minimum fact base the
analysis needs, run the one specialist pass, and deliver with its So-what.
Discipline scales down; it never switches off.

The deliverable is **one self-contained memo** — finding, evidence,
So-what, recommended action — not a folder the executive must assemble.
Working files (fact base, session minutes) are appendices for whoever asks
"show me"; a busy executive should be able to act from the memo alone.

## Situation review (no decision on the table yet)

Sometimes the ask is "where do we actually stand?" — a periodic strategic
health check with no single decision attached. Drucker still probes for the
hidden decision first (there often is one); if the review is genuinely
open-ended, run Phases 0–2 with the brief reframed (scope + horizon + "what
would make this review useful"), then Minto closes with a **situation
synthesis** instead of a recommendation:

- performance dashboard: the 5–8 metrics that tell the story, 3-year trend,
  vs peers `[S#]`
- the 3–5 strategic issues, ranked by value at stake × urgency, each stated
  as a question the board will eventually have to answer
- options preview: for the top issue(s), the 2–3 directions that exist —
  named, not analyzed
- what we do NOT know: the gaps in the fact base that a real decision would
  need filled

Stop there. The review's success is that the *next* engagement starts with
a sharp question and a warm fact base — not that it smuggled in a
recommendation nobody asked for.

## Engagement playbooks

One pipeline, several shapes. Drucker names the playbook at Phase 0 so the
executive knows what they're signing up for; anything not listed runs the
standard pipeline with casting judgment.

| Playbook | How it differs from the standard pipeline |
|----------|-------------------------------------------|
| **Decision engagement** | The default — everything above. |
| **Situation review** | Phases 0–2 + situation synthesis; stops before options (see above). |
| **Annual planning cycle** | Starts by *reviewing last year's plan and signposts* (what fired? which assumptions died?). Phase 3 becomes a portfolio pass — Three Horizons over all initiatives with real resource allocation — instead of three options for one decision. Output: the plan + reallocation table + next year's signposts. Graham prices the portfolio; Taleb pre-mortems the top 2 bets, not everything. |
| **Crisis decision** | Compressed: fact base in hours not days (mark reliability honestly — speed raises the bar for labelling, not lowers it), two options acceptable when the clock forbids three, gates collapse into one executive check-in. Never skipped: the pre-mortem (an hour of it) and the decision log — crisis choices are the ones most litigated later. |
| **Big-bet variant** (M&A, platform, transformation) | Standard pipeline plus: Taleb's ruin check is mandatory, Wack's scenarios are mandatory, and the default recommendation shape is *staged* (cheapen-the-bet applied unless the executive explicitly buys the full commitment up front). |

A playbook earns its own file only when its guidance outgrows this table —
let real usage decide, not anticipation.
