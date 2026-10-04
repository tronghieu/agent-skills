# Simplified Technical English rules for English docs

ASD-STE100 Simplified Technical English (STE) is a controlled language from the
aerospace and defense industry. It removes the two main causes of misreading:
words with more than one meaning, and sentences with more than one possible
structure. Maintainer: ASD, https://www.asd-ste100.org/.

This file paraphrases the public rule categories. It does not contain the
official dictionary of about 900 approved words. That dictionary is free to
request but not free to redistribute. Output that follows this file is
STE-style, not certified STE. Rule set adapted from asd-ste100-skill (MIT,
danyuchn), https://github.com/danyuchn/asd-ste100-skill.

## Scope

These rules add to the language-neutral rules in `SKILL.md`. They apply only
to English text.

- **Strict:** how-to guides, reference pages, the steps of a tutorial,
  warnings, and error messages. Apply every structural rule as a hard limit.
- **Light:** explanations, and tutorial prose between steps, only when the
  user asks for STE. Apply the structural rules. Treat the lexical rules as
  advice.
- Do not apply STE to text where voice or persuasion is the point.

## Structural rules

| Rule | Do | Don't |
| --- | --- | --- |
| Sentence length | 20 words or fewer for an instruction. 25 or fewer for a description. In strict scope these are limits, not review signals. | "Prior to commencing removal of the panel, it is essential that the electrical power supply be disconnected." |
| Imperative instructions | "Disconnect the power." | "The power should be disconnected." |
| Simple verb forms | Imperative, infinitive, simple present, simple past, simple future, past participle as an adjective. | "We have received the report." Use "We received the report." |
| No -ing verb forms | "Before you remove the panel, ..." | "Before removing the panel, ..." An -ing word is allowed as part of a technical name ("landing gear"). |
| Passive voice | Only in descriptions, and only when the actor is unknown or irrelevant. | Passive in an instruction. |
| No phrasal verbs | "Remove the panel." "Start the job." | "Take off the panel." "Spin up the job." |
| Verb, not noun | "Inspect the filter." | "Perform an inspection of the filter." |
| No semicolons | Write two sentences. | Any semicolon. |
| No dropped words | Keep the subject, verb, and articles: "Make sure that the valve is closed." | "Ensure valve closed." |

## Lexical rules (advice without the dictionary)

- One word has one meaning and one part of speech in the document. "Apply oil
  to the valve", not "Oil the valve".
- Use the most common word: "before", not "prior to". "Use", not "utilize".
  "Start", not "initiate". "Obey", not "follow", when the meaning is "comply".
- Keep necessary technical nouns and verbs. Define each one once if it is not
  common English. STE allows a project glossary for these terms.

## When rules conflict

- Certainty wins over tense. Keep "may have failed". Do not change it to
  "failed".
- Precision wins over length. If a split or a shorter word loses a condition,
  number, or scope limit, keep the longer text. Tell the user which sentence
  you kept and why.
- Do not change text that already follows the rules.
- Clarity is the goal, not the shortest text. Stop when the sentence has one
  meaning.

## Example

Before:

> This tool will attempt to synchronize state across the various backends
> that have been configured, and if a conflict is detected it may resolve it
> automatically depending on the strategy that has been set.

After:

> The tool tries to synchronize state across the configured backends. If it
> finds a conflict, it reads the configured strategy. If the strategy allows
> it, the tool may resolve the conflict automatically.

The hedge "may resolve" stays. The rewrite removes the present perfect and
splits one long sentence into three.
