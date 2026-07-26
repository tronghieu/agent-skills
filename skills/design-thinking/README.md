# Design Thinking

**Language:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

Turn real user evidence into a focused problem, a portfolio of concepts, and falsifiable tests—without inventing personas, quotes, or research findings.

```bash
npx skills add tronghieu/agent-skills --skill design-thinking
```

## Quick examples

```text
/design-thinking Users leave our learning app after the first week. Help me frame the problem and create a non-leading interview plan for adult learners.

/design-thinking I have eight interview transcripts about small retailers accepting digital payments. Synthesize them into evidence-backed insights, personas only if the segments are real, and HMW questions.

/design-thinking We already have a clickable checkout prototype. Map its riskiest assumptions and design a usability test with pre-registered pass/fail criteria.
```

## Why use it instead of an ordinary chatbot conversation?

An ordinary chat can quickly produce plausible ideas—and equally plausible fictional “user insights.” This skill adds a disciplined process:

- Every evidence source receives an `[S#]`; every insight `[I#]` traces back to those sources.
- Unsupported claims stay visibly labelled as hypotheses; personas never receive invented details for color.
- A persistent project record preserves decisions, open questions, and loop-backs across sessions.
- Explicit gates prevent the process from drifting forward before evidence or a user decision is ready.
- Independent ideation lenses reduce anchoring; adversarial audits challenge attractive but weak conclusions.
- Tests are designed to falsify the riskiest assumption, with criteria fixed before results are seen.

## What this skill is and who it is for

Design Thinking is a human-centered, iterative method for learning what people actually need before committing to a solution. This skill facilitates the full **Empathize → Define → Ideate → Prototype → Test** loop. It can also help with one phase only, such as writing an interview guide or testing an existing prototype.

It is designed for product managers, UX researchers, designers, service teams, founders, and innovation groups. You need access to real users or real evidence such as interview notes, transcripts, support tickets, surveys, analytics, or test results.

## The method

| Phase | What happens | Gate or hand-off |
| --- | --- | --- |
| **Kickoff** | Frame the problem, target users, scope, constraints, and current evidence. | You confirm the frame. |
| **Empathize** | Design research questions, recruiting criteria, interview/observation guides, and unbiased prompts based on past behavior. | The skill pauses while you conduct the research and return real data. |
| **Define** | Extract observations, affinity-map tensions, form evidence-linked insights, and create personas only when the data supports meaningful segments. Turn these into POV statements and How Might We (HMW) questions. | An insight audit checks sources, quotes, assumptions, alternatives, and persona details; you choose 3–5 HMWs. |
| **Ideate** | Diverge without judging, then converge separately. Independent lenses—such as first principles, analogous domains, SCAMPER, extreme users, inversion, and technology-led—produce varied ideas. The shortlist is discussed using desirability, feasibility, and viability. | You choose 1–3 concepts and expose their open assumptions. |
| **Prototype** | Build the lowest-fidelity artifact that can answer one named question: storyboard, wireframe, concierge/Wizard-of-Oz flow, fake door, or functional slice. The spec states what is real, what is faked, and which behaviors to watch. | The prototype is ready only when it can support a measurable test. |
| **Test** | Map assumptions, select the highest-impact and least-certain one, then pre-register a test card with participants, procedure, metric, and pass/fail threshold. | An assumption audit runs before you conduct the test; results produce a learning card. |

The result is not always “continue.” Evidence leads to one of four explicit decisions: **persevere**, **iterate** on the prototype, **pivot** back to the problem framing, or **stop**. Each loop records its round and reason.

## How the facilitation feels

The skill speaks through **Helm**, the lead facilitator that holds project state, guides decisions, and changes working lens as needed:

- **Lens** designs user research; **Radar** adds market and feasibility context.
- **Loom** synthesizes evidence into insights, personas, POVs, and HMWs.
- **Prism** runs ideation through several independent perspectives.
- **Forge** specifies learning-focused prototypes; **Probe** designs falsifiable tests.
- **Judge** independently audits insights and assumptions at the two critical gates.

These are functional perspectives, not characters you must manage. Helm tells you which mode is active, shows the artifact, and pauses at decisions. During Ideate, several Prism lenses can contribute independently before their ideas are compared; Judge can also review independently rather than rubber-stamping the same reasoning.

Expect real pauses: the skill designs research and tests, but **you or your team conduct them**. A rehearsal interview may be role-played to improve the guide, but it is always labelled as simulation and never treated as evidence. When you return later, the skill resumes from the recorded phase instead of restarting.

## What to provide

Start with whatever you have:

- The problem or decision, target users, scope, constraints, and what success means.
- Existing raw evidence, with enough source context to register it honestly.
- Access to people who can be interviewed or can try a prototype.
- An existing concept or prototype if you want to enter directly at Prototype or Test.

If you have no primary research yet, you can deliberately proceed in hypothesis-only mode. In that case, insights remain hypotheses, personas are clearly marked **proto-personas**, and Test becomes the first point where reality can validate or reject them.

## What you receive

Depending on where you start: a research plan and discussion guide; a source register; evidence-linked insights and personas; POV and HMW questions; a scored idea portfolio; prototype briefs; an assumption map; pre-registered test cards; learning cards; and a decision journal that supports multi-session work.

## Recommended complementary skills

These recommendations are helpful companions, not prerequisites:

- [`market-researcher`](../market-researcher/README.md) for market sizing, competitor deep dives, trends, or broader demand signals. Its desk research can provide cited context, but it does not replace primary user research.
- [`product-manager`](../product-manager/README.md) after user needs and concepts are clearer, when you need product prioritization, specifications, roadmap choices, metrics, or launch planning.

## Important boundaries

Desk research cannot establish what *your* users think or will buy. The skill never invents interview data or silently upgrades assumptions into facts. It cannot recruit participants or conduct real-world sessions on your behalf, and its tests inform—not replace—your judgment, ethics, and domain expertise. For a fake-door or commitment test, do not take money you cannot fulfil or refund honestly.

Detailed phase methods and evidence schemas are available in [`references/`](./references/).
