.PHONY: build test lint clean fmt tidy docker docker-push ci new-module help

GO ?= go
VERSION ?= $(shell git describe --tags --always --dirty 2>/dev/null || echo "0.0.0-dev")
LDFLAGS ?= -s -w -X main.version=$(VERSION)
BINARY ?= your-module
NAME ?=
OUT ?=
ORG ?= Muxcore-Media

build:
	$(GO) build -ldflags="$(LDFLAGS)" -o $(BINARY) ./cmd/module

test:
	$(GO) test -race -count=1 -timeout 60s ./...

lint:
	golangci-lint run --timeout 120s ./...

clean:
	rm -f $(BINARY)
	rm -f cmd/module/module
	rm -rf dist/

fmt:
	$(GO) fmt ./...

tidy:
	$(GO) mod tidy

docker:
	docker build -t ghcr.io/yourorg/$(BINARY):$(VERSION) .
	docker tag ghcr.io/yourorg/$(BINARY):$(VERSION) ghcr.io/yourorg/$(BINARY):latest

docker-push: docker
	docker push ghcr.io/yourorg/$(BINARY):$(VERSION)
	docker push ghcr.io/yourorg/$(BINARY):latest

ci: lint test build

# Example: make new-module NAME=my-module
# Optional: OUT=../my-module ORG=Muxcore-Media
new-module:
	@test -n "$(NAME)" || (echo "NAME is required, e.g. make new-module NAME=my-module" >&2; exit 2)
	./scripts/new-module.sh NAME=$(NAME) $(if $(OUT),OUT=$(OUT),) ORG=$(ORG)

help:
	@echo "Targets:"
	@echo "  build       - compile the module binary"
	@echo "  test        - run tests with race detection"
	@echo "  lint        - golangci-lint"
	@echo "  clean       - remove build artifacts"
	@echo "  fmt         - format Go source"
	@echo "  tidy        - go mod tidy"
	@echo "  docker      - build Docker image"
	@echo "  docker-push - build and push Docker image"
	@echo "  ci          - lint + test + build"
	@echo "  new-module  - scaffold a module (NAME=slug required)"
