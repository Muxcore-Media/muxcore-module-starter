# {{ cookiecutter.module_name }}

[![CI](https://github.com/Muxcore-Media/{{ cookiecutter.module_slug }}/actions/workflows/ci.yml/badge.svg)](https://github.com/Muxcore-Media/{{ cookiecutter.module_slug }}/actions)
[![Go Version](https://img.shields.io/badge/Go-1.26-blue)](https://go.dev/)
[![License: GPL-3.0](https://img.shields.io/badge/License-GPL--3.0-blue.svg)](LICENSE)

{{ cookiecutter.description }}

MuxCore sidecar module. Pins published `core@v0.6.13`. CI runs on GitHub Actions — no sibling `core` checkout.

## Clone

```bash
git clone https://github.com/Muxcore-Media/{{ cookiecutter.module_slug }}.git
cd {{ cookiecutter.module_slug }}

export GOPRIVATE='github.com/Muxcore-Media/*'
export GONOSUMDB='github.com/Muxcore-Media/*'
gh auth setup-git
```

## Build

```bash
make build
make test
make ci
```

## Run

```bash
export MUXCORE_GRPC_ADDR=localhost:9090
export MUXCORE_INSECURE_DISABLE_TLS=true
./{{ cookiecutter.module_slug }}
```

## Capability

`{{ cookiecutter.capability }}` (role `{{ cookiecutter.role }}`)

## CI

`.github/workflows/ci.yml` runs on GitHub Actions (`MUXCORE_CI_TOKEN` for private module access).

## License

GPL-3.0
