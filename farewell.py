#!/usr/bin/env python3
"""Prints "Goodbye, <name>!" for the first argument, or "Goodbye, world!" with none."""
import sys


def farewell(name="world"):
    return f"Goodbye, {name}!"


if __name__ == "__main__":
    print(farewell(sys.argv[1] if len(sys.argv) > 1 else "world"))
