# Diagnosis: methods, labels, verification

This is the heart of the skill. Everything here serves one outcome: a
cause tree the user can *act on*, where every link is honestly labeled
and the leading candidate has survived — or is scheduled for — a real
test.

## Choosing the method

Match the method to the problem's shape, not to habit:

| Shape (what you observe) | Method | Why it fits |
|---|---|---|
| One clear symptom; the causes likely chain behind it | **Five Whys** | Drills a linear chain fast, with branching when it forks |
| Many plausible contributors, no obvious chain | **Fishbone** | Surveys the cause space by category before drilling |
| Recurs after fixes, oscillates, or fixes make it worse | **Causal loops** | Linear methods can't see feedback; loops can |
| A change effort that keeps stalling | **Force-field / constraints** (add-on) | The cause is the force balance, not an event |

One method usually suffices; two at most (fishbone to survey, then Five
Whys down the strongest bone, is the classic combination). Running
three frameworks on one problem is tourism, not thoroughness.

## The labeling convention

Every causal link in the tree carries a tag as it's written, never
retro-fitted:

- `[verified]` — the user confirmed it from direct knowledge, or data
  they checked says so. Note *how* it's verified in parentheses when
  it isn't obvious: `[verified — order log]`.
- `[assumed]` — everything else, including your hypotheses, the user's
  hunches, and things that merely sound obvious. Load-bearing
  `[assumed]` links also get an entry in `assumptions.md` (see
  `references/assumption-log.md`).

The tags are for the *reader of the tree next week* — someone deciding
what to check first should see the honest state of knowledge at a
glance. A tree that's all `[assumed]` is fine early on; a tree that's
all `[verified]` after one conversation is a sign you're rubber-stamping
plausibility, since real verification usually takes real-world time.

## Five Whys

Drill from symptom toward structure by asking why, one why at a time —
the user answers, you structure. Never fire five whys as a batch; each
answer decides the next question.

- **Branch when answers fork.** "Why are custom cakes late?" may
  honestly split into "prep takes longer than the slot allows" *and*
  "prep starts late". Follow both branches; forcing one chain on a
  forked reality loses half the diagnosis.
- **Five is a guideline, not a quota.** Stop when the answer is
  something the user can *change*, and continue past five when you're
  still in symptoms.
- **Process, not person.** A chain that ends at "because I forgot" or
  "because John made a mistake" stopped one why early. Ask why the
  forgetting *mattered* — "why does one missed alarm cascade into three
  late orders?" The person is rarely the fixable cause; the process
  that gave their slip that blast radius is.
- **The stop test.** Before accepting a root cause, ask: *"if we fixed
  this, would the problem stop recurring?"* If not obviously yes, it's
  a contributing cause, not the root — keep going or branch.

**Worked example** (bakery, drilling the boundary pattern from
Is/Is-Not — "late orders are the >30-min-prep ones"):

```
1 in 4 orders arrives late [verified — order log]
└─ why? prep finishes after the courier pickup slot [assumed]
   └─ why? weekend batches exceed solo prep capacity [assumed]
      ├─ why? custom-cake orders doubled since June [verified — user checked, June menu post went viral]
      └─ why? prep slots are booked as if each cake takes 30 min,
         but customs average ~50 [assumed → A2 in log]
```

Note what the labels do: the tree is honest that the middle of the
chain is still hypothesis, and it points at exactly one measurement
(actual prep time per custom cake) that would firm up the whole chain.

## Fishbone (Ishikawa)

Use when contributors are many and a single chain would be premature.
Spine = the problem statement; bones = cause categories; the session
brainstorms candidate causes onto each bone — the user supplies
candidates first (they know their world), you add candidates they
missed, all tagged like everything else.

- **Categories fit the domain.** Manufacturing's 6M (Machine, Method,
  Material, Manpower, Measurement, Environment) and services' 6P
  (People, Process, Policy, Place, Procedures, Product) are starting
  points, not law. For the bakery: Orders, Prep, Packaging, Handoff,
  Courier, Customer-communication beats either canned set. Three to
  six categories; more dilutes.
- **Rate the bones, then drill.** After the survey pass, mark each
  candidate: evidence for it (`[verified]`/`[assumed]`), and rough
  impact if true. Then take the 1–2 strongest bones into a Five Whys
  drill rather than "investigating everything" — the fishbone's job is
  aim, not answer.
