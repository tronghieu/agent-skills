# Impediments — the Shield play

Impediments don't get resolved by being written down. They get
resolved by being **visible, owned, and aged** — and escalated before
they fossilize. The register exists so that nothing blocks quietly.

## impediments.md — the register

```markdown
# Impediments — <team>

| IM# | Opened | What & who it blocks | Owner | State | Last action | Links |
|-----|--------|----------------------|-------|-------|-------------|-------|
| IM-2 | 2026-08-26 | Staging env down — blocks A-105, QA idle | Tùng | aging | nudge draft ready 08-29 → state.md | SC-2 |
```

Rules:

- An impediment enters the register the moment a pulse or a
  conversation surfaces it — not at the next ceremony.
- Every `IM#` has an owner. "Unowned" is written as `owner: NONE` in
  the table and reported as its own problem — an unowned impediment
  is the oldest kind.
- An owner who also owns the story the impediment blocks is a
  conflict, not a plan — nobody fixes the infra and ships the feature
  at once. Flag the join; propose an owner outside the blocked work.
- Closing records what worked, one line. Closed lines stay in the
  table; they feed the retro data pack and the health-scan.

## The aging ladder

Age drives action. Check ages at every pulse and every re-entry; list
open impediments oldest-first.

| Age | State | The move |
|-----|-------|----------|
| 0–2 days | fresh | Owner works it. Note it, stay out of the way. |
| 3–6 days | aging | **Nudge**: draft a short message to the owner — what's stuck, what would unstick it, offer help. |
| ≥ 7 days | stale | **Escalate**: draft a message to whoever can actually fix it, propose a plan B, tell the user plainly this now costs the sprint goal. |
| Outgrows the team | project-level | **Hand off to the risk register** (below). |

Thresholds are defaults — a hard team agreement in `context.md`
overrides them. What never changes: age is checked, and rising age
forces a bigger move. An impediment nudged four times is not being
managed; it is being watched.

The ladder binds **every play that touches the register**, not just
tend-impediments. A retro prep that meets a 12-day impediment drafts
its escalation in that same session and marks the state `stale` —
root-cause work is added on top of the ladder move, never substituted
for it.

## Handoffs — the honest-hands rule

This skill has no legs. Every nudge and escalation is a **draft**: the
message text, a named recipient proposed from `context.md` or the PM
roster — ask only when the files offer nobody — and a follow-up note
in `state.md` ("check IM-4 next session").

Two states, and the words never drift past them:

- **`draft ready <date>`** — the message text exists **in a file**.
  The reply alone dies with the window: save the draft beside its
  follow-up in `state.md` and point the register cell at it. No saved
  text, no claim — "escalation drafted" with nothing to show is a
  violation, not a shortcut. The next session will read the register
  and believe it.
- **`sent <date>`** — only when the user confirms it went out, or
  asked us to send it through a connected tool.

There is no past-tense "escalated (by me)" — the reply says "draft
ready, not sent" and the user says when it becomes sent. A draft is
written to its recipient, in the recipient's frame; the test is
whether the user could forward it unedited. Analysis addressed to the
user ("what I'd worry about...") is not a draft. Tightening a reply
removes duplication, never the artifact — the quoted messages are the
part the user can use. Never mark an impediment "handled" because a
draft exists.

Escalation drafts name the cost, not the villain:

> "IM-4: staging has been down 9 days. Sprint goal ★ stories can't be
> verified; QA has been idle 3 of the last 5 days. We need either
> infra time this week or a decision to test in prod behind a flag.
> Which do you want?"

## Project-level handoff — IM# ↔ R#

Some impediments outgrow the team: they need budget, another
department, or authority nobody in the room has. If `_project/`
carries a project-manager workspace, that is where they belong.

1. Draft the risk entry in `R#` form (risk, probability × impact,
   owner, trigger) for the user to paste into
   `registers/risks.md` — **never write that file yourself**.
2. Link both ways: the `IM#` line gets `→ R12`, and the drafted `R#`
   text cites the `IM#`.
3. The impediment stays open here until the block actually clears —
   a risk being tracked is not a block being gone.

No project-manager workspace → same drafting move, addressed to
whoever holds the authority (a sponsor, a manager), tracked only here.

## The weekly sweep

Impediment work is a habit, not an event. Every pulse touches the
register (rule 4 of the pulse play). Once a sprint — at the pulse
nearest mid-sprint — do the full sweep: re-age everything, chase
`owner: NONE`, check whether sent escalations actually moved
anything, and surface the median age. Median age above sprint length is a
health-scan trigger (see `anti-patterns.md`, impediment rot).
