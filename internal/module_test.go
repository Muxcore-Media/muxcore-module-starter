package internal

import (
	"context"
	"encoding/json"
	"os"
	"path/filepath"
	"runtime"
	"testing"
)

type muxcoreManifest struct {
	Name           string   `json:"name"`
	Description    string   `json:"description"`
	Version        string   `json:"version"`
	Author         string   `json:"author"`
	Roles          []string `json:"roles"`
	Capabilities   []string `json:"capabilities"`
	Contracts      []any    `json:"contracts"`
	MinCoreVersion string   `json:"minCoreVersion"`
}

func loadMuxcoreManifest(t *testing.T) muxcoreManifest {
	t.Helper()
	_, file, _, ok := runtime.Caller(0)
	if !ok {
		t.Fatal("runtime.Caller failed")
	}
	raw, err := os.ReadFile(filepath.Join(filepath.Dir(file), "..", "muxcore.json"))
	if err != nil {
		t.Fatalf("read muxcore.json: %v", err)
	}
	var manifest muxcoreManifest
	if err := json.Unmarshal(raw, &manifest); err != nil {
		t.Fatalf("parse muxcore.json: %v", err)
	}
	return manifest
}

func TestModuleInfo(t *testing.T) {
	manifest := loadMuxcoreManifest(t)
	m := NewModule()
	info := m.Info()
	if info.ID == "" {
		t.Error("module ID must not be empty")
	}
	if info.Version == "" {
		t.Error("module version must not be empty")
	}
	if info.ID != "your-module" {
		t.Fatalf("ID = %q", info.ID)
	}
	if info.Name != manifest.Name {
		t.Fatalf("Name = %q, manifest = %q", info.Name, manifest.Name)
	}
	if info.Description != manifest.Description {
		t.Fatalf("Description = %q, manifest = %q", info.Description, manifest.Description)
	}
	if info.Author != manifest.Author {
		t.Fatalf("Author = %q, manifest = %q", info.Author, manifest.Author)
	}
	if info.MinCoreVersion != manifest.MinCoreVersion {
		t.Fatalf("MinCoreVersion = %q, manifest = %q", info.MinCoreVersion, manifest.MinCoreVersion)
	}
	if len(info.Roles) != len(manifest.Roles) || info.Roles[0] != manifest.Roles[0] {
		t.Fatalf("Roles = %v, manifest = %v", info.Roles, manifest.Roles)
	}
	if len(info.Capabilities) != len(manifest.Capabilities) || info.Capabilities[0] != manifest.Capabilities[0] {
		t.Fatalf("Capabilities = %v, manifest = %v", info.Capabilities, manifest.Capabilities)
	}
}

func TestModuleHealth(t *testing.T) {
	m := NewModule()
	if err := m.Health(context.Background()); err != nil {
		t.Fatalf("Health: %v", err)
	}
}

func TestModuleLifecycle(t *testing.T) {
	m := NewModule()
	ctx := context.Background()

	if err := m.Init(ctx); err != nil {
		t.Fatalf("Init: %v", err)
	}
	if err := m.Start(ctx); err != nil {
		t.Fatalf("Start: %v", err)
	}
	if err := m.Stop(ctx); err != nil {
		t.Fatalf("Stop: %v", err)
	}
}
