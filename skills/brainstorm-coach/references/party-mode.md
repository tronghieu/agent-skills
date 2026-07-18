# Party mode

Party mode brings a small panel of role-lenses into the hybrid rhythm —
not to replace the user's ideas, but to build on them from angles one
mind, human or AI, tends to miss. It answers a real limit of solo
brainstorming: a lone facilitator either speaks in one voice for
everyone, or stays quiet and leaves gaps nobody names. The panel is a
deliberate, capped way to fill those gaps.

It fails two ways if run carelessly. **Drowning the user** — four roles
each producing their own stream of ideas turns one round into a wall of
text nobody can absorb; every format below caps output and forces
synthesis into one digest for this reason. **Counterpoint during
divergence teaching self-censorship** — a panel is a natural home for a
skeptical voice, and if that voice delivers verdicts while ideas are
still forming, the user learns to stop offering anything it might shoot
down. Both come from the same root: treating the panel as independent
broadcasters instead of one facilitated instrument.

## Casting guide

Casting is choosing 3–4 role-lenses *for this topic*, not picking from a
fixed roster. A lens is a single vantage point on the problem — who
experiences it, who has to deliver it, who's never seen it before, who's
willing to question it. Fill these four slots, in order — and hold the
**total at 3–4 roles**, because the cap is what keeps the digest small
enough for the user to actually answer. Count before you cast: a fifth
lens always feels justified in the moment and always costs more than it
adds.

**(a) 1–2 stakeholder lenses.** The person who buys, uses, or lives with
the outcome. Pull this from the topic itself, not from a generic "the
user" — a café's stakeholder is the specific customer segment that walks
in the door (the student who nurses one coffee for four hours is a
different lens than the commuter grabbing something to go). Use two
stakeholder slots when the topic visibly has two different people living
with the outcome (a borrower and a lender, an employee and their manager)
— and when you do, **drop one of the other slots** (usually the outsider,
or fold its instinct into the provocateur) so the total stays at four;
use one stakeholder when the topic doesn't demand two.

**(b) One operator/realist lens.** Whoever has to build, run, staff, or
maintain what the session is imagining — the barista during the rush, the
engineer who owns the on-call rotation, the person who has to actually
execute the plan. This lens exists to keep ideas tethered to something
that can exist, without turning into the silent judge divergence already
bans — more on that below.

**(c) One outsider lens.** Someone who has never seen this problem before:
a competitor, a business or product from an unrelated industry facing a
structurally similar problem, or a total newcomer encountering the topic
cold. The value of this slot is specifically *not* knowing the topic's
unstated assumptions — a boutique hotel lobby that also serves coffee
sees a café's problem differently than another café would.

**(d) The provocateur.** An assumption-flipper in the spirit of
Provocation (PO, see `deep-exploration.md`) — its job is to invert
whatever the rest of the cast is currently taking for granted. This slot
is almost always worth filling; it's the one role not grounded in a real
person's perspective, and it's where the counterpoint rule below does its
work.

| Topic | Stakeholder(s) | Operator/realist | Outsider | Provocateur |
|---|---|---|---|---|
| Café revenue | the student customer — cheap, social, studies here 4 hours on one coffee | the barista/manager running the counter during the lunch rush | a boutique hotel lobby that also sells coffee | "what if the café made zero money from coffee itself?" |
| Internal HR tool | the employee filing a request — wants speed, no jargon | the HR ops person who processes requests by hand today | a video game's character-creation onboarding flow | "what if there were no tool, only a person you talk to?" |
| Personal career change | the self two years into the new role, living with the daily reality of it | today's self, who has to execute the transition — savings, timeline, logistics | someone who made a structurally similar leap in an unrelated field | "what if you could never quit — only add?" |

**Lenses, not personas.** A role is one line of brief — "you are the
student customer: cheap, social, studies here four hours on one coffee"
— not a name, a backstory, or a personality. This is a deliberate choice,
not a shortcut: the drama budget in this skill goes to the ideas, and the
family convention this skill shares with `design-thinking` is
lens-subagents doing focused work, not BMAD-style theatrical personas
performing a character. A role brief that starts growing a name and a
biography is a sign to trim it back to the one line that actually does
the work — what this lens sees that the others don't.

Cap the cast at four. A fifth or sixth lens rarely adds proportional
signal; it adds proportional digest bloat, which is exactly the first
failure mode this reference opened with.

## The party round (diverge phase)

The party round is the hybrid rhythm run through a cast instead of one
AI voice, with an extra synthesis step so the cast never reaches the
user directly. The beat:

1. **Facilitator poses the prompt** — same as a solo round, one question,
   then wait.
2. **User contributes first** — unchanged from the hybrid rhythm; the
   panel builds on what the user brings, never gets there ahead of them.
3. **Each role produces 1–2 builds** — extensions of the user's ideas or
   the prompt itself, from that role's specific vantage point.
4. **Facilitator synthesizes one digest** — every item tagged
   `(AI:role-slug)`, capped at roughly six items total across the whole
   cast, with overlapping ideas from different roles merged rather than
   listed twice.
5. **Floor returns to the user** with one question — not a recap of all
   six items followed by "thoughts?", but a direct pull: "which thread do
   you want to pull?"

**The counterpoint rule.** During diverge, the provocateur — and any
other role whose instinct is critical — has its output transformed into
a generative prompt before it reaches the digest. The provocateur doesn't
say "students won't pay for that"; it asks "what if students never paid
with money at all?" The operator/realist doesn't say "that's not
feasible"; it asks "what would make that cheap enough to try this week?"
Verdicts — "won't work," "not feasible," "too expensive" — are banned
from this phase for every role, not just the provocateur. The reason is
the same one the main skill gives for banning judgment during divergence
generally: a verdict that lands mid-round doesn't just kill one idea, it
teaches the user which categories of idea are safe to offer next time,
and pre-filtering is the death of divergence. Real objections aren't
lost — they're the entire subject of the red-team round below.

