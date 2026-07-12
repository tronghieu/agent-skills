# Status — RAG with evidence, watermelon checks, audience tiers

Guides the **report-status** play (Diogenes · Pulse). This is the
anti-watermelon-reporting weapon: a report that is green outside and red
inside — rigorous-looking, but whose colors trace to nobody's evidence.
Diogenes carries the lamp that finds it. Read `references/pm-discipline.md`
first for the provenance labels this file assumes throughout.

## RAG semantics with teeth

A color is a claim. Claims need citations. Define the three colors so they
mean the same thing every week, for every reader, regardless of who is
drafting:

- **Green — on track, with evidence.** The milestone or workstream is
  proceeding to plan, and the report cites the fact that makes that true:
  a demo accepted, an export showing burn-rate on pace, a date already hit.
  Green with no citation is not a lighter shade of green — it is a
  reporting bug.
- **Amber — a recoverable slip, with a recovery action named.** Something
  is behind, but there is a specific action, with an owner and a date, that
  closes the gap. "Amber, we're keeping an eye on it" is not amber; it is
  red wearing a disguise, because there is no recovery action to check
  against next week.
- **Red — a decision is needed, from someone named.** The gap cannot be
  closed inside the team's own authority: it needs a scope trade, a date
  move, a budget call, or an escalation. Red without a named decision-maker
  and a decision date is a complaint, not a status.

Every color in a snapshot cites one of: an evidence id `EV#` (resolves to
`registers/evidence.md`), an assumption id `A#` (resolves to
`registers/assumptions.md`), or `(user, <date>)` for something the user
asserted directly. This is the same discipline `references/pm-discipline.md`
sets for every decision artifact — status reports are not exempt just
because they ship weekly.

**Worked example** (illustrative — replace the specifics with your own
registers):

```
M3 — API integration        Amber   EV7: partner sandbox still returns
                                     403 on webhook subscribe (checked
                                     2026-07-10). Recovery: R4 owner
                                     (Priya) escalating to vendor support
                                     by 2026-07-14; if unresolved, CH2
                                     (date move) goes to sponsor 2026-07-15.
```

Notice the color, the evidence, the recovery action, the owner, and the
fallback are all in one line — a reader should never have to ask "amber
because of what, exactly?"

## %-complete rules

A percent-complete number is only as honest as its denominator. Rules:

- **Only from countable units.** Work packages done / total, stories
  accepted / committed, acceptance criteria passed / defined — never a
  gut-feel percentage. If there is no countable unit yet, say "not yet
  measurable" instead of guessing a number that looks measured.
- **State the denominator in the same breath.** "60% (9/15 stories
  accepted)" — never a bare "60%".
