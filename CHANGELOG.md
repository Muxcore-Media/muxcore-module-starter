# Changelog

## [Unreleased]

### Added

- `make new-module NAME=…` / `scripts/new-module.sh` (cookiecutter or bash fallback)
- Forgejo origin CI (`runs-on: native`, `git.zem.systems/muxcore` module rewrite)
- Cookiecutter emits `.golangci.yml` and `deploy/` samples
- Agent notes live in umbrella `docs/agents/` (generated modules do not ship `AGENTS.md`)

### Changed

- README rewritten as cookiecutter-quality starter docs (no Feature X placeholders)
- Cookiecutter-emitted CI matches root: Forgejo native, no sibling tree
- `ROADMAP.md` points at workspace `MASTER-ROADMAP.md`
- Published `core@v0.5.8` pin (removed local `replace` directives)

### Added (prior)

- `cookiecutter/` template and `scripts/check-cookiecutter.sh`

## [0.1.0] - scaffold

- Initial project scaffold