**Worked example** — topic: a community tool-lending library. Cast (4 —
two stakeholders, so the outsider slot is dropped and its
break-the-frame instinct folds into the provocateur): the borrower
(stakeholder), the lender (stakeholder), the volunteer coordinator
(operator), and the provocateur.

- Prompt: "What could make people actually try borrowing before buying?"
- *(user)*: "A trial partnership with the local hardware store — borrow
  the exact drill you'd otherwise buy for a weekend, and if you decide to
  buy it, the rental fee counts toward the price."
- *(user)*: "A loyalty card — after 10 borrows, pick a free tool from the
  library's surplus stock."
- Digest:
  - *(AI:borrower)* Extend the trial-credit idea online too — buy through
    an affiliate link after the trial, and the library gets a small cut
    instead of the hardware store.
  - *(AI:lender)* Pair the loyalty card with a "condition streak" — tools
    returned in good shape count double toward the 10, nudging behavior
    the library actually wants.
  - *(AI:coordinator)* Turn the trial partnership into a standing monthly
    slot with one store, rather than a one-off — same tool category,
    same weekend, so it's schedulable instead of ad hoc.
  - *(AI:provocateur)* Borrow a loot-box framing from games — the "free
    tool from surplus" pick is randomized within a category the borrower
    chooses, which makes surplus stock feel like a discovery mechanic
    instead of leftovers. (The dropped outsider slot's instinct, carried
    by the provocateur.)
  - *(AI:provocateur)* What if nobody ever bought a tool at all — what
    would the library need to offer so borrowing beat owning outright,
    not just undercut it on price?
- Return the floor: "Which of these five threads do you want to pull on
  — or is there a sixth angle none of us hit?"

## The red-team round (converge phase)

Where the party round defers judgment, the red-team round is where
judgment happens — deliberately, structurally, and after clustering but
before the survivors get sorted into Immediate / Future / Moonshots. It
runs the shortlist, not the raw idea pile, through a fixed three-field
pass per idea:

- **Strongest objection** — steelmanned, delivered by whichever role in
  the cast is closest to the risk (the operator on feasibility, the
  stakeholder on desirability, the outsider on "someone already tried
  this and here's what broke").
- **What would kill it** — the falsifier: one concrete fact that, if
  true, ends the idea. Not a vague worry — a specific, checkable
  condition.
- **What would de-risk it** — the cheapest test or change that answers
  the objection, short of abandoning the idea.

The rule that keeps this from turning into the silent-judge problem in a
different phase: no taste-based dismissal. An objection has to be
answered with a falsifier and a de-risk step, not a shrug. An idea with a
scary objection but a cheap de-risk stays alive — that distinction is
exactly what feeds the Immediate/Future/Moonshots split next: cheap
de-risk and low cost of being wrong points toward Immediate; a real
falsifier that needs real time to check points toward Future; a
falsifier that can only be resolved by actually building the thing
points toward Moonshot, not toward being cut.

**Worked example** — same tool-lending library, two shortlisted ideas.

*Trial-credit partnership with the hardware store*
- Strongest objection *(operator)*: hardware stores have no commercial
  incentive to legitimize borrowing over buying — it can look like
  helping a customer skip their own sale.
- What would kill it: if store margins already assume returns/trials
  customers can exploit without the library's involvement, the
  partnership adds nothing a customer couldn't already get.
- What would de-risk it: a one-month pilot with a single store and a
  single tool category (power drills only) before drafting any formal
  agreement.

*Loyalty card — 10 borrows for a free surplus tool*
- Strongest objection *(lender)*: rewarding borrow count over care
  incentivizes churning low-value items just to hit 10, straining a
  surplus stock room that isn't infinite.
- What would kill it: if surplus stock is already near zero, there's
  nothing to pay the reward out with.
- What would de-risk it: run it with 20 members for one quarter, capped
  to a small rotating drawer of surplus items, before a full rollout.

The red-team round isn't exclusive to party sessions — a solo session
can run the same three-field pass as a lightweight converge option, with
the facilitator playing all three fields itself instead of assigning them
across a cast.

## Execution

**With subagents.** Fan out one agent per role, in parallel. Each agent
gets: the topic and its constraints, the current idea list (or the
shortlisted subset for a red-team round), its one-line role brief, and a
narrow instruction — return 1–2 builds for a diverge round, or the
objection/kill/de-risk fields for its assigned ideas in a red-team round.
The facilitator is the only place synthesis happens: it collects the
returns, dedupes overlapping builds across roles, and writes the single
digest the user sees. Roles never talk to each other directly and never
address the user directly — every path runs through the facilitator.

**Without subagents.** Run the same panel in one context, in sequence —
same roles, same caps, same digest format, just no parallel fan-out.
Either way, never simulate dialogue between roles: no back-and-forth
transcript of "the operator says... the outsider responds..." — that's
theater, and the drama budget rule from casting applies here too. The
output is a digest, not a scene.

**Cost.** Party mode runs more model calls than a solo round — a cast of
four plus a synthesis pass costs meaningfully more than one voice
building 2–4 additions. That's the reason it stays opt-in through the
three doors the main skill lists (user request, facilitator offer at an
energy checkpoint, or the converge red-team option), rather than the
default mode for every session.
