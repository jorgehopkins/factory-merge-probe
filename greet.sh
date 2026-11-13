#!/usr/bin/env bash
# Prints "Hello, <name>!" for the first argument, or "Hello, world!" with none.
echo "Hello, ${1:-world}!"
