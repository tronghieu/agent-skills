# Critical Thinking

**Language:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

Audit a memo, proposal, analysis, article, or draft—and become better at judging it yourself instead of handing judgment to AI.

```bash
npx skills add tronghieu/agent-skills --skill critical-thinking
```

## Quick start

Send the complete text or argument when possible and name the decision it should inform. Start with one of these:

```text
/critical-thinking Quick-audit this vendor proposal. We must decide today whether to shortlist them; show the three issues most likely to change that decision.
```

```text
/critical-thinking Deep-audit this investment memo. Map the load-bearing claims, test its warrants and source credibility, and tell me what evidence would falsify the recommendation.
```

```text
/critical-thinking Review my board draft. Preserve what holds, give a concrete repair for every important gap, and steelman the strongest objection before it reaches a skeptical reader.
```

```text
/critical-thinking I have completed eight audits. Give me a progress review: recurring miss-types, confidence calibration, commit-skip rate, and one thing to watch next.
```

## Why not just ask a chatbot?

A general chatbot can produce a plausible critique. This skill makes the critique inspectable and useful for learning:

- It anchors each finding to an exact quotation and location, so you can check the audit rather than accept its tone.
- It separates a broken inference from an unverified fact, an unstated assumption, and an honest disagreement.
- It focuses on the few claims that carry the conclusion, then ranks issues by their impact on the decision.
- It asks for your read first by default, so the audit becomes a comparison and a practice rep—not a substitute for your judgment.

You remain responsible for the decision. The skill is a structured, adversarial check on the reasoning presented to you.

## Who it is for

Use this skill when you need to decide what a document actually establishes, what it only assumes, and what to verify before acting. It is for decision-makers, analysts, consultants, reviewers, founders, and writers working with an investment memo, vendor proposal, board paper, strategy note, opinion piece, or their own draft.

## The mental model: prose is not an argument

The audit reconstructs the reasoning underneath the document rather than summarizing its sections.

1. **Name the ask.** It distinguishes the decision being requested (for example, “approve the budget”) from the belief claim meant to justify it (for example, “this market will grow 30%”).
2. **Find the load-bearing claims.** It identifies the roughly 3–7 claims whose failure would collapse the conclusion, and anchors each to the source text.
3. **Expose the bridge.** For each claim, a Toulmin map records the grounds (evidence), warrant (why that evidence should support the claim), qualifier (how strongly it is stated), and rebuttal handling. The often-hidden warrant is where many polished arguments break.
4. **Try to falsify it.** The audit surfaces silent assumptions, tests source credibility and alternatives, scans for a clearly anchored fallacy or bias only after mapping the argument, and asks what observable evidence would prove the conclusion wrong.

Every finding has one honest label:

| Label | Meaning |
| --- | --- |
| `[GAP]` / `[LEAP]` | Missing evidence / evidence that does not support the inference |
| `[ASSUME]` / `[CONFLICT]` | A load-bearing unstated premise / statements that cannot both hold |
| `[FALLACY]` | A named, quote-anchored reasoning pattern—not merely a claim the auditor dislikes |
| `[OPINION]` / `[CANNOT-ASSESS]` | Honest disagreement / a claim requiring outside expertise or data |

Deep audits also review clarity, accuracy, precision, relevance, depth, breadth, logic, significance, fairness, and source credibility. They do not average those dimensions into a comforting score: a clear document whose conclusion does not follow is still a weak argument.

## How an audit works

1. **Send the document and stake.** State the decision it should inform and mention missing attachments, a deadline, or the risk that matters most.
2. **Choose the depth.** Use a quick audit for triage, a deep audit for a consequential decision, or a draft review to strengthen your own writing.
3. **Commit first (normally).** Before seeing the audit, give your view: Does the argument hold? How confident are you? What is weakest? Deep audits also ask for a hidden assumption. You can say `skip` when time is critical.
4. **Receive the audit.** The report leads with an actionable verdict, then gives an argument map and severity-ranked findings with exact quotations. It explains what was not examined rather than implying completeness.
5. **Compare and learn.** If you committed first, the report identifies what you caught, missed, or suspected without support, then compares your confidence with the result. With repeat use, an optional reasoning profile records evidence-backed patterns and calibration—not personality judgments.

## Choose a mode

| Mode | Use it when | You receive |
| --- | --- | --- |
| **Quick audit** | A short document, low stakes, or limited time | Verdict, reasoning skeleton, and the three issues most likely to change the decision |
| **Deep audit** | The decision or document is load-bearing | Full argument map, assumptions, credibility and fallacy checks, falsifiability tests, and questions for the author |
| **Draft review** | The document is yours | What already holds, repairs for key flaws, the strongest hostile objection, and missing stage-gates or go/no-go criteria |
| **Progress review** | You have used the skill repeatedly | Audit mix, recurring miss-types, confidence calibration, and one focused next practice target |

## What comes back

Expect a verdict first, followed by an argument map and numbered findings ordered by severity, not document order. A deep audit may also include an assumptions register, falsifiability assessment, an explicitly separate “honest corner” for `[OPINION]` and `[CANNOT-ASSESS]`, and questions to return to the author. Draft review adds repair paths and decision structure; progress review describes only patterns supported by the record.

## Useful companions

- Use [Market Researcher](../market-researcher/README.md) when the audit labels a market size, competitor fact, or other external claim `[CANNOT-ASSESS]`; establish the facts, then re-audit the reasoning that depends on them.
- Use [Strategy Board](../strategy-board/README.md) when a document audit reveals a company-level strategic bet that needs multiple executive perspectives and a full recommendation.
- Use [Design Thinking](../design-thinking/README.md) when a proposal says “users want X”; this skill tests the argument offered, while Design Thinking investigates what users actually need.
- Use [Socratic Questor](../socratic-questor/README.md) when the goal becomes learning a topic through guided dialogue rather than testing one specific argument.

## Limits

This is an audit of the reasoning available in the document, not a guarantee that every specialist fact is true. Missing data or expertise is marked for verification rather than guessed. Quote anchors make the work checkable, not infallible; consequential legal, medical, financial, technical, or regulatory decisions still need appropriate domain review.
