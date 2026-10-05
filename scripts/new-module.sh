#!/usr/bin/env bash
# Generate a new MuxCore module from cookiecutter/ (or a bash fallback).
# Generated repos use GitHub Actions CI and published
# core@v0.5.8 pins — no sibling ../core checkout.
# Usage:
#   scripts/new-module.sh NAME=my-module [OUT=../my-module]
#   make new-module NAME=my-module
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
NAME=""
OUT=""
ORG="Muxcore-Media"
AUTHOR="Muxcore-Media"
DESCRIPTION="A MuxCore sidecar module."
ROLE=""
CAPABILITY=""

usage() {
  cat <<'EOF'
Usage: scripts/new-module.sh NAME=<slug> [OUT=<dir>] [ORG=Muxcore-Media]

Creates a new module repo from cookiecutter/{{cookiecutter.module_slug}}.
Prefer: make new-module NAME=my-module
EOF
}

for arg in "$@"; do
  case "$arg" in
    NAME=*) NAME="${arg#NAME=}" ;;
    OUT=*) OUT="${arg#OUT=}" ;;
    ORG=*) ORG="${arg#ORG=}" ;;
    AUTHOR=*) AUTHOR="${arg#AUTHOR=}" ;;
    DESCRIPTION=*) DESCRIPTION="${arg#DESCRIPTION=}" ;;
    ROLE=*) ROLE="${arg#ROLE=}" ;;
    CAPABILITY=*) CAPABILITY="${arg#CAPABILITY=}" ;;
    -h|--help) usage; exit 0 ;;
    *=*) ;;
    *)
      if [[ -z "$NAME" ]]; then
        NAME="$arg"
      else
        echo "unexpected argument: $arg" >&2
        usage >&2
        exit 2
      fi
      ;;
  esac
done

if [[ -z "$NAME" ]]; then
  echo "NAME is required (e.g. NAME=my-module)" >&2
  usage >&2
  exit 2
fi

if [[ ! "$NAME" =~ ^[a-z][a-z0-9-]*$ ]]; then
  echo "NAME must be a lowercase slug (letters, digits, hyphens): got '$NAME'" >&2
  exit 2
fi

# Title-case slug: my-module → My Module
to_title() {
  local s="$1" out="" part
  IFS='-' read -ra parts <<<"$s"
  for part in "${parts[@]}"; do
    [[ -z "$part" ]] && continue
    out+="${out:+ }$(printf '%s' "${part^}")"
  done
  printf '%s' "$out"
}

MODULE_NAME="$(to_title "$NAME")"
ROLE="${ROLE:-${NAME%%-*}}"
CAPABILITY="${CAPABILITY:-${NAME//-/.}}"
OUT="${OUT:-$ROOT/../$NAME}"

if [[ -e "$OUT" ]]; then
  echo "refusing to overwrite existing path: $OUT" >&2
  exit 1
fi

TEMPLATE="$ROOT/cookiecutter/{{cookiecutter.module_slug}}"
if [[ ! -d "$TEMPLATE" ]]; then
  echo "missing template directory: $TEMPLATE" >&2
  exit 1
fi

render_bash() {
  local src="$1" dest="$2"
  mkdir -p "$dest"
  # Copy tree, then rewrite placeholders in text files.
  cp -a "$src/." "$dest/"
  # Drop cookiecutter raw tags while preserving GH Actions expressions.
  while IFS= read -r -d '' file; do
    case "$file" in
      *.png|*.jpg|*.jpeg|*.gif|*.webp|*.ico|*.pdf|*.zip|*.tar|*.gz) continue ;;
    esac
    # Skip binary-ish files
    if grep -Iq . "$file" 2>/dev/null; then
      :
    else
      continue
    fi
    local tmp
    tmp="$(mktemp)"
    sed -e "s|{{ cookiecutter.module_slug }}|${NAME}|g" \
        -e "s|{{cookiecutter.module_slug}}|${NAME}|g" \
        -e "s|{{ cookiecutter.module_name }}|${MODULE_NAME}|g" \
        -e "s|{{cookiecutter.module_name}}|${MODULE_NAME}|g" \
        -e "s|{{ cookiecutter.github_org }}|${ORG}|g" \
        -e "s|{{cookiecutter.github_org}}|${ORG}|g" \
        -e "s|{{ cookiecutter.description }}|${DESCRIPTION}|g" \
        -e "s|{{cookiecutter.description}}|${DESCRIPTION}|g" \
        -e "s|{{ cookiecutter.author }}|${AUTHOR}|g" \
        -e "s|{{cookiecutter.author}}|${AUTHOR}|g" \
        -e "s|{{ cookiecutter.capability }}|${CAPABILITY}|g" \
        -e "s|{{cookiecutter.capability}}|${CAPABILITY}|g" \
        -e "s|{{ cookiecutter.role }}|${ROLE}|g" \
        -e "s|{{cookiecutter.role}}|${ROLE}|g" \
        -e 's|{% raw %}||g' \
        -e 's|{% endraw %}||g' \
        "$file" >"$tmp"
    mv "$tmp" "$file"
  done < <(find "$dest" -type f -print0)
}

if command -v cookiecutter >/dev/null 2>&1; then
  parent="$(dirname "$OUT")"
  mkdir -p "$parent"
  (
    cd "$parent"
    cookiecutter "$ROOT/cookiecutter" --no-input \
      "module_slug=${NAME}" \
      "module_name=${MODULE_NAME}" \
      "github_org=${ORG}" \
      "description=${DESCRIPTION}" \
      "author=${AUTHOR}" \
      "capability=${CAPABILITY}" \
      "role=${ROLE}"
  )
  generated="$parent/$NAME"
  if [[ "$generated" != "$OUT" ]]; then
    mv "$generated" "$OUT"
  fi
else
  echo "cookiecutter not found; using bash template render" >&2
  render_bash "$TEMPLATE" "$OUT"
fi

export GOPRIVATE="${GOPRIVATE:-github.com/Muxcore-Media/*}"
export GONOSUMDB="${GONOSUMDB:-github.com/Muxcore-Media/*}"
export GIT_TERMINAL_PROMPT=0
if command -v go >/dev/null 2>&1; then
  # go.sum ships with the template (published core pins). tidy needs private-module auth when the cache is cold.
  (cd "$OUT" && go mod tidy) || echo "warning: go mod tidy failed (set GOPRIVATE + GitHub auth, e.g. gh auth setup-git); go.sum is already present" >&2
fi

echo "Created module at $OUT"
echo "Next: cd $OUT && make build && make test"
echo "Push to GitHub: github.com/Muxcore-Media/${NAME}"
echo "Private modules: export GOPRIVATE=github.com/Muxcore-Media/* and run gh auth setup-git"
