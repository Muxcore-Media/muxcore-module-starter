# Contributing to muxcore-module-starter

## Starting from the starter

```bash
git clone https://git.zem.systems/muxcore/muxcore-module-starter.git
cd muxcore-module-starter
make new-module NAME=your-module
# or: ./scripts/new-module.sh NAME=your-module
```

## Development Setup

### Prerequisites

- Go 1.26.x
- golangci-lint (optional but recommended)
- Private module fetch:

```bash
export GOPRIVATE='github.com/Muxcore-Media/*'
export GONOSUMDB='github.com/Muxcore-Media/*'
git config --global url."ssh://forgejo@git.zem.systems:2222/muxcore/".insteadOf "https://github.com/Muxcore-Media/"
```

### Clone and build

```bash
git clone https://git.zem.systems/muxcore/muxcore-module-starter.git
cd muxcore-module-starter
make build
make test
```

### Run against a local muxcored

```bash
# Terminal 1: start core in dev mode (from a core checkout or published binary)
MUXCORE_INSECURE_DISABLE_TLS=true muxcored

# Terminal 2: start module
make build
MUXCORE_GRPC_ADDR=localhost:9090 MUXCORE_INSECURE_DISABLE_TLS=true ./your-module
```

## Running Tests

```bash
make test
./scripts/check-cookiecutter.sh
```

Tests must not depend on a running muxcored instance.

## Linting

```bash
make lint
```

## Code Conventions

- No comments explaining what the code does — name things well instead.
- Comments only for non-obvious WHY — hidden invariants, workarounds.
- No `os.Exit` from library code — only `main` exits.
- Structured logging via `log/slog` — no `fmt.Println` in non-test code.
- Context propagation — every function that does I/O takes `ctx context.Context` as its first argument.
- Error wrapping — use `fmt.Errorf("operation %q: %w", name, err)`.

## Branch Naming

```
feat/<short-description>
fix/<short-description>
docs/<short-description>
refactor/<short-description>
```

## Pull Request Process

1. Branch from `main`.
2. Make your changes with tests.
3. Run `make ci` locally — it must pass.
4. Open a PR against `main` on Forgejo (`git.zem.systems/muxcore/muxcore-module-starter`).
5. Squash-merge preferred.

## Security Vulnerabilities

Do **not** open a public issue. See [SECURITY.md](SECURITY.md) for the private reporting process.

## License

By contributing, you agree that your contributions will be licensed under the GPL-3.0 license.
