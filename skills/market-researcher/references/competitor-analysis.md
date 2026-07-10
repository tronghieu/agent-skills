# Competitor Analysis

Reference for the market-researcher skill. Use this when the research question involves who else serves the target customer, how they compete, and where open space might exist.

Citation discipline applies to everything in this file: every factual claim about a competitor gets a source ID like [S3] registered in `sources.md` (URL, publisher, date accessed, confidence). Anything you conclude yourself gets labeled `(inference)` or `(assumption)`. A competitor profile with uncited claims is worse than no profile — it looks authoritative while being unverifiable.

## Contents

1. [Competitive scope](#1-competitive-scope)
2. [Identification tactics](#2-identification-tactics)
3. [Quick Scan protocol](#3-quick-scan-protocol)
4. [Deep Dive profiling](#4-deep-dive-profiling)
5. [Positioning analysis](#5-positioning-analysis)
6. [Ethics and honesty rules](#6-ethics-and-honesty-rules)
7. [Monitoring hooks](#7-monitoring-hooks)

Two modes, matching the skill's overall modes:

- **Quick Scan** — identify 5–10 competitors; one-line profiles plus a positioning read (sections 1–3). Use when the user needs orientation fast or as the first pass of a Deep Dive.
- **Deep Dive** — everything in Quick Scan, then profile the top 3–5 deeply and map positioning (sections 4–5). Use when the user is making a real decision (build, enter, price, position) that a competitor can spoil.

Sections 6–7 (ethics, monitoring) apply to both modes.

## 1. Competitive scope

Classify every competitor you find into one of four tiers. The tier determines how you analyze them, so classify before profiling.

- **Direct** — same product category, same target customer, same job. Customers compare them side by side in a buying decision.
- **Indirect** — different product category, same job. A spreadsheet template competes with a budgeting app; a freelancer marketplace competes with a staffing agency.
- **Substitute** — a different way to make the problem go away entirely. Hiring an assistant substitutes for scheduling software; moving closer to work substitutes for a commuter service.
- **Status quo ("do nothing")** — the customer keeps their current workaround: the manual process, the shared Google Sheet, the intern who does it by hand, or simply tolerating the pain.

Always include the status-quo competitor explicitly in the analysis. It is usually the most dangerous and the most forgotten, for a concrete reason: in most markets the largest "share" belongs to nobody — most potential customers buy nothing. The status quo charges no money, requires no procurement approval, no migration, no learning curve, and no risk of blame if it fails. A product does not just need to beat the named competitors; it needs to beat inertia, and inertia wins by default. When you analyze it, treat it like a real competitor: what does "doing nothing" cost the customer (cite evidence of that cost where you can find it), and what does switching away from it cost them?

Also flag **potential entrants** when the evidence supports it — an adjacent player whose job postings or product announcements point at this market [S#] — but keep this labeled `(inference)` unless they have publicly signaled entry.

## 2. Identification tactics

Do not rely on the user's initial competitor list or your own memory; both are biased toward well-known names and stale by months or years. Verify and expand through live web research. Each tactic below finds competitors the others miss.

- **"Alternatives to X" queries.** Search `alternatives to [known competitor]`, `[known competitor] vs`, `[known competitor] competitors`. Comparison content is written to capture buyers who are actively shopping, so it maps the consideration set customers actually see. Register the comparison page itself as a source.
- **Review-site categories.** Browse the relevant category on G2, Capterra, TrustRadius, Software Advice (B2B software) or Trustpilot (consumer). Category pages list players ranked by review volume — a rough traction signal in itself. Note the category name; it tells you how the market self-defines.
- **App store searches.** For anything with a mobile surface, search the App Store and Google Play with the customer's words (the job, not the product name). Rankings, ratings counts, and "last updated" dates are all citable signals.
- **Funding databases.** Crunchbase, Dealroom, PitchBook (public pages), and TechCrunch/press coverage of raises. A funded startup in the category is a competitor even with no revenue yet — money signals investor belief in the same opportunity, and the funding announcement usually states the wedge.
- **Local-language searches for regional markets.** If the market is Vietnam, search in Vietnamese (e.g., "phần mềm quản lý kho" rather than "warehouse management software"); likewise Thai for Thailand, Indonesian for Indonesia. English-only search systematically misses the local incumbents customers actually use — often the strongest competitors in-market. Check local app stores, local review/forum sites, and local tech press too.
- **Ask the demand side.** Search Reddit, Hacker News, industry forums, and Facebook groups (dominant in Southeast Asia) for "what do you use for [job]". This surfaces the status quo and the duct-tape substitutes no directory lists.

Stop expanding when new searches keep returning names you already have. Record which tactics you used, so a reader knows what the search covered — and what it might have missed.

## 3. Quick Scan protocol

Use in Quick Scan mode, or as the first pass of a Deep Dive. Goal: a defensible map of the field in one pass, not deep truth about any one player.

Identify **5–10 competitors** spanning the scope tiers — do not fill all ten slots with direct competitors while ignoring substitutes and the status quo. For each, capture four facts, **each individually cited**:

| Field | What to capture | Typical source |
|---|---|---|
| What it is | One line, in plain words — the job it does, not its slogan | Homepage, app store listing [S#] |
| Target segment | Who it is clearly built for (SMB/enterprise, vertical, geography) | Pricing page, case studies, review demographics [S#] |
| Pricing signal | Cheapest paid tier, model (per-seat/usage/flat), or "pricing not public" | Pricing page [S#] |
| Traction signal | Review count, app downloads bracket, funding raised, claimed customer count | G2/app store/press [S#] |

Rules:

- One line per fact. If you cannot state it in one line, you do not understand it yet — that is fine at this stage; mark it "unclear" rather than padding.
- "Pricing not public" and "no traction data found" are valid, useful entries. Never guess a number to fill a cell.
- Distinguish claimed from observed: "claims 10,000 customers [S4]" is not the same as "has 10,000 customers".

Example row (format, not real data):

| Competitor | Tier | What it is | Segment | Pricing signal | Traction signal |
|---|---|---|---|---|---|
| Acme Sched | Direct | Shift scheduling for restaurants [S3] | SMB F&B, US [S3] | From $2.50/user/mo [S4] | 1,200 G2 reviews, 4.4★ [S5] |
| Shared Google Sheet | Status quo | Manager builds rota by hand | Everyone not yet buying | Free | Default in forum threads [S9] |

Close the Quick Scan with a **positioning read** of 3–5 sentences: how the field clusters (e.g., "two enterprise suites, five SMB point tools, one open-source option"), which tier looks crowded, and what you did *not* find. Label the read as `(inference)` — it is your synthesis, not a sourced fact.

## 4. Deep Dive profiling

Use in Deep Dive mode. Profile the **top 3–5** competitors — the ones that can actually affect the user's decision, including at least one non-obvious pick (a substitute or a probable entrant) if the evidence supports its relevance. Depth on three real threats beats shallow notes on ten names.

For each competitor, cover:

**Company facts.** Founded year, HQ, funding history and investors, headcount signal. LinkedIn employee count and its trend are citable [S#]; job postings reveal even more — a company hiring five ML engineers or its first enterprise AE is telling you its roadmap and go-to-market plans months before any announcement. Cite specific postings.

**Product and features.** Build a feature comparison matrix across the profiled competitors (rows = capabilities that matter to the target buyer, columns = competitors, cells = yes/no/partial with [S#] from docs, changelogs, or reviews). Choose rows by what buyers care about — from review complaints and comparison pages — not by what is easy to check. A matrix of trivial checkboxes is busywork.

**Pricing and packaging.** Tiers, price points, billing model, what is gated behind which tier, free tier/trial. Packaging reveals strategy: what a company gates at the enterprise tier is who it thinks pays the most; what it gives away free is where it fears a cheaper rival. Archive pricing pages (they change silently — note the access date, and consider the Wayback Machine for history).

**Go-to-market motion.** Self-serve, sales-led, channel/partner, or product-led? Infer from observable evidence: "book a demo" buttons vs. instant signup, sales job postings, partner directories, ad presence, content strategy. Label the conclusion `(inference)` and cite the evidence behind it.

**Review mining.** Read actual reviews on G2/Capterra/app stores — not just star averages. Extract what users consistently praise and consistently complain about, and cite specific review sources ("recurring complaints about migration difficulty in G2 reviews from 2025 [S12]"). Weight recent reviews over old ones; products change. Complaints about the category leader are a direct map of unmet demand — this is often the single highest-value output of the whole exercise.

**Strengths and weaknesses.** Close each profile with 2–3 of each, every one traceable to cited evidence above — no free-floating adjectives like "strong brand" without a fact behind them. Where the evidence supports it, add a one-line read on how this competitor would likely respond to the user's move, judged from their incentives and past behavior `(inference)`.

Profile skeleton:

```markdown
### [Competitor] — [their strategy in one sentence] (inference)

**Company:** founded [year] [S#] · [funding, investors] [S#] · ~[N] employees,
[trend] [S#] · hiring signals: [notable postings] [S#]

**Product:** [2–3 lines on what it does and for whom] [S#]
(feature detail lives in the shared comparison matrix)

**Pricing:** [tiers, price points, model, what's gated where] [S#]
(page archived [date])

**GTM motion:** [self-serve / sales-led / PLG / channel] (inference) —
evidence: [demo-only signup [S#], AE job posts [S#], partner page [S#]]

**Users praise:** [pattern] [S#] · [pattern] [S#]
**Users complain:** [pattern] [S#] · [pattern] [S#]

**Strengths:** 1. [claim — evidence [S#]] 2. …
**Weaknesses:** 1. [claim — evidence [S#]] 2. …
**If the user does X, they likely:** [response] (inference, confidence L/M/H)
```

## 5. Positioning analysis

After profiling, map the field.

**Choose two axes that matter to buyers.** Not generic price-vs-quality — that map almost always shows the same diagonal and teaches nothing. Derive axes from the evidence you already gathered: what do reviews complain about, what do comparison pages fight over, what trade-off does the buyer actually face? Good axes are real trade-offs: depth-of-integration vs. time-to-value, all-in-one vs. best-of-breed, compliance-grade vs. move-fast. State *why* you chose these axes, citing the buyer evidence.

**Map the players.** Place each profiled competitor on the two axes, justifying each placement with the cited facts from its profile — do not place by vibe. Include the status quo on the map; it usually sits at "free, zero switching cost, low capability", which is exactly why it is hard to beat.

Present the map as a simple table rather than ASCII art — it cites better:

| Competitor | Axis 1: [name] (low→high) | Axis 2: [name] (low→high) | Placement evidence |
|---|---|---|---|
| [A] | High | Low | [S#], [S#] |
| Status quo | Low | Low | free, zero setup |

**Find open space — then attack your own finding.** An empty quadrant is a hypothesis, not an opportunity. State the falsifiable claim behind any gap explicitly: "no player offers [X] for [segment Y], AND segment Y wants X badly enough to pay for it." The first half you can verify from your map; the second half needs its own evidence. Every gap must survive the question: **"or is there simply no demand there?"** Empty quadrants are frequently empty because companies tried, died, and left no visible trace — or because the position is structurally unprofitable. Look for demand evidence (complaints asking for exactly that combination [S#], failed predecessors, workarounds people build) and report what you find either way. "The lower-right quadrant is empty, and I found no evidence anyone wants it" is a legitimate and valuable conclusion. So is "no defensible open space exists."

## 6. Ethics and honesty rules

- **Public information only.** Websites, app stores, reviews, filings, press, job posts, archived pages. Never suggest pretexting (posing as a customer to extract non-public info), scraping behind logins, or using leaked material. Beyond the ethics, conclusions built on information the user cannot legitimately re-verify are worthless to them.
- **Never fabricate market share.** Reliable share data rarely exists outside paywalled analyst reports, and a confident fake percentage is the most damaging lie a competitor analysis can tell — it anchors strategy on fiction. If no source exists, write exactly that and reason from proxies: "No reliable public market-share data found; proxies suggest A leads B — A has ~4x B's G2 review count [S7] and ~3x the LinkedIn headcount [S8]." Cite each proxy and label the ranking `(inference)`.
- **Confidence and freshness travel with the claim.** Register every source in `sources.md` with confidence; flag anything older than ~12 months, since pricing, features, and headcount all drift.
- **Keep the record correction-friendly.** When later evidence contradicts an earlier claim, update the claim and note the conflict — do not silently keep the version that made the narrative cleaner.

## 7. Monitoring hooks

A competitor analysis is a snapshot that starts decaying immediately. End every analysis with a short "what to re-check" list so the user can refresh it cheaply:

- **Pricing pages** (quarterly) — repackaging and price moves signal strategy shifts; diff against the archived version.
- **Job postings** (monthly) — the earliest public signal of roadmap and expansion: new roles, new locations, new skill demands.
- **Release notes / changelogs** (monthly) — shipped features, especially any that close the gaps your matrix identified.
- **Review streams** (quarterly) — new complaint patterns, or old complaints disappearing (they fixed it).
- **Funding and M&A news** (set an alert) — a raise or acquisition can invalidate the positioning map overnight.
- **The identified gap** (each revisit) — is anyone now moving into the open space you flagged? If a well-funded player enters it, that is evidence the demand hypothesis was right, and the window is closing.

For each hook, record the URL to re-check and the date of the current snapshot, so the next pass is a diff rather than a redo.
