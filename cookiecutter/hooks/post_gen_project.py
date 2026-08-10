#!/usr/bin/env python3
"""Tidy Go modules after cookiecutter generation."""
import subprocess
import sys

def main() -> int:
    r = subprocess.run(["go", "mod", "tidy"], check=False)
    if r.returncode != 0:
        print("warning: go mod tidy failed; run it manually", file=sys.stderr)
        return 0  # do not fail generation
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
