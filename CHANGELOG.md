# Changelog

## Scripts

- `greet.sh` — prints a greeting for the first argument, or for "world" with none. The optional `--lang <code>` flag, placed before the name, picks the language: `en` (English, the default), `es` (Spanish) or `fr` (French). The code is case-insensitive; an unsupported or missing code prints an error naming `en, es, fr` to stderr, nothing to stdout, and exits with status 2.
  Example: `./greet.sh Ana` prints `Hello, Ana!`; `./greet.sh --lang es Ana` prints `¡Hola, Ana!`.
- `test-greet.sh` — checks `greet.sh` greetings with and without a name in each language, the case-insensitive code, and the error cases; exits non-zero on any mismatch.
  Example: `./test-greet.sh`
