# Product Manager Skill

**Language / Ngôn ngữ / 语言:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

This skill turns your AI agent into a disciplined **product management copilot** — the kind of PM who won't hand you a RICE table full of invented reach numbers, or a PRD quoting a customer who never said that, just to look thorough.

## What Is the Product Manager Skill?

Ask a generic chatbot to "prioritize our backlog" and it will produce a confident-looking RICE table in seconds — reach, impact, effort, all filled in, ranked to two decimal places. None of it is real. It's a plausible guess wearing the costume of analysis, and once it's in a slide deck nobody can tell the difference from a table backed by actual analytics. This skill is built so that failure can't hide: every number in a prioritization, every metric in an OKR, every claim in a PRD carries a label you can click through to where it came from — a source, a stated assumption with a range, or your own estimate on the record. If the number doesn't exist yet, the skill asks for it or registers an honest assumption. It never fills the cell just to keep the table looking tidy.

It's also not a one-shot document generator. Product management doesn't end when a PRD ships — there's a backlog to keep grooming, OKRs to check in on, feedback piling up, a launch to watch and maybe roll back. This skill runs as a **copilot for a living product**: one workspace, initialized once, that you return to across weeks and months. It remembers what was decided and why, so every session starts with "here's where we left off" instead of you re-explaining the product from scratch.

You stay the product manager. You own the product, you talk to the users, you make every call on what ships. The skill's job is to draft well, push back when your ask contradicts your own evidence, run the numbers honestly, and keep the books so nothing gets silently forgotten or re-litigated.

## Why Use It?

- **Every number declares where it came from.** Reach, impact, effort, a baseline, a conversion rate — each one is tagged `[S#]` (a real source), `A#` (a registered assumption with an honest range), or `(user estimate, <date>)`. An unlabelled number is treated as a bug, not a shortcut.
- **Rankings get stress-tested, not just computed.** Any prioritization leaning on assumptions gets run at the low and high end of each range, so you see which conclusions are rock-solid, which flip depending on a guess, and which are genuinely too close to call — before you bet a quarter on it.
- **Every feature traces to a reason, or admits it doesn't.** A PRD or a backlog item either points to real evidence of a user problem, or is flagged plainly as a bet. Nothing gets a retroactive justification bolted on to look evidence-based.
- **A second pass checks the work before you see it.** PRDs, prioritizations, and launch plans each get an adversarial audit — checking for naked numbers, untested acceptance criteria, missing rollback thresholds — before you're asked to act on them. Findings show up in the artifact, not quietly patched away.
- **The workspace remembers, so you don't have to.** A running decision log is the product's institutional memory: what was decided, why, what was rejected and why, and the trigger that would make you revisit it. Come back in three months and the skill reads it before saying a word.

## Five Things This Skill Never Compromises On

1. **No invented numbers.** Every quantitative input is a real source, a labelled assumption with a range, or your own dated estimate — never a plausible guess dressed up to fill a cell.
2. **Sensitivity before precision.** A ranking built on assumptions gets tested across their honest range before it's presented as a conclusion — a confident two-decimal score on a guessed number is precision theater.
3. **Outcome over output.** Every opportunity and every PRD traces to a real user problem and names the metric it should move. Work that doesn't trace to anything is still allowed — bets exist — but it's visibly a bet, never quietly rebranded.
4. **The workspace is the source of truth, not memory.** The skill reads the decision log and current state before doing anything, every time, and reflects it back to you. A correction propagates everywhere it's repeated, not just the one file you happened to be looking at.
5. **Nothing ships without a second look.** A PRD, a prioritization, and a launch plan each pass an independent audit before you're asked to act — and whatever it finds is shown to you, not silently cleaned up.

The question every artifact has to survive: **"where did this number actually come from — and if it's wrong, does the decision change?"**

## The Team of Lenses

Each hat has a name now, but you never have to summon anyone — it's still one PM switching hats as the work demands, not a roster you pick from. The names are Vietnamese; Bao, for one, honors Bao Công, the incorruptible judge of Vietnamese folklore — exactly the energy the audit lens brings.

