#!/usr/bin/env bash
# Generate a throwaway module from cookiecutter/ and verify build+test.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OUT="${TMPDIR:-/tmp}/muxcore-cc-check-$$"
mkdir -p "$OUT"
trap 'rm -rf "$OUT"' EXIT
cd "$OUT"
cookiecutter "$ROOT/cookiecutter" --no-input module_slug=cc-probe module_name="CC Probe"
cd cc-probe
go mod tidy
CGO_ENABLED=0 go test -count=1 ./...
CGO_ENABLED=0 go build -o /dev/null ./cmd/module
grep -q 'path: cc-probe' .github/workflows/ci.yml
grep -q 'secrets.MUXCORE_CI_TOKEN' .github/workflows/ci.yml
! grep -q '{% raw %}' .github/workflows/ci.yml
echo COOKIECUTTER_OK
