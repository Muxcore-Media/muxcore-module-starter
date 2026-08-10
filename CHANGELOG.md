# Changelog

## [Unreleased]

### Added

- `make new-module NAME=…` / `scripts/new-module.sh` (cookiecutter or bash fallback)
- Self-hosted CI and release without sibling `core` checkout (published `core@v0.5.0` + `MUXCORE_CI_TOKEN`)

### Changed

- README rewritten as cookiecutter-quality starter docs (no Feature X placeholders)
- Cookiecutter-emitted CI matches root: self-hosted, no sibling tree
- `ROADMAP.md` points at workspace `TASKS.md`

### Added (prior)

- `cookiecutter/` template and `scripts/check-cookiecutter.sh`

## [0.1.0] - scaffold

- Initial project scaffold
