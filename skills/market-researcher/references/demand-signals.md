# Demand Signals & Customer Hypotheses (Desk Research)

How to mine the public web for evidence of demand, organize it with Jobs-to-be-Done,
and produce honestly-labeled customer hypotheses — without ever pretending you talked
to a real customer.

## Contents

1. [The honesty rule](#1-the-honesty-rule)
2. [Where demand signals live](#2-where-demand-signals-live)
3. [Jobs-to-be-Done framing](#3-jobs-to-be-done-framing)
4. [Pain-point mining protocol](#4-pain-point-mining-protocol)
5. [Hypothesis personas](#5-hypothesis-personas)
6. [Willingness-to-pay signals](#6-willingness-to-pay-signals)
7. [Output format](#7-output-format)

---

## 1. The honesty rule

You are doing desk research. You cannot interview users, run surveys, or observe
behavior. Therefore:

- **Everything you produce here is a SIGNAL or a HYPOTHESIS, never a validated insight.**
  A validated insight requires contact with real customers — that work belongs to the
  user or to a calling skill (design-thinking, strategy-board) that owns primary research.
- **Every factual claim must carry a source ID** like [S3] pointing to the research's
  source register. Anything without a citation must be explicitly labeled
  `(hypothesis)` or `(assumption)`. No third category exists. If you catch yourself
  writing a confident customer claim with no bracket after it, stop and classify it.
- **Frame all deliverables as input to primary research**, not a substitute for it.
  End every demand-signals section with open questions that only real interviews or
  tests can answer.

Why so strict? Because a fabricated persona that *looks* researched is worse than no
persona at all. A team with no persona knows it is guessing and stays humble; a team
with a polished but invented "Marketing Manager Mai, 32, frustrated by X" stops asking
questions, builds for a fiction, and discovers the error only after shipping. Desk
research is cheap precisely because it is unverified — preserve that price tag by
labeling honestly. Your credibility as a research skill rests on the reader always
knowing which statements are evidence and which are your inference.

## 2. Where demand signals live

Real people leave traces of unmet needs all over the public web. Search these source
types deliberately — each answers a different question. Register every source you use
and cite it by ID.

| Source type | What it signals | How to mine it |
|---|---|---|
| **Product reviews** (app stores, e-commerce, G2/Capterra, Shopee/Tiki/Lazada for VN) | What incumbents get right and wrong, in the customer's own words | Mine 1–2 star reviews for complaints, 4–5 star for the job the product is hired for. Quote verbatim, cite the review page. |
| **Forum & community threads** (Reddit, Hacker News, niche forums; plus each market's dominant community channels — e.g. Facebook Groups/Zalo in Vietnam, LINE communities in Japan/Thailand, WhatsApp/Telegram groups in India, Brazil, or the Middle East) | Problems people care enough about to write about; workarounds they share | Search "[problem] + reddit", "how do you deal with", "alternative to [incumbent]" — in the market's own language. In many markets, closed social groups carry more signal than public forums — search group posts and comment threads where accessible. |
| **Support/FAQ pages of incumbents** | Recurring friction the incumbent has been forced to document | A long FAQ entry means many customers hit that wall. Docs about workarounds signal product gaps. |
| **Search-volume proxies** (Google Trends, autocomplete, "People also ask", keyword tools) | Relative scale and trajectory of interest | Treat as directional only — volume ≠ purchase intent. Compare related queries against each other, cite the tool and date. |
| **Job postings** | Budget exists: a company hiring someone to solve a problem is paying real money for it today | Search job boards for roles whose duties match the problem space. "Hiring a person to do X manually" is a strong build-a-tool signal. |
| **"I wish X existed" patterns** | Explicit unmet demand | Search literal phrases: "I wish there was", "why is there no", "does anyone know a tool that", "giá mà có" / "có app nào" (VN). Rare gold — always capture the full quote and link. |

Rules of thumb:

- **Prefer verbatim quotes over paraphrase.** The customer's own words carry tone and
  intensity that your summary destroys, and they are checkable.
- **Note the date of each signal.** A 2019 complaint about a product that shipped a fix
  in 2023 is not current demand.
- **Watch for astroturf.** Review sites and forums contain vendor-planted content;
  discount suspiciously polished praise and single-purpose accounts.

## 3. Jobs-to-be-Done framing

Organize signals around the *job* the customer is trying to get done, not around your
product idea. Jobs are stabler than solutions and keep you from pattern-matching every
complaint into a feature request.

Classify each job on three dimensions:

- **Functional job** — the task to complete. "Reconcile monthly invoices without manual
  spreadsheet work."
- **Emotional job** — how the person wants to feel. "Feel confident nothing was missed
  at month-end."
- **Social job** — how they want to be perceived. "Look competent to the finance
  director."

Write job statements in the form: *When [situation], I want to [motivation], so I can
[expected outcome].*

**Every job statement must be tagged to cited evidence.** A job you inferred from a
cluster of quotes is fine — cite the quotes: "Job J2 (functional): ... — inferred from
[S4], [S7], [S9]." A job with no supporting citation is a hypothesis and must say so:
"Job J5 (emotional, hypothesis — no direct evidence found)." This tagging is what
separates a desk-research JTBD map from brainstorming.

## 4. Pain-point mining protocol

Follow this sequence; do not skip straight to conclusions.

1. **Collect verbatims.** Gather exact quotes expressing frustration, workaround, or
   desire. For each: the quote, source link, date, and source ID. Keep the original
   language (a quote stays in its original language; add a translation when
   the report is written in another).
2. **Cluster.** Group quotes describing the same underlying pain, even when worded
   differently. Name each cluster with a plain description, not a solution ("manual
   re-entry between tools", not "needs our integration feature").
3. **Rank by frequency × intensity.**
   - *Frequency*: how many independent sources/people voice it (count them, cite them).
   - *Intensity signals*: profanity or exasperation, quantified loss ("costs me 3 hours
     a week"), evidence of paid workarounds, people building their own hacks, switching
     products over it.
4. **Distinguish "loud on forums" from "willing to pay."** Forums over-represent
   articulate power users with free time; the median buyer may not share their pain,
   and vocal complainers often will not pay for a fix. For each top pain, explicitly
   note whether you found any *money signal* (see §6) alongside the noise. A pain with
   ten angry threads and zero spending evidence gets flagged: "high volume, unproven
   willingness to pay."
5. **Check who owns the source before counting it.** Complaints about a product
   hosted on a competitor's blog, an affiliate review site, or a comparison page
   with referral links are marketing, not testimony. Quote them only with the
   affiliation named inline, and never let them contribute to a pain's
   frequency/intensity rank or carry a money-signal flag — a competitor trashing
   a rival is evidence of rivalry, not of customer pain. The same applies in §6:
   a WTP claim sourced from a party that profits from you believing it needs
   independent corroboration before it counts.

Output of this protocol: a ranked pain table where each row has cluster name, evidence
count, representative verbatim quote with citation, intensity notes, and a
money-signal flag.

## 5. Hypothesis personas

You may sketch personas — but only as clearly-labeled hypotheses, never as findings.

- **Label each one in its heading:** "Persona hypothesis H1 — to validate." Never a
  bare "Persona: ...". The label must survive copy-paste into someone's slide deck.
- **Every attribute is either cited or marked.** Demographics, behaviors, tools used,
  budget — each line ends with [Sx] or `(assumption)`. Do not invent a name, age, and
  photo-ready backstory to make it "relatable"; that is exactly the fabricated realism
  the honesty rule forbids. A short role description is enough.
- **Cap the count.** Two or three hypothesis personas maximum. More personas than
  evidence clusters means you are inventing.
- **Include a "How to validate" line per persona** — the specific interview question or
  cheap test that would confirm or refute it. Example: "Validate by asking 5 café
  owners: 'Walk me through the last time you did inventory — what did you use and how
  long did it take?' Refuted if most report under 30 minutes with existing tools."

Template:

```markdown
### Persona hypothesis H1 — to validate
- Role/context: owner of a 1–3 location F&B business in a large metro area [S2], [S8]
- Key job: J1 (see jobs section) [S4]
- Current workaround: tracks inventory in Excel + phone photos shared in a group chat (assumption, weak signal in [S8])
- Budget signal: pays ~$25/month for a POS that lacks this feature [S11]
- How to validate: interview 5 owners; ask about their last stock-count. Refuted if Excel takes them <30 min/week.
```

## 6. Willingness-to-pay signals

Complaints are cheap; spending is evidence. Hunt specifically for money leaving wallets:

- **Existing spend on substitutes and workarounds.** Subscriptions to partial solutions,
  freelancers/VAs hired to do it manually, agency fees, hardware bought to compensate.
  Cite prices and sources: "users report paying $29/mo for [tool] just for feature X [S6]."
- **Pricing of adjacent solutions.** What do the nearest incumbents charge, and at what
  tiers? This bounds the price customers are already trained to accept. Cite pricing
  pages (with date — pricing changes).
- **Job postings as spend** (again): a salary line dedicated to the problem is the
  strongest desk-observable WTP signal there is.
- **Complaint patterns about current cost.** "Too expensive for what it does" is
  double-edged: it proves people are paying AND that a cheaper/better entrant has an
  opening. Distinguish "won't pay anything" grumbling from "paying but resentful"
  quotes — only the latter is a WTP signal.

What desk research cannot tell you: the actual price *your* target will pay for *your*
solution. State this limit explicitly and route it to the open-questions list
(pricing interviews, fake-door or pre-order tests — owned by primary research).

## 7. Output format

Produce a demand-signals section structured like this, feeding the skill's main report
and its source register:

```markdown
## Demand Signals

### Jobs-to-be-Done
- J1 (functional): When [situation], I want [motivation], so I can [outcome]. — [S3], [S7]
- J2 (emotional): ... — [S4]
- J3 (social, hypothesis — no direct evidence found): ...

### Ranked pains
| # | Pain cluster | Evidence | Representative quote | Intensity | Money signal? |
|---|---|---|---|---|---|
| 1 | [name] | 9 sources | "..." [S7] | quantified loss, paid workaround [S9] | Yes — pays $29/mo [S6] |
| 2 | [name] | 4 sources | "..." [S12] | loud, no spend found | No — flag: unproven WTP |

### Hypothesis personas (to validate — not research findings)
[Persona hypothesis H1 — per §5 template]
[Persona hypothesis H2 — per §5 template]

### Willingness-to-pay signals
- [signal + citation, per §6]
- Limit: desk research cannot establish price acceptance for the proposed solution.

### Open questions for primary research
1. [Question only a real interview/test can answer, mapped to the persona or pain it de-risks]
2. ...
```

The open-questions list is mandatory and is the true deliverable of this file: it is
the bridge from desk signals to the validated insights that design-thinking or
strategy-board will pursue with real users. A demand-signals section without open
questions is claiming certainty it has not earned.
