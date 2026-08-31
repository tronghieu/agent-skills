# Adopt — taking a team

The adopt play turns "be our scrum master" into a working setup in one
session, without an interrogation. Survey first, ask only for gaps.

## Step 1 — survey what exists

Before asking anyone anything, look:

- `_project/` present? Read `_project/README.md` if it exists.
- A project-manager workspace? (`_project/context/`,
  `_project/registers/` — flat files at the root.) Gold: team,
  methodology, stakeholders are probably already recorded.
- `_project/tools.md`? Existing tool entries may already reach the
  team's tracker.
- Any tracker, board export, or sprint doc the user mentioned.

## Step 2 — initialize

```bash
bash /mnt/skills/user/scrum-master/scripts/init-scrum.sh "<team name>" [parent-dir]
```

(Inside this repo: `skills/scrum-master/scripts/init-scrum.sh`.)
Idempotent; report created vs skipped. It creates the shared base
(`README.md`, `tools.md`) only when absent, then
`_project/scrum-master/` skeletons.

## Step 3 — the shared `_project/` namespace

Several skills live in `_project/`. The rules that keep the peace:

- **Whichever skill runs first creates the shared base.** Later
  skills find it and append. A skip is normal, not a conflict.
- **Each skill owns a subdirectory named after itself.** This skill
  owns `_project/scrum-master/` and writes nowhere else.
- **`project-manager` is the grandfathered exception** — it predates
  the convention and keeps flat files at the root (`context/`,
  `registers/`, `plan/`, `status/`, `state.md`). Treat all of those
  as its home.
- **Read other skills' files freely; never write them.** Not even a
  helpful fix. Hand the owner a draft instead.
- **One fact, one home.** Cross-reference by id (`IM-4 → R12`); never
  copy content between homes — copies drift, then lie.

What to read from a project-manager workspace instead of asking:

| Question | Read |
|----------|------|
| Who is on the team, capacity | `_project/context/team.md` |
| Methodology, sprint length | `_project/context/methodology.md` |
| Who cares about reports | `_project/context/stakeholders.md` |
| Known risks touching the team | `_project/registers/risks.md` |
| Project vocabulary | `_project/context/glossary.md` |

Two more reads before asking anything:

- **Date sweep.** Collect every dated commitment landing inside the
  upcoming sprint window — checkpoints, deliverable due dates, deploy
  freezes, contingency triggers — from `plan/` and `registers/`.
  Convert each into capacity, all the way: "freeze 09-01→09-03 = 3 of
  10 working days → plan sprint 4 at ≈ 70% of velocity." Days lost is
  half the sentence; the plan number is the whole one. Then check
  whether swept items gate each other — a vendor signature this week
  may still wait on the freeze lifting 09-03; ask the one question
  that resolves the chain.
- **Unconfirmed availability.** An approved hire with no start date,
  leave without dates — each is a capacity unknown to ask about,
  never a fact to assume.

Reflect what was found back to the user for confirmation — files can
be stale. Quote capacity unambiguously: per-sprint values with the
average ("32/35/34 → ~34 pts/sprint"), never a bare total. When two
artifacts conflict (a RACI with no PM seat; an actions file naming a
"PM"), quote both in the question — an evidenced question gets a real
answer. State inferences as guesses to confirm ("sprint 4, starting
today — right?"), not open-ended asks. Then ask only what's still
missing.

## Step 4 — minimal intake, one exchange

Ask for these, and say why each matters. Skip anything already known:

1. **Cadence** — sprint length, start day, event times, timezone.
   (Plays schedule themselves around this.)
2. **Definition of Done** — even a rough one. (Without it, "done" in
   every snapshot is negotiable.)
3. **Tracker & access** — what tool, and may this skill fetch from
   it? (Decides tools.md entry vs manual-export mode.)
4. **Product Owner** — who accepts stories, who writes the goal with
   the team.
5. **A human Scrum Master?** — if one exists, this skill works as
   their prep-and-memory copilot: same plays, same artifacts, but the
   human leads the ceremonies and owns the conversations. When the
   files conflict, ask with the evidence ("AC-6, AC-8 and the monthly
   deck are owned by 'PM', but the roster lists no PM seat — does
   that work stay with them or come to me?"). Day-one posture is "I
   don't want to double up or drop something" — claim the plays after
   the answer, not before.

Do not ask for working agreements on day one — they accumulate in
`context.md` as they are actually made.

## Step 5 — tools.md

`_project/tools.md` is the shared connection contract — every skill
reads it, any skill may append an entry. Probe the tracker once during
adopt: try the fetch, record exactly what worked. Ask for a
connection, never a secret — "connect the Jira integration and I'll
probe it", not an invitation to paste tokens into chat.

```markdown
## jira — issue tracker
- fetch: `jira sprint list --board 12` (or the MCP tool that worked)
- maps: sprint backlog ← board 12, active sprint;
  estimate ← field "Story Points"; sprint goal ← sprint name
- auth: PAT in env JIRA_TOKEN
- added by: scrum-master, verified 2026-08-31
```

Probe failed, or no access granted → record manual-export mode
honestly:

```markdown
## jira — issue tracker (manual)
- fetch: none — user pastes board export on request
- added by: scrum-master, 2026-08-31
```

Never leave the tool question implicit. "Fetch or ask — never invent"
only works when everyone knows which mode they're in.

## Step 6 — context.md and first play

Write `context.md`:

```markdown
# Team context — <name>
updated: 2026-08-31

## Team
See `_project/context/team.md` (project-manager) — confirmed 2026-08-31.
<or an inline roster table when no PM workspace exists>

## Cadence
2-week sprints, start Monday. Daily async 09:30 ICT. Retro last Friday.

## Definition of Done
- Code reviewed, merged, deployed to staging, AC verified by PO.

## Working agreements
| Date | Agreement | Origin |
```

Update `state.md`, then propose the first play based on where the team
is: mid-sprint → pulse; between sprints → plan-sprint; a pile of
history and pain → health-scan.

The first reply reports the writes: created, skipped, and — in a
shared workspace — deliberately untouched ("your project-manager
files are unmodified"). Build the list from what was actually written
this session, file by file — a real write missing from the list
breaks the same trust the list exists to build. Then the working contract in two lines: where
this skill writes, which existing registers stay authoritative, how
cross-references flow (`IM# → R#`). Trust in a shared home is built
by saying where your hands went. Keep day one tight: a non-blocking
question folds into a related one, or waits for session two.