| Lens | Concern | You'd meet it when... |
|------|---------|------------------------|
| **Sao** (Compass) | Direction — vision, positioning, big structural bets | You ask "should this be its own product or a feature?" or need help with pricing |
| **Minh** (Scope) | Definition — turning a problem into a spec | You ask for a PRD, a story map, or user stories |
| **Lam** (Scale) | Ordering — what to build next, and why | You ask to prioritize the backlog |
| **Kim** (Gauge) | Measurement — what "good" looks like | You ask to define a north-star metric or set OKRs |
| **Mai** (Lab) | Learning — testing a risky belief before betting on it | You ask to design an A/B test or validate an assumption |
| **Phong** (Ramp) | Shipping — getting a feature out safely | You ask to plan a launch, with rollback criteria |
| **Thanh** (Echo) | Listening — turning raw feedback into signal | You dump a pile of support tickets or reviews to sort through |
| **Bao** (Judge) | Audit — the skeptical second look | Automatically, before a PRD, prioritization, or launch plan is handed to you |

Judge runs as an independent pass whenever the agent can spin up a separate subagent — a self-review of your own homework isn't worth much, so it deliberately doesn't grade itself. Everything else happens as one PM working through the conversation with you, in the room.

## What You Can Ask For

There's no fixed order and no "phase 1 of 5" — you walk in through whatever the moment calls for, and the skill routes to the right lens:

- **"Prioritize our backlog"** — Scale lens: RICE scoring (or Kano, for classifying what kind of expectation a feature is) with every input labelled and a sensitivity read on the ranking.
- **"Write me a PRD for X"** — Scope lens: problem statement tied to evidence, a story map, testable user stories, an explicit Won't-have list.
- **"Triage this pile of customer feedback"** — Echo lens: raw feedback sorted into the backlog as real opportunities, not just tallied.
- **"Plan our OKRs for the quarter"** / **"What should our north-star metric be?"** — Gauge lens: a metrics tree with a labelled baseline, not a metric picked because it sounds good.
- **"Design an A/B test for..."** — Lab lens: a test card with a pass/fail bar set *before* the test runs, not interpreted afterward to fit the result you wanted.
- **"Plan the launch of..."** — Ramp lens: a rollout plan scaled to the actual risk, with numeric rollback thresholds fixed in advance.
- **"Should this be a platform or a feature?"** / **"How should we price this?"** — Compass lens: the structural calls that shape everything downstream.

A one-off ask gets served well without ceremony — you don't have to set up a whole workspace just to get one clean answer — but the numbers still stay labelled even in a quick pass. The skill also works in any language you bring to it; it stops at well-formed user stories and hands the rest to engineering.

## The Workspace It Produces

```text
<product-dir>/
  product.md              # vision, positioning, users, constraints — the core truth
  state.md                 # what's open, what's waiting on you
  decisions.md              # append-only decision log — the reason you can walk away and come back
  discovery/
    sources.md             # [S#] every source, real evidence only
    insights.md             # [I#] user insights, your own or imported from design-thinking
    feedback-log.md         # FB# raw feedback, triaged over time
  strategy/
    metrics.md               # north-star metric + the metrics tree + guardrails
    okrs-<period>.md          # one file per OKR period
  backlog/
    opportunities.md         # OP# problems worth solving, framed as job stories
    assumptions.md            # A# registered assumptions — statement, basis, honest range, status
    prioritization-<date>.md  # dated RICE/Kano passes, never overwritten — this is your priority history
  specs/                    # prd-<feature>.md — PRD, story map, stories
  experiments/               # exp-<slug>.md — test cards and what was learned
  launches/                  # launch-<release>.md — the plan, rollback criteria, post-launch review
```

**Coming back is easy.** Walk back into an existing product directory and say "status" — the skill reads `decisions.md` and `state.md` first and tells you where things stand before doing anything else: "Last time we shipped the Q3 prioritization; the offline-mode PRD is drafted and waiting on your engineering estimate; two experiments are running." It trusts the files over its own memory, and it won't quietly redo or overwrite work you've already finished.

## Works With the Companion Skills

Product management touches user research and market facts constantly, but it isn't built to *do* either from scratch — three companion skills cover that ground, each optional and only ever suggested once:

