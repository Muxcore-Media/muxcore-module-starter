# AGENTS.md — {{ cookiecutter.module_slug }}

MuxCore sidecar module (`{{ cookiecutter.module_slug }}`).

## Module identity

| Field | Value |
|-------|-------|
| Directory | `{{ cookiecutter.module_slug }}` |
| Role | `{{ cookiecutter.role }}` |
| Capability | `{{ cookiecutter.capability }}` |

## Build

```bash
cd {{ cookiecutter.module_slug }}
go test ./...
make lint
```

## Agent rules

- Modules run as gRPC sidecars; capabilities are the security boundary.
- TLS required in production (`MUXCORE_INSECURE_DISABLE_TLS` is dev-only).
- Match existing Go patterns; run `gofmt` and package tests before finishing.
- Roadmaps and remaining-work checklists live in workspace `MASTER-ROADMAP.md` (umbrella). Do not add `ROADMAP.md` / `TASKS.md` in generated modules.
