# {{ cookiecutter.module_name }}

[![CI](https://github.com/{{ cookiecutter.github_org }}/{{ cookiecutter.module_slug }}/actions/workflows/ci.yml/badge.svg)](https://github.com/{{ cookiecutter.github_org }}/{{ cookiecutter.module_slug }}/actions)
[![Go Version](https://img.shields.io/badge/Go-1.26-blue)](https://go.dev/)
[![License: GPL-3.0](https://img.shields.io/badge/License-GPL--3.0-blue.svg)](LICENSE)

{{ cookiecutter.description }}

MuxCore sidecar module. Pins published `core@v0.5.0`. Self-hosted CI uses `MUXCORE_CI_TOKEN` for private module fetch (no sibling `core` checkout).

## Build

```bash
make build
make test
```

## Run

```bash
export MUXCORE_GRPC_ADDR=localhost:9090
export MUXCORE_INSECURE_DISABLE_TLS=true
./{{ cookiecutter.module_slug }}
```

## Capability

`{{ cookiecutter.capability }}` (role `{{ cookiecutter.role }}`)

## License

GPL-3.0
