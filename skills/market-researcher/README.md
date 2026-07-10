# Market Researcher Skill

**Language / Ngôn ngữ / 语言:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

This skill turns your AI agent into a disciplined **desk market-research analyst** — the kind whose every number you can click through to a source, from a five-minute go/no-go scan to a full multi-session market deep dive.

## What Is the Market Researcher Skill?

Ask a generic chatbot to size a market and you get a confident number with no way to check it — a fabricated $4.2B TAM looks exactly like a real one. This skill exists to make that failure detectable: it takes a raw question like "is there a market for X?", "how big is the market for Y in Brazil?", or "should we launch this in Indonesia?" and returns a report in which **every factual claim traces to a registered source**. It works for any market, any country, any language — a $50M niche in Kenya gets the same discipline as a $50B category in the US.

The skill runs **desk research only**: web sources, public data, documents you provide. It is honest about that limit — what it learns about customers are demand *signals* and *hypotheses*, never validated insight (see non-negotiable 5 below). When you need real customer validation, this skill hands off open questions to primary research instead of pretending to answer them.

## Why Use It?

- **No number without a source.** Every figure carries a source tag `[S#]` resolving to a row in `sources.md`, is an explicit derived estimate showing its formula and cited inputs, or is labelled `(assumption A#)`. An untagged factual sentence is treated as a bug.
- **Facts from the web, not from memory.** Market sizes, prices, competitor moves, regulations — researched fresh, every time. Training data is stale and, worse, statistically plausible; if web access is unavailable, the skill says so and stops rather than degrading into an uncited essay.
- **Triangulated, never silently averaged.** When two credible sources or methods disagree by more than roughly 2x, the report surfaces the conflict and diagnoses it (different market definitions, years, currencies, revenue vs. GMV) instead of blending it away.
- **Verified before it ships.** A skeptic pass re-checks the report's most decision-relevant claims against their sources, recomputes every derived estimate, and flags stale or single-source data — before you ever see the report.
- **Desk research yields signals, not validated insight.** Personas and customer needs produced here are hypotheses for primary research to test, always labelled as such, always closing with open questions for real interviews or tests.

## The Five Non-Negotiables

1. **Every claim is traceable** — a source tag `[S#]`, a derived estimate with its formula shown, or an explicit `(assumption)`.
2. **Current facts come from the web, not from memory** — stale training data doesn't get to pose as research.
3. **Triangulate; never silently average** — disagreements between sources are reported and diagnosed, not smoothed over.
4. **A verification pass runs before delivery** — a skeptic re-checks the load-bearing claims and the arithmetic.
5. **Desk research yields signals, not validated customer insight** — personas and needs are hypotheses, always labelled, always handed to primary research to confirm.

## Two Modes

| | **Quick Scan** (default) | **Deep Dive** (opt-in) |
|---|---|---|
| Question | "Is this worth a closer look?" | "What exactly are we walking into?" |
| Duration | One session | Multi-session, resumable |
| Sizing | One method + sanity check, wide honest ranges | ≥2 methods, triangulated |
| Competitors | 5–10 identified, one-line profiles | Top 3–5 profiled in depth |
| Customers | Headline demand signals | Full signal mining + hypothesis personas |
| Macro | 2–3 kill-factors / tailwinds only | Structured PESTEL + trends |
| Output | Go/no-go brief (~4–8 pages) | Modular report |

The agent defaults to Quick Scan and says so up front. Quick Scan runs on a hard working budget of **~15 registered sources per lane** — enough to bound the answer, not to settle it. Deep Dive is modular: you pick the lanes that matter (sizing, competitors, demand, macro) instead of running all four ritualistically, and it's resumable across sessions — say `status` in a new session and the agent reads `state.md` and picks up exactly where things stopped.

## The Four Research Lanes

| Lane | What it produces |
|---|---|
| **Market & sizing** | TAM/SAM/SOM via bottom-up and/or top-down methods, triangulated ranges tied to named assumptions |
| **Competitor analysis** | Direct, indirect, substitute, and status-quo competitors, tiered and profiled, positioning read |
| **Demand signals** | Jobs-to-be-Done, pain-point mining, willingness-to-pay signals, honestly-labelled hypothesis personas |
| **Trends & macro (PESTEL)** | What in the environment helps or kills this specific opportunity — never a geography lesson |

