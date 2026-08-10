#!/usr/bin/env bash
# Generate a throwaway module and verify build+test (no sibling core tree).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OUT="${TMPDIR:-/tmp}/muxcore-cc-check-$$"
mkdir -p "$OUT"
trap 'rm -rf "$OUT"' EXIT

export GOPRIVATE="${GOPRIVATE:-github.com/Muxcore-Media/*}"
export GONOSUMDB="${GONOSUMDB:-github.com/Muxcore-Media/*}"

"$ROOT/scripts/new-module.sh" "NAME=cc-probe" "OUT=$OUT/cc-probe"
cd "$OUT/cc-probe"
test -f go.sum
# Prefer cache; do not require network/auth for the smoke check.
CGO_ENABLED=0 go test -count=1 ./...
CGO_ENABLED=0 go build -o /dev/null ./cmd/module
grep -q 'runs-on: self-hosted' .github/workflows/ci.yml
grep -q 'secrets.MUXCORE_CI_TOKEN' .github/workflows/ci.yml
grep -q 'GOPRIVATE: github.com/Muxcore-Media/\*' .github/workflows/ci.yml
! grep -q 'path: core' .github/workflows/ci.yml
! grep -q 'repository: Muxcore-Media/core' .github/workflows/ci.yml
! grep -q '{% raw %}' .github/workflows/ci.yml
! grep -q 'cookiecutter\.' .github/workflows/ci.yml internal/module.go go.mod README.md
echo COOKIECUTTER_OK
