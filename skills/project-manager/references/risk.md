# Risk — register, ROAM, pre-mortem, escalation

The Watch lens (Epictetus). Read this before running `assess-risks`.
Epictetus's discipline is the model here: separate what is within the
project's control from what must be accepted, and be honest, in writing,
about which is which — that separation *is* the risk register.

## Contents

- [Register schema](#register-schema)
- [ROAM vocabulary](#roam-vocabulary)
- [Discovery prompts by category](#discovery-prompts-by-category)
- [Pre-mortem](#pre-mortem)
- [Review cadence](#review-cadence)
- [Escalation](#escalation)
- [Risk ↔ other registers](#risk--other-registers)

## Register schema

`registers/risks.md` (schema fixed by `scripts/init-project.sh`):

| ID | Risk | P | I | Score | ROAM | Owner | Trigger / next review | Status |
|----|------|---|---|-------|------|-------|-----------------------|--------|
| R7 | Vendor sandbox credential delayed past 2026-07-20 | 3 | 4 | 12 | Owned | Chen (Eng Lead) | Trigger: credential not received by 07-18. Next review: 07-15 | active |

**Probability × Impact, on a 1–5 scale each, anchored to *this* project's
charter** — not a generic dollar-threshold table copied between projects.
Derive the anchors from `context/charter.md`'s dates and budget envelope
before scoring anything:

| Impact | Anchor (example: Capigo Mobile App, budget $180k, 12-week timeline) |
|---|---|
| 1 — negligible | <1 day slip, no budget effect |
| 3 — moderate | 1–2 week slip, or >5% of budget |
| 5 — severe | Misses the committed launch date, or >20% of budget |

Every risk names an **owner from `context/team.md`** — a real person, by
name. "The team" owns nothing, because a risk owned by everyone gets
reviewed by no one; when a review cycle comes and a risk has drifted, the
first question is "whose job was watching this," and that question needs
a one-word answer.

## ROAM vocabulary

Adopted from SAFe, kept methodology-neutral. Every active risk carries
exactly one of these, and moving between them is itself a decision worth
a line in `registers/decisions.md` when the stakes are material:

- **Resolved** — the condition that created the risk no longer applies
  (the vendor delivered, the dependency shipped). Close it; don't delete
  the row — it's history.
- **Owned** — someone is actively working a mitigation right now, with a
  next-review date that actually gets checked.
- **Accepted** — the team chooses to live with the exposure rather than
  spend effort mitigating it. **Requires a documented rationale and a
  contingency** in the row or a linked note — "accepted" without both is
  neglect wearing the vocabulary of a decision. The rationale answers "why
  is mitigating this not worth it," and the contingency answers "what do
  we do if it fires anyway."
- **Mitigated** — action has been taken that measurably reduces P or I;
  record what changed and re-score.

## Discovery prompts by category

Run a **sweep of every category**, not just the two or three risks that
come to mind first — stopping early after finding a couple of obvious
risks is satisficing, and it reliably misses the categories that don't
volunteer themselves (resource and external risks especially hide from a
quick brainstorm). Use these prompts per category, and visibly account
for each category even when the honest answer is "none identified here":

- **Technical** — What hasn't been built before on this stack? What
  integration has never been tested end-to-end? What happens under load
  nobody has simulated? What's the single point of failure?
- **Dependency** — What does this plan wait on that this team doesn't
  control (vendor, another team, an approval, infrastructure)? Which of
  those sit on the critical path (`references/planning.md`)?
- **Resource** — Who is a single point of failure for a skill or
  decision? What happens if a named person is out for two weeks? Is
  capacity assumed at 100% utilization anywhere?
- **Schedule** — Which milestone has the thinnest buffer
  (`references/estimation.md`)? What was optimistic in the last estimate
  round that hasn't been revisited?
- **External** — Regulatory, market, or organizational changes outside
  the project that could shift scope, budget, or priority mid-flight?

## Pre-mortem

Run at baseline and again before each major gate (a re-baseline, a phase
transition, a go/no-go). Prompt the group with: **"It's six months from
now, and this project failed. What happened?"** — asking for the failure
story directly, before it's happened, surfaces causes that a forward-
looking "what could go wrong" question tends to miss, because imagining a
completed failure invites specific detail instead of hedged generalities.

Every failure story produced becomes one of two things, not a feel-good
workshop artifact filed away and forgotten:

- A new `R#` entry (with owner, ROAM status, trigger) if it names a risk
  not already on the register.
- A plan change — a reordered dependency, an added buffer, a milestone
  split — if the fix belongs in `plan/schedule.md` rather than the risk
  register.

Worked example (Capigo Mobile App pre-mortem, 2026-07-10, `(user, 2026-07-10)`):
"We failed because the App Store review rejected the release twice over a
privacy-manifest issue nobody checked until submission." → registered as
`R11 — App Store privacy-manifest compliance unverified before
submission`, Owned by Amara (Mobile Lead), trigger: not verified two weeks
before submission date.

## Review cadence

A weekly sweep, not a passive table nobody reopens:

1. **Owned** risks — what progress since last review? Is the
   next-review date still meaningful, or has it quietly slipped?
2. **Mitigated** risks — is the mitigation actually working, evidenced
   (`EV#`), or is that a hope?
3. **Accepted** risks — still the right call, or has P/I moved enough to
   revisit the acceptance?
4. **New** — anything from this week's work, meetings, or status
   snapshots that wasn't on the register before; run it through the
   category sweep above rather than adding it ad hoc.

**Risks stale past their next-review date surface automatically at
re-entry** — the re-entry protocol in `SKILL.md` treats an overdue risk
review the same as an overdue action: bad news that travels first, not
something the user has to remember to ask about.

## Escalation

Escalate when any of these hold: the score jumps materially between
reviews, a mitigation is visibly failing and the owner lacks authority to
fix it (needs budget, needs another team's commitment, needs a scope
trade), or a risk has sat "Owned" past two review cycles with no
movement.

Escalation note format — one page, decision-ready, not a status report in
disguise:

```
## Escalation — R7, 2026-07-16

Situation: Vendor sandbox credential still not received; trigger date
(07-18) is two days out.

Decision needed: Whether to hold the M4 date or replan around it.

Options:
- Hold M4, absorb up to 3 days from the schedule buffer if credential
  arrives by 07-20. Risk: buffer is already 40% burned elsewhere (status
  2026-07-14).
- Replan M4 behind M5, resequencing payment work after search — costs an
  estimated 4 days of idle payment-team capacity (A11).
- Escalate to vendor's account manager directly (contact: charter
  sponsor's counterpart) — no cost, uncertain speed.

Recommendation: Escalate to the vendor now (no cost, strictly upside)
while holding M4 provisionally; revisit hold-vs-replan on 07-18 if no
credential.

Required by: 2026-07-16 EOD, so the vendor escalation can go out same day.
```

## Risk ↔ other registers

A risk register that lives in isolation stops being trustworthy the
moment reality moves — wire it to the registers that track what actually
happened:

- A risk that **materializes** becomes an issue, and usually a `CH#` in
  `registers/changes.md` if it moves scope, date, or budget.
- A **mitigation** becomes one or more `AC#` action items in
  `registers/actions.md`, each with an owner and a due date — "mitigate
  R7" is not itself an action; "escalate to vendor account manager by
  07-16" is.
- Whatever the register missed — a risk nobody saw coming, or a category
  the sweep should have caught — becomes an `L#` lesson in
  `registers/lessons.md`, feeding the next project's discovery sweep and
  this project's next pre-mortem.
