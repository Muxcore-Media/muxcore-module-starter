# Changelog

## [0.1.5] - 2026-10-05

### Changed
- Built on core v0.6.14 / sdk/go/module v0.6.4: unregisters on shutdown and re-registers after core restarts (ADR-0022).

## [0.1.4] - 2026-10-05


### Changed
- Release train train-2026.10.2 (core v0.6.13): go.mod and cookiecutter template (incl. go.sum), compose default image tag, `minCoreVersion` 0.6.13, README/COMPATIBILITY.

## [0.1.3] - 2026-10-05


### Changed
- Reported version comes from muxcore.json (ADR-0021); built on core v0.6.12 / sdk/go/module v0.6.3 (mesh enrollment, ADR-0017).

## [0.1.2] - 2026-10-05


### Changed
- Pin release train train-2026.10.1: core v0.6.7 (go.mod, cookiecutter template, compose default image tag, `minCoreVersion` 0.6.7).

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
