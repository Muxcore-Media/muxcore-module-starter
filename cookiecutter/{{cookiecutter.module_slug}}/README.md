# {{ cookiecutter.module_name }}

[![CI](https://git.zem.systems/muxcore/{{ cookiecutter.module_slug }}/actions/workflows/ci.yml/badge.svg)](https://git.zem.systems/muxcore/{{ cookiecutter.module_slug }}/actions)
[![Go Version](https://img.shields.io/badge/Go-1.26-blue)](https://go.dev/)
[![License: GPL-3.0](https://img.shields.io/badge/License-GPL--3.0-blue.svg)](LICENSE)

{{ cookiecutter.description }}

MuxCore sidecar module. Pins published `core@v0.5.8`. Origin CI runs on Forgejo (`runs-on: native`) with the `git.zem.systems/muxcore` module rewrite — no sibling `core` checkout.

## Clone (Forgejo origin)

```bash
git clone https://git.zem.systems/muxcore/{{ cookiecutter.module_slug }}.git
cd {{ cookiecutter.module_slug }}

export GOPRIVATE='github.com/Muxcore-Media/*'
export GONOSUMDB='github.com/Muxcore-Media/*'
git config --global url."ssh://forgejo@git.zem.systems:2222/muxcore/".insteadOf "https://github.com/Muxcore-Media/"
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

## Optional GitHub CI

`.github/workflows/ci.yml` is an optional mirror for public GitHub consumers (`MUXCORE_CI_TOKEN`). Forgejo is the documented default install path.

## License

GPL-3.0