- **Cross-bone patterns matter.** The same underlying cause showing up
  on three bones (capacity strain appearing in Prep, Handoff, and
  Communication) is a strong root-cause signal.
- **Borrow stakeholder lenses to widen the survey.** Before closing the
  candidate list, ask the user two or three perspective questions —
  "what would a customer say goes wrong?", "what would the courier
  point at first?" The lenses generate *questions for the user*, never
  AI-roleplayed answers: the user owns the facts; a lens only aims
  their attention at a bone they haven't looked down.

## Causal loops & system archetypes

Reach for these when the problem's history says *feedback*: it returns
after every fix, it oscillates seasonally without a seasonal cause, or
each fix seems to make the next episode worse. Linear methods find a
chain and stop; loops explain why the chain keeps re-arming.

Map variables and influence arrows with the user, then look for loops:
**reinforcing** (growth or decay compounding) and **balancing**
(something resisting change toward a hidden limit). Three archetypes
cover most real cases:

- **Fixes that fail** — the quick fix relieves the symptom and quietly
  feeds the cause. Bakery: apologizing with discount codes for late
  orders → discounts drive more orders → more overload → more lateness.
- **Shifting the burden** — the symptomatic fix erodes the capability
  for the real fix. Working until 2am to catch up prevents ever
  redesigning the prep schedule that causes the overload.
- **Limits to growth** — a growth engine hits a balancing constraint;
  pushing the engine harder does nothing. More Instagram marketing
  can't outrun a solo-prep capacity ceiling — the leverage is the
  constraint, not the engine.

The output is still a cause tree entry: the loop, stated in one or two
sentences, with its links labeled — not a diagram for its own sake. If
drawing helps the user, a small text sketch (`A → B → C → back to A`)
is plenty; the family convention spends the drama budget on substance,
not visuals.

## Add-on: force-field and constraint analysis

Optional lenses, mainly for organizational-change problems:

- **Force-field** — list driving forces (pushing the change forward)
  vs restraining forces (holding it back), with strength estimates from
  the user. The counter-intuitive move it exists to teach: *weakening a
  restraining force usually beats strengthening a driving force*, which
  just raises tension.
- **Constraint identification** — Theory-of-Constraints style: find the
  bottleneck that caps the whole system's throughput. Its verification
  test is built in: *if you relieve the constraint and throughput
  doesn't move, it wasn't the constraint.*

## Rival hypotheses

Diagnosis inherits medicine's differential rule: never walk into
verification with only one candidate. A single-suspect cause tree is
usually anchoring wearing a lab coat — the first plausible explanation
(often the user's opening hunch) quietly absorbs all attention, and
every check ends up designed to confirm it.

- **Keep at least two rivals alive** until evidence separates them. If
  the tree has grown only one branch, ask "what else would produce
  exactly this Is/Is-Not pattern?" before testing anything.
- **Prefer the separating test.** An observation that supports one
  rival *and* weakens the other is worth more than two confirmations.
  Bakery: "late only on custom cakes" separates prep-capacity from
  courier-degradation in a single look at the order log.
- **Rivals die by evidence, not by vote.** When one wins, the loser
  stays in the assumption log at its new low confidence — cheap
  insurance for the day a pivot trigger fires and the diagnosis
  re-opens.

## Verification tests

Every root-cause candidate leaves Diagnose with a test attached:

1. **Prediction** — "if this is the cause, we would expect to see ___."
2. **Cheapest disproof** — the least effort observation that could show
   the prediction false. Cheap matters: a test the user won't actually
   run protects nothing.

Track them in `diagnosis.md` as a small table:

| Candidate | If true, we'd see… | Cheapest check | Result |
|---|---|---|---|
| Prep-slot mis-estimate (A2) | customs averaging well over 30 min | time the next 5 custom preps | ⏳ pending |
| Courier degradation (A1) | transit times up vs. spring | compare 10 old vs 10 recent handoff→delivery stamps | ✗ transit unchanged — **weakened** |

A failed prediction is a *result*, recorded and celebrated — the
courier hypothesis dying cheaply is the discipline doing its job (its
log entry drops accordingly; see the assumption log). When a test needs
real-world time, this is where the session pauses: set the check as
homework, note the pause point in the workspace, and resume at re-entry.

**The gate, restated:** Solve waits until the leading candidate is
verified, or the user explicitly proceeds at-risk — in which case the
solution work carries the unverified assumption's tag so nobody
mistakes the foundation for stone.
