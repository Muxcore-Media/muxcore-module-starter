# {{ cookiecutter.module_name }}

[![CI](https://github.com/{{ cookiecutter.github_org }}/{{ cookiecutter.module_slug }}/actions/workflows/ci.yml/badge.svg)](https://github.com/{{ cookiecutter.github_org }}/{{ cookiecutter.module_slug }}/actions)

{{ cookiecutter.description }}

## Build

```bash
make build
```

## Run

```bash
export MUXCORE_GRPC_ADDR=localhost:9090
export MUXCORE_INSECURE_DISABLE_TLS=true
./{{ cookiecutter.module_slug }}
```

## License

GPL-3.0
