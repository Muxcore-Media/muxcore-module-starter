# Your Module

[![CI](https://github.com/yourorg/your-module/actions/workflows/ci.yml/badge.svg)](https://github.com/yourorg/your-module/actions)
[![Go Version](https://img.shields.io/badge/Go-1.26-blue)](https://go.dev/)
[![License: GPL-3.0](https://img.shields.io/badge/License-GPL--3.0-blue.svg)](LICENSE)

**One-line description of what your module does.**

A MuxCore sidecar module that does X. Without this module, core can't do Y.

---

## How It Works

```
Client request ──→ your-module ──→ muxcored
                     │
                     ▼
              Does the thing
```

### Key concept 1

Explanation.

### Key concept 2

Explanation.

---

## Configuration

Core connection is resolved by the module SDK (priority: Config field → env → CLI flag → `Module.Info().ID` for module ID).

### CLI Flags

| Flag | Default | Description |
|------|---------|-------------|
| `--muxcore-mesh-addr` | (required) | Core gRPC address (`host:port`) |
| `--muxcore-module-id` | `Info().ID` (`your-module`) | Module identifier override |

### Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `MUXCORE_GRPC_ADDR` | (required if no flag) | Core gRPC address (`host:port`) |
| `MUXCORE_MODULE_ID` | `Info().ID` (`your-module`) | Module identifier override |
| `MUXCORE_INSECURE_DISABLE_TLS` | — | Used by **core** / compose; this scaffold hardcodes `Insecure: true` in `cmd/module` |

---

## Quick Start

```bash
# Build
make build

# Run against local core (dev mode)
# Terminal 1: MUXCORE_INSECURE_DISABLE_TLS=true ./muxcored
# Terminal 2:
export MUXCORE_GRPC_ADDR=localhost:9090
./your-module
```

---

## Deployment

### Docker

```bash
make docker
docker run -d --restart=unless-stopped \
  -e MUXCORE_GRPC_ADDR=core:9090 \
  ghcr.io/yourorg/your-module:latest
```

### docker-compose

```bash
docker compose -f deploy/docker-compose.yml up
```

### systemd

```bash
sudo cp deploy/systemd/muxcore-module.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now muxcore-module
```

---

## Development

```bash
make build    # compile ./your-module
make test     # run tests
make lint     # golangci-lint
make fmt      # format code
make ci       # lint + test + build
```

### Integration Tests

```bash
# Start core in dev mode, then:
MUXCORE_GRPC_ADDR=localhost:9090 go test -tags=integration -race -count=1 ./test/
```

---

## Implementation

Scaffold state (`internal/module.go`):

- Module ID / name / version: `your-module` / `Your Module` / `0.1.0`
- Roles and capabilities: empty in `Info()` (see Conflicts if `muxcore.json` differs)
- Implements `contracts.Module` lifecycle (`Init` / `Start` / `Stop`); `Health` returns `not implemented`
- Started via `modulesdk.Run` in `cmd/module`

Replace placeholders and register capabilities/contracts as you implement the module.

---

## License

GPL-3.0
