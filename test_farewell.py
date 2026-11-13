"""Tests for farewell.py. Run with: python3 -m unittest test_farewell"""
import subprocess
import sys
import unittest
from pathlib import Path

SCRIPT = Path(__file__).resolve().parent / "farewell.py"


def run(*args):
    return subprocess.run(
        [sys.executable, str(SCRIPT), *args], capture_output=True, text=True
    )


class FarewellTest(unittest.TestCase):
    def test_prints_goodbye_with_name(self):
        result = run("Ana")
        self.assertEqual(result.returncode, 0)
        self.assertEqual(result.stdout, "Goodbye, Ana!\n")

    def test_defaults_to_world(self):
        result = run()
        self.assertEqual(result.returncode, 0)
        self.assertEqual(result.stdout, "Goodbye, world!\n")


if __name__ == "__main__":
    unittest.main()
