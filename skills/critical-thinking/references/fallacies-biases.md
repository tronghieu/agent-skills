# Fallacies & Biases: The Detection Catalog

A catalog of the reasoning fallacies and cognitive biases that actually show up in business and executive documents — memos, proposals, investment analyses, board papers, pitch decks. This is not a philosophy-class list; textbook fallacies that rarely surface in business prose (appeal to force, appeal to novelty, tu quoque as a standalone category) are left out on purpose. Every entry earns its place by being something a sharp reader actually finds in a real deck.

**Scan discipline — read this before scanning:**

1. Scan *after* mapping the argument, never before. A fallacy label without a quoted anchor is itself a fabrication — the same discipline the audit applies to every other claim in this skill. If you cannot point to the exact sentence, you do not have a finding, you have a hunch.
2. One clear instance beats five stretched ones. A document with one unambiguous survivorship-bias chart is more useful to the executive than a report that tags every optimistic sentence as "optimism bias." Padding the finding count degrades trust in the whole audit.
3. Never label something a fallacy when it is merely a claim you disagree with. "The market will grow 20%" is a forecast, not base-rate neglect — it becomes base-rate neglect only when the document ignores a relevant reference class it had reason to know about. The test is always: does the *reasoning*, not the *conclusion*, break down?
4. Quote first, label second. Copy the offending text verbatim before you decide what to call it — deciding the label first and then hunting for text to match it is how audits manufacture findings.
5. Every finding names the pattern, shows the exact quote, and says what evidence would repair it. A label with no repair path is a gotcha, not an audit.
6. Distinguish a fallacy (a broken inference) from a bias (a systematic tilt in how evidence was gathered, weighted, or framed). Both matter; they get flagged differently — a fallacy is a step in the argument that doesn't follow, a bias is a lens the author didn't disclose.

## Evidence fallacies

How data is selected, filtered, or presented before it ever reaches the argument.

**Cherry-picking / selective evidence (chọn lọc bằng chứng có lợi)**
Presenting only the data points that support the conclusion while omitting comparably relevant ones that don't.
*Detection cue*: a single supporting chart or quote with no visible denominator; competitor comparisons that stop at exactly the metric where the company wins.
*Example*: "Customer satisfaction hit 92% in Q3" — with no mention that Q1 and Q2 were 61% and 58%.
*In the audit, write*: quote the cited figure, name the missing comparison period or segment, and ask for the full series or the selection criteria used to choose this one data point.

**Hasty generalization / small-sample overreach (khái quát hóa vội vàng)**
Drawing a general conclusion from a sample too small or unrepresentative to support it.
*Detection cue*: "our pilot showed," "customers we talked to said," a single case study standing in for a market-wide claim.
*Example*: "Three of our beta customers loved the new pricing, so the market is ready" — from a beta of three.
*In the audit, write*: state the sample size next to the claim it's asked to carry, and name the scale of decision riding on it; ask for the confidence interval or a larger validation sample before the decision is sized to it.

**Survivorship bias (thiên kiến người sống sót)**
Drawing conclusions only from the entities that made it through a selection process, ignoring those that were filtered out or failed.
*Detection cue*: "our top-performing accounts," "successful competitors in this space did X," case studies of companies that still exist.
*Example*: "Every unicorn in this category raised a Series A within 18 months, so speed is the key success factor" — silent on the founders who raised fast and still failed.
*In the audit, write*: name what population was excluded from the sample (the failures, the churned accounts, the shut-down competitors) and ask whether the pattern holds across that excluded group too.

**Texas sharpshooter (thiện xạ Texas — vẽ vòng tròn sau khi bắn)**
Spotting a pattern in data after the fact and presenting it as if it were predicted, without a pre-specified hypothesis.
*Detection cue*: a metric or segment cut that appears only once, in the result section, with no earlier mention that it was the thing being tracked; "when we looked closer, we found that..."
*Example*: "Digging into the data, we found that our best-performing cohort was left-handed users who signed up on a Tuesday" — presented as an actionable insight.
*In the audit, write*: ask whether this cut was hypothesized before the data was pulled, and how many other cuts were tried and discarded before this one was found (multiple-comparisons exposure).

