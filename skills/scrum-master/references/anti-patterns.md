# Anti-patterns — the catalog, and how to scan for them

Process rot is gradual, so the people inside can't see it. The
workspace can. This reference powers two plays: **health-scan** (read
the history, name what it shows) and **coach** (have the conversation
about one pattern well).

## Running a health-scan

1. Read everything: all close snapshots, `retros.md`, `impediments.md`,
   recent pulse logs, `context.md` agreements.
2. Compute the trends the catalog needs: velocity, carry-over %,
   added-mid-sprint, goal streak, `PI#` completion rate, impediment
   ages.
3. Walk the catalog. **A pattern is reported only with two or more
   cited instances** — sprint numbers, `PI#` ids, dated lines. One
   occurrence is an event; two is a candidate; three is a pattern.
   No evidence, no claim.
4. Write `health-<date>.md` — dated, kept, never overwritten:

```markdown
# Health scan — 2026-08-31

Headline: <one sentence — the single most expensive pattern>

## Patterns found
### <name>
- Evidence: S09 carry-over 38% (snapshot), S10 41%, S11 35%
- Cost: <what it is doing to the team, concretely>
- Smallest fix: <one experiment, one sprint>
- The conversation: <2–3 sentence script the user can say>

## Watch list
<candidates with only one instance — named, not diagnosed>

## What's healthy
<name it, with sources — a mirror that only shows damage gets ignored>
```

5. In the reply: headline, the top pattern with its evidence, and the
   one conversation to have first. Not the whole scan.

## The catalog

Each entry: the workspace **signal**, the **cost**, and **the
conversation** — because the coach play's output is a conversation,
not a rule.

### Goal-less sprints
- Signal: sprint files with no goal, or goals like "do the tickets";
  ★ marks missing.
- Cost: nothing to say no with — every interruption is equally valid;
  review has nothing to demo against.
- Conversation: "What would make sprint N a success in one sentence,
  to someone outside the team? Let's plan backward from that."

### Carry-over normalization
- Signal: carry-over ≥ ~30% in 3+ consecutive snapshots, and planning
  keeps committing the same amount.
- Cost: commitment stops meaning anything; forecasts inherit the lie.
- Conversation: "We plan 34 and land 21, three sprints running. Plan
  21 and finish — or find what's eating the 13?"

### Silent scope morph
- Signal: delivered stories that never appeared in a committed table;
  empty `SC#` sections beside diverging numbers; added-mid-sprint
  high in every snapshot.
- Cost: the team absorbs work invisibly; planning learns nothing.
- Conversation: "Mid-sprint asks are real — let's make them cost
  something visible. One in, one out, written down."

### Retro theater
- Signal: `PI#` completion under ~50% across 3 retros; the same theme
  in 3 retro records; audits that keep finding "untouched".
- Cost: the team learns retro promises are decorative; honest input
  dries up.
- Conversation: "One improvement next retro, not three — and it gets
  sprint capacity like a story. Deal?"

### Status-theater daily
- Signal: pulse logs are per-person status lists; zero `IM#` ever
  born from a daily while carry-over stays high.
- Cost: fifteen minutes daily spent reporting up instead of unblocking
  sideways; blockers surface at review.
- Conversation: "Walk the board, not the room — what's stuck and
  what's in the way, per ★ story, not per person?"

### Velocity worship
- Signal: velocity climbing while goal streak worsens; estimates
  inflating (same-shaped stories growing points across sprints).
- Cost: the number improves, the product doesn't; estimates become
  negotiation chips.
- Conversation: "Velocity is our thermometer, not our grade. Which ★
  outcomes shipped?"

### Hero pattern
- Signal: one name owns most ★ stories across snapshots; impediments
  cluster around one person's availability.
- Cost: bus factor of one; the hero burns out; others stop growing.
- Conversation: "A-line work goes through Minh every sprint. Pairing
  on the next one — cheaper than the week we lose when Minh is out?"

### Zombie backlog
- Signal: planning after planning flags the same readiness failures —
  no estimates, no AC, giant stories pulled anyway.
- Cost: planning becomes estimation-under-pressure; sprints start
  half-blind.
- Conversation: "An hour of refinement mid-sprint buys back the first
  two days of the next one. Try it for one sprint?"

### Impediment rot
- Signal: median open `IM#` age above sprint length; items nudged 3+
  times without state change; `owner: NONE` lines surviving sweeps.
- Cost: the team routes around blocks permanently; escalation muscles
  atrophy.
- Conversation: "IM-4 is older than the sprint. Escalate it today, or
  decide out loud that we accept it and stop paying attention tax."

### Watermelon reporting
- Signal: a report or status claim says on-track while the same-day
  snapshot shows ★ stories not started, or numbers with no source.
- Cost: the one pattern that kills trust in everything else.
- Conversation: "Say 'at risk' while it's cheap. The report that
  survives an audit is the one worth sending."

## Coaching with the catalog

- **One pattern at a time.** Change capacity is smaller than analysis
  capacity. Name the most expensive one; park the rest on the watch
  list.
- **Smallest experiment, one sprint, revisit date** — written into
  `context.md` agreements or a `PI#`, so the next scan can check it.
- **Coach, don't police.** The catalog names team habits, not
  villains. The conversation scripts offer a change; the team's "no"
  is a legitimate answer — record it and re-raise when the cost has
  data behind it.
