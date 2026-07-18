# Brainstorm Coach

**Language / Ngôn ngữ / 语言:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

A brainstorming partner for your AI agent — think of it as a facilitator sitting across the table from you, not a machine spitting out a list. It helps you generate real ideas for a name, a campaign, a feature, a career move, anything you're stuck on — and it makes sure the ideas stay *yours*, with the AI adding to them rather than replacing them.

## Why This Exists

Ask a typical AI to "brainstorm with me" and you'll get thirty ideas back in one breath. It feels generous, but it quietly turns you into a reader instead of a thinker — and the ideas tend to be generic, because the AI doesn't actually know your taste, your constraints, or the half-formed hunch you haven't said out loud yet.

This skill works the other way around: **you go first, every time.** Your idea gets written down exactly as you said it — never cleaned up or reworded, because rewording someone's idea is a quiet way of taking credit for it. Only after that does the AI add its own ideas, clearly marked as its own, building on what you said instead of steering the room. And while you're still generating ideas, nothing gets criticized or ranked yet — no "that probably won't work" — because even one comment like that teaches you to filter your own ideas before you say them, which is exactly what kills a good brainstorm.

## What You Can Ask It

**Wide open, no shape yet** — you just have a topic worth poking at.
> "Brainstorm with me — I need a name for the new product line."
> "Let's explore options for the Q3 campaign angle. Nothing's off the table yet."

**A narrow question** — you know the space, you need depth.
> "Give me ideas for cutting our onboarding time from 10 days to 3 — that's the only thing I care about."
> "I'm stuck on how to structure the pricing tiers. Help me think it through."

**Stuck and need a push** — you want a nudge, not a takeover.
> "I'm blocked on the feature list for v2. Give me a couple of starter ideas, then let's keep going together."

**A full session, start to finish** — broad first, narrowing down by the end.
> "Run me through a proper brainstorming session on retention — start wide and narrow it down."

**Want a few other viewpoints in the room** — not just yours and the AI's.
> "Give me different angles on these ideas — bring in a skeptic too."
> "Party mode — throw a customer, a competitor, and a devil's advocate at this."

It works the same in Vietnamese, English, or whatever language you bring:
> "Brainstorm cùng tôi về tên gọi cho tính năng mới này."
> "Cho tôi ý tưởng để giảm tỷ lệ rời bỏ khách hàng — tôi đang bí ý tưởng."
> "Cho tôi vài góc nhìn khác nhau về mấy ý tưởng này — kể cả góc phản biện."

You never need to name a specific method or explain how it works — "help me come up with…" or "I'm stuck on…" is enough to get started.

## What a Session Looks Like

**A quick check-in first.** What are we brainstorming, in one sentence? Any hard limits (budget, time, things already off the table)? Do you want to keep a written record of the session (yes, by default)? If the real problem is "something's broken and we don't know why," it'll say so before diving into ideas — throwing ideas at a problem you haven't diagnosed yet rarely helps.

**Picking a way in.** You can choose from a short menu of approaches, let the agent recommend one and say why, ask for something random to shake up a stale topic, or run a full sequence that starts broad and narrows down.

**Opening up ideas.** One question at a time — you answer first, the agent adds a few ideas of its own on top of yours, then hands the floor back. This keeps going with the same approach as long as it's producing good material, and switches once it stops.

**Narrowing down.** Once there are enough ideas on the table, everything gets a look together: similar ideas get grouped and named, nothing new gets added, and anything ranked comes with a reason you can actually push back on — never just a number pulled from thin air.

**Wrapping up.** The best ideas get sorted into what you could start this week, what's worth developing later, the big wild swings worth keeping around, and anything else the session revealed. You pick your own top 3 first — then the agent shares its picks — and you both land on a first small step for each.

## Party Mode

Sometimes one perspective isn't enough — you want to hear how a customer would react, what a skeptic would push back on, how a competitor might see it. Party mode invites a small panel of viewpoints into the session without burying you in AI output.

It's opt-in: just ask for it ("give me different angles on these ideas", "party mode"), or the agent offers it when ideas start feeling samey. Your ideas still come first — the panel only builds on what's already on the table — and it replies as one short digest with each viewpoint clearly labeled, not a flood of separate voices.

The devil's advocate plays by a rule: while you're still generating ideas, it turns pushback into a question instead of a verdict ("what if nobody paid with money at all?" instead of "that won't work") — a flat "that won't work" would just teach you to self-censor. Real critique gets its own moment later, in a structured pass where every objection comes with what would fix the idea, not just what's wrong with it.

## Example Session

> **You:** Brainstorm with me — we need ideas for our end-of-year customer event. Budget's tight, maybe $5k.
>
> **Agent:** Got it — $5k, end-of-year event. Quick check: are we open on the whole format, or is that already fixed and you need ideas within it? And want a written record as we go?
>
> **You:** Format's open. Yes to the record.
>
> **Agent:** Let's start broad and ask "what if the budget didn't exist at all — what would the event be?" — then we can bring it back down to earth once we have a direction.
>
> **You:** Honestly? A weekend retreat somewhere nice, flying in our top 20 customers.
>
> **Agent:** *(your idea)* A flown-in weekend retreat for the top 20 customers — noted.
> *(building on it)* A few ways to keep that spirit at $5k: a half-day local "retreat" at a nice venue instead of flights; a small in-person core group plus a mailed "retreat box" for everyone else; or a virtual weekend with a genuinely good production budget instead of travel.
>
> Want to riff on any of those, or keep exploring the wide-open version first?

## A Library of Ways to Brainstorm

`references/techniques.md` holds about 20 named approaches — familiar ones like SCAMPER, Six Thinking Hats, reversal, thinking by analogy, question storming, role playing, and "what if" — grouped by the kind of thinking they're good for. The agent picks from this library instead of freestyling, and explains why it's suggesting one.

## Works With the Rest of the Family

This skill is part of a small family of skills (github.com/tronghieu/agent-skills) that hand off to each other at the right moment. If the next skill isn't installed yet, the agent just mentions it, tells you it's installable from the same place, and keeps going with a lighter version in the meantime — it never leaves you stuck.

| When | It hands off to |
|---|---|
| The real issue is "something's broken and we don't know why" | **problem-solver** — figures out the cause before you brainstorm fixes |
| An idea needs to be grounded in what real customers actually think | **design-thinking** — real research instead of guesses |
| A top idea needs a market reality check | **market-researcher** — demand, competitors, market size |
| A top idea has grown into a company-level bet | **strategy-board** — a full strategic case |
| You've written up an idea as a proposal and want the reasoning checked | **critical-thinking** — an honest audit before it ships |

## Getting Started

Install it by pasting this into your terminal:

```bash
npx skills add tronghieu/agent-skills --skill brainstorm-coach
```

Then just tell your AI agent what you're stuck on:

```text
Brainstorm with me — I need ideas for the campaign angle. Nothing decided yet.
```

```text
Give me ideas for cutting our support response time in half. That's the only constraint.
```

```text
I'm stuck on the feature name. Help me think it through.
```

```text
Cho tôi ý tưởng để cải thiện trải nghiệm onboarding — tôi đang bí hướng đi.
```

You don't need to say "brainstorm coach" by name — "let's explore options for…" or "I'm stuck on…" is enough for it to pick up the thread.
