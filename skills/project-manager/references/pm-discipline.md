# PM Discipline: Evidence Provenance, the Decision Log, and the Judge Audits

The machinery that makes the non-negotiables enforceable. Read this before
writing any decision artifact — a baseline plan, a status report, a change
decision. The schema exists because a fabricated status is indistinguishable
from a real one by looks alone: "M3: Green" reads identically whether a
sponsor accepted the demo yesterday or nobody checked. Provenance labels are
the only defense, and one unlabelled status in an artifact makes every
status in it suspect.

## Contents

- [The provenance labels: EV#, A#, (user, date)](#the-provenance-labels-ev-a-user-date)
- [The registries](#the-registries)
- [The assumption registry: registers/assumptions.md](#the-assumption-registry-registersassumptionsmd)
- [The evidence registry: registers/evidence.md](#the-evidence-registry-registersevidencemd)
- [The decision log: registers/decisions.md](#the-decision-log-registersdecisionsmd)
- [state.md](#statemd)
- [The Judge audits](#the-judge-audits)
- [The propagation rule](#the-propagation-rule)
- [Copy, never retype](#copy-never-retype)
- [The user-facing reply is an artifact too](#the-user-facing-reply-is-an-artifact-too)
- [Self-check before handing off any artifact](#self-check-before-handing-off-any-artifact)

## The provenance labels: EV#, A#, (user, date)

Every status color, percent-complete, forecast date, and estimate carries
exactly one of:

| Label | Means | Example |
|-------|-------|---------|
| `EV#` | Traces to a registered fact — a demo accepted, an export pulled, a milestone signed off | `M3: Green (EV7 — sponsor accepted the demo 2026-07-09)` |
| `A#` | A registered assumption with a stated basis and range | `Vendor integration: 3 wk (A2 — no local data; vendor's own SOW estimate; range 2–5 wk)` |
| `(user, <date>)` | The user said so, on the record | `Migration script effort: 4 days (user, 2026-07-11)` |

Rules of use:

- **Missing input → ask or register, never invent.** "I don't have
  confirmation the UAT environment is ready — do you have a sign-off, or
  shall I register an assumption with a range?" is always the right move.
  Coloring a milestone green to keep the table tidy is the exact failure
  this skill exists to prevent.
- **User assertions are legitimate but dated.** A sponsor's verbal "we're
  fine on M4" is a real input; the label keeps it honest and revisitable.
  If it later proves load-bearing (a go/no-go rests on it), promote it to
  an `A#` with a range, or ask for the export that would make it `EV#`.
- **Derived numbers show their arithmetic inline**, with each input
  labelled: `Forecast M5 = M4 actual (EV9) + 6 wk baseline duration
  (plan/baseline-2026-06-01.md) + 1.5 wk buffer burn (A5, vendor risk still
  open) = 2026-08-20`.
- **Qualitative claims follow the same spirit.** A risk narrative ("the
  vendor is behind") cites an `EV#`, an `A#`, or `(user, date)` — never
  floats as ambient team sentiment with no source.

## The registries

Seven registers, each with its own full schema in a dedicated reference
file — this file only fixes the id prefixes and the cross-file contract so
artifacts can cite across registers without ambiguity:

| Prefix | File | For | Full schema |
|--------|------|-----|--------------|
| `EV#` | `registers/evidence.md` | Facts: demos accepted, exports received, dates hit | this file, below |
| `A#` | `registers/assumptions.md` | Beliefs with a basis and a range, used until resolved | this file, below |
| — | `registers/decisions.md` | Append-only decision log — the re-entry backbone | this file, below |
| `R#` | `registers/risks.md` | Probability × impact, ROAM, owner, trigger | `references/risk.md` |
| `CH#` | `registers/changes.md` | Scope/date/budget changes with impact assessment | `references/change-control.md` |
| `AC#` | `registers/actions.md` | Action items with owner, due date, source | `references/stakeholders.md` |
| `L#` | `registers/lessons.md` | Plan-vs-actual lessons that feed future estimates | `references/lessons.md` |

Ids are never renumbered or reordered, even across sessions or when a play
imports rows from another tool — continuing the sequence is what lets a
citation stay valid forever.

## The assumption registry: registers/assumptions.md

One table, append-only ids:

```markdown
# Assumptions: <project>

| ID | Statement | Basis | Range (low–high) | Used by | Status |
|----|-----------|-------|-------------------|---------|--------|
| A2 | Vendor API integration takes 2–5 wk | vendor's own SOW estimate; no local delivery history with this vendor | 2–5 wk | plan/estimates.md row 4, R6 | open |
| A5 | Buffer burn on the vendor risk continues at current rate | observed burn over last 2 status cycles (status-2026-06-15, status-2026-06-29) | 1–2 wk additional | status-2026-07-06 forecast | open |
```

- **Statement** is falsifiable — written so a fact (`EV#`) could kill it.
- **Basis** says where the guess comes from; "gut feel from the last
  project" is an acceptable basis, but it must say so.
- **Range** is the honest interval, used directly by estimate sensitivity
  (`references/estimation.md`). A point value with no range is not a
  registered assumption — it is an invented number wearing a label.
- **Used by** lists every artifact leaning on it, so when the assumption
  resolves you know exactly what to revisit.
- **Status**: `open` · `validated (EV#)` · `falsified (EV#)` · `retired
  (reason)`. A falsified assumption triggers a walk through its Used-by
  list before the next artifact ships — a stale status corrupts every
  later plan or forecast quietly.

## The evidence registry: registers/evidence.md

```markdown
# Evidence registry: <project>

| ID | Date | Fact | Source | Notes |
|----|------|------|--------|-------|
| EV7 | 2026-07-09 | Sponsor accepted the M3 demo | meeting recording + sponsor email | unblocks M4 start |
| EV8 | 2026-07-11 | Sprint 14 velocity: 34 pts | Jira sprint report export | third sprint at this run rate |
```

- **Fact, not interpretation.** "Sponsor accepted the demo" is a fact;
  "the project is on track" is a conclusion an artifact draws *from*
  facts — it does not belong in this register.
- **Source names where a skeptic could go look** — a specific export, a
  specific email thread, a specific meeting, not "the team said so."
- Status colors, forecasts, and %-complete cite `EV#` rows directly —
  never a paraphrase of one.

## The decision log: registers/decisions.md

Append-only. Every play that ends in a decision writes an entry:

```markdown
## 2026-07-11 — Baseline re-cut after vendor delay (CH4)
- **Decision:** re-baseline the plan; M4 moves from 2026-07-20 to
  2026-08-03; absorb the slip from the schedule buffer, not by cutting
  scope.
- **Alternatives considered:** drop the reporting-export story to hold
  the date (rejected — sponsor priority, per CH4 impact assessment).
- **Why:** vendor integration slipped past its A2 upper bound (EV11 —
  vendor status call 2026-07-10); buffer covers 2 of the 2 wk needed.
- **Against advice / dissent:** none.
- **Revisit when:** vendor slips again, or buffer burn (A5) exceeds 80%.
```

- The **revisit-when** line is mandatory — a decision without a reversal
  trigger silently becomes dogma nobody re-checks.
- **A play blocked on data still writes an entry** — a pending-decision
  row with what's missing and a revisit trigger, so the gap is visible at
  the next re-entry instead of silently forgotten:

  ```markdown
  ## 2026-07-11 — Pending: M5 estimate basis
  - **Status:** blocked — no reference-class data for the reporting-export
    work; registered as A6 (range 3–6 wk, wide because untested) until a
    spike narrows it.
  - **Revisit when:** the spike (AC9, due 2026-07-18) reports.
  ```

- **Dissent is recorded, not erased** — including this skill's own
  disagreement when the user overrules it (Habits: challenge before you
  comply, in `SKILL.md`). The log is the project's institutional memory;
  a sanitized log teaches nothing to the next re-entry.
- On re-entry, the latest entries of this file are read first, before any
  play runs.

## state.md

Short and current — what is open, not what happened (history lives in
`decisions.md`):

```markdown
# State: <project>

open_plays:
  - control-change (CH4): decided, re-baseline drafted, waiting on
    stakeholder comms
  - assess-risks: weekly sweep due 2026-07-13
waiting_on_user:
  - sign-off on the re-baselined plan/baseline-2026-07-11.md
last_session: 2026-07-11 — CH4 decided, re-baseline drafted (see decisions.md)
```

## The Judge audits

Run by Judge (Solon): adversarial, evidence-first, run before the user is
asked to act on a baseline plan, a status report, or a change decision.
Use a separate subagent when available — the author of a plan is the worst
judge of its own optimism. Findings are appended to the artifact under
`## Judge audit — <date>`; nothing is quietly fixed or quietly dropped, and
any fix propagates to every file repeating the flagged content (see
[the propagation rule](#the-propagation-rule)).

### Audit 1 — Baseline plan (before the user commits it externally)

1. **Milestone completeness.** Does every milestone have a named owner, a
   dependency list, and a labelled estimate (`EV#`/`A#`/(user, date))? An
   owner-less milestone is nobody's job the day it slips.
2. **Acceptance evidence defined up front.** Does each milestone state
   what fact would mark it done ("EV: sponsor accepts the demo"), not just
   a date? A milestone with no acceptance evidence is a watermelon waiting
   to happen.
3. **Critical path identified.** Is the critical path named in the plan,
   not left for someone to reconstruct from a dependency graph under
   pressure during a slip?
4. **Buffers visible.** Are buffers named line items at plan level, not
   hidden padding inside task durations? (`references/estimation.md`)
5. **Pre-mortem run.** Has a pre-mortem happened for this baseline, and
   did its findings become `R#` rows or plan changes — not a workshop
   nobody acted on? (`references/risk.md`)
6. **Charter ↔ plan reconciliation.** Does the plan's scope match
   `context/charter.md`'s In list exactly? Any mismatch is either a
   missing `CH#` or a charter that needs updating — never a silent drift.
7. **Known risks reflected.** Do the top `R#` risks show up as schedule
   buffer, sequencing choices, or contingency — or does the plan read as
   if the risk register doesn't exist?

### Audit 2 — Status report (before it's sent)

1. **Provenance sweep.** Every RAG color and every %-complete cites
   `EV#`/`A#`/(user, date). One naked color fails the whole report.
2. **Watermelon check.** Is any Green backed only by "on track" prose with
   no fact behind it? Is any Amber missing a named recovery action?
3. **Percent-complete honesty.** Does every %-complete resolve to a
   countable numerator/denominator (work packages, accepted stories) — and
   if the same number repeats two reports running, does the report say so
   out loud instead of restating it silently?
4. **Forecast confronts history.** Does a revised forecast date explain
   *why* it will hold, given the project's own slip record
   (`registers/lessons.md`, prior status snapshots) — or does it just
   restate the wish?
5. **Bad news first.** Do slips, red risks, and overdue actions appear
   before achievements, in the headline — not buried in a detail table?
6. **Audience-tier consistency.** Do the exec summary and the team-detail
   view tell the *same* truth at different zoom levels? A tier that
   softens a color, not just the prose, fails.

### Audit 3 — Change decision (before it's executed)

1. **Impact assessment complete.** Does the `CH#` row cover schedule,
   cost, risk, *and* quality — each with a labelled basis — or does it
   stop at schedule because that's the easy one?
2. **Decision authority matches the charter.** Was the decision made (or
   explicitly delegated) by the authority named in `context/charter.md`,
   not defaulted to whoever was in the room?
3. **Baseline handling is explicit.** If the change moves a committed
   date or budget, was a new `plan/baseline-<date>.md` snapshot taken,
   with the old one kept, not overwritten?
4. **Propagation checklist run.** Do the schedule, estimates, risk
   register, and stakeholder comms plan all reflect the decided change —
   or does one register now disagree with another?
5. **Trade-off named, not smuggled.** Does the record show which option
   was chosen — absorb / trade / extend / reject — and why, rather than
   the change simply appearing done?

## The propagation rule

A finding fixed in one file but repeated stale in another is not fixed —
it is relocated. Before closing any Judge finding or any user-requested
correction, grep the workspace for the flagged string (a stale forecast
date, a since-corrected estimate, a superseded risk score) and update
every file that repeats it: the schedule, the estimates, the risk row, the
stakeholder comms draft, the last status snapshot's forward-looking notes.
A fix that lives only in `decisions.md` while `plan/schedule.md` still
shows the old date is exactly the kind of drift the workspace exists to
prevent.

## Copy, never retype

Numbers and quotes copied from a user export, a vendor email, or a Jira
report are copied character-for-character into the workspace — never
retyped from memory. Retyping is how a `34 pts` sprint velocity silently
becomes `35`, or a sponsor's conditional "yes, if X" becomes an
unconditional "yes" by the third file it propagates through. Before any
number or quote ships in a decision artifact or the reply, check it
against its source (grep works for exact strings); a mismatch means it
drifted and must be re-copied, not patched by eye.

## The user-facing reply is an artifact too

Everything above applies to the message sent to the user, not only to the
workspace files — the reply is the artifact most stakeholders will ever
actually read. Concretely:

- **The headline leads.** On track / slipping / blocked, and why, comes
  first — never after a recap of what went well.
- **The decisive numbers carry their labels** inline in the reply, not
  only in the linked file: "M4 forecast slips to 2026-08-03 (CH4, buffer
  absorbs it — vendor delay EV11)."
- **The recommendation is inline.** A reader who never opens `_project/`
  should still get the finding, its evidence, and what to do next.
- **Reference files by workspace-relative path** (`registers/risks.md`),
  never by absolute filesystem path.
- **Speak as a PM, not as a methodology.** No "per this skill's rules," no
  naming the machinery to the user. The labels and audits appear in the
  work; the voice is a colleague explaining a recommendation. End on the
  recommendation or the open decision — not a promissory sign-off.

## Self-check before handing off any artifact

Thirty seconds, every time:

1. Any status, date, or number with no `EV#`/`A#`/(user, date) label? (Ask, register, or cut.)
2. Any `A#` used as a point value with no range? (Add the range.)
3. Any milestone with no named owner or no acceptance evidence defined? (Fix or flag.)
4. Any id (`EV#`, `A#`, `R#`, `CH#`, `AC#`, `L#`) that doesn't resolve to its register? (Register it.)
5. Any Green with no fact behind it, or Amber with no named recovery action? (Fix the color or the report.)
6. Decision made this session not yet in `decisions.md` with a revisit-trigger? (Append it.)
7. Any status a fact has already changed but a file still shows the old one? (Update, and walk the propagation checklist.)
8. Does the reply stand alone — headline first, key numbers labelled, recommendation inline, no absolute paths, no methodology talk? (Fix the reply.)
9. Every copied number or quote, in every file and in the reply, matched verbatim against its source? (Search each one; fix any drift.)
