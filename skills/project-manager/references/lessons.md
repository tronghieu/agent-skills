# Lessons — retros that change the next estimate

This file governs the `capture-lessons` play (lens **Heraclitus · Loop**).
Lessons are the mechanism that closes the planning-fallacy loop: an estimate
that never confronts its own history repeats its own mistakes, confidently.
A lessons register that nobody reads back into estimation is not
discipline — it is a diary with a table format. Everything below exists to
make the register *feed* the next estimate, not just record the last one.

## 1. When to run

Run a retro whenever there is fresh signal to extract, not on a fixed
calendar alone:

- **End of a phase, sprint, or milestone.** The natural cadence — plan
  existed, actuals now exist, the gap is fresh in memory. In agile
  projects this is the sprint retro; in predictive projects, the milestone
  close.
- **After a risk in `registers/risks.md` materializes.** Run this one
  within days, not at the next scheduled ceremony — memory of *why* the
  risk landed decays fast, and the trigger conditions are still visible.
- **After a re-baseline.** Any time `control-change` freezes a new
  `plan/baseline-<date>.md`, ask what made the old baseline wrong. A
  re-baseline without a lesson just moves the goalposts and waits to
  repeat the miss.
- **At close-out.** A full-project retro that rolls up the phase-level
  lessons, checks which ones actually got used, and exports the durable
  ones for the next project (see §4) or sibling projects in a portfolio
  (`references/portfolio.md`).

**Small and often beats one grand post-mortem.** A single three-hour
close-out retro six months after the fact recovers a fraction of what
happened and nobody attends with real memory left. A fifteen-minute
plan-vs-actual walk at every milestone, logged as it happens, compounds
into an accurate record and costs less total time. When a project has run
for months with zero `L#` rows, that is itself a finding — say so and
propose the next natural trigger instead of waiting for a "retro day".

## 2. The L# schema

`registers/lessons.md` holds one row per lesson:

| ID | Date | Context | Planned vs actual | Lesson | Feeds |
|----|------|---------|--------------------|--------|-------|

