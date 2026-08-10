package internal

import (
	"context"
	"fmt"
	"log/slog"

	"github.com/Muxcore-Media/core/pkg/contracts"
)

type Module struct {
	id       string
	meshAddr string
}

func NewModule() *Module {
	return &Module{
		id:       "{{ cookiecutter.module_slug }}",
		meshAddr: "",
	}
}

func (m *Module) Info() contracts.ModuleInfo {
	return contracts.ModuleInfo{
		ID:           m.id,
		Name:         "{{ cookiecutter.module_name }}",
		Version:      "0.1.0",
		Roles:        []string{"{{ cookiecutter.role }}"},
		Description:  "{{ cookiecutter.description }}",
		Author:       "{{ cookiecutter.author }}",
		Capabilities: []string{"{{ cookiecutter.capability }}"},
		DependsOn:    []string{},
	}
}

func (m *Module) Init(ctx context.Context) error {
	slog.Info("initializing module", "id", m.id)
	return nil
}

func (m *Module) Start(ctx context.Context) error {
	slog.Info("starting module", "id", m.id)
	return nil
}

func (m *Module) Stop(ctx context.Context) error {
	slog.Info("stopping module", "id", m.id)
	return nil
}

func (m *Module) Health(ctx context.Context) error {
	return fmt.Errorf("not implemented")
}
