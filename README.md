# muxcore-module-starter

Cookiecutter + reference scaffold for new MuxCore sidecar modules.

## Create a new module

```bash
# from a checkout of this repo:
cookiecutter ./cookiecutter
# or non-interactive:
cookiecutter ./cookiecutter --no-input module_slug=my-module module_name="My Module"
```

The template emits a **green CI** workflow (ubuntu-latest, `go vet` / `go test` / `go build`, sibling `core` checkout via `MUXCORE_CI_TOKEN`).

Verify locally:

```bash
./scripts/check-cookiecutter.sh
```

---

## Reference scaffold (this repo)

The files at the repo root are the live reference module (`your-module` placeholders). Prefer `cookiecutter/` when starting a real module.

### Configuration / build

See `Makefile`, `.env.example`, and `cmd/module`. Core connection uses the module SDK (`MUXCORE_GRPC_ADDR`, optional `MUXCORE_INSECURE_DISABLE_TLS`).

```bash
make build
make test
make ci
```

### License

GPL-3.0
