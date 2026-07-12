# Deep Audit Rubric

A merged operational checklist for dissecting a business document: the
Paul–Elder eight elements and nine standards, plus Robert Ennis's
credibility criteria and domain-knowledge checkpoint. Use it in three
passes, in order — each pass depends on what the previous one surfaced.

1. **Pass 1 — Elements.** Find and name the reasoning's parts. You cannot
   grade a standard against an element you haven't located yet, so this
   pass comes first even though it feels like the least "critical" one.
2. **Pass 2 — Standards.** Grade what Pass 1 found. A missing element from
   Pass 1 usually shows up here as a standard failure (no stated
   alternatives → weak breadth; no stated purpose → everything downstream
   is ungradable for relevance).
3. **Pass 3 — Credibility and domain knowledge.** Grade the sources behind
   the claims, and be honest about what you personally are and are not
   qualified to judge.

Hold two dispositions through all three passes, per Ennis: seek reasons
rather than accept assertions at face value, and seek genuine alternatives
rather than the first counterargument that comes to mind. A document that
never considers a competing hypothesis fails breadth in Pass 2 regardless
of how polished its prose is. Represent the document's actual position
honestly before you critique it — steelman before you strike, or the
audit is just a rebuttal wearing a rubric's clothes.

Work section by section for long documents; a single pass over an entire
30-page memo produces vague, unusable notes. Quote the exact sentence
you're grading — a rubric item without a quoted anchor is an opinion, not
an audit finding.

## Pass 1 — Elements: is each element present and identifiable?

For each element, ask the question, watch for the named failure mode, and
locate the sentence(s) that do — or fail to do — the job.

**Purpose.** What is this document trying to get the reader to believe,
approve, or do? Violation: the ask is buried or plural and shifting — a
memo that opens "aligning on our data strategy" and closes "approve the
$2M platform buy" has smuggled its real purpose past the reader.

**Question at issue.** What specific question does the argument answer?
Violation: the question is broader or narrower than the evidence
supports — "should we enter the EU market" answered with evidence about
one country's regulatory regime.

**Information.** What data, examples, or facts is the reasoning built
on? Violation: information asserted with no visible source — "enterprise
customers are demanding this" with no survey, ticket count, or deal note
behind it.

**Interpretation and inference.** What conclusions are drawn from the
information, and by what steps? Violation: the inferential step is
invisible — the document states a fact and states a conclusion,
adjacent, with the connecting logic left for the reader to invent: "churn
rose 3 points. We need a loyalty program."

**Concepts.** What are the load-bearing ideas and terms the argument
turns on? Violation: a key term does real work but is never defined, or
is defined once and used differently later — "platform" meaning the core
API in section 2 and meaning the whole product suite in section 4.

**Assumptions.** What is taken for granted rather than argued for?
Violation: an assumption is doing the heaviest lifting in the argument
and is never surfaced as an assumption at all — a growth projection that
silently assumes flat customer acquisition cost through 3x scale.

**Implications and consequences.** What follows if the argument's
recommendation is adopted — including costs, risks, and second-order
effects? Violation: only the intended, positive consequence is traced;
downside or knock-on effects go unmentioned — a pricing change memo that
models revenue lift but never mentions churn risk or competitor response.

**Point of view.** From what vantage is the argument written, and whose
interests or framing does it privilege? Violation: the document presents
one stakeholder's frame as the neutral, objective one — an engineering
proposal that frames "technical debt" purely in engineering-effort terms
with no mention of the sales team's competing view of the same tradeoff.

## Pass 2 — Standards: grade what is present

Grade only what Pass 1 located — don't invent content to grade. Use the
three-level anchor to keep grades comparable across sections and across
different audits.

**Clarity.** Could a reader restate the claim in their own words without
guessing? Violation: jargon or vague nominalizations stand in for a
concrete claim — "we need to modernize our data posture" instead of
naming what changes.
- Strong: every key claim restatable in one plain sentence.
- Weak: some claims require re-reading or guessing intent.
- Absent: core claims are unparaphrasable as written.

**Accuracy.** Do the stated facts match what's checkable — cited
sources, known figures, arithmetic? Violation: a cited number doesn't
match the source, or is stated more precisely than the source supports —
"73.4% of customers" sourced to a survey of 40 respondents.
- Strong: every checkable claim verified against its source or general
  knowledge.
- Weak: minor discrepancies (rounding, stale figures) that don't change
  the conclusion.
- Absent: a load-bearing figure is wrong, unverifiable, or contradicted
  by its own cited source.

**Precision.** Is the claim specific enough to be actionable or
falsifiable? Violation: vague quantifiers stand in for numbers —
"significant improvement," "most customers," "in the near term" with no
figure or date attached anywhere in the document.
- Strong: claims carry numbers, dates, or named scope throughout.
- Weak: some sections precise, others rely on vague quantifiers.
- Absent: the document is quantifier-soup end to end — nothing is
  falsifiable.

**Relevance.** Does each piece of evidence actually bear on the question
at issue identified in Pass 1? Violation: impressive but tangential
evidence substitutes for evidence that speaks to the actual decision — a
build-vs-buy memo that spends two pages on the vendor's funding round and
one sentence on total cost of ownership.
- Strong: every cited fact visibly supports the stated question at issue.
- Weak: some evidence is adjacent but not squarely on point.
- Absent: the evidence answers a different, easier question than the one
  posed.

**Depth.** Does the argument engage the real complexity — root causes,
mechanisms, tradeoffs — or stay at the surface? Violation: a symptom is
treated as the cause — "support tickets are up, so we need more support
staff" with no investigation of what's generating the tickets.
- Strong: the argument traces mechanism, not just correlation, and
  addresses the hardest version of the problem.