Each lane can run as a parallel subagent with its own source budget, its own findings file, and a reserved block of `[S#]` ids so parallel work never collides.

## Composition Contract: Callable by Other Skills

Market Researcher is built to be used as a research engine by other skills and workflows — a strategy board building its fact base, a design-thinking workspace validating a problem space, or any product-brief process that needs external market facts. The contract is simple:

- **Input:** the caller supplies the research question and decision context, a market definition (or asks this skill to draft one), a mode and lanes, and a target directory inside its own workspace.
- **Output:** this skill writes into that directory — appending to an existing `sources.md` and **continuing its `[S#]` numbering, never renumbering** what's already there — plus `findings-*.md` and `report.md`, all following the same citation schema so the caller can cite `[S#]` directly without knowing how the research was done.
- **Boundary:** this skill answers market questions from desk research. It says so explicitly, rather than stretching, when the ask is non-market research or needs real primary research with customers.

## The Workspace It Produces

```text
research/market/<topic-slug>/
  sources.md          # the source registry: ID, URL, publisher, dates, confidence
  findings-sizing.md         # one findings file per lane run
  findings-competitors.md
  findings-demand.md
  findings-macro.md
  report.md            # the deliverable: verdict, driving facts, caveats, open questions
  state.md              # mode, lanes done, verification status — for resuming later
```

`scripts/init-research.sh` scaffolds this workspace (idempotent — it never overwrites files that already exist, so it's safe to re-run against a caller's workspace that already has a `sources.md`).

## How to Trigger

Ask your AI agent tasks like:

```text
Is there a market for a subscription meal-kit service for solo diners in Germany?
```

```text
How big is the TAM for B2B expense-management software in Southeast Asia?
```

```text
Who are the competitors of a mid-market accounting SaaS in Canada, and where's the open space?
```

```text
Nghiên cứu thị trường xe điện hai bánh tại Việt Nam — có đáng để làm không?
```

```text
市場調査をお願いします。日本の高齢者向け配食サービス市場は参入する価値がありますか？
```

The skill triggers on requests to research, size, validate, or enter a market, in any language and for any country — no need to say the words "market research."

## Installation

### 1. Using CLI (Recommended)

```bash
npx skills add tronghieu/agent-skills --skill market-researcher
```

### 2. Manual Installation (For Non-Technical Users)

1. **Download:** Go to the `skills/` folder in this repository and download `market-researcher.zip`.
2. **Extract & Copy:** Extract `market-researcher.zip` and copy the `market-researcher` folder into one of the following directories:

**For a Specific Project:**
Copy the `market-researcher` folder to `.agents/skills/` or `.claude/skills/` in your project's root directory.

**Globally (Available for all projects):**
* **Mac / Linux:** `~/.agents/skills/` or `~/.claude/skills/`
* **Windows:** `%USERPROFILE%\.agents\skills\` or `%USERPROFILE%\.claude\skills\` (usually `C:\Users\<YourUsername>`)

## Example Usage

> **You:** We're thinking about launching a B2B invoicing SaaS in Mexico. Is the market worth going after?
>
> **Agent:** I'll run a Quick Scan first — a wide, honest read in one session; we can deep-dive into any lane that looks decisive. Quick clarifying question: are you targeting SMBs, mid-market, or both, and is this Mexico-only or a LatAm beachhead?
>
> *(confirms the frame, initializes the workspace, runs sizing / competitors / demand / macro lanes — each reading fresh web sources, tagging every claim, registering sources with `[S#]` ids)*
>
> **Agent:** Verdict: **go, with medium confidence.** The formal-SMB segment in Mexico is sizeable and underserved by local players [S4][S11], but the strongest willingness-to-pay evidence comes from businesses that already use *some* invoicing software [S9] — much thinner signal on the informal-sector majority you'd need to convert. Biggest caveat from verification: two of the three market-size figures trace back to the same vendor report series [S3][S7], so treat the upper end of the range with caution. Full report, sources, and open questions for primary research are in `research/market/mx-invoicing-saas/report.md`.
