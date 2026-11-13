# Grilling Transcript 0001: Greet in English, Spanish and French

- **Spec**: [0001-greet-in-english-spanish-and-french.md](../specs/0001-greet-in-english-spanish-and-french.md)
- **Where it ran**: the Software Factory's Grilling screen, with an AI agent asking and the Operator answering.

## The Operator (2026-11-13)

A small command-line tool that greets people in three languages

## The Factory (2026-11-13)

I looked at the repo first. It already has `greet.sh`, which prints `Hello, <name>!` (or `Hello, world!` with no name). It has a test script, `test-greet.sh`, and a changelog. There is also a separate `farewell.py` that says goodbye in English. Nothing is settled yet, so the Spec is still empty. Here are the questions on the first round.

❓ **Q1** - **Extend `greet.sh` or build a new tool?**: The existing `greet.sh` is already "a small command-line tool that greets people". I'd add the languages to it, so `./greet.sh Ana` keeps printing `Hello, Ana!` exactly as today. `farewell.py` stays untouched. Do you agree?

➡️ Yes: extend `greet.sh` and leave `farewell.py` alone. Existing behaviour doesn't change.

---

❓ **Q2** - **Which three languages?**: I'd pick English, Spanish and French, as they are the most common choice for a tool like this.

| Language | Greeting |
|---|---|
| English | `Hello, Ana!` |
| Spanish | `Hola, Ana!` |
| French | `Bonjour, Ana!` |

➡️ Yes: English, Spanish, French.

---

❓ **Q3** - **How does the person choose the language?**: I'd add an optional `--lang <code>` flag before the name, such as `./greet.sh --lang es Ana`. The codes would be `en`, `es` and `fr`. With no flag, the language is English, so nothing existing breaks.

➡️ Yes: `--lang <code>` with codes `en`/`es`/`fr`, defaulting to English.

---

❓ **Q4** - **What does the tool print when no name is given?**: Today that's `Hello, world!`. For the other languages I'd translate "world" too:

| Language | No-name greeting |
|---|---|
| English | `Hello, world!` |
| Spanish | `Hola, mundo!` |
| French | `Bonjour, le monde!` |

➡️ Yes: translate "world" in each language, as shown above.

---

❓ **Q5** - **Spanish punctuation**: Written Spanish normally opens with an inverted mark, as in `¡Hola, Ana!`. This can show up as garbage in terminals that don't use UTF-8. Do you want the proper `¡Hola, Ana!`?

➡️ Yes: use `¡Hola, Ana!` and `¡Hola, mundo!`. UTF-8 is the norm on modern terminals.

---

❓ **Q6** - **What if the language isn't supported?**: For `--lang de`, or `--lang` with no value, I'd print a one-line message to stderr naming the supported codes (`en, es, fr`) and exit non-zero. It would print no greeting.

➡️ Yes: error message to stderr listing `en, es, fr`, exit non-zero, no greeting on stdout.

---

❓ **Q7** - **How strict is the code matching?**: Should `--lang ES` work as well as `--lang es`? I'd accept either case, but not full names like `--lang spanish`, to keep it small.

➡️ Yes: codes only, case-insensitive.

---

❓ **Q8** - **How will this ship?**: I'd merge it straight to everyone, with no feature flag, since it only adds an optional flag. I'd update `CHANGELOG.md` and extend `test-greet.sh` to cover each language, the no-name case and the unsupported-language error. Undoing it means reverting the change.

➡️ Yes: straight to main, with the changelog and tests updated. No flag.

## The Operator (2026-11-13)

Yes

## The Factory (2026-11-13)

Thanks, that settles every question. I've written the Spec, and nothing is left open.

**What I've written**
- `greet.sh` gains an optional `--lang <code>` flag placed before the name. The codes are `en`, `es` and `fr`, matched without regard to case, and English is the default.
- Greetings are `Hello, Ana!`, `¡Hola, Ana!` and `Bonjour, Ana!`. With no name they are `Hello, world!`, `¡Hola, mundo!` and `Bonjour, le monde!`.
- An unsupported code, or `--lang` with no code, prints a one-line message listing `en, es, fr` to stderr, prints nothing to stdout, and exits non-zero.
- It ships straight to `main` with no flag, and `test-greet.sh` and `CHANGELOG.md` are updated. There are 11 Acceptance Criteria.
- `farewell.py` is untouched.
- I added a short glossary with Greeting, Language code and Default language.

No ADR is needed, since nothing here is hard to reverse. The Spec is ready for the Spec Gate.
