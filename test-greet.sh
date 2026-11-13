#!/usr/bin/env bash
# Checks greet.sh for a named and an unnamed greeting. Exits non-zero on any mismatch.
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

check "Hello, Ana!" Ana
check "Hello, world!"

exit "$fail"
