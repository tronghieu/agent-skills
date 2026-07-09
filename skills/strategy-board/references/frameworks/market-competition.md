# Market & Competition — Porter's Working File

Tools for judging an industry and locating a position in it. Every output
follows its rigid format so results stay comparable across engagements. Every
figure carries `[S#]` from `fact-base.md` or `(assumption)`.

## Five Forces

**When:** entering a market, judging industry attractiveness, explaining why
margins are what they are.

**How:** define the industry boundary first (product scope × geography ×
customer set — most bad analyses die here). Then assess each force with
evidence, rate Low/Medium/High, and note the *trend*, which matters more than
the level.

Key drivers per force — rivalry: competitor count/balance, growth rate, fixed
costs, differentiation, exit barriers. New entrants: scale economies, brand,
capital, switching costs, distribution access, regulation, expected
retaliation. Supplier power: concentration, substitutes for the input,
forward-integration threat. Buyer power: concentration, differentiation,
switching costs, backward-integration threat, price transparency. Substitutes:
price-performance trajectory, switching cost, buyer propensity.

**Output format:**

```
## Five Forces: [industry, boundary stated]

| Force | Rating | Trend | Key driver | Evidence |
|-------|--------|-------|-----------|----------|
| Rivalry | L/M/H | ↑/→/↓ | … | … [S#] |
| New entrants | | | | |
| Supplier power | | | | |
| Buyer power | | | | |
| Substitutes | | | | |

### Industry attractiveness: [Low/Medium/High] — [one sentence why]
### So what
[2–4 sentences: what this means for THIS decision]
```

**Tips:** regulation can act as a sixth force — note it when it shapes entry
or pricing. Quantify where possible (CAGR, concentration/HHI, margin
benchmarks). Local and global force profiles differ — match the boundary to
the decision.

## Market map & segmentation

**When:** "where do we play" questions; before any sizing.

**How:** define the market from the customer's alternatives outward (what
would they use instead?), not from the client's product. Segment by needs or
job-to-be-done first; demographics only when they proxy needs. For each
segment: size (with Graham), growth, needs, current solutions, and fit with
the client's strengths.

**Output format:** table — `Segment | Size [S#] | Growth | Dominant need |
Today's solution | Our fit (1–5) | Notes`, followed by a So-what naming the
1–2 segments that matter and why.

## Arena screen (choosing among markets)

**When:** the question is "which of these markets / segments / geographies
do we enter or prioritize?" — several candidate arenas, one comparison. Runs
after a market map (and usually a light Five Forces per finalist), never
instead of them. The GE–McKinsey nine-box spirit, compressed.

**How:** score every candidate on the same two axes, plus the color:

- **Attractiveness** — structural, from the arena itself: the Five Forces
  read, size and growth `[S#]`, margin benchmarks. Not "do we like it".
- **Ability to win** — from us: fit from the market map (1–5), the 2–3
  capabilities the arena demands vs Grove's honest ratings, and the response
  the incumbents can afford (from the competitor profiles).
- **Palette color** (`frameworks/strategy-palette.md`) — the game the arena
  forces. An attractive market that demands a Shaping game we cannot
  orchestrate, or an Adaptive game our planning culture cannot run, is a
  legitimate rejection: attractive, but the wrong game for us.

Score attractiveness from evidence per arena — not one column researched and
the rest eyeballed. Where two arenas tie, the tiebreakers are reversibility
and what each teaches: a cheap test of a bigger thesis outranks a slightly
better standalone.

**Output format:**

```
| Arena | Attractiveness (L/M/H — why [S#]) | Ability to win (L/M/H — why) | Palette color | Verdict |
```

then a So-what naming the 1–2 arenas to carry into Phase 3 as options. The
screen ranks; it does not decide — the entry decision still gets the full
options treatment with Graham's numbers.

**Tips:** this is a funnel stage, not a beauty contest — six arenas in, one
or two out, and every rejected arena keeps one honest line in the record
(Minto's rule on rejected options applies here too). High-attractiveness /
low-ability arenas are acquisition or partner candidates, not automatic
"no"s — route them through the build-buy-partner comparison before
discarding.

## Value chain analysis

**When:** "where does the margin actually sit" questions — pricing, vertical
integration, build-vs-buy (is this activity core or commodity?), cost
programs.

**How:** map the chain from raw input to end customer, including stages the
client doesn't own. For each stage: who performs it, roughly what share of
the end price it captures `[S#]`, and how concentrated the players are. Then
locate the client: which stages they occupy, where their cost or
differentiation advantage lives, and which stages upstream/downstream have
the power to squeeze them. The strategic read: margin migrates toward the
scarce stage — is the client's stage getting scarcer or more commoditized?

**Output format:** table — `Stage | Who performs it | ~% of end-price value
[S#] | Concentration | Our position`, then a So-what: the stage where value
is accruing, the squeeze threats, and what that means for the decision
(integrate, exit, or defend the stage).

## Competitor profiles

**When:** any decision a competitor can spoil.

**How:** profile only the 3–5 players that can actually affect the outcome
(including one non-obvious entrant or substitute-maker). For each: strategy
in one sentence, economics (revenue/share/margin as available), strengths,
vulnerabilities, and — the part most analyses skip — *likely response to our
move*, judged from their incentives and past behaviour.

**Output format:**

```
### [Competitor] — [strategy in one sentence]
- Economics: … [S#]
- Wins because: …
- Vulnerable at: …
- If we do X, they likely: … (confidence: L/M/H)
```

Close with a positioning read: the dimensions customers pay for, where each
player sits, and where the defensible open ground is (if any — "none" is a
legitimate and important answer).

**Tips:** past behaviour beats stated intentions. An incumbent's response is
constrained by what protecting their margin allows them to do — that
asymmetry is often the entrant's whole case.
