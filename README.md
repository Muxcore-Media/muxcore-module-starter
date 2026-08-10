# muxcore-module-starter

[![CI](https://github.com/Muxcore-Media/muxcore-module-starter/actions/workflows/ci.yml/badge.svg)](https://github.com/Muxcore-Media/muxcore-module-starter/actions)
[![Go Version](https://img.shields.io/badge/Go-1.26-blue)](https://go.dev/)
[![License: GPL-3.0](https://img.shields.io/badge/License-GPL--3.0-blue.svg)](LICENSE)

**Cookiecutter template and reference scaffold for MuxCore sidecar modules.**

Pins published `core@v0.5.0` (no local `replace`, no sibling checkout). Self-hosted CI fetches private modules with `MUXCORE_CI_TOKEN`.

---

## Create a new module

From a checkout of this repo:

```bash
make new-module NAME=my-module
# optional: OUT=/path/to/my-module ORG=Muxcore-Media
```

Or:

```bash
./scripts/new-module.sh NAME=my-module
# if you have cookiecutter installed:
cookiecutter ./cookiecutter --no-input module_slug=my-module module_name="My Module"
```

The generator writes a ready-to-push module (Go module path, `muxcore.json`, Makefile, self-hosted CI without a sibling `core` tree).

Verify the template locally:

```bash
./scripts/check-cookiecutter.sh
```

Then in the new repo:

```bash
cd ../my-module   # default OUT
make build
make test
```

See [Writing Modules](https://github.com/Muxcore-Media/core/wiki/Writing-Modules) for the full authoring guide.

---

## Reference scaffold (this repo)

Root files are the live reference module (`your-module` placeholders). Prefer `make new-module` / `cookiecutter/` when starting a real module; keep this tree as the smoke-tested baseline.

### Configuration

Core connection is resolved by the module SDK (Config → env → CLI → `Info().ID`).

| Variable / flag | Default | Description |
|-----------------|---------|-------------|
| `MUXCORE_GRPC_ADDR` / `--muxcore-mesh-addr` | (required) | Core gRPC address (`host:port`) |
| `MUXCORE_MODULE_ID` / `--muxcore-module-id` | `Info().ID` | Module ID override |
| `MUXCORE_INSECURE_DISABLE_TLS` | — | Dev-only; scaffold sets `Insecure` from this env |

### Build & test

```bash
make build
make test
make ci     # lint + test + build
```

### Run against local core

```bash
# Terminal 1
MUXCORE_INSECURE_DISABLE_TLS=true muxcored

# Terminal 2
export MUXCORE_GRPC_ADDR=localhost:9090
export MUXCORE_INSECURE_DISABLE_TLS=true
./your-module
```

### Deploy

```bash
make docker
docker compose -f deploy/docker-compose.yml up
# or: sudo cp deploy/systemd/muxcore-module.service /etc/systemd/system/
```

---

## License

GPL-3.0
