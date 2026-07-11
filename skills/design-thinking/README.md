# Design Thinking Skill

**Language / Ngôn ngữ / 语言:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

This skill turns your AI agent into a friendly, disciplined **design-thinking facilitator and thinking partner** — it walks you through Empathize → Define → Ideate → Prototype → Test as a project that can span many sessions, and it's careful never to make up what your users think.

## What Is the Design Thinking Skill?

Ask a generic chatbot to "understand your users" and it will happily invent a persona, write a convincing quote, or even sketch out a "test result" — all fluent, all confident, and hard to tell apart from real research just by reading it. This skill is built to gently guard against exactly that. It helps you design the research instruments — interview guides, observation plans, experiments with clear pass/fail criteria — you go out and collect the real data, and the skill synthesizes it carefully: every insight `[I#]` (a small reference tag that points back to the exact interview or document it came from) traces back to a piece of registered evidence `[S#]` in `research/sources.md`. Anything not backed by real data yet is clearly marked `(hypothesis — needs validation)` instead of being presented as fact.

This skill isn't meant to do design thinking *for* you — you're the one who interviews users, runs the usability tests, and owns every real-world conversation. In return, the skill takes care of the discipline: staying organized, tracking evidence, and giving you a workspace that carries over across sessions and loops back on itself the way real design-thinking projects naturally do.

Many general-purpose AI tools tend to make up personas and quotes without really meaning to — it's just what happens when a model is asked to sound helpful without any real data to draw on. This skill is careful never to do that: anything that isn't grounded in your real data stays clearly marked as a guess worth checking, never dressed up as a finding.

## Why Use It?

- **Every insight comes with its evidence attached.** Any claim about what users think, feel, or do carries an `[I#]`/`[S#]` tag or is clearly labelled a hypothesis, so you can always see where it came from.
- **You run the real world, the skill runs the rigor.** It won't simulate an interview or guess at "what users would probably say." Practice interviews are welcome to role-play — they're just labelled as practice, never counted as real evidence.
- **Desk research adds context, it doesn't replace real users.** Secondary sources help ground the picture and scan existing solutions; they can point to a signal worth checking, but they won't stand in for a "users feel X" insight on their own.
- **A second look happens at every gate.** Before Define wraps up and before Test begins, an independent, evidence-first review checks the work — and whatever it finds is shared openly rather than quietly patched over.
- **Going back a step is normal, and it's logged.** If a test doesn't pan out, the project may return to Define or Ideate; every round and its reason are written into `phase-state.md` instead of being smoothed over.

## Five Promises the Skill Keeps

1. **No made-up user insight** — every insight `[I#]` traces back to evidence `[S#]` you actually collected; anything else is labelled `(hypothesis — needs validation)` rather than asserted as fact.
2. **The skill designs the research, you run it** — discussion guides, interview questions, and experiment designs come from the skill, then it waits for your real data. No simulated interviews, no invented quotes.
3. **Desk research supports, it doesn't substitute** — secondary sources add context and signals, always cited `[S#]`, but never stand in for hearing from real users.
4. **A fresh set of eyes checks in at every phase gate** — an insight review at the end of Define, an assumption review before Test, both careful and evidence-first.
5. **The process is meant to loop** — when an assumption doesn't hold up, the project happily goes back to Define or Ideate on purpose, and every loop is logged with its round number and reason.

## The Team of Lenses

You work with **Helm** by default, who takes on one functional lens at a time — not named personas, no menu to pick from.

| Lens | Phase | What it does |
|------|-------|--------------|
| **Helm** (default) | Throughout | Holds phase state, switches lenses, runs gates, talks with you, keeps the journal |
| **Lens** | Empathize | Research plan, discussion guides, interview questions, observation plans — then waits for data |
| **Radar** | Empathize → Prototype | Market context, existing-solution scans, feasibility checks |
| **Loom** | Define | Affinity mapping, insights `[I#]`, hypothesis personas, POV statements, HMW questions |
| **Prism** | Ideate | Parallel idea generation, one lens per subagent — the one place fanning out genuinely pays off |
| **Forge** | Prototype | Storyboards, paper-prototype specs, prototype briefs, each built to answer a question |
| **Probe** | Test | Assumption map, riskiest-assumption pick, test cards with pass/fail criteria |
| **Judge** | Phase gates | Insight review and assumption review — runs independently when subagents are available, to keep the review honest |

Only Ideate fans out into parallel subagents (one per Prism lens); Judge runs as its own independent pass at the gates. Everything else is sequential lens-switching in the main conversation — Helm belongs in the room with you.

## The Phase Loop

```
0 Kickoff    → Helm              → project.md              ⛔ user confirms the frame
1 Empathize  → Lens              → research plan, guides   ⏸ waits for user data → research/
2 Define     → Loom              → insights, personas, hmw ⛔ Judge insight review + user picks HMWs
3 Ideate     → Prism (fan-out)   → ideas.md                ⛔ user picks concept(s)
4 Prototype  → Forge             → prototypes/*
5 Test       → Probe             → tests/*                 ⛔ Judge assumption review → ⏸ user runs test
↺ Loop       → Helm              → journal, phase-state    (record round + reason, re-enter the right phase)
```