## Causal fallacies

Where the document says X causes Y and the reasoning doesn't support it.

**Correlation vs. causation (nhầm tương quan với nhân quả)**
Treating two co-occurring trends as cause-and-effect without ruling out confounders, reverse causation, or coincidence.
*Detection cue*: "since we launched X, Y went up," a chart with two lines that move together and no discussion of what else changed at the same time.
*Example*: "Since we introduced the loyalty program, revenue grew 15%" — with no mention of the pricing change that shipped the same quarter.
*In the audit, write*: name the concurrent factor(s) that weren't ruled out, and ask for the isolating evidence (a controlled test, a before/after with other variables held constant) that would let the causal claim stand.

**Post hoc ergo propter hoc (ngộ nhận nhân quả theo trình tự thời gian)**
Assuming that because B followed A, A caused B — causation-from-sequence alone.
*Detection cue*: timelines used as the entire argument; "after we rebranded, churn dropped."
*Example*: "We changed the onboarding flow in March, and April signups were up 20%" — no mention of the seasonal spike that happens every April.
*In the audit, write*: point out the sequence-only reasoning and ask what rules out seasonality, a concurrent campaign, or normal variance as the actual driver.

**False analogy (loại suy khập khiễng)**
Arguing that because two situations are alike in some respects, a conclusion true of one must be true of the other, when the relevant respects differ.
*Detection cue*: "just like [famous company] did," a comparison to another industry, market, or era with no discussion of what's different.
*Example*: "Netflix moved from DVDs to streaming and won, so we should kill our retail channel and go all-digital" — no comparison of capital structure, customer base, or switching costs.
*In the audit, write*: name the dimension on which the two cases diverge (market power, capital position, customer lock-in) and ask whether the analogy still holds once that difference is accounted for.

## Statistical biases

Systematic distortions in how numbers are chosen, weighted, or read.

**Base-rate neglect (bỏ qua tỷ lệ nền)**
Ignoring the general prevalence of an event or outcome in favor of a vivid specific instance or a plausible-sounding story.
*Detection cue*: a projection built entirely on the company's own model with no reference to how similar bets have played out across the industry or historically.
*Example*: "Our churn-prediction model flags this account as 90% likely to renew" — without noting the model's flags are right maybe 40% of the time at that confidence level, or what the overall renewal base rate is.
*In the audit, write*: ask what the base rate is for this category of outcome (industry average, historical hit rate) and whether the specific case has been shown to differ from it, or is just being treated as if it does.

**Overconfidence / miscalibration (tự tin thái quá, ước lượng sai độ chắc chắn)**
Stating a forecast or estimate with a confidence level, or lack of a range, that isn't earned by the underlying evidence.
*Detection cue*: single-point forecasts with no range or downside case; "we are confident that," round numbers presented to two decimal places.
*Example*: "Revenue will reach $42.3M in Year 2" — a single point estimate for a product that hasn't shipped.
*In the audit, write*: ask for the range and the assumptions that would produce the low end, and note that a single-point forecast this far out implies a precision the input data doesn't support.

**Narrative fallacy (ngụy biện tường thuật — gán câu chuyện cho dữ liệu)**
Imposing a clean, causal storyline onto a sequence of events that is better explained by noise, luck, or multiple interacting factors.
*Detection cue*: an origin story used as proof of strategy ("we knew from day one that..."), a tidy three-act narrative applied to what was actually a messy, iterative process.
*Example*: "Our founder's insight in 2019 anticipated exactly this market shift" — reconstructed after the shift happened, with no contemporaneous evidence the insight was that specific.
*In the audit, write*: ask for contemporaneous documentation of the claimed foresight, and note that a retrospective story fitting the outcome perfectly is itself a warning sign, not confirmation.

