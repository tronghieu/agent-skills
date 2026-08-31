# The sprint loop — plan, pulse, close

Three plays share one artifact: the sprint file. This reference holds
its schema and the rules of each play.

## The sprint file

One file per sprint: `sprints/sprint-<NN>.md`. Two-digit numbers so
files sort. The file is the sprint's single home: goal, committed
scope, changes, pulse notes, and the close snapshot all live here.

```markdown
# Sprint 07 — <the goal, one sentence>

status: planning | active | closed
dates: 2026-08-24 → 2026-09-04
capacity basis: 3-sprint velocity 21 / 24 / 19 → plan ≈ 20 pts
  (source: sprints/sprint-04..06 close snapshots; Linh out 3 days)

## Committed scope (at planning, 2026-08-24)

| ID | Story | Est | Owner |
|----|-------|-----|-------|

Total: <N> pts across <M> stories. Goal stories marked ★.

## Scope changes

| SC# | Date | +/− | Story | Est | Who asked | Goal impact |
|-----|------|-----|-------|-----|-----------|-------------|

## Pulse log

### 2026-08-26 — day 3 of 10
- Done: A-102. In progress: A-104, A-107. Blocked: A-105 → IM-2.
  (source: Jira fetch 2026-08-26)

## Close snapshot — written 2026-09-04, immutable
```

Mark the stories that carry the sprint goal with ★. Velocity can look
fine while every ★ story sits untouched — that is a dying sprint with
healthy-looking numbers. Track ★ stories separately in every pulse.
★ means goal-critical **this** sprint: a story carried in from last
sprint enters unstarred unless the new goal covers it — a ★ outside
the goal is a contradiction the team will spot at planning.

## plan-sprint — the Shield play

Planning is a gate, not a transcription. Five checks, in order:

**1. Place the carry-over first.** Read the closing sprint's snapshot.
Every unfinished story gets an explicit destination — into this
sprint, back to the backlog, or dropped — before any new scope is
discussed. Carry-over that is merely *mentioned* vanishes, then
returns as a week-2 surprise. An open `PI#` due this sprint gets the
same treatment: a slot and a check, or a recorded deferral.

**2. Goal first.** No sprint goal → don't build the story table yet.
Help write one: one sentence, an outcome someone outside the team would
care about, falsifiable at review. "Do the tickets" is not a goal — a
goal is what lets the team say no to mid-sprint noise. One outcome is
the shape; two is the ceiling, and only when the ★ stories genuinely
serve both. Three outcomes is a task list wearing a goal's clothes.

**3. Capacity from history.** Read the last 3 close snapshots; the
velocity range is the budget. Show the arithmetic all the way down,
in dev-days: "21 / 24 / 19 → avg ≈ 21. Capacity: 3 devs × 10 days =
30 dev-days, minus Bảo's 3 leave days → 27/30 ≈ 90% → plan ≈ 19."
Watch the denominator: one person's leave costs their dev-days (3 of
30 ≈ −10%); a deploy freeze stops everyone (3 of 10 days = −30%). A
percentage asserted without its division can quietly plan a goal
story out of the sprint — the visible derivation is the number's
defense in the meeting. No history yet → ask the team for their
honest guess and label it an assumption.

