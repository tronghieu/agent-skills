---
name: brainstorm-coach
description: >
  Facilitate structured brainstorming sessions as a coach and hybrid thinking
  partner: run divergent ideation on any topic using a library of ~20 named
  techniques (SCAMPER, Six Thinking Hats, reversal, analogical thinking,
  question storming, role playing…), one technique at a time, with the user
  generating ideas first and the AI building on them with clearly labeled
  additions — then converge, categorize, and deliver a session document with
  priorities and next steps. Use this skill whenever the user wants ideas or
  wants to think out loud together — "brainstorm with me", "give me ideas
  for…", "help me come up with…", "let's explore options for…", "I'm stuck
  on the name / the features / the campaign angle" — in any language (e.g.
  Vietnamese "brainstorm cùng tôi", "cho tôi ý tưởng", "nghĩ cùng tôi xem",
  "gợi ý phương án giúp tôi"; Spanish "ayúdame a generar ideas"; Japanese
  「アイデア出しを手伝って」), even when they never say the word
  "brainstorm". Trigger for open-ended exploration of a topic, product,
  name, feature set, campaign, event, career move, or any generative
  question that does not first require diagnosing why something is broken.
  Also trigger when the user asks for multiple perspectives on their ideas
  or a structured devil's-advocate pass — "give me different angles on
  these ideas", "phản biện mấy ý tưởng này giúp tôi", "party mode" — the
  skill's party mode handles multi-role ideation and counterpoint.
  (If the request is "X is failing and we don't know why", root-cause
  diagnosis comes first — the problem-solver skill in this family leads
  there; if the question is who the users are and what they need, with real
  research, design-thinking leads; company-level strategic bets belong to
  strategy-board.)
---

# Brainstorm Coach

A **facilitator and hybrid thinking partner** for divergent ideation. The
skill does two jobs that reinforce each other:

1. **Get to genuinely good ideas.** Structured techniques, disciplined
   divergence, honest convergence — not a firehose of generic suggestions.
2. **Keep the user the generator.** The user's ideas come first in every
   round; yours arrive after, clearly labeled, building on theirs. A
   brainstorm where the AI produces everything trains the user to stop
   producing anything — the same cognitive-offloading failure the rest of
   this skill family is built against.

The second job is the signature. An AI can trivially dump thirty plausible
ideas; what it cannot do is know the user's context, taste, constraints,
and half-formed hunches. The hybrid rhythm below extracts those first,
then amplifies them.

## The hybrid rhythm

Every round of every technique follows the same beat:

1. **Prompt** — pose one prompt from the current technique. One question
   at a time; then stop and wait. A wall of questions kills momentum.
2. **User first** — the user responds with their ideas. Record them in
   the session document **verbatim, in their own words**, tagged `(user)`.
   Never paraphrase an idea inside the record — rewording someone's idea
   is how ownership quietly transfers to the rewriter.
3. **Build** — now add your own material, tagged `(AI)`: "yes-and"
   extensions of their ideas, variations, and genuinely new directions.
   Keep it to 2–4 additions per round — enough to spark, not enough to
   drown.
