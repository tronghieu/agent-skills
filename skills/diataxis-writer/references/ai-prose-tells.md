# AI prose tells for documentation

This is a short checklist for the prose-polish step when the humanizer skill
is not installed. It covers only the tells that show up most in
documentation. It is not a full replacement for the humanizer skill, which
covers 35 patterns with more examples and false-positive guidance. Install
humanizer for the full set: `npx skills add blader/humanizer`. Patterns are
adapted from Wikipedia's "Signs of AI writing" (WikiProject AI Cleanup) as
curated by the humanizer skill (MIT, Siqi Chen),
https://github.com/blader/humanizer.

## Rules

- Keep every claim. Do not invent facts, names, numbers, or citations while
  editing.
- Keep code, commands, paths, tables, quotations, and link targets unchanged.
- Keep technical terms and constraints. Do not simplify away a required
  detail.
- Keep the voice of the document type: a tutorial keeps its guiding "we"
  voice, a how-to stays imperative, a reference stays neutral, and an
  explanation may weigh alternatives.
- For non-English prose, apply the structural tells in this checklist. The
  English word lists do not transfer directly.

## Checklist

| Tell | Watch for | Fix |
| --- | --- | --- |
| Inflated importance | pivotal, crucial, key role, marks a shift, underscores its importance | State the fact. |
| Trailing -ing phrases | ensuring..., allowing..., highlighting... | Cut it or make it a separate sentence. |
| Sales language | seamless, powerful, robust, effortless, best-in-class | Say what it does. |
| Stock AI words | delve, leverage, enhance, landscape, showcase, underscore, additionally, vital | Use the plain word. |
| Not X but Y | "not just X, it's Y", "it's not about X" | Say Y. |
| Forced groups of three | three adjectives or three examples when the real count differs | Use the real count. |
| Bold mini-headings in lists | every bullet starts with **Label:** | Use plain bullets, or a table in reference pages. |
| Too much bold and title case | bolded phrases without a reason, headings capitalized like a title | Bold only warnings and UI labels; use sentence-case headings unless the doc set's style says otherwise. |
| Chatbot leftovers | "I hope this helps", "Certainly!", "Here is a...", "Let me know" | Delete. |
| Filler and hedging | "it is important to note that", "in order to", "it is worth mentioning" | Cut. |
| Heading echo and generic closing | heading repeated in the first sentence, "In conclusion...", "exciting possibilities" | Cut the echo; stop when the content stops. |
| Rejecting fake alternatives | "one might be tempted to...", "an obvious approach would be... but" | State the constraint directly. |

## Do not flag

- One transition word on its own. A single "however" or "additionally" is not
  a tell.
- Passive voice when the actor is unknown or irrelevant. This is common in
  reference text.
- Warnings, scope notes, and prerequisites. Keep these even if they repeat a
  pattern above.
- Bold on UI labels, keys, and warnings.
- Real alternatives that a reader might choose in an explanation or design
  doc. Remove only an alternative the text dismisses and never uses again.
- Watched phrases inside quotations, product names, or examples being
  discussed rather than used.