⛔ marks a gate: the skill pauses, shows you the artifact, and waits for your decision. ⏸ marks the point where the skill has done its part and real-world data collection is in your hands — it says exactly what it's waiting for and offers useful parallel work (usually desk research) in the meantime.

**Entering mid-process is completely normal.** Arrive with a stack of interview notes and the skill starts at Define; arrive with a prototype and it starts at Test. Kickoff runs lightly — confirm the frame, set up the workspace, register what you brought as sources — then it jumps to the right phase.

**No primary data yet? That's okay too.** You can enter Define on desk research and declared assumptions alone, once the skill has said the trade-off out loud. Every persona built that way is an explicit **proto-persona**, every insight a hypothesis, and Test is where reality gets its first vote.

## The Workspace It Produces

```text
<project-dir>/
  project.md        # the brief: problem space, target users, scope, constraints
  phase-state.md    # current round + phase, gate status, what's waiting on the user
  journal.md        # per-session decision log — the re-entry backbone
  research/
    sources.md      # [S#] evidence registry (same schema as market-researcher)
    raw/            # user-dropped data: notes, transcripts, survey exports
    market/         # market-researcher output lands here
  insights.md       # [I#] insights, each tracing to [S#] evidence
  personas.md       # personas — honestly labelled by evidence strength
  hmw.md            # POV statements and How-Might-We questions
  ideas.md          # the scored idea portfolio
  prototypes/       # one spec per prototype
  tests/            # assumption map, test cards, results, learning cards
```

**Re-entry, made easy.** When the project directory already exists, the skill reads `phase-state.md` and `journal.md` first and reflects the state back to you before doing anything else — "Last session ended in Define, round 2; the insight review flagged I4 as unsupported; we're waiting on your three remaining interviews." It trusts the files, not memory, and it won't quietly redo or overwrite work you've already completed.

## Works With the Market-Researcher Skill

Design thinking needs market context at several points — grounding Empathize and Define, scanning existing solutions before Ideate, checking feasibility before Prototype. For anything beyond a handful of quick searches (market sizing, competitor deep dives, demand-signal mining), this skill uses **[market-researcher](../market-researcher/)** as its research engine, if it's installed: it invokes it per the composition contract, pointing it at `<project-dir>/research/market/`, and market-researcher appends to `research/sources.md` **continuing the existing `[S#]` numbering** — so insights and ideas cite its sources directly.

If market-researcher isn't installed, this skill mentions it once — install from https://github.com/tronghieu/agent-skills#market-researcher (`npx skills add tronghieu/agent-skills --skill market-researcher`) — and fully respects a "no": it proceeds with light inline desk research instead, every claim cited under the same `[S#]` schema, just without a full sizing or competitor deep dive. It's an optional companion, never a prerequisite.

## How to Trigger

Ask your AI agent tasks like:

```text
Our users are churning and we don't know why — help us figure out what's going on.
```

```text
Here are 12 interview transcripts from our onboarding research — synthesize them into insights and personas.
```

```text
We picked a concept — design an experiment to test whether people will actually pay for it.
```

```text
Chúng tôi muốn hiểu vì sao khách hàng bỏ giỏ hàng — bắt đầu một dự án tư duy thiết kế giúp tôi.
```

```text
先週インタビューした5人分のメモがあります。インサイトとペルソナにまとめてください。
```

The skill also triggers on `status` inside an existing project directory to pick up right where things left off — no need to say "design thinking" by name.

## Installation

### 1. Using CLI (Recommended)

```bash
npx skills add tronghieu/agent-skills --skill design-thinking
```

### 2. Manual Installation (For Non-Technical Users)

1. **Download:** Go to the `skills/` folder in this repository and download `design-thinking.zip`.
2. **Extract & Copy:** Extract `design-thinking.zip` and copy the `design-thinking` folder into one of the following directories:

**For a Specific Project:**
Copy the `design-thinking` folder to `.agents/skills/` or `.claude/skills/` in your project's root directory.

**Globally (Available for all projects):**
* **Mac / Linux:** `~/.agents/skills/` or `~/.claude/skills/`
* **Windows:** `%USERPROFILE%\.agents\skills\` or `%USERPROFILE%\.claude\skills\` (usually `C:\Users\<YourUsername>`)

## Example Usage

> **You:** Our users are churning after the first week and we don't know why. Can you help us understand what's going on?
>
> **Agent:** I'll run this as a design-thinking project, starting in Empathize. Quick frame check: is "churning" cancellations, or just going quiet without cancelling — and do you already have any user contact (interview access, support tickets, analytics), or are we starting from zero?
>
> *(confirms the frame, sets up the project workspace, drafts a research plan and a semi-structured discussion guide targeting the first-week drop-off, registers your support-ticket export as `[S1]`–`[S6]` in `research/sources.md`)*
>
> **Agent:** Research plan and discussion guide are ready in `research/`. I've pulled three early signals from the support tickets you already have [S2][S4] — but those are desk signals, not validated insight yet, so I've labelled them hypotheses. I'm not going to guess at what your users would say in an interview. Once you run 5–6 of these conversations and drop the notes into `research/raw/`, I'll synthesize real insights and we move into Define.