**McNamara fallacy (ngụy biện McNamara — chỉ coi trọng cái đo được)**
Overweighting whatever is quantifiable and disregarding what matters but resists easy measurement, sometimes to the point of treating "not measured" as "doesn't matter."
*Detection cue*: a decision framework built entirely on metrics with hard numbers (CAC, NPS, conversion rate) with no line for brand trust, employee morale, or long-term optionality; "the data says" used to end discussion.
*Example*: "The numbers clearly favor Option A" — in a decision where Option B protects a relationship or reputation the model doesn't capture.
*In the audit, write*: name the qualitative factor left out of the scoring, and ask whether it was excluded because it was assessed and found immaterial, or simply because it doesn't fit the spreadsheet.

**Halo effect (hiệu ứng hào quang)**
Letting a positive impression in one area (a strong leader, a well-known brand, a past win) inflate the assessment of unrelated areas.
*Detection cue*: "given their track record," credentials substituted for evidence about the specific plan at hand.
*Example*: "The team that built [past hit product] is behind this, so execution risk is low" — for a product in a different category with a different team composition.
*In the audit, write*: separate the track record from the specific claim it's being used to support, and ask for evidence about this plan on its own terms.

## Framing & rhetoric

How the argument is worded, structured, or staged to move the reader without changing the substance.

**False dichotomy / false dilemma (ngụy biện lưỡng nan giả)**
Presenting only two options as if they were exhaustive, when other paths exist.
*Detection cue*: "we either do X or we lose the market," a decision framed as binary with no "do nothing," "do less," or "do it differently" option on the table.
*Example*: "It's either we acquire this company now, or our competitor will and we're locked out forever."
*In the audit, write*: name at least one omitted option (build in-house, partner, wait, acquire a different target) and ask why it was excluded from the comparison.

**Straw man (ngụy biện người rơm)**
Restating an opposing view in a weaker or distorted form, then refuting that version instead of the actual position.
*Detection cue*: "critics would say..." followed by an oversimplified objection that's easy to knock down; the counterargument section is noticeably thinner than the main case.
*Example*: "Some argue we should 'just wait and see' — but standing still while the market moves is not a strategy" — when the actual objection was a specific, resourced alternative plan, not passive waiting.
*In the audit, write*: quote the flattened version of the objection next to what the real counter-position argues, and ask for a response to the stronger form.

**Appeal to (inappropriate) authority (viện dẫn quyền lực không phù hợp)**
Citing a credentialed source as settling a claim when that source's expertise doesn't cover the specific claim being made.
*Detection cue*: a name-drop ("as [famous CEO] says...") standing in for evidence; a McKinsey or Gartner citation used to close a debate rather than inform it.
*Example*: "A leading economist has said AI will add $15T to the global economy, so our AI investment will pay off" — a macro forecast used to justify a specific bet the economist never assessed.
*In the audit, write*: name the gap between what the authority actually studied and what the document is using them to support, and ask for evidence specific to this claim.

**Appeal to consensus / bandwagon (ngụy biện a dua theo số đông)**
Arguing a course of action is right because many others, especially competitors, are doing it.
*Detection cue*: "industry leaders are all moving to X," "everyone in the space is investing in Y."
*Example*: "Three of our five main competitors have launched an AI copilot feature this year, so we need one too."
*In the audit, write*: ask what evidence exists that the move worked for those competitors specifically, and whether the company's position (cost structure, customer base) makes the same move a good fit or just a follow-along.

**Equivocation (ngụy biện đánh tráo khái niệm)**
Using a key term in more than one sense across the argument, so the conclusion trades on a shift in meaning the reader doesn't notice.
*Detection cue*: a word like "growth," "engagement," or "risk" used loosely early on and then leaned on precisely later, without being redefined.
*Example*: "Growth" meaning new signups in the market-sizing section, then "growth" meaning revenue in the projections section, with the same word carrying the argument across both.
*In the audit, write*: quote both uses of the term side by side and ask which definition the conclusion actually depends on.