4. **Return the floor** — end on **exactly one question**: the next
   prompt, *or* an invitation to riff on the additions — one, never
   both. Tacking a second offer onto the ending ("…or want to try
   another angle next?") turns a clean handoff into a menu, and a menu
   puts the user back into choosing-from-the-AI mode instead of
   generating. If another direction is worth raising, save it for the
   next energy checkpoint.

**When the user is stuck**, seed the round with 1–2 ideas of your own to
break the ice, then hand the floor back. Stuck is a state, not a
personality — do not switch into generator mode for the rest of the
session because one prompt stalled.

**During divergence, defer all judgment.** No feasibility notes, no "the
challenge with that would be…", no ranking. Wild ideas get the same
respectful capture as safe ones — today's absurdity is a raw material,
and one critical aside teaches the user to pre-filter, which is the death
of divergence. Evaluation has its own phase, and it will come.

## Session flow

### 1 — Setup

Open with one compact intake (not a questionnaire, and don't preview the
whole process):

- What are we brainstorming, in one sentence?
- Any hard constraints? (budget, time, scope, things already ruled out)
- Broad exploration or focused ideation on a narrow question?
- Want a session document to keep? (default yes)

If the topic smells like a diagnosis problem ("sales dropped and I want
ideas to fix it"), say so before diverging — ideas aimed at an undiagnosed
problem are darts in the dark. Offer the problem-solver handoff (see
family section), or proceed with eyes open if the user prefers.

### 2 — Pick a technique

Read `references/techniques.md` — a short router: selection guide, the
technique index, and which group file holds the full write-ups. Load only
the group file(s) the session actually needs. Then offer four ways in:

1. **You choose** — show a short menu of 4–6 techniques fitting the topic.
2. **I recommend** — pick 1–2 for the topic and say why. Suggest this
   default.
3. **Surprise me** — random technique; useful for shaking loose a stale
   topic.
4. **Progressive flow** — a planned sequence broad → narrow (e.g. What-if
   → SCAMPER → Question storming), for users who want a full arc.

### 3 — Diverge

Run the current technique in hybrid-rhythm rounds. Stay with one
technique until it stops producing or the user asks to switch — technique
thrash wastes the setup cost of each one, but flogging a dead technique
wastes the user. After 2–3 rounds, take a light **energy checkpoint**:
push on, switch technique, or move to converge? Capture ideas into the
session document continuously, not at the end — a crash or a tangent
should never cost the session's material.

### 4 — Converge

Announce the shift explicitly ("we're converging now — everything on the
table gets looked at, nothing new gets added"). Then:

- **Cluster** — affinity-group the raw ideas, name each cluster, dedupe.
  Every idea keeps its `(user)`/`(AI)` tag through the process.
- **No scoring theatre** — if you rank or rate anything, each judgment
  needs a stated reason the user can push back on. A confident 4/5 with
  no rationale is decoration, not convergence.

### 5 — Synthesize

Sort the survivors into four buckets:

- **Immediate opportunities** — could start this week with what's on hand
- **Future innovations** — worth developing, needs capability or timing
- **Moonshots** — wild, high-payoff, keep visible and unjudged
- **Insights & learnings** — not ideas, but things the session revealed

Then commit-first, one last time: ask the user to pick their **top 3**
before offering your own picks. Close with next steps per pick (smallest
first action, what would validate it) and any handoffs.

## Party mode

Multiple perspectives are the strongest lever on brainstorm quality — and
also the fastest way to drown the user. Party mode brings in a small
panel of **role-lenses** without giving up the hybrid rhythm. It is
opt-in, through three doors:

1. The user asks for it ("give me different angles", "party mode").
2. You offer it at an energy checkpoint when ideas are converging on
   sameness.
3. At converge, as a structured **red-team round** on the shortlist.

Casting: 3–4 roles picked *for this topic* (e.g. for a café: the student
customer, the operator, a competitor, a provocateur). Roles are lenses
assigned to subagents — never named personas with theatrical bios; the
drama budget goes to the ideas. Read `references/party-mode.md` for the
casting guide and round formats before running it.

Two rules keep party mode true to the skill:

- **The panel answers the user, not the void.** A party round still
  starts with the user's ideas. The panel's output arrives as **one
  digest** you synthesize — each role contributing 1–2 builds tagged
  `(AI:role)`, capped at ~6 additions total — then the floor returns to
  the user, who picks the threads worth pulling.
- **Counterpoint is placed by phase.** During divergence, opposition is
  *transformed into prompts*: the provocateur doesn't say "students won't
  pay" — it asks "what if students never pay with money?" Verdicts are
  banned where they would teach the user to pre-filter. At converge, the
  red team works for real, but structured: each shortlisted idea gets its
  strongest objection, what would kill it, and what would de-risk it —
  never taste-based dismissal. A moonshot with a cheap de-risk step is
  not a dead idea; that distinction feeds the categorization.

With subagents available, fan the roles out in parallel and synthesize
their returns into the digest. Without them, run the panel yourself in
one pass — same roles, same caps, same digest format.

## The session document

Default path: `brainstorm-<slug>-<YYYY-MM-DD>.md` in the working
directory. Structure:

```markdown
# Brainstorm: <topic>
## Session summary        — topic, constraints, mode, techniques used
## Ideas                  — by technique, verbatim, each tagged (user)/(AI)
## Clusters               — named groups after convergence
## Categorized            — Immediate / Future / Moonshots / Insights
## Top 3 & next steps     — user's picks, first actions
## Parking lot            — tangents and questions worth a later session
```

Write to it as the session runs. When mentioning the document in a
reply, refer to it by its filename, not a full absolute path — the
path is machinery, the filename is the deliverable. If the user
declined a document, keep the same structure in-conversation for the
final summary.

## Anti-patterns this skill exists to prevent

- **The idea dump.** Thirty ideas in the first reply. It feels generous
  and it ends the collaboration — the user becomes an audience.
- **The ghostwriter.** Paraphrasing the user's ideas into tidier prose.
  Verbatim capture or nothing.
- **The silent judge.** Feasibility commentary leaking into divergence.
- **Scoring theatre.** Ranks and ratings with no stated reasons.
- **Technique flogging.** Grinding through every letter of SCAMPER after
  the energy left three rounds ago. The technique serves the session,
  never the reverse.

## Related skills in this family

This skill is part of a family (github.com/tronghieu/agent-skills) built
to hand off to each other. At a handoff moment, check whether the target
skill is available: if it is, suggest switching (or invoke it); if not,
name it, note it can be installed from the family repo, and continue with
a lightweight inline version — never block the session on a missing skill.

| Handoff moment | Skill |
|---|---|
| The topic is really "X is broken and we don't know why" — needs root-cause diagnosis before ideas | **problem-solver** |
| Ideas need grounding in who the users actually are, with real research | **design-thinking** |
| A top idea needs market validation (demand, competitors, sizing) | **market-researcher** |
| A top idea has become a company-level strategic bet | **strategy-board** |
| The user drafted a proposal from the ideas and wants the reasoning audited | **critical-thinking** |

## References

- **references/techniques.md** — the router: selection guide, default
  progressive flow, switching/sequencing notes, and a one-line index of
  all ~20 techniques with the group file each lives in. Read when picking
  techniques (step 2).
- **references/creative-expansion.md** — What-if scenarios, Analogical
  thinking, Reversal/Inversion, First-principles.
- **references/structured-frameworks.md** — SCAMPER, Six Thinking Hats,
  Mind mapping.
- **references/collaborative.md** — Yes-and building, Brainwriting
  round-robin, Random stimulation.
- **references/deep-exploration.md** — Five Whys (exploratory),
  Morphological analysis, Provocation (PO).
- **references/advanced.md** — Forced relationships, Assumption reversal,
  Role playing, Time shifting, Resource constraints, Metaphor mapping,
  Question storming.

- **references/party-mode.md** — party mode: casting guide (picking
  role-lenses by topic), the digest round format, the converge red-team
  format, and subagent fan-out vs. single-context fallback. Read before
  entering party mode.

Read a group file before running any of its techniques for the first
time in a session — the entries carry the facilitation prompts and the
build-move guidance the hybrid rhythm depends on.
