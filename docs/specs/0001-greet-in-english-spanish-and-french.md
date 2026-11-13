# Greet in English, Spanish and French

## Summary

`greet.sh` today greets only in English. This change lets the person running it pick English, Spanish or French with an optional `--lang <code>` flag. Anyone using `./greet.sh` today sees no difference unless they pass the flag.

## Scope

**In**
- An optional `--lang <code>` flag on `greet.sh`, placed before the name.
- Three languages: English (`en`, the default), Spanish (`es`) and French (`fr`).
- A translated greeting for the no-name case in each language.
- A clear error for an unsupported or missing language code.
- Updating `test-greet.sh` and `CHANGELOG.md`.

**Out**
- Full language names such as `--lang spanish`.
- Any language beyond English, Spanish and French.
- Choosing the language from the environment (for example the `LANG` variable).
- Any change to `farewell.py`, which stays English-only.
- Any change to how the name is handled: only the first name is used, as today.

## Behaviour

Greetings, where `<name>` is the name given:

| Language | With a name | No name |
|---|---|---|
| English (`en`) | `Hello, <name>!` | `Hello, world!` |
| Spanish (`es`) | `¡Hola, <name>!` | `¡Hola, mundo!` |
| French (`fr`) | `Bonjour, <name>!` | `Bonjour, le monde!` |

- With no `--lang` flag the language is English, so `./greet.sh Ana` and `./greet.sh` print exactly what they print today.
- The flag comes first, then the optional name: `./greet.sh --lang es Ana`, or `./greet.sh --lang fr` for the no-name greeting.
- The language code is matched without regard to case: `ES`, `Es` and `es` all mean Spanish. Only the codes `en`, `es` and `fr` are accepted.
- Output is UTF-8 text, so the Spanish `¡` is printed as a normal UTF-8 character.
- The greeting goes to stdout on one line, and the exit status is zero.

When things go wrong:
- If the code isn't `en`, `es` or `fr` (for example `--lang de` or `--lang spanish`), nothing is printed to stdout. One line goes to stderr naming the supported codes (`en, es, fr`), and the exit status is non-zero.
- If `--lang` is the last argument, with no code after it, it is handled the same way: nothing on stdout, a one-line message on stderr naming `en, es, fr`, and a non-zero exit.

## How will this ship?

Straight to everyone on `main`, with no feature flag, because it only adds an optional flag and leaves existing calls unchanged. `CHANGELOG.md` is updated to describe the new flag and languages. To undo it, revert the change.

## Acceptance Criteria

- AC-1: `./greet.sh Ana` prints `Hello, Ana!` and `./greet.sh` prints `Hello, world!`, both exiting zero, as before the change.
- AC-2: `./greet.sh --lang en Ana` prints `Hello, Ana!`.
- AC-3: `./greet.sh --lang es Ana` prints `¡Hola, Ana!`.
- AC-4: `./greet.sh --lang fr Ana` prints `Bonjour, Ana!`.
- AC-5: With no name, `--lang en` prints `Hello, world!`, `--lang es` prints `¡Hola, mundo!` and `--lang fr` prints `Bonjour, le monde!`.
- AC-6: The code is case-insensitive: `./greet.sh --lang ES Ana` prints `¡Hola, Ana!` and `./greet.sh --lang Fr Ana` prints `Bonjour, Ana!`.
- AC-7: `./greet.sh --lang de Ana` prints nothing to stdout, prints one line to stderr that contains `en, es, fr`, and exits non-zero.
- AC-8: `./greet.sh --lang spanish Ana` is handled as in AC-7.
- AC-9: `./greet.sh --lang` (no code) is handled as in AC-7.
- AC-10: `test-greet.sh` checks every case in AC-1 to AC-9 and exits non-zero if any fails.
- AC-11: `CHANGELOG.md` describes the `--lang` flag, the three codes and the English default.

## Acceptance note

Accepted on 2026-11-13 with no known gaps.