**Begging the question / circular reasoning (lập luận vòng tròn)**
Assuming the truth of the conclusion within a premise, so the argument proves nothing beyond restating itself.
*Detection cue*: a rationale that, read closely, just rephrases the recommendation; "this is the right move because it's the strategic choice."
*Example*: "We should prioritize this feature because it's our top priority" — the priority ranking is the thing being justified.
*In the audit, write*: show that the premise and the conclusion say the same thing in different words, and ask for an independent reason.

**Goalpost shifting (dời cột mốc)**
Changing the criteria for success after the fact, so the original target is quietly replaced once it isn't met.
*Detection cue*: comparing this document's success metric to a prior document's plan and finding they don't match; "while we didn't hit the original target, the real measure of success is..."
*Example*: a proposal set a 15% adoption target last quarter; this quarter's update declares success at 8% adoption by calling it "strong early signal" instead.
*In the audit, write*: quote the original target next to the current framing and ask which one the decision should be judged against.

**Whataboutism (ngụy biện "còn cái kia thì sao")**
Deflecting a criticism by pointing to a different, often unrelated, shortcoming elsewhere — usually a competitor's — instead of addressing the point raised.
*Detection cue*: a risk raised about the plan gets answered with "but [competitor] has the same problem" instead of a mitigation.
*Example*: "Yes, our margins are thin here, but so are [competitor]'s" — in response to a question about whether the unit economics work.
*In the audit, write*: note that the competitor's comparable weakness doesn't answer whether this plan's economics work, and ask for a direct response to the original risk.

**Red herring (đánh lạc hướng)**
Introducing an irrelevant point that diverts attention from the question actually being asked.
*Detection cue*: a question about cost is answered with a paragraph about vision or mission; a risk question answered with a list of past achievements.
*Example*: asked about the plan's execution risk, the memo pivots to "our company was founded on a bold vision to..."
*In the audit, write*: name the question that was asked and the answer that was given, and point out they don't match.

**Hedging that masquerades as a claim (lập lờ nước đôi ngụy trang thành khẳng định)**
Language soft enough to be unfalsifiable while reading, on a skim, as a concrete commitment or number.
*Detection cue*: "could potentially," "up to," "as much as," "in some cases" attached to the document's headline figure.
*Example*: "This could unlock up to $50M in value" — the only number in the document, doing the work of a forecast while carrying no commitment if it doesn't happen.
*In the audit, write*: quote the hedge next to the number it's attached to, and ask for the base case and the conditions under which the upper bound would actually be reached.

**Slippery slope (ngụy biện dốc trơn)**
Arguing that a first, modest step will inevitably lead to a chain of increasingly extreme consequences, without evidence for each link in the chain.
*Detection cue*: "if we allow X, next it'll be Y, and eventually Z"; domino-style reasoning used to block a limited proposal.
*Example*: "If we grant this one client a custom contract term, every client will demand one and our pricing model collapses."
*In the audit, write*: ask for evidence of the first link (has this happened when similar terms were granted before?) and note that each step in the chain needs its own support, not just plausibility.

## Self-serving cognition

Biases in how the author's own mind processed the evidence — not distortions of the data itself, but of the reasoning layered on top of it. These are the hardest to catch because they don't look like errors; they look like conviction.

**Anchoring (neo tư duy vào con số ban đầu)**
Letting an initial number — even an arbitrary or outdated one — set the frame for every subsequent estimate.
*Detection cue*: a first-mentioned figure (last year's budget, a competitor's headline number) that every later estimate in the document is a small adjustment from.
*Example*: "Last year's marketing budget was $2M, so this year we're requesting $2.4M" — with no independent build-up of what the plan actually requires.
*In the audit, write*: name the anchor figure and ask for an estimate built bottom-up from the current plan's requirements, independent of the prior number.

