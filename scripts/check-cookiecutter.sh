#!/usr/bin/env bash
# Generate a throwaway module and verify build+test (no sibling core tree).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OUT="${TMPDIR:-/tmp}/muxcore-cc-check-$$"
mkdir -p "$OUT"
trap 'rm -rf "$OUT"' EXIT

export GOPRIVATE="${GOPRIVATE:-github.com/Muxcore-Media/*}"
export GONOSUMDB="${GONOSUMDB:-github.com/Muxcore-Media/*}"
export GIT_TERMINAL_PROMPT=0

"$ROOT/scripts/new-module.sh" "NAME=cc-probe" "OUT=$OUT/cc-probe"
cd "$OUT/cc-probe"
test -f go.sum
test -f .golangci.yml
test -f AGENTS.md
test -f deploy/docker-compose.yml
test -f deploy/systemd/muxcore-module.service
# Prefer cache; do not require network/auth for the smoke check when go.sum is warm.
CGO_ENABLED=0 go test -count=1 ./...
CGO_ENABLED=0 go build -o /dev/null ./cmd/module

! grep -q 'path: core' .github/workflows/ci.yml
! grep -q 'repository: Muxcore-Media/core' .github/workflows/ci.yml
! grep -q '{% raw %}' .github/workflows/ci.yml
! grep -q 'cookiecutter\.' .github/workflows/ci.yml internal/module.go go.mod README.md AGENTS.md

grep -q 'golangci-lint' "$ROOT/.github/workflows/ci.yml"
echo COOKIECUTTER_OK
