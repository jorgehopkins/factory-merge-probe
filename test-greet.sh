#!/usr/bin/env bash
# Checks greet.sh greetings in en, es and fr, the Language code handling and its errors.
# Exits non-zero on any mismatch.
dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fail=0

check() {
  local expected="$1"; shift
  local actual
  if ! actual="$("$dir/greet.sh" "$@")"; then
    echo "FAIL: greet.sh $* exited non-zero" >&2
    fail=1
    return
  fi
  if [ "$actual" != "$expected" ]; then
    echo "FAIL: greet.sh $* printed '$actual', expected '$expected'" >&2
    fail=1
  else
    echo "ok: greet.sh $* -> $actual"
  fi
}

# Asserts: empty stdout, exactly one stderr line containing "en, es, fr", non-zero exit.
check_fails() {
  local out err status errfile
  errfile="$(mktemp)"
  out="$("$dir/greet.sh" "$@" 2>"$errfile")"
  status=$?
  err="$(cat "$errfile")"
  rm -f "$errfile"
  if [ "$status" -eq 0 ]; then
    echo "FAIL: greet.sh $* exited zero, expected non-zero" >&2
    fail=1
  elif [ -n "$out" ]; then
    echo "FAIL: greet.sh $* printed '$out' to stdout, expected nothing" >&2
    fail=1
  elif [ "$(printf '%s\n' "$err" | wc -l)" -ne 1 ] || [ -z "$err" ]; then
    echo "FAIL: greet.sh $* stderr was not exactly one line: '$err'" >&2
    fail=1
  elif [[ "$err" != *"en, es, fr"* ]]; then
    echo "FAIL: greet.sh $* stderr '$err' does not contain 'en, es, fr'" >&2
    fail=1
  else
    echo "ok: greet.sh $* -> exit $status, stderr: $err"
  fi
}

check "Hello, Ana!" Ana
check "Hello, world!"
check "Hello, Ana!" --lang en Ana
check "¡Hola, Ana!" --lang es Ana
check "Bonjour, Ana!" --lang fr Ana
check "Hello, world!" --lang en
check "¡Hola, mundo!" --lang es
check "Bonjour, le monde!" --lang fr
check "¡Hola, Ana!" --lang ES Ana
check "Bonjour, Ana!" --lang Fr Ana
check_fails --lang de Ana
check_fails --lang spanish Ana
check_fails --lang

exit "$fail"