**Availability heuristic (thiên kiến dễ nhớ, dễ hình dung)**
Judging likelihood or importance by how easily examples come to mind, rather than by actual frequency.
*Detection cue*: a risk or opportunity justified by a recent, vivid, widely-discussed event rather than by base-rate data.
*Example*: "After the [recent high-profile breach] in the news, we need to triple our security budget" — sized to the vividness of the headline, not to this company's actual exposure.
*In the audit, write*: ask what this company's own incident history or risk assessment shows, separate from the salience of the recent news event.

**Confirmation bias (thiên kiến xác nhận)**
Seeking, interpreting, or recalling evidence in a way that confirms a pre-existing belief, while underweighting disconfirming evidence.
*Detection cue*: every cited data point supports the same conclusion with no discussion of contrary signals; a competitive review that lists only the target's weaknesses.
*Example*: a build-vs-buy memo that cites five reasons to build and omits the vendor evaluation the team also ran.
*In the audit, write*: ask what evidence was considered and set aside, and why — the absence of any disconfirming data point in a real decision process is itself worth flagging.

**Motivated reasoning (lập luận thiên vị theo mong muốn)**
Working backward from a preferred conclusion and selecting the reasoning that gets there, rather than following the evidence to wherever it leads.
*Detection cue*: the recommendation appears early (often in the executive summary) and the body reads as justification rather than investigation; alternatives are dismissed in a sentence each.
*Example*: an exec summary that opens with "we should proceed with the acquisition" before the valuation, diligence findings, or integration risk have been presented.
*In the audit, write*: note the order in which the conclusion and the evidence appear, and ask whether the alternatives got the same depth of analysis as the preferred option.

**Sunk cost fallacy (ngụy biện chi phí chìm)**
Continuing a course of action because of resources already invested, rather than because of the merits of continuing from today.
*Detection cue*: "we've already invested $X in this," "we've come too far to stop now" used as a reason to continue, rather than a forward-looking cost-benefit case.
*Example*: "We've spent 18 months and $4M building this platform, so pausing now would waste that investment."
*In the audit, write*: point out that the past spend is quoted as a reason to continue rather than the forward-looking cost and benefit of continuing, and ask for the decision reframed without reference to what's already spent.

**Planning fallacy (ngụy biện lập kế hoạch — luôn đánh giá thấp thời gian, chi phí)**
Underestimating the time, cost, or risk of a plan, even when past projects of a similar kind consistently ran over.
*Detection cue*: a timeline or budget with no reference to how the last comparable project actually went; best-case assumptions presented as the default case.
*Example*: "The migration will take 3 months" — for a team whose last two migrations took 7 and 9 months, unmentioned.
*In the audit, write*: ask for the actual outcome of the most recent comparable project, and whether this estimate accounts for the gap between that outcome and its own original plan.

**Optimism bias (thiên kiến lạc quan thái quá)**
A general tendency to expect favorable outcomes more often than base rates justify, independent of any specific planning estimate.
*Detection cue*: risk sections that are shorter and vaguer than the opportunity sections; downside scenarios described in a sentence while upside scenarios get a page.
*Example*: a five-page market opportunity section followed by a single bullet: "Key risk: execution."
*In the audit, write*: point out the imbalance in space and specificity between the upside and downside cases, and ask for the downside case to be developed to the same level of detail.

**Loss aversion framing (đóng khung theo tâm lý sợ mất mát)**
Framing a choice in terms of avoiding a loss rather than achieving a gain, to make an option seem more urgent or necessary than a neutral framing would support.
*Detection cue*: "if we don't act now, we'll lose X," urgency language attached to inaction rather than a clear-eyed comparison of the options' actual expected value.
*Example*: "If we don't move on this acquisition, we risk losing our market position permanently" — with no equivalent framing of what's gained, and at what cost, by moving.
*In the audit, write*: restate the choice in gain-framed terms next to the loss-framed original, and ask whether the recommendation still holds once the framing is neutralized.
