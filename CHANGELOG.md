# Changelog

## [Unreleased]

## [0.1.1] - 2026-10-05

### Changed
- CI runs on GitHub-hosted runners from the umbrella template; retired-origin workflows removed.
- Dependencies resolve from published GitHub tags (no filesystem `replace`); requires core v0.6.0.

### Added

- `make new-module NAME=…` / `scripts/new-module.sh` (cookiecutter or bash fallback)
- CI workflow with private-module fetch
- Cookiecutter emits `.golangci.yml`, `AGENTS.md`, and `deploy/` samples

### Changed

- README rewritten as cookiecutter-quality starter docs (no Feature X placeholders)
- Cookiecutter-emitted CI matches root: no sibling tree
- `ROADMAP.md` points at workspace `MASTER-ROADMAP.md`
- Published `core@v0.5.8` pin (removed local `replace` directives)

### Added (prior)

- `cookiecutter/` template and `scripts/check-cookiecutter.sh`

## [0.1.0] - scaffold

- Initial project scaffold