**4. Story readiness.** Each candidate story needs an estimate, an
owner-able size, and acceptance criteria. Flag every story that fails.
Two checks against the team's own history: a story bigger than ~⅓ of
velocity — or bigger than anything a snapshot shows delivered — gets
a split proposal, not a pass. Stories sharing a surface with each
other or with recently shipped work get an overlap question ("how is
this different from what S06 shipped?") — a duplicate caught at
planning is a sprint slot saved. Read the story text, not only its
fields: a bug on a surface that has failed before may be urgent —
raise the triage question, not just "no estimate". Unready stories
can still enter —
but only after the team hears what's missing and says yes anyway
(record it).

**5. The over-commit check.** Sum of estimates > velocity range →
push back once, plainly, and show what yes would look like, from the
snapshots: "You're asking for 36; the last three sprints delivered
21 / 24 / 19. Committing 36 means ~20 done and ~16 carried — S06
again." Figures on every leg — pts in, ~pts out, ~pts carried,
against last sprint's carry — the scenario persuades because the PO
sees the number, not the adjective. Offer the cut that fits, with
named first pull-ins. Then do what the team decides, and record the
decision and its basis in the file. Never adjust the numbers to make
the answer comfortable. The gate protects the team, never the record:
"your call — logged here so it's on file if it slips at review" is
the anti-pattern in its purest form, an SM building a paper trail
instead of making the case.

Output: the sprint file with status `active`, committed table filled,
★ marked, capacity basis labeled. The Owner column stays TBD — the
team pulls its own work; show load-fit as a check ("An and Cường at
7 pts each, Bảo lighter for his leave"), never as assignments. Close
the reply with a numbered checklist of what's needed to flip the
status to `active` — a checklist gets answered; a paragraph gets
skimmed. Update `state.md`.

## pulse — the Mirror play

Run on demand, or at whatever cadence the team agreed in `context.md`.

1. **Get current state.** Fetch via the `tools.md` entry; no entry or
   fetch fails → ask for a paste/export. Label the source and date.
   Flaws in the data — an export older than 2 days, a pulse log with
   a gap — are disclosed **in the reply, before the analysis**, even
   after the files are reconciled. A patched gap the user discovers
   later poisons every number that came before it.
2. **Diff against the committed table.** Stories on the board that are
   not in the committed table = scope changes. Write the `SC#` lines
   now, with who asked and the goal impact — no name in the data →
   the best guess from labels and fields, marked as a guess. This
   diff is the whole point of the play — silent additions are found
   here or never.
3. **The goal in words, ★ stories first.** Open with the sprint goal
   sentence verbatim — a status without the goal is a task list.
   Report ★ progress before general progress. Then cross-check: who
   is working non-goal items while their own ★ story sits untouched?
   Unplanned work displacing goal work is the finding that changes
   someone's next hour.
4. **Blockers become `IM#` entries** in `impediments.md` immediately,
   not notes in passing. Check ages of open ones while there — and
   every ladder move that is due (nudge, escalation) rides in the
   reply as quoted, sendable text in the recipient's frame, saved per
   the honest-hands rule (`impediments.md`). The drafts are pulse
   deliverables; shortening a reply never cuts them.
5. **Forecast with arithmetic.** A required line: committed vs done vs
   realistic-at-close, from days left and observed pace. "5 of 34
   done on day 6 leaves 29 pts for 4 days — not happening" beats
   "goal at risk". Never soften it with a short streak of good
   sprints. Goal at risk → recommend the specific cut, cheapest first
   (no work sunk yet, unplanned `SC#` additions), with the numbers:
   "cut B-202 — 5 pts, zero work sunk" is a recommendation; "is the
   spike worth 5 points?" hands the analysis back. The call stays the
   PO's. Set the tripwire too — the named date when risk turns into
   action ("A-105 still blocked Wednesday → it goes to the review as
   at-risk, not as a surprise").
6. **Audit "Done", note what's holding.** Whenever an environment or
   tooling impediment overlaps a Done transition, ask which DoD steps
   could actually run — "done" during a staging outage may only mean
   merged. A question, not an accusation, and never skipped when the
   overlap exists. And end with one line of verifiably good news:
   which past improvements and agreements are still holding, with
   the source. Teams need to know what not to fix, and it is the one
   good line a stakeholder update can carry honestly.

Append the pulse note to the sprint file. Never rewrite earlier notes.

## close-sprint — the Mirror play

Run on the last day, after the review.

1. Final fetch or export — same source rules.
2. Fill the close snapshot:

```markdown
## Close snapshot — written 2026-09-04, immutable

| Metric | Value | Source |
|--------|-------|--------|
| Committed | 34 pts / 8 stories | planning section above |
| Added mid-sprint | 8 pts / 3 stories | SC-1..SC-3 |
| Delivered | 21 pts / 5 stories | Jira export 2026-09-04 |
| Carry-over | 13 pts / 3 stories | Jira export 2026-09-04 |
| Velocity | 21 pts | delivered points |
| Goal | partial — onboarding behind flag, not GA | review demo 2026-09-04 |
| Impediments | 2 opened, 1 closed; IM-2 open 11d | impediments.md |
```

3. Set status `closed`. The snapshot is never edited afterward — a
   later correction is a dated addendum line beneath it, with the
   original left standing. Snapshots are the team's memory; memory you
   can rewrite is not memory.
4. Offer the retro; the snapshot is its data pack's first row.

## Where the numbers come from

Every number in this file carries one of three labels:

- `(source: <tools.md entry> fetch <date>)` — a live fetch.
- `(source: <export/paste description> <date>)` — user-provided data.
- `(assumption: <basis>)` — an honest guess, marked as one.

A number with no label is a bug. When data is missing, ask or write
"unknown" — an unknown the team can see beats a guess they trust.
