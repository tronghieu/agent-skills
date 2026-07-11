# Prioritize: Opportunity Backlog, RICE, and Kano

The Scale lens (Lam). Read `references/pm-discipline.md` first — every cell in a
scoring table is subject to number provenance, and the ranking is subject
to the Judge (Bao) prioritization audit before it is presented as final.

## Contents

- [The opportunity backlog: backlog/opportunities.md](#the-opportunity-backlog-backlogopportunitiesmd)
- [Which tool at which altitude](#which-tool-at-which-altitude)
- [RICE scoring](#rice-scoring)
- [When the inputs don't exist yet](#when-the-inputs-dont-exist-yet)
- [Sensitivity analysis on the ranking](#sensitivity-analysis-on-the-ranking)
- [The strategic-adjustment pass](#the-strategic-adjustment-pass)
- [Kano: classifying expectations](#kano-classifying-expectations)
- [Output format: prioritization-<date>.md](#output-format-prioritization-datemd)

## The opportunity backlog: backlog/opportunities.md

An opportunity is a **problem worth solving, framed as a job story** — not
a feature request. Features are one possible answer; opportunities keep the
question open long enough to answer it well.

```markdown
## OP2 — Reduce first-week abandonment
- **Job story:** When I sign up to evaluate the product on company time,
  I want to reach a working result in one sitting, so I can justify
  adopting it before my trial attention runs out.
- **Evidence:** [I3] (trust breaks at first real action), FB4, FB9, FB11
  (n=3 of 14 triaged this month), week-1 retention 22% [S4]
- **Metric it should move:** week-1 retention (north-star input L1)
- **Status:** open        (open · prioritized · specced (prd-…) · shipped · retired)
```

Rules:

- **The job story traces or confesses.** Situation and motivation cite
  `[I#]`/`FB#`/`[S#]`; a job story with no evidence is written anyway but
  carries `(hypothesis — needs validation)` and is a weaker candidate by
  construction. Deep job discovery (interviews, four-forces analysis)
  belongs to the design-thinking skill — this skill consumes its insights;
  it does not conduct fieldwork.
- **Feature requests get translated, not transcribed.** "Add CSV export"
  enters the backlog as the job behind it ("when I need to report upward,
  I want the data in my own tools…"), with the requested feature noted as
  one candidate solution. The translation is where a PM earns their keep.
- **One row per problem**, merged when triage finds duplicates; counts
  accumulate on the merged entry ("requested by 9 accounts, FB4…FB27").

## Which tool at which altitude

Answer the question you are actually being asked. The frameworks are not
competitors; they operate at different altitudes, and using one at the
wrong altitude produces confident nonsense:

| Question on the table | Use | Not |
|---|---|---|
| What kind of expectation is this? | Kano | RICE (a must-be gap can score low on RICE and still sink you) |
| Which opportunity do we tackle next? | RICE + sensitivity | MoSCoW (it has no notion of cost or reach) |
| What ships in *this* release of the chosen opportunity? | MoSCoW (in the PRD — see `references/definition.md`) | RICE (stories within one feature share reach; the math degenerates) |
| How does the opportunity decompose into stories? | Story mapping (PRD) | any scoring |

The most common real-world confusion is RICE vs MoSCoW. The tie-breaker:
RICE compares *independent investments*; MoSCoW draws *a scope line inside
one investment already chosen*.

## RICE scoring

`Score = (Reach × Impact × Confidence) / Effort` — per opportunity, every
input labelled per pm-discipline:

- **Reach** — how many users/accounts experience the problem per period.
  Same period and same population for every row (the Judge audit's
  denominator check). Comes from analytics `[S#]` or an `A#` with range —
  never from vibes.
- **Impact** per affected user: 3 massive · 2 high · 1.5 substantial ·
  1 medium · 0.5 low · 0.25 minimal, *on the metric the opportunity names*.
  If the metric link is missing, fix the backlog entry first.
- **Confidence** — 100% strong evidence · 80% some evidence · 50% educated
  guess. Below 50%, don't score it — register the assumption and consider
  a cheap experiment before investing a rank in it. Confidence is where
  fabricated Reach/Impact get honestly discounted, so it may not silently
  stay at 100% — and a confidence held flat across every row is itself
  an assumption: vary it in the sensitivity pass or say why it is flat.
- **Effort** — person-weeks or S/M/L/XL from whoever will build it. This
  input belongs to engineering; solicit it via the user, label it
  `(user estimate, <date>)`, and resist the temptation to guess it
  yourself — effort is the input PMs most reliably invent and most
  reliably get wrong.

## When the inputs don't exist yet

The common real case: the user asks for a RICE ranking and has none of the
inputs at hand — no per-feature reach, no effort estimates, no impact
evidence. **Refusing to score is not the discipline; scoring honestly
without data is.** The provenance rules give you a legal way to proceed:
register every missing input as an `A#` with a stated basis ("gut feel"
is acceptable — it must just say so) and an honest range, then score.

The default move, in one exchange:

1. Ask for the inputs the user plausibly has (analytics reach, dev-team
   effort), listing exactly what's needed and why.
2. **Offer — and unless the user declines, produce — a provisional
   ranking now**: every unelicited cell an `A#` with a range, the
   sensitivity pass run across those ranges, and the output labelled
   *provisional — ranks marked sensitive are unstable until their `A#`
   is replaced by data*. A wide-range provisional ranking that says
   which ranks are robust anyway is more useful than a refusal, and the
   sensitivity table doubles as the priority order for collecting real
   inputs.
3. Refuse to score only if the user declines assumption-based scoring —
   and then still deliver the question list and the registered
   assumptions.

**A blocked or provisional play still closes like a play.** Whatever
path is taken: append the (pending) decision to `decisions.md` with a
revisit trigger ("revisit when dev-team effort estimates arrive — A7/A8
replaced"), record what's `waiting_on_user` in `state.md`, and run or
offer the Judge prioritization audit on whatever was produced. Missing
inputs pause the *ranking*; they never switch off the governance.

## Sensitivity analysis on the ranking

Method in `references/pm-discipline.md`. Applied here: recompute the
ranking with each `A#` input at its range ends; report which rank
positions are **robust**, which **flip** (and on which assumption), and
which are **borderline** ties. The sensitive assumptions are the
experiment queue — a rank that flips on A4 is an argument for spending a
week testing A4 before spending a quarter building the winner.

## The strategic-adjustment pass

Raw RICE is an input to judgment, not a verdict. After the scored ranking,
run one explicit pass for what the formula cannot see: dependencies and
sequencing, must-be gaps flagged by Kano, strategic bets, commitments
already made, portfolio balance (all-delighters and all-plumbing are both
failure modes). Every adjustment is written next to the ranking with its
reason, and the final order goes to `decisions.md`. Adjusting is healthy;
adjusting *silently* is rigging.

## Kano: classifying expectations

Kano answers a question RICE cannot: *what kind* of expectation a
capability is. Categories: **must-be** (absence infuriates, presence earns
nothing), **performance** (more is linearly better), **delighter**
(absence costs nothing, presence charms), **indifferent**, **reverse**.
Two uses here:

1. **Challenge the RICE order.** A must-be gap (e.g. reliability, data
   export at contract renewal) can score mid-table on RICE and still be
   existential — surface it in the strategic-adjustment pass.
2. **Feed packaging** (see `references/pricing.md`): must-bes go in every
   tier; delighters and performance features fence the upper tiers.

**Method honesty is the whole game with Kano.** The real method is a
paired-question survey per feature ("How do you feel if it's present?" /
"…if it's absent?" on the five-answer scale, mapped through the standard
Kano evaluation table). This skill *designs* that survey — feature list,
question pairs, target segment, sample-size guidance (~30+ per segment
before category assignments stabilize) — and then **waits for the user to
run it**; results register as `[S#]` and categories cite it. When there is
no survey and no time for one, categories may be assigned as hypotheses —
each labelled `A#` with a basis — and they enter the strategic pass as
challenges, not facts. Never present a gut Kano table as if customers were
asked. Also honor Kano drift: yesterday's delighter is today's must-be;
survey-based categories older than ~a year are stale.

## Output format: prioritization-<date>.md

```markdown
# Prioritization — 2026-07-11 (Q3 planning)

## Inputs
(period, population, who supplied effort, links to opportunities/assumptions)

## RICE table
| OP | Reach | Impact | Confidence | Effort | Score |
(every cell labelled; arithmetic shown for derived cells)

## Sensitivity
(robust / sensitive-on-A# / borderline — next to the ranks they qualify)

## Kano check
(categories with their method label: survey [S#] or hypothesis A#)

## Strategic adjustments
(final order; each move from raw RICE order justified in one line)

## Judge audit — <date>
(findings, resolutions, open caveats)

## Recommendation
(the order, its confidence, the assumption that would change it)
```

Dated files accumulate; never overwrite a previous pass — the sequence of
prioritizations *is* the product's strategy history. Close by appending
the decision (with its revisit-trigger) to `decisions.md`.
