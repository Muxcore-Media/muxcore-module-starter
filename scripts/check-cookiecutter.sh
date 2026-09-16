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
git config --global url."https://git.zem.systems/muxcore/".insteadOf "https://github.com/Muxcore-Media/" 2>/dev/null || true

"$ROOT/scripts/new-module.sh" "NAME=cc-probe" "OUT=$OUT/cc-probe"
cd "$OUT/cc-probe"
test -f go.sum
test -f .golangci.yml
test ! -f AGENTS.md
test -f deploy/docker-compose.yml
test -f deploy/systemd/muxcore-module.service
# Prefer cache; do not require network/auth for the smoke check when go.sum is warm.
CGO_ENABLED=0 go test -count=1 ./...
CGO_ENABLED=0 go build -o /dev/null ./cmd/module

grep -q 'runs-on: native' .forgejo/workflows/ci.yml
grep -q 'git.zem.systems/muxcore' .forgejo/workflows/ci.yml
! grep -q 'path: core' .forgejo/workflows/ci.yml
! grep -q 'repository: Muxcore-Media/core' .forgejo/workflows/ci.yml
! grep -q '{% raw %}' .forgejo/workflows/ci.yml
! grep -q 'cookiecutter\.' .forgejo/workflows/ci.yml internal/module.go go.mod README.md

grep -q 'runs-on: native' "$ROOT/.forgejo/workflows/ci.yml"
grep -q 'git.zem.systems/muxcore' "$ROOT/.forgejo/workflows/ci.yml"
grep -q 'check-cookiecutter.sh' "$ROOT/.forgejo/workflows/ci.yml"
grep -q 'golangci-lint' "$ROOT/.forgejo/workflows/ci.yml"
echo COOKIECUTTER_OK
