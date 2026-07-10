# Market Sizing: TAM / SAM / SOM

Every number in a sizing must either carry a source ID like `[S3]` (registered in
`sources.md` with URL, publisher, date accessed, and confidence high/medium/low) or
be an explicit derived estimate showing its formula and cited inputs. A sizing
without traceable inputs is a guess wearing a suit — the reader cannot check it,
update it, or trust it.

## Contents

- [When to size and at what depth](#when-to-size-and-at-what-depth)
- [Define the market before you size it](#define-the-market-before-you-size-it)
- [TAM: three methods](#tam-three-methods)
- [SAM: constrain the TAM](#sam-constrain-the-tam)
- [SOM: scenarios tied to named assumptions](#som-scenarios-tied-to-named-assumptions)
- [Triangulation discipline](#triangulation-discipline)
- [Growth dynamics](#growth-dynamics)
- [Common failure modes](#common-failure-modes)

## When to size and at what depth

Match effort to the decision the number will inform.

- **Quick Scan**: one method (usually bottom-up, since its inputs are checkable)
  plus a sanity check against any published top-down figure. Report a wide range,
  not a point estimate — "TAM roughly $2–5B" from one method is honest;
  "$3.4B" from one method is false precision. Use when the user needs an
  order-of-magnitude answer: is this a $100M market or a $10B market?
- **Deep Dive**: at least two independent methods, triangulated (see
  [Triangulation discipline](#triangulation-discipline)). Independent means the
  methods do not share their dominant input — top-down from an industry report and
  bottom-up from government business counts are independent; two top-down figures
  that both trace to the same Grand View Research report are not.

In both modes, prefer ranges over points. Convey the range's source: is it the
spread between methods, uncertainty in one input, or a scenario band?

## Define the market before you size it

Write the market definition down before touching any number, because every source
you find will have sized a slightly different market and you need a reference to
compare against. Specify:

- **Product/service category** — what's in, what's out (e.g., "cloud HR software
  for SMBs" excludes on-prem suites and payroll-only tools).
- **Customer** — who pays, B2B or B2C, which segments.
- **Geography** — global, regional, single country.
- **Value chain position** — are you sizing end-customer spend, vendor revenue,
  or platform GMV? These differ by multiples.
- **Year and currency** — every figure gets a year; convert currencies explicitly
  and cite the exchange rate as an input.

## TAM: three methods

### Top-down: industry report × relevant share

Steps:

1. Search for the market's published size: `"<category>" market size <year>`,
   `"<category>" market report TAM`. Look for analyst firms (Gartner, Forrester,
   IDC, Statista), market-report publishers (Grand View, MarketsandMarkets,
   Mordor — treat as medium/low confidence, their methodology is opaque), trade
   associations, and public company filings or investor decks that quote a market
   size (they usually cite the analyst source — follow it to the original).
2. Register each figure in `sources.md` with its market definition, year, and
   confidence. Two "HR software market" figures can differ 3x purely on scope.
3. If the report covers a broader market, cut it down with a cited or assumed
   share — and name that assumption, because it is usually the weakest link.

Worked example:

> Global cloud HR software market: $28B in 2025 [S2]. SMB segment ≈ 35% of
> spend [S5]. TAM ≈ $28B [S2] × 35% [S5] = **$9.8B**.

Top-down is fast but inherits every flaw of the report: unknown methodology,
possibly stale base year, possibly inflated by a publisher selling optimism.
Never let it be the only method in a Deep Dive.

### Bottom-up: unit count × price

Steps:

1. Find the number of potential buying units from primary statistical sources:
   government business censuses (US Census SUSB/CBP, Eurostat, national statistics
   offices), regulator registries, trade association member counts, platform
   counts (e.g., app store listings, LinkedIn company counts — medium confidence).
2. Establish price per unit per year (ACV, ARPU, average ticket × frequency):
   competitor public pricing pages, public company revenue ÷ customer count from
   filings, industry benchmark surveys. If no source exists, state it as a named
   assumption with your reasoning.
3. Multiply, showing the formula.

Worked example:

> US businesses with 10–99 employees: 2.1M [S4]. Assumed ACV $1,200/yr, anchored
> on competitor X's published mid-tier pricing [S7] (assumption A2).
> TAM ≈ 2.1M businesses [S4] × $1,200 ACV (assumption A2) = **$2.5B**.

Bottom-up is the most defensible method because each input is independently
checkable — prefer it as the anchor in both modes.

### Value theory: value created × capture rate

For new categories with no published market and no clear buyer count analog.

1. Quantify the value the product creates per customer (hours saved × loaded wage
   [cite wage source], revenue lift, cost avoided).
2. Apply a capture rate — the fraction of created value a vendor can charge for.
   10–30% is a common heuristic; state it as a named assumption, since no source
   will hand it to you.
3. Multiply by the addressable unit count (sourced as in bottom-up).

Worked example:

> Value created: 5 hrs/week saved × $35/hr loaded cost [S9] × 48 weeks ≈
> $8,400/yr per user. Capture rate 15% (assumption A4) → price potential
> ≈ $1,260/user/yr. TAM ≈ 800K target users [S6] × $1,260 (derived from S9, A4)
> = **$1.0B**.

Value theory carries the widest error bars — treat its output as a plausibility
bound, not a headline number.

## SAM: constrain the TAM

SAM is TAM cut down by what the business can actually serve. Apply constraints
one at a time, each cited or named as an assumption, so the reader sees exactly
where the shrinkage comes from:

- **Geography** — markets you will actually operate in. Cite the regional share
  (e.g., "US = 42% of global spend [S2]").
- **Segment** — the customer slices your product fits (company size, vertical,
  use case).
- **Channel** — customers reachable through your go-to-market motion (e.g.,
  self-serve excludes buyers who only purchase through procurement/RFP).
- **Regulation** — licensing, data-residency, or compliance regimes that lock
  out territories or verticals until satisfied.
- **Technical requirements** — prerequisites the customer must already have
  (e.g., must run Shopify, must have an EHR system).

Present as a chain: `SAM ≈ TAM $9.8B × 42% US [S2] × 60% target verticals
(assumption A3) = $2.5B`. A SAM that is 90%+ of TAM usually means a constraint
was skipped — question it.

## SOM: scenarios tied to named assumptions

SOM is what the entrant can plausibly capture in a defined horizon (state the
horizon, e.g., year 3). Never present one number; present three scenarios, each
tied to explicit, named assumptions that the reader can dispute individually:

| Scenario | Year-3 share of SAM | Key assumptions |
|---|---|---|
| Conservative | 0.5% | Slow sales ramp (A6), 2 funded incumbents respond (A7) |
| Realistic | 1.5% | Ramp per comparable company X's S-1 trajectory [S11] |
| Optimistic | 4% | Category tailwind persists [S3], channel partnership lands (A8) |

Benchmarks for calibration: new entrants in established markets rarely exceed
1–3% share within 3 years; even eventual category leaders typically took 5+
years to pass 10%. Anchor share assumptions on comparable-company trajectories
from S-1s, annual reports, or credible press-reported ARR milestones — and cite
them. An unanchored "we'll take 5%" is the same error as "1% of China."

## Triangulation discipline

In Deep Dive, compare the outputs of your independent methods.

- **Agreement within ~2x**: report the range spanned by the methods and say which
  end you find more credible and why (usually the bottom-up, whose inputs are
  checkable).
- **Disagreement beyond ~2x**: never silently average — an average of two numbers
  measuring different things is a third number measuring nothing. Report the
  conflict openly and diagnose it. The usual culprits:
  - **Different market definitions** — one figure includes services revenue or
    adjacent categories the other excludes. Re-read each source's scope statement.
  - **Different years** — a 2021 figure vs. a 2025 figure in a market growing
    25%/yr is a 2.4x gap by itself.
  - **Currency or unit mismatch** — nominal vs. constant dollars, local currency
    converted at different rates, revenue vs. spend vs. GMV.
  - **Bad input** — often the top-down report itself; check whether other sources
    corroborate it.
- If diagnosis explains the gap, adjust one estimate to the other's definition and
  re-compare. If it doesn't, present both with the discrepancy flagged and lower
  the confidence rating on the final range.

## Growth dynamics

- **CAGR**: source it, don't assert it. Analyst reports publish CAGRs [cite];
  where two reports disagree, present the range ("12–18% CAGR 2025–2030
  [S2][S8]"). Alternatively derive it from two sourced year-values and show the
  formula. Note the projection window — a CAGR is meaningless without its start
  and end years.
- **Drivers and inhibitors**: list 2–4 of each, each backed by a citation (a
  regulatory change [S10], an adoption statistic [S12]), not vibes. Drivers
  explain why the CAGR could hold; inhibitors explain why it might not.
- **Presenting ranges**: project forward with low/high growth bands rather than
  one curve ("$2.5B today [derived above] → $4.0–5.5B by 2030 at 10–17% CAGR
  [S2][S8]"). Say which scenario each band assumes.

## Common failure modes

- **Citing a number without its market definition.** "$28B market [S2]" is
  unusable until you state what S2 counted — category scope, geography, year,
  revenue vs. spend. Record the definition in `sources.md` alongside the figure.
- **Mixing revenue, spend, and GMV.** A marketplace's GMV can be 10x the revenue
  of the vendors selling into it. Pick one measure for the whole sizing and
  label every source's figure with which measure it is.
- **Stale data presented as current.** A 2021 figure quoted in 2026 without a
  year label silently misstates a growing market by half. Attach a year to every
  number; roll old figures forward only with a cited growth rate, showing the
  formula.
- **Top-down-only "1% of China" reasoning.** "The market is $50B, we only need
  1%" asserts nothing about how the 1% is obtained. Any share claim must trace to
  a bottom-up path: customers reachable × win rate × price, with cited or named
  inputs.
- **Point estimates from single sources.** One report, one number, no range — the
  reader can't tell confidence from theater. Minimum bar even in Quick Scan: a
  range plus a sanity check.
- **Assumption laundering.** A derived number quoted later without its
  `(assumption A2)` tag hardens into fake fact within the same report. Carry the
  tags through every downstream use.