- Weak: some causal reasoning, but stops at the first plausible
  explanation.
- Absent: surface description only — what happened, not why.

**Breadth.** Are genuine alternative explanations, options, or
viewpoints considered? Violation: a strawman alternative is knocked down
to make the preferred option look inevitable — "the only other option is
doing nothing" when a cheaper, phased option exists and goes unmentioned.
- Strong: at least one credible alternative is considered on its own
  terms, with real tradeoffs stated.
- Weak: an alternative is named but dismissed in a clause, unexamined.
- Absent: single-option tunnel vision — the recommendation is presented
  as the only path.

**Logic.** Do the conclusions actually follow from the premises and
evidence given — no gaps, no non-sequiturs, no fallacies? Violation:
correlation presented as causation, or a conclusion that requires an
unstated premise the reader wouldn't automatically grant — "competitors
raised prices and grew revenue, so we should raise prices" skips the
premise that price was the cause of their growth.
- Strong: each conclusion's chain from evidence is traceable and none of
  the steps require an unstated leap.
- Weak: the overall direction is sound but one or two steps need
  charitable filling-in.
- Absent: the conclusion doesn't follow from the stated evidence at all,
  or requires an assumption strong enough to be the real argument.

**Significance.** Does the document focus on what actually matters most
for the decision, rather than what's easiest to write about? Violation:
pages of detail on a minor, easily-solved risk while the decision's
biggest exposure gets one sentence — three pages on rebranding logistics,
one line on the regulatory approval that could kill the whole plan.
- Strong: space allocated roughly tracks stakes; the biggest risk or
  driver gets the most scrutiny.
- Weak: important points are present but under-weighted relative to
  minor ones.
- Absent: the most consequential factor is missing or buried.

**Fairness.** Is opposing evidence and viewpoint represented on its own
terms, not weakened before being addressed? Violation: a strawman version
of the counterargument is refuted instead of the strongest real version —
"critics say we should never take risks" as a stand-in for a specific,
reasoned objection someone actually raised.
- Strong: the strongest form of the counterargument is stated and
  engaged, even where it's inconvenient.
- Weak: a real objection is acknowledged but understated or answered
  only partially.
- Absent: opposing views are omitted or only appear in weakened,
  strawman form.

## Pass 3 — Credibility and domain-knowledge checkpoint

This pass covers two different questions that get conflated if you rush:
whether the document's *sources* can be trusted, and whether *you*, the
auditor, are equipped to judge the *content*. Skipping either produces a
confident-sounding audit that's quietly unreliable.

### Source credibility

For every load-bearing claim traced to an external source in Pass 1, ask:

- **Expertise.** Is the source positioned to know this? A market-sizing
  claim attributed to the company's own sales VP is a different kind of
  evidence than the same claim from an independent analyst firm.
- **Conflict of interest.** Does the source benefit from the claim being
  believed? A vendor's whitepaper claiming their category is about to
  triple is evidence of the vendor's marketing, not the market.
- **Corroboration.** Does another independent source agree? One
  unconfirmed data point presented as settled fact — "industry reports
  show 40% adoption" with no report named — is a Pass-2 accuracy problem
  and a Pass-3 credibility problem at once.
- **Track record and reputation.** Has this source been reliable on
  similar claims before, and do they have something to lose by being
  wrong (a named analyst, an audited filing) or nothing to lose (an
  anonymous forum post, an unlinked "industry expert")?
- **Reasons given.** Does the source show its own work, or just assert a
  conclusion? A cited study that names its sample size and method is
  worth more than a cited article that states a statistic with no
  visible methodology.

Grade cited sources the same three-level way as a standard: strong (named,
expert, low conflict of interest, reasons shown), weak (named but
unverifiable methodology or a mild conflict of interest), absent
(unnamed, or a source with an obvious stake in the claim and no
corroboration).

### The cannot-assess flag

Domain background knowledge is not optional garnish on critical
thinking — it's what separates a real audit from a rubric applied blind.
A logically airtight argument built on a domain fact you cannot verify is
still an argument you cannot certify.

Before grading any claim that depends on specialized domain knowledge —
a technical feasibility estimate, a regulatory interpretation, an
actuarial assumption, an industry-specific benchmark — ask: do I actually
know enough here to tell a plausible-sounding claim from a wrong one, or
am I pattern-matching on fluent prose?

When the honest answer is no, say so explicitly in the audit output
instead of grading the claim as if you'd checked it. Flag format:
"Cannot assess: this claim about [specific claim] requires
[specific domain knowledge — e.g., semiconductor fab yield economics]
beyond what I can verify. Recommend [a named domain expert or specific
verification step]." A flagged claim is a legitimate audit finding, not a
gap in the audit — a false "this checks out" on a claim you couldn't
actually evaluate is worse than an honest "I can't tell."

This is the one place in the rubric where the discipline is to *stop*
rather than to keep grading.

## Scoring discipline

Never collapse the nine standards into one number. A document that is
strong on clarity and precision but absent on logic is not a "6.5/10
argument" — it is a broken argument that happens to be well written, and
averaging hides exactly that. The grades exist to be read individually,
not summed.

Lead the audit report with the two or three worst-graded standards, not
the highest ones and not the order they appear in the rubric. A reader
who only reads your first paragraph should already know the argument's
actual weak point — usually logic, breadth, or significance, since those
are the standards weak business prose fails most often while still
reading fluently. Everything strong-graded can wait for the appendix.
