#!/usr/bin/env bash
# Prints a Greeting for the first name argument, or for "world" with none.
# Optional "--lang <code>" before the name picks the language: en (default), es or fr.
code="en"
if [ "${1:-}" = "--lang" ]; then
  code="${2-}"
  if [ "$#" -ge 2 ]; then shift 2; else shift; fi
fi
lang="${code,,}"
case "$lang" in
  en) echo "Hello, ${1:-world}!" ;;
  es) echo "¡Hola, ${1:-mundo}!" ;;
  fr) echo "Bonjour, ${1:-le monde}!" ;;
  *)
    echo "greet.sh: unsupported language '$code'; supported: en, es, fr" >&2
    exit 2
    ;;
esac
