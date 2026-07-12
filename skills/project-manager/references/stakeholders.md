# Stakeholders — map, comms plan, meetings → actions

Guides the **map-stakeholders** and **run-meeting** plays (Socrates ·
Bridge). Socrates works by dialogue — this file is where the project's
people, not just its tasks, get tracked with the same discipline as the
schedule. Read `references/pm-discipline.md` first for the provenance
labels this file assumes throughout.

## Stakeholder map

Lives in `context/stakeholders.md`, under the `## Map` table:

| Stakeholder | Interest | Influence | Attitude | Origin |
|-------------|----------|-----------|----------|--------|
| Priya (Eng lead) | High — owns delivery risk | High | Supportive | (user, 2026-07-02) |
| Finance (Sofia) | Medium — budget owner | High | Neutral | (user, 2026-07-02) |

- **Interest** and **influence** are rated relative to *this project*, not
  the person's general seniority — a VP with no stake in this particular
  delivery is low-interest here even if high-influence elsewhere.
- **Attitude** (supportive / neutral / resistant, or similar) is **the
  user's read, never the skill's invention.** The skill has no channel
  into what a named person actually thinks; asserting an attitude from
  inference would be exactly the kind of fabricated-authority failure the
  non-negotiables exist to prevent. If the user hasn't given a read yet,
  the cell says so ("unknown — ask") rather than guessing "neutral" as a
  safe default.
- **Origin** is almost always `(user, <date>)` for this table — attitudes
  and influence reads rarely resolve to hard evidence, but the label still
  belongs there so a stale read (someone's attitude from six months ago)
  is visibly stale.

**Engagement strategy by quadrant**, a standard high-interest/high-influence
frame worth naming explicitly so the comms plan below isn't arbitrary:

| | Low influence | High influence |
|---|---|---|
| **High interest** | Keep informed — detail welcome | Manage closely — the steering-committee tier |
| **Low interest** | Monitor — light touch | Keep satisfied — brief, timely, no surprises |

## Communication plan

Lives in `context/stakeholders.md`, under `## Communication plan`:

| Audience | What they get | Cadence | Channel | Owner |
|----------|---------------|---------|---------|-------|
| Steering committee | Exec-tier status + decisions needed | Bi-weekly | Meeting + doc | PM |
| Eng team | Team-tier status + risk register | Weekly | Standup / Slack | PM |

This table is what `references/status.md`'s audience tiers actually
route to — the exec tier isn't a format choice made fresh each week, it's
this row. Every stakeholder in the map above should resolve to a row here;
a high-influence stakeholder with no communication plan row is a gap to
raise, not an oversight to leave implicit.

**The surprise test:** no stakeholder should learn bad news later than
their influence warrants. Before a status snapshot goes out, check it
against this table — if a red item affects someone whose cadence is
"bi-weekly" but the news is time-sensitive, that is a signal to reach out
off-cycle, not to wait for the scheduled slot. A steering committee that
hears about a slipped milestone from a hallway conversation before the
official update has failed the surprise test regardless of how accurate
the eventual report was.

## Meeting kit

A meeting is scaled to the decision it needs to produce — not every
touchpoint deserves the same ceremony:

- **Before scheduling, name the decision or information need.** "Sync up"
  is not a reason to convene people; "decide whether to accept CH4" or
  "walk finance through the Q3 forecast" is. A meeting without either gets
  declined politely, with the alternative offered (an async update, a
  one-line answer).
- **Agenda scales to the decision.** A single decided item gets a single
  agenda line with the options already drafted (so the room can decide,
  not discover); a steering committee gets the pack described below.
- **Minutes are captured live, in the meeting, not reconstructed after.**
  Two outputs, both real-time:
  - Decisions → appended to `registers/decisions.md` as they're made,
    with the decision, alternatives considered, why, and dissent if any.
  - Actions → a new `AC#` row in `registers/actions.md` per action, with
    owner and due date named *in the room* — an action item with no owner
    assigned in the meeting becomes an action item nobody does.
- **Parking lot.** Off-topic but real items get a visible parking-lot
  line in the minutes, each routed afterward to the register it belongs
  in (a new risk, a new `CH#`, a future agenda item) — not silently
  dropped and not silently absorbed into the current meeting's scope.

## AC# action tracking

Schema (from `registers/actions.md`): `ID | Action | Owner | Due | Source
| Status`. Source names the meeting or status snapshot that created it, so
an action's origin is always traceable.

- **Overdue items surface at every re-entry** — when the skill picks the
  project back up in a new session, overdue `AC#` rows are part of the
  state reflected back to the user, not left for someone to notice by
  scrolling the register.
- **Overdue items surface in every status snapshot** until closed (see
  `references/status.md`'s "actions overdue" section) — visibility, not
  nagging, is the point; an overdue action that never resurfaces might as
  well not exist.
- **Closing an action requires an outcome note, not just a checkbox.**
  "Done" with no note loses the information that made the action worth
  tracking in the first place — what happened, what it unblocked, whether
  it needs a follow-up. A one-line outcome is enough; a bare status flip
  is not.

## Steering-committee pack

The recurring artifact for the high-interest/high-influence audience,
assembled **from the registers, every time — never written fresh from
memory**:

```markdown
# Steering pack: <project> — <date>

## Status headline
(from the latest status/status-<date>.md)

## Decisions needed
(pending rows from registers/decisions.md, each with options +
recommendation — the committee's actual job this session)

## CH# queue
(changes raised but not yet decided, from registers/changes.md)

## Top risks
(highest-score rows from registers/risks.md, ROAM state, owner)
```

Assembling this by pulling from the four source files (not by drafting a
narrative and citing them loosely afterward) is what keeps the pack
consistent with everything else the project reports — a steering pack
that says something the weekly status snapshot doesn't is a sign one of
the two was written from memory instead of from the registers.

## Difficult-message patterns

Candor first, options attached, blame absent — three patterns that recur
often enough to template, each drafted *with* the user, never sent without
their review:

- **Slip announcement.** State the slip and the evidence in the first
  sentence (no lead-up). Name what changed and why, in plain terms. State
  the recovery plan or, if there isn't one yet, when there will be.
  End with what's needed from the reader, if anything.
- **Descoping proposal.** State the constraint driving it (date, budget,
  capacity — with its `CH#` or evidence). Offer the specific trade
  (what comes out, what stays) as a recommendation, not an open question
  — a proposal that asks "what should we cut?" pushes the PM's job onto
  the stakeholder. Name what the trade protects (the committed date, the
  budget) so the ask reads as a choice, not a failure.
- **Escalation note.** Situation (one paragraph, factual) → decision
  needed (specific, not "please advise") → options with honest trade-offs
  → recommendation → required-by date. An escalation with no
  recommendation asks the reader to do the PM's analysis for them; an
  escalation with no required-by date invites indefinite delay.

Every pattern above states facts and evidence, not fault — "the vendor API
still 403s on webhook subscribe (EV7)" carries the same information as
"the vendor is being difficult" without spending any of the relationship
capital the project will need for the next hard conversation.
