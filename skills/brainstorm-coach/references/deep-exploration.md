# Group 4 — Deep exploration

Three techniques that go down instead of out — chasing the real
motivation under a stated want, mapping a topic's independent dimensions
before combining them, or mining a deliberately absurd statement for the
one useful movement inside it. Reach for this group when the topic
needs depth rather than more breadth, or when a session feels like it's
generating ideas without ever touching what actually matters. The
examples below use one running generic topic — a community tool-lending
library (a place where neighbors borrow tools instead of buying them) —
so the same idea can be seen through several techniques.

## 11. Five Whys (exploratory)

**What it is** — Asking "why" repeatedly, one round per why, to chase
the deeper need or motivation behind a stated want. This is the
*discovery* flavor of Five Whys, used to find what the user or the
user's audience actually wants — not to diagnose why something broke.
Root-cause Five Whys, aimed at "why did X fail," belongs to the
problem-solver skill; this version is about wants, not faults, and
should never turn into a hunt for who's to blame.

**Best for** — Topics where the stated goal might be one layer above the
real motivation — naming a feature when the actual want is something
more basic, like trust, belonging, or independence.

**Facilitate it** — Start from the stated want: "Why does a tool library
matter to you — what's it actually for?" Take the answer and ask why
again, one why per round, following the user's own answer rather than a
fixed script. Stop once an answer feels like a genuine motivation rather
than another intermediate reason — usually three to five whys in.

**Example round**
- Prompt: "Why does a tool library matter to you — what's it for?"
- *(user)*: "So people don't have to buy a $200 drill they'll use twice
  a year."
- *(AI)*: "Why does that matter — what's underneath not wanting to buy
  a rarely-used drill?"
- *(user)*: "Money, but also — I hate owning stuff I don't need. Clutter
  stresses me out."
- *(AI)*: "Why does the clutter stress specifically matter here — what's
  underneath wanting less stuff?"
- *(user)*: "I think... I want to feel like I have what I need without
  being weighed down by it. Like security without ownership."
- *(AI) builds*:
  - *(AI) Name the need in plain language*: the tool library isn't
    really selling tool access — it's selling "capability on demand
    without accumulation."
  - *(AI) One idea that serves that need directly*: a members' page
    showing "what you have access to" (everything in the library) rather
    than "what you've borrowed" — reframing the whole relationship
    around abundance, not transaction.
- Return the floor: "Does 'security without ownership' feel like the
  real thing this is about — should we build ideas from there?"

**Your build move** — Name the underlying need in plain language once
it surfaces, and offer one idea that serves that need directly — often
a simpler, more direct idea than anything generated before the whys
started.

**Where it goes wrong** — In a group or even solo, this technique can
slide from "why do I want this" into "whose fault is it that we don't
have this yet" — a blame hunt instead of a motivation hunt. If the
answers start pointing at people instead of needs, redirect explicitly:
"let's stay on the want, not on who's responsible for it not existing."

**Bail when** — An answer stops changing shape after two whys (the third
"why" just restates the second answer in different words); that's
bedrock — stop digging and build from what surfaced rather than forcing
a fourth or fifth why that won't add anything.

## 12. Morphological analysis

**What it is** — Breaking the topic into its independent parameters or
dimensions first, then systematically exploring combinations across
them, rather than brainstorming whole ideas at once. Listing the
dimensions before combining them catches combinations free-form
ideation would never stumble into on its own.

**Best for** — Topics with several genuinely independent variables —
useful when constraints feel *absent* and the space needs structure
rather than more openness.

**Facilitate it** — Ask the user to name the dimensions first: "What
are the three or four independent parameters of the tool library — the
things that could each vary on their own?" Once dimensions exist (say,
location, membership model, and tool category), explore combinations
round by round: pick one value from each dimension and ask what that
specific combination looks like.

**Example round**
- Prompt: "What are the independent dimensions of a tool library — the
  things that could each vary separately?"
