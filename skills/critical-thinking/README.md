# Critical Thinking

**Language / Ngôn ngữ / 语言:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

An argument auditor and thinking coach in one: hand it any memo, proposal, or analysis and it tells you exactly which sentences don't hold up — and makes sure using it leaves you sharper, not more dependent on it.

## Why This Exists

Every memo, pitch deck, and investment case that lands on your desk is written to sound certain. Confidence is cheap; a document can be wrong and polished at the same time, and you rarely have the hours it would take to reverse-engineer its logic before you approve the budget, sign the contract, or take it upstairs yourself. Most of the time you're deciding on vibes and trust in whoever wrote it — which is fine, until it isn't.

The obvious fix — "ask an AI if this is any good" — has a quiet cost. Two independent studies (a 2025 Microsoft/CHI study of knowledge workers, and a separate 2025 study by Gerlich) found the same pattern: the more people lean on an AI to do their thinking for them, the weaker their own unassisted judgment gets over time. A tool that just hands you a verdict trains you to stop forming your own. This skill is built to give you the audit without paying that price — it asks for your own read before it shows you its own, so every session is a rep for your judgment, not a replacement for it.

## What You Can Ask It

**Quick audit** — a document just landed and you need a read in minutes, not an hour.
> "A vendor sent this proposal an hour before our budget meeting — give me the top three problems before I walk in."
> "Is this partnership pitch worth a follow-up call, or full of holes?"

**Deep audit** — the decision is big enough to deserve real scrutiny.
> "The board votes on this $2M expansion plan next week. Give it a full audit before I bring it to them."
> "Our team spent three weeks on this market-entry case. Before I sign off, tell me what's actually solid and what's wishful thinking."

**Review your own draft** — before you send something to a tough audience, have it fortify the argument instead of just praising it.
> "I'm sending this to our CFO tomorrow and she'll push back hard. Where does she attack first?"
> "Review my proposal before the exec team sees it — and check whether I've actually defined when we'd walk away from this."

**Progress review** — check how your own judgment is trending over time.
> "How has my thinking been developing over the last couple months? What do I keep missing?"

It works the same way in Vietnamese, English, Spanish, Chinese, Japanese, French, or whatever language you bring it — no need to translate anything first.

## What a Session Looks Like

You drop in a memo — say, a regional expansion proposal — and mention what's riding on it: you have to recommend yes or no to your boss by Friday.

Before it says anything about the document, it asks you two quick questions: does the core argument hold up, roughly how confident are you, and what's the weakest point as you see it? You can answer in a sentence or two, or just say "skip it, I'm short on time" — either is fine, and skipping is tracked honestly rather than quietly ignored.

Then the audit arrives, verdict first: what holds, what doesn't, and exactly which sentences the problems live in. If you answered the questions, it shows you what you caught on your own and what you missed — no grading, no "good job," just the honest gap between your read and its read. That gap is where you actually get better at this.

Over weeks, it keeps a private file — think of it as your own thinking gym — that quietly tracks the kinds of things you tend to miss (unstated assumptions? cherry-picked data?) and whether your stated confidence tends to match how things actually turn out. Ask "how's my thinking trending" any time and it reads that file back to you straight, including "the data's too thin to say yet" if that's the honest answer.

## Example Session

> **You:** Here's a five-page proposal from a vendor pushing for exclusive distribution rights in exchange for waived setup fees. I need to decide by Thursday.
>
> **Agent:** Before I dig in — what's your own read? Does the case hold up, roughly how confident are you, and what feels like the weakest part to you? Fine to skip if you're pressed for time.
>
> **You:** I'd say about 70% confident it's solid. The weakest part is probably the exclusivity clause — feels like a lot to give up just for a fee waiver.
>
> **Agent:** Got it, noted. Here's the audit — verdict first: the fee-waiver math checks out, but two claims elsewhere don't hold up, and there's one assumption baked in that nobody's stated out loud.
>
> *(the full audit follows — each finding tied to the exact sentence it's about)*
>
> **Agent:** You caught the exclusivity clause — the audit flags it as the single biggest risk too. What you didn't catch: the vendor's "20% faster fulfillment" claim has no data behind it anywhere in the proposal, and the whole case quietly assumes your current supplier can't match these terms — nobody actually checked that.

## What Makes It Trustworthy

**Every finding points to an exact quote.** No "the logic here is weak" without showing you the sentence it's talking about. If it can't point at the words, it isn't a finding — it doesn't get to appear in the report.

**It admits what it can't judge.** Some claims need domain data or expertise the auditor doesn't have — a specific industry benchmark, a technical spec it can't verify. Instead of guessing and dressing the guess up as analysis, it says plainly: this one needs a real check, here's where to get it.

**It separates "wrong" from "I disagree."** A conclusion can be argued well and still be one you'd personally push back on — those are different problems, and the audit labels them differently instead of dressing an opinion up as a logic flaw.

**When you're reviewing your own draft, it fortifies rather than demolishes.** It leads with what's structurally solid, sketches the fix for each hole instead of just naming it, and checks whether your plan has real decision points — clear go/no-go criteria, conditions under which you'd stop — because that's often the cheapest thing missing from an otherwise strong proposal.

In blind head-to-head testing across four realistic scenarios — auditing an expansion memo seeded with flaws (contradictory payback numbers, a cherry-picked pilot result, a hedge that quietly turned into a stated fact), reviewing a CEO's own board draft, and two judgment-discipline tests — an AI using this skill met 25 of 26 quality criteria. The same AI without the skill met 12 of 26, and its most consistent failure was the one that matters most: it handed over its full analysis immediately, every time, instead of letting the reader think first.

## Getting Started

Install it once:

```bash
npx skills add tronghieu/agent-skills --skill critical-thinking
```

Then just hand your AI agent a document and say what's riding on it:

```text
Audit this vendor proposal before our 2pm meeting — top issues only.
```

```text
Give this expansion memo a full audit. The board votes on it next week.
```

```text
Review my draft before I send it to the exec team — where does it fall apart?
```

```text
Phản biện giúp tôi bản đề xuất này — tôi cần trình bày trong chiều nay.
```

You never have to say "use critical thinking" or explain the process — dropping in a document and asking whether to trust it is enough.
