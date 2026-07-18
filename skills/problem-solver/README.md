# Problem Solver

**Language / Ngôn ngữ / 语言:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

A diagnosis partner for your AI agent — before it helps you fix anything, it helps you find out what's actually broken and why. Think of it as the discipline that sits between "something's wrong" and "here's what to do about it": it turns a vague complaint into a precise, confirmed problem statement, traces the real cause instead of the first plausible story, and only then hands you off to solving it.

## Why This Exists

Ask a typical AI "why did sales drop?" and it will hand you a confident-sounding explanation in one breath — plausible, structured, and often completely made up, because the AI has no access to your data, your team, or your customers. A tidy cause chain built from invented facts is worse than an honest "I don't know yet," because it sends you off to fix the wrong thing with full confidence.

This skill works the other way around: **facts come from you, hypotheses get labeled, and nothing gets called a cause until something in the real world confirms it.** Every causal claim in the session carries `[verified]` or `[assumed]` next to it, every load-bearing assumption gets logged with a way to check it cheaply, and at least two rival explanations stay alive until evidence — not a vote, not a hunch — picks a winner. If you ask for solutions before the cause is known, it says so and gives you the choice, instead of quietly skipping the hard part.

## What You Can Ask It

**Something's broken and you don't know why** — the core case.
> "Sales dropped 15% last month and we don't know why."
> "Orders keep arriving late. I've tried a few things, nothing's stuck."

**Something keeps recurring, or fixes keep failing.**
> "This bug keeps coming back no matter how many times we patch it."
> "Every time we fix onboarding drop-off, something else breaks."

**You want a structured root-cause session.**
> "Run a five whys on this outage."
> "Do a post-mortem with me — production went down for 2 hours yesterday."

**You asked for solutions, but the cause isn't known yet.**
> "Give me ideas to fix falling sales." *(the skill will point out this is a diagnosis wearing a brainstorm costume, and let you choose)*

It works the same in Vietnamese, English, or whatever language you bring:
> "Sao đơn hàng cứ bị trễ hoài mà không biết vì sao?"
> "Tìm giúp tôi nguyên nhân gốc của việc doanh số giảm."

You don't need to name a method — "we don't know why X keeps happening" is enough to start.

## What a Session Looks Like

**Frame.** One compact intake, not a form: what's happening in observable terms, when it started, who's affected and what it's costing, what's already been tried, and what "fixed" would look like. If your opening message already hands over a sharp clue — a boundary plus a coincident change — it proposes a cheap check for that clue in the very first reply, instead of saving it for later. Then it reads the refined problem statement back to you, stripped of any hidden guess-at-a-cause or jump-to-a-solution, and waits for your confirmation before going further.

**Bound.** An Is/Is-Not pass: where the problem shows up vs. where it doesn't, when vs. when not, who vs. who not. The sharpest clues live in what's different between the two columns.

**Diagnose.** It picks the method that fits the problem's shape — Five Whys for one symptom with a likely chain behind it, fishbone when there are many plausible contributors, causal loops when the problem keeps coming back or fixes make it worse — and builds the cause tree with you, one question at a time, tagging every link `[verified]` or `[assumed]` as it lands. At least two rival candidates stay on the table until a test separates them. Nothing moves to solutions until the leading cause is verified, or you explicitly choose to proceed at-risk.

**Solve.** Once the cause is confirmed, it generates solutions aimed at *that* cause — handing off to brainstorm-coach for real divergent ideation if it's installed. Every solution names the root cause it addresses; anything that doesn't gets labeled a symptom patch, not a fix.

**Decide.** You set the criteria (effectiveness, cost, time, risk — yours may differ). Every score cites evidence or is honestly labeled "unknown — assumption." One recommendation, with what would change it.

**Plan.** A rollout (pilot by default when confidence isn't high), owners for the first steps, success metrics tied back to what "fixed" meant in Frame, and pivot triggers — a clear rule for when a plan that isn't working means the diagnosis was wrong, not just that execution needs more effort.

## The Evidence Discipline

This is the part that makes the skill trustworthy rather than just articulate. Three rules run through every phase:

- Nothing gets stated as a fact about your world unless you said it or showed it. A missing fact becomes a question or an `[assumed]` label — never a filled-in guess.
- Every root-cause candidate carries a test: "if this is the cause, we'd expect to see ___" plus the cheapest way to check it's wrong. A cause nothing could disprove ("it's a communication problem") isn't a diagnosis yet.
- Confidence going *down* counts as progress. An assumption checked and ruled out just saved you from building a fix on sand — and the skill treats that as a win, out loud, not a setback.

## Example Session

> **You:** Orders keep arriving late, maybe 1 in 4. Started around early June. We've tried reminding staff to hurry, didn't help.
>
> **Agent:** Quick clarifying one before I lock in the statement — does the lateness cluster on any particular kind of order, or is it spread evenly? And has anything else changed since early June — menu, staffing, courier?
>
> **You:** Now that you mention it, it's mostly the custom cake orders. And yeah, we had a menu post go viral right around then.
>
> **Agent:** That's useful — here's the statement I'd confirm: *"Since early June, roughly 1 in 4 orders arrives late, concentrated in custom-cake orders; a menu post went viral the same week."* Sound right? If so, one cheap check before we go further: if rising custom-cake volume is outrunning prep capacity, average prep time per custom cake should be creeping toward or past the delivery slot — worth timing the next few?
>
> **You:** Yeah that's right. I'll time the next 5.
>
> **Agent:** *(logs the plan, marks "prep-capacity vs. custom-cake volume" as the leading `[assumed]` candidate with a pending test, keeps "courier degradation" alive as a rival, and pauses here until you're back with the timings.)*

## Methods, Matched to the Problem's Shape

`references/diagnosis.md` holds the method library — Five Whys, fishbone, causal loops and system archetypes, plus force-field and constraint add-ons for change efforts that stall — each with when it fits and a worked example. The agent picks based on how your problem actually looks (one symptom vs. many contributors vs. a problem that fights back), never by habit or to look thorough.

## Works With the Rest of the Family

This skill is part of a small family of skills (github.com/tronghieu/agent-skills) that hand off to each other at the right moment. If the next skill isn't installed yet, the agent just names it, tells you it's installable from the same place, and keeps going with a lighter version in the meantime.

| When | It hands off to |
|---|---|
| The cause is verified and you need real divergent ideation on it | **brainstorm-coach** |
| The "problem" is really about who your users are and what they need | **design-thinking** |
| The diagnosis or decision write-up needs its reasoning audited | **critical-thinking** |
| The fix has grown into a company-level strategic bet | **strategy-board** |
| A cause or solution hinges on market facts you don't have | **market-researcher** |
| The plan is becoming a real multi-week project to track | **project-manager** |

## Getting Started

Install it by pasting this into your terminal:

```bash
npx skills add tronghieu/agent-skills --skill problem-solver
```

Then just tell your AI agent what's broken:

```text
Sales dropped 15% last month and we don't know why.
```

```text
This keeps happening no matter what we try — help me find the actual cause.
```

```text
Run a post-mortem with me on yesterday's outage.
```

```text
Sao đơn hàng cứ bị trễ hoài mà không biết vì sao?
```

You don't need to say "problem solver" by name — "we don't know why X keeps happening" is enough for it to pick up the thread.