- *(user)*: "Location (fixed site vs. mobile vs. lockers), membership
  model (fee, free, deposit-based), and tool category (general
  household vs. specialty/contractor-grade)."
- *(AI) builds*:
  - *(AI) Propose an unexplored combination*: mobile + deposit-based +
    specialty tools — a trailer that only carries expensive
    contractor-grade equipment, funded by refundable deposits instead of
    fees, since that's the tier most worth the logistics of a truck.
  - *(AI) Propose a second unexplored combination*: lockers + free +
    general household — a no-cost, unstaffed locker wall with the ten
    most commonly needed basic tools, funded by a sponsor rather than
    members at all.
  - *(AI) Flag a combination worth ruling out*: fixed site + free +
    specialty — free access to expensive equipment with no deposit is
    the highest-risk cell in the matrix and probably isn't viable as-is.
- Return the floor: "Which cell in that matrix is worth developing
  further?"

**Your build move** — Propose a combination that crosses dimensions the
user hasn't paired yet — the point of the matrix is the unexplored
cells, so a good build should point at one, not restate a cell the user
already named.

**Where it goes wrong** — The dimensions the user names aren't actually
independent — "cheap" and "free" end up as two values on what's really
the same dimension, which makes the matrix redundant instead of
generative. Check each proposed dimension by asking "could this vary
without changing the others?" before locking it in.

**Bail when** — The matrix has more than four dimensions or the
combinations start feeling arbitrary rather than illuminating; trim back
to the two or three dimensions that matter most, or switch to Mind
mapping if the topic wants a looser, more associative structure instead.

## 13. Provocation (PO)

**What it is** — Stating something deliberately unreasonable or
impossible about the topic, then mining that statement for the one
useful movement it points toward — the statement itself is never meant
to be taken literally; its job is to dislodge thinking that's stuck.

**Best for** — Genuine deadlocks — when every idea generated so far
feels like a small variation on the same approach and nothing new is
surfacing.

**Facilitate it** — Offer one provocation to seed the shape of the move:
"PO: the tool library has no rules at all." or "PO: every tool costs a
thousand dollars to borrow for an hour." Then ask, as its own beat:
"that's absurd — but what's the one useful direction hiding inside it?"
Extracting the movement is separate from stating the provocation; don't
rush past the absurdity straight to a tame answer.

**Example round**
- Prompt: "PO: the tool library has no rules at all — anyone can take
  anything, forever, no tracking."
- *(user)*: "That's absurd, it'd be empty in a week. But... maybe the
  useful thing is that tracking is the actual friction, not the rules
  themselves. What if there were fewer rules but really good tracking
  instead — like each tool just has a simple RFID tag and a screen shows
  where everything currently is, no checkout process at all?"
- *(AI) builds*:
  - *(AI) A second movement from the same provocation*: "no rules" could
    also mean no fixed return date — tools just show as "in use" until
    tapped back in, replacing due dates with visibility instead of
    deadlines.
  - *(AI) A third movement*: if trust replaces rules, maybe the real
    idea is social visibility — you can see who currently has the
    ladder, so social accountability does the job rules used to do.
- Return the floor: "Does the tracking-instead-of-rules direction feel
  worth developing, or does one of these other two pull more?"

**Your build move** — Look for a second, different movement hiding in
the same provocation the user already mined once — provocations usually
contain more than one usable thread, and the first extraction rarely
exhausts it.

**Where it goes wrong** — The user's provocation isn't actually
unreasonable enough — a "PO" that's really just a mild exaggeration of
the current plan won't dislodge anything. If the provocation lands as
merely optimistic rather than absurd, push it further before asking for
the movement inside it.

**Bail when** — The extracted movement keeps landing back on the
existing plan almost unchanged; that's a sign the deadlock isn't about
lack of ideas but about something else (a real constraint, a decision
avoided) — worth naming that directly rather than running more
provocations.
