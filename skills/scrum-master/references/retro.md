# Retro — the Gardener play

The retro is the team's improvement engine, and the most commonly
faked ceremony: complaints are aired, actions are listed, nothing
happens, repeat. This skill's retro has one distinguishing move — it
**opens with the audit**, not with feelings.

## retros.md — the improvement book

One file, two parts: the `PI#` register on top, retro records below.

```markdown
# Retrospectives — <team>

## Improvement register

| PI# | Born | Improvement | Owner | Due | Status | Note |
|-----|------|-------------|-------|-----|--------|------|
| PI-6 | S10 | Rotate CI babysitter weekly | Minh | S11 | open | |

## Retro — sprint 10 (2026-08-22)
...
```

Statuses: `open`, `in-progress`, `done`, `dropped (<reason>)`. There
is no silent way out of this table — that is the point of the table.

## Running a retro

### Step 0 — audit the previous actions. Always. First.

Read every non-closed `PI#`. State each one aloud: done, in progress,
or a candidate to drop. Dropping is legitimate — but it takes a
recorded reason. Compute the completion rate and say it: "Last retro
produced 3 improvements; 1 done, 2 untouched." Teams change what they
measure; a retro that never checks its own output teaches the team
that retro promises are decorative.

**The recurrence rule.** Before the discussion, search past retro
records for this sprint's emerging themes. A theme appearing for the
**third time** is no longer feedback — it is a system condition. Do
not re-list it as a fresh `PI#`. Name it as a recurrence, say which
retros raised it, and route it to root-cause work: a five-whys in this
retro, a health-scan, or — if the fix needs authority or budget the
team lacks — a drafted `R#` handoff to the project risk register.

### Step 1 — the data pack

Feelings drift; snapshots don't. Prepare the pack from close snapshots
and registers before opinions start, every number with its source:

- Velocity, last 3 sprints, and the trend.
- Carry-over pts and %, last 3 sprints — always beside velocity. A
  team can slow down, or finish less of what it starts; only the pair
  tells which, and they are different retros.
- Added-mid-sprint pts (`SC#` totals), last 3 sprints.
- Goal: met / partial / missed streak.
- Impediments: opened, closed, oldest open with age.
- `PI#` completion rate from step 0.

Two cross-checks on top of the numbers:

- **Owner concentration.** Cross impediment owners × open `PI#`
  owners × ★ story owners. One name in all three columns is the
  structural risk the totals hide: the sprint is betting on the
  person already underwater. Say it as a join, not three facts.
- **Displaced work.** Stories carried more than once — especially
  small ones — and what displaced them each time. A 1-pt story
  bumped twice by firefighting is the retro's most concrete exhibit.

Missing history → smaller pack, gaps named. Never pad with estimates.

The pack goes in the reply body, table and all — `retros.md` keeps
the record, but the facilitator reads the reply in the room. A number
that stays in a file was never delivered.

### Step 2 — collect and discuss

Async-friendly formats. Pick by fit for what the sprint was, and say
the fit reason first ("timeline walk — the sprint broke mid-way and
the pulse log shows where"). Rotation only breaks ties between
formats that fit; it is never the stated reason:

- **Keep / Drop / Try** — fastest, good default.
- **4Ls** (Loved / Learned / Lacked / Longed for) — when the sprint
  had feelings that need naming before mechanics.
- **Timeline walk** — replay the sprint day by day against the pulse
  log; best after a chaotic sprint.

For distributed teams, draft the collection message for the user to
post, gather replies, synthesize by theme, and quote people's words —
don't paraphrase everything into consultant-speak.

### Prepping the room — the full pack, every time

Prep is additive: a sharper analysis never replaces a working
artifact. Hours before the retro, the facilitator needs all of this
in one reply:

1. **The sprint goal, quoted**, and how it ended — a retro about a
   missed goal that never names the goal is odd in the room.
2. **The Step-0 audit and the data pack**, tables in the reply.
3. **Recurrences with their routing — and the ladder move riding
   along.** Root-cause work never substitutes for the escalation an
   aged `IM#` is already owed (see `impediments.md`): five-whys AND
   the drafted, sendable message. Not either/or. The prep states the
   draft's status plainly — draft ready, not sent — and never books
   the escalation as done.
4. **A time-boxed agenda** the user can run the room with, minute by
   minute, format chosen for fit (rotation is a tiebreaker).
5. **Facilitator prompts as speakable questions** ("A-190 has been
   bumped two sprints running — what keeps eating it?").
6. **Open decisions with a recommendation to veto** — a recipient
   from `context.md`, a close-or-keep call — never cold questions
   hours before the room.
7. **The bridge forward**: one line on what this retro feeds into the
   next planning — carry-in stories counted toward capacity.

Save the pack before the meeting: a clearly labeled prep section in
`retros.md` ("## Retro prep — S11, written pre-meeting") or a prep
file, and say in the reply where it lives. A pack that exists only in
chat dies with the window. Offer the data pack as a short team
pre-read the user can post before the room — numbers read in advance
argue less. The full retro record still lands only after the meeting
— prep never records what hasn't happened.

### Step 3 — new improvements, capped

At most **2–3 new `PI#` per retro.** Improvement work spends the same
capacity as feature work; a list of eight actions is a list of zero.
Each `PI#` gets:

- The **smallest change that tests the fix** — "rotate CI babysitter
  weekly", not "improve CI culture".
- A named owner and a due sprint.
- A "how we'll know" — observable in a future snapshot or register.

### Step 4 — record

Append the retro record: audit results, data pack, discussion by
theme, new `PI#`s, recurrences flagged. Update the register table.
Update `state.md` with follow-ups ("check PI-7 at next pulse").

## Record template

```markdown
## Retro — sprint 11 (2026-09-05)

### Previous actions audit
| PI# | Improvement | Status | Note |
Completion: 1 of 3.

### Data pack
| Metric | S09 | S10 | S11 | Source |

### Discussion — Keep / Drop / Try
- Keep: ...
- Drop: ...
- Try: ...

### New improvements
| PI# | Improvement | Owner | Due | How we'll know |

### Recurrences
- Flaky CI: raised S09 (PI-3), S10 (PI-6), again now → root-cause
  work, see IM-4 escalation draft.
```

## Handoffs

The retro conversation itself may need a human: a conflict between two
people, feedback for one person, a topic the team won't type into a
shared doc. Name it, hand it off — talking points for the user, a
named owner, a follow-up in `state.md`. Never role-play the
conversation as having happened.