- **[design-thinking](../design-thinking/)** — for deep user discovery: interviews, field research, prototype testing, validating a hypothesis job story properly instead of guessing at it. This skill consumes its insights (`[I#]` blocks import straight into `discovery/insights.md`, numbering continuing on) — it never runs the fieldwork itself. Install: `npx skills add tronghieu/agent-skills --skill design-thinking` — info: https://github.com/tronghieu/agent-skills#design-thinking
- **[market-researcher](../market-researcher/)** — for external market facts beyond a quick search: pricing benchmarks, competitor context, market sizing for a reach assumption. It writes straight into this workspace's `discovery/`, continuing the `[S#]` numbering, so your artifacts cite its sources directly. Install: `npx skills add tronghieu/agent-skills --skill market-researcher` — info: https://github.com/tronghieu/agent-skills#market-researcher
- **[strategy-board](../strategy-board/)** — for decisions above product altitude: entering a new market, build-vs-buy, killing a product line — company-level bets a PM playbook shouldn't decide alone. Its recommendation comes back as input to your `strategy/` files and a logged decision. Install: `npx skills add tronghieu/agent-skills --skill strategy-board` — info: https://github.com/tronghieu/agent-skills#strategy-board

If a companion isn't installed, the skill mentions it once and, if you'd rather not add it, proceeds on its own with light desk research or clearly-labelled hypotheses instead. Never a requirement, always your call.

## How to Trigger

Ask your AI agent tasks like:

```text
Prioritize these 6 features for next quarter using RICE.
```

```text
Write me a PRD for offline mode — here's what we know about the problem.
```

```text
Here's three months of support tickets and app-store reviews — triage this into our backlog.
```

```text
Should this be its own product or a feature of what we already have?
```

```text
Hãy giúp tôi ưu tiên backlog quý này và viết PRD cho tính năng được chọn.
```

```text
今四半期のOKRを一緒に決めたいです。ノーススターメトリクスから考えましょう。
```

The skill also triggers on `status` inside an existing product workspace, and on any product question in general — you never have to say "act as a product manager" for it to kick in.

## Installation

### 1. Using CLI (Recommended)

```bash
npx skills add tronghieu/agent-skills --skill product-manager
```

### 2. Manual Installation (For Non-Technical Users)

1. **Download:** Go to the `skills/` folder in this repository and download `product-manager.zip`.
2. **Extract & Copy:** Extract `product-manager.zip` and copy the `product-manager` folder into one of the following directories:

**For a Specific Project:**
Copy the `product-manager` folder to `.agents/skills/` or `.claude/skills/` in your project's root directory.

**Globally (Available for all projects):**
* **Mac / Linux:** `~/.agents/skills/` or `~/.claude/skills/`
* **Windows:** `%USERPROFILE%\.agents\skills\` or `%USERPROFILE%\.claude\skills\` (usually `C:\Users\<YourUsername>`)

## Example Usage

> **You:** Prioritize these 6 features with RICE — sign-in with Google, offline mode, dark mode, CSV export, team roles, and in-app chat.
>
> **Agent:** I can run this now — but I don't have reach, impact, or effort figures for any of these yet, so I'd be scoring on guesses unless you can give me a few. Quick check: do you have analytics on how many users each of these would touch, and has engineering sized any of them?
>
> **You:** No effort estimates yet, and I only have real usage data for CSV export and team roles.
>
> **Agent:** Got it — I'll score all six now: CSV export and team roles get real reach figures `[S2]` `[S3]`, the other four get registered assumptions with honest ranges (`A1`–`A6` in `backlog/assumptions.md`), and effort is a labelled assumption with a range for all six until your dev team weighs in.
>
> *(builds the RICE table, runs the sensitivity pass across each assumption's range, logs the assumptions and the provisional ranking)*
>
> **Agent:** Provisional ranking: **offline mode and sign-in with Google are robust** — they come out on top across every honest range I tried. **CSV export and dark mode swap places at #3/#4** depending on how much effort each actually takes, so that pair is genuinely undecided until you get me real estimates. I've logged this as a provisional decision in `decisions.md` with a revisit trigger — as soon as engineering sizes effort, I'll firm up the ranking instead of leaving it on guesses.