- **Context** — what was being planned or estimated, and at what
  methodology stage (a sprint's velocity, a milestone's critical-path
  task, a whole phase's budget).
- **Planned vs actual** — the real numbers, **copied, never retyped**,
  from `plan/baseline-<date>.md` and `status/status-<date>.md` (the
  copy-never-retype discipline in `references/pm-discipline.md` applies
  here exactly as it does to quotes). Citing a remembered approximation
  ("about a month late") instead of the dated figures defeats the point
  of keeping baselines at all.
- **Lesson** — the generalizable insight, not a restatement of the
  incident. "The vendor was late" is an incident. "Vendor-gated
  milestones need an access-confirmation precondition before the clock
  starts" is a lesson.
- **Feeds** — mandatory. Names the estimate class, checklist, or context
  file this lesson should change: an entry in `plan/estimates.md`'s
  reference-class column, a line added to the anti-pattern checklist in
  `references/estimation.md`, a revision to `context/methodology.md`'s
  cadence. **A lesson that feeds nothing is a diary entry** — either find
  its target before registering it, or hold it as a candidate and say so.

Worked example (illustrative — provenance labels shown as they would
appear in a real register):

> `L3` | 2026-06-02 | Vendor API integration, milestone M4 | Planned 2
> weeks (basis: analogous estimate, `plan/baseline-2026-04-01.md`);
> actual 5 weeks (`status/status-2026-05-30.md`, `EV12`: vendor sandbox
> access granted 3 weeks late) | Vendor-dependent integrations must
> buffer for access/sandbox lag, not just build effort — the build itself
> ran close to plan | **Feeds:** the "third-party API integration"
> reference class in `plan/estimates.md`; add "sandbox access confirmed"
> as a precondition to the estimation checklist in
> `references/estimation.md`

Note what the lesson is *not*: it does not say "the vendor was slow" and
stop there. It names the planning gap (access lag wasn't modeled) and
points at exactly the file that should change so the same gap doesn't
reopen on the next vendor integration.

## 3. Retro format kit

Pick the format to fit the trigger — a five-minute risk-materialization
retro doesn't need a full plan-vs-actual walk, and a phase close does.

- **Plan-vs-actual walk.** Milestone by milestone (or story by story),
  compare the baseline figure to the actual, in order, out loud.
  Facilitation note: walk the *numbers* first, feelings and narrative
  second — starting with "how did it feel" invites a story that doesn't
  reconcile with the record. Ask "what would have changed the estimate,
  if we'd known it then?" for every row that missed by more than the
  buffer.
- **Keep / drop / try.** The standard team retro, run by the user with
  their team; the skill's role is to draft the discussion prompts ahead
  of time (tuned to what actually happened this cycle, not generic
  prompts) and to structure whatever the user reports back into `L#`
  rows afterward. Facilitation note: timebox each column to keep the
  session under thirty minutes for a sprint-sized retro; a keep/drop/try
  that runs an hour stops producing lessons and starts producing
  meeting minutes.
- **Five-whys on one incident.** Reserved for a single materialized risk
  or a sharp slip, not a whole phase. Pick the one incident, drill "why"
  until the answer names a system or a missing process, then stop —
  five-whys that keeps drilling past the actionable layer degenerates
  into cosmic causes ("why does anything ever go wrong") that feed
  nothing. Route the answer through the blame-hygiene check in §5 before
  it becomes a lesson.

**Facilitation boundary.** When the user runs a retro live with their
team, the skill drafts the prompts and structures the output — it does
not sit in the room and does not invent what teammates said. Whatever the
user reports back is copied into the `L#` row verbatim where it's a
quote, and summarized honestly where it isn't; nothing is embellished to
sound more like a lesson than it is.

## 4. The feedback-loop mechanics

A lessons register earns its place only by changing what happens next.
Three concrete hookups:

- **Estimate consults lessons.** Before `estimate` issues a range, it
  reads `registers/lessons.md` for rows whose `Feeds` names the estimate
  class in play — this *is* the reference-class check described in
  `references/estimation.md`. An estimate for a vendor-gated milestone
  that ignores `L3` above is repeating a mistake with a paper trail.
- **Initiation imports history.** When a user starts a new project and
  has lessons from a previous one (their own prior `_project/registers/
  lessons.md`, or a summary they bring), `initiate` registers them into
  the new project's `context/` or `registers/assumptions.md` with an
  origin label pointing at the source project. Don't re-derive lessons
  from a description of what happened — import the rows.
- **Close-out exports lessons.** At project close, the durable lessons
  (the ones whose `Feeds` names something reusable beyond this one
  project — an estimate class, a checklist, an organizational pattern)
  get flagged for export: to the next project via the import path above,
  or across a live portfolio via `references/portfolio.md` §5.

Worked example of the loop actually closing: `L3` above changes the
default buffer for the "third-party API integration" reference class from
none to +2 weeks. The next estimate for a different vendor integration
cites `L3` directly in its basis column instead of repeating the bare
two-week guess that produced `L3` in the first place.

## 5. Blame hygiene

Lessons name **conditions and systems, not villains**. This is not a
soft-skills nicety — a register that reads as a blame log stops getting
fed, quietly, and a lessons file nobody writes to is worse than none
because it looks like discipline while doing nothing.

- Bad: "Priya missed the sandbox deadline." This names a person, implies
  fault, and teaches nothing about the next project.
- Good: "The sandbox-access request had no escalation path when the
  vendor didn't respond within five business days." This names a missing
  process and points directly at a fix.

Practical checks before an `L#` row ships:

- If the draft names a person as the subject of the lesson, rewrite it
  to name the condition that let the outcome happen — the person's name
  can stay in the *context* column as a fact (who owned the task) without
  being the subject of the *lesson*.
- If five-whys bottoms out on "someone should have been more careful,"
  that is not the actionable layer — go one level up to the system that
  depended on someone happening to be careful.
- The register should be safe to hand to the whole team, including
  whoever is named in the context of a slip. If it wouldn't survive being
  read aloud in the room, it is a grievance, not a lesson — hold it back
  and rewrite it, or raise it with the user as a people issue outside the
  register.

When Judge (Solon) audits a lessons draft alongside other artifacts, this
is one of the checks: does any `L#` row read as a verdict on a person
rather than a finding about a system?
