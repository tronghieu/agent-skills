# Triage-Feedback: From Raw Voice-of-Customer to Backlog Evidence

The Echo lens (Thanh). Read `references/pm-discipline.md` first. Feedback is the
workspace's richest evidence stream and its noisiest: three loud
customers feel like a trend, an exec's anecdote outweighs fifty tickets,
and the users who churned silently never appear at all. Triage is the
discipline that turns the stream into evidence without letting volume or
volume-of-voice masquerade as importance.

## Contents

- [The feedback log: discovery/feedback-log.md](#the-feedback-log-discoveryfeedback-logmd)
- [The triage pass](#the-triage-pass)
- [Counting honestly](#counting-honestly)
- [Routing rules](#routing-rules)
- [The voice-of-customer summary](#the-voice-of-customer-summary)

## The feedback log: discovery/feedback-log.md

One table, append-only ids. Raw dumps (support exports, NPS verbatims,
call notes) land in `discovery/` and get an `[S#]` row first, so quotes
stay citable; individual entries then reference their source:

```markdown
# Feedback log

| ID | Date | Channel | Who (segment) | Verbatim / summary | Source | Routed to |
|----|------|---------|---------------|--------------------|--------|-----------|
| FB11 | 2026-07-08 | support | trial, SMB | "gave up on setup — couldn't import our data" (verbatim) | [S8] | OP2 |
| FB12 | 2026-07-09 | sales call | enterprise prospect | needs offline mode for field teams (summary) | [S8] | OP5 |
| FB13 | 2026-07-10 | NPS comment | paying, 14mo | export broken since last release (verbatim) | [S9] | BUG → user |
```

- **Verbatim or summary, labelled which.** Quotation marks mean verbatim
  from the source file — design-thinking's quote rule applies unchanged:
  a smoothed quote is a fabricated one; mark cuts with ellipses.
- **Segment matters more than sentiment.** A trial user and a 14-month
  payer saying the same words are different signals; capture who, to the
  precision the data allows, without inventing details.
- Every entry routes somewhere (last column) — an unrouted entry is
  triage debt, visible as such.

## The triage pass

Run on a cadence the user picks (weekly/biweekly) or when a dump arrives:

1. **Register** the raw material (`[S#]`), then log entries `FB#`.
2. **Cluster** by the job behind the words, not by the feature named —
   "CSV import broken", "can't get our data in", and "setup takes
   forever" may be one cluster wearing three costumes.
3. **Count with denominators** (below).
4. **Route** every entry (rules below).
5. **Report** the deltas: new opportunities, reinforced ones, anything
   contradicting current priorities — with the standing question applied:
   does this change any decision? If yes, say which and propose the play
   (usually prioritize); if no, say that too. Feedback that never touches
   a decision is a mailbox, not a process.

## Counting honestly

- **Always n of what base**: "9 of 41 tickets this month" not "many
  users". The base makes selection bias visible — support tickets
  oversample the frustrated-but-hopeful; NPS oversamples the engaged;
  sales notes oversample prospects saying what closes deals; **churned
  users are missing from all of it** (an exit survey — see
  `references/experiments.md` — is the fix, not extrapolation).
- **Weight by evidence, not decibels.** An exec anecdote is one `FB#`
  with segment "internal, secondhand". It may still matter strategically
  — that's the strategic-adjustment pass's call, made visibly — but it
  never inflates a count.
- **Frequency ≠ severity.** A must-be breakage (Kano) reported twice can
  outrank a nice-to-have requested twenty times; flag suspected must-be
  violations for immediate attention rather than letting them queue.

## Routing rules

| Signal | Route |
|---|---|
| New problem, no matching opportunity | draft a new `OP#` (job-story form), status `open` |
| Matches an existing opportunity | link `FB#` to the `OP#`, increment its evidence line |
| Bug / must-be breakage | out of scope for the backlog — hand to the user's bug process immediately; note the handoff |
| Praise / validation | attach to the shipped feature's post-launch review; it's evidence too |
| Contradicts a current priority or an `[I#]` | surface it in the triage report — contradictions are findings, not noise |
| Genuinely nothing | mark `ignored (reason)` — an explicit no beats a silent one |

Feature requests route through the translation rule
(`references/prioritization.md`): the job enters the backlog; the
requested feature is noted as one candidate solution.

## The voice-of-customer summary

When the user needs a stakeholder-facing digest (monthly, or
pre-planning), produce it from the log — never from memory:

```markdown
# Voice of customer — July 2026
Base: 41 support tickets [S8], 28 NPS comments [S9], 6 sales calls [S10]

## Top themes
1. Onboarding/data-import friction — 11 entries (FB4…), trial-heavy
   → OP2 (currently rank #1)
2. Offline mode — 4 entries, all enterprise prospects → OP5
3. Export regression — 3 entries, paying customers → BUG, escalated <date>

## Contradictions & surprises
(what cuts against current priorities, stated plainly)

## Blind spots
(who this data cannot hear from — churned users, silent majority)
```

The blind-spots section is mandatory: a VoC summary that doesn't say who
it *can't* hear is a survivorship-bias machine with a nice layout.