- **Flag stalled percentages.** The same percent reported two snapshots in
  a row is not necessarily fine — it is a signal the report must name
  ("87% for the third week running; EV12 shows the remaining 13% is one
  blocked story, R6"). A percent that stalls silently reads as progress
  when it is actually a stall.
- **"Done" is binary, not a percentage.** A milestone is complete when its
  evidence (`EV#`) says so — a demo accepted, a sign-off received — never
  when a percentage crosses an arbitrary line like 95%.

## Forecast honesty

A forecast date is a prediction, and predictions that ignore their own
track record are wishes with a calendar icon attached.

- **Confront the slip history.** Before restating or rolling a forecast
  date, check the milestone's own history in `plan/schedule.md` and past
  `status/` snapshots. If M2 slipped twice already, the M3 forecast either
  explains *why this time is different* (in writing, citing what changed)
  or inherits the same risk of slipping — say which.
- **Report buffer burn alongside the date.** If the plan carries a visible
  buffer (per `references/estimation.md`), the status snapshot states how
  much of it is spent and how much remains against how much work is left —
  a forecast that hits the date only by spending buffer nobody tracked is
  not actually on schedule.
- **A forecast is a range with a basis, not a single date dressed as
  certainty**, unless real evidence (`EV#`) pins it down. "M4 forecast:
  Sep 3–10, basis: remaining work at current velocity (EV9), buffer
  remaining 4 of 10 days" beats "M4: Sep 3."

## The snapshot format

Every status play writes a new, dated file — `status/status-<date>.md` —
and never overwrites a previous one. The history *is* estimation data: it
feeds `references/lessons.md` and the reference-class checks in
`references/estimation.md`. Shape:

```markdown
# Status: <project> — <date>          overall: green | amber | red

## Headline
(one paragraph: on track / slipping / blocked, and the one thing driving
that verdict — bad news first, never buried under achievements)

## Milestones
| ID | Milestone | Target | Status | Evidence |
|----|-----------|--------|--------|----------|
| M3 | API integration | 2026-07-20 | Amber | EV7, R4 |

## Risk delta since last snapshot
(new risks, risks that moved score or ROAM state, risks resolved —
cite registers/risks.md rows)

## Decisions needed
(red items, each: decision, owner who must make it, by when, options if
known — pulled verbatim from registers/decisions.md pending entries)

## Actions overdue
(AC# rows past due date, from registers/actions.md — surfaced here even
if this snapshot's audience won't act on them; visibility is the point)

## Judge audit — <date>
(pass/fail against the audit 2 checklist in pm-discipline.md; findings
ship visibly even if unresolved)
```

Bad news leads. A reader who stops after the headline should already know
the one thing that matters this week.

## Audience tiers

The same underlying truth, reported at different zoom — never a different
color for a different audience. That distinction is the whole point:

- **Executive tier** — top 3 items (usually the reds and any amber close to
  turning red), decisions needed with a recommendation attached, and the
  trend line (better / same / worse than last snapshot). One screen, no
  scrolling.
- **Team tier** — the full milestone table, the full risk delta, every
  overdue action. The detail the team needs to actually act.

Both tiers are views over the same snapshot file, generated together, not
drafted separately from memory — a red at team-tier and an amber at
exec-tier for the same milestone is exactly the watermelon-reporting
failure this file exists to prevent. If the exec version omits something,
it omits *detail*, never *severity*.

## Dialect adaptations

`context/methodology.md` decides the shape; the non-negotiables never
change with it. Three dialects, one rule underneath all of them: every
metric input is `EV#`-labelled — a real export, a real sprint report,
never a number reconstructed from memory to fill a cell.

- **Predictive — EVM-lite.** Planned value, earned value, and a simple SPI
  (schedule performance index) or plain-language equivalent ("2 weeks
  behind plan value") — computed from the schedule and actuals, not
  estimated from feel. Milestone table stays primary; EVM numbers support
  it, they don't replace the evidence column.
- **Agile — burnup + flow metrics.** Burnup chart data (scope line vs
  completed line) and flow metrics (cycle time, throughput, WIP) pulled
  from the real board export (`EV#`) for the sprint or period — never a
  velocity number the reporter half-remembers. A burnup with an
  eyeballed scope line is exactly as fake as a Gantt chart with invented
  dates.
- **Hybrid — spine + detail.** The milestone spine (predictive-style,
  M# rows) carries the audience-facing headline; each milestone's
  interior iterations report burnup/flow detail for the team tier.

## Judge audit hook

Every status snapshot passes **Judge audit 2** (full checklist in
`references/pm-discipline.md`) before it goes to the user to send: every
color cites its evidence, forecasts confront slip history, percentages
carry denominators, bad news comes first, and the audience tiers agree on
severity. Findings the audit raises ship visibly in the snapshot — a
finding quietly fixed teaches nobody anything.

The standing note that governs everything downstream of this file: **the
user may soften the message to stakeholders — that is their call to make,
about their relationship with their audience — but the workspace keeps the
unsoftened version.** `status/status-<date>.md` is what actually happened.
What gets sent in an email is a different, allowed, and separate act of
communication.
