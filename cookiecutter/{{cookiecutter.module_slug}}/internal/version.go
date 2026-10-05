package internal

import (
	modulesdk "github.com/Muxcore-Media/core/sdk/go/module"
	manifest "github.com/{{ cookiecutter.github_org }}/{{ cookiecutter.module_slug }}"
)

const MinCoreVersion = "0.6.13"

// Version is an optional build-time override (-ldflags -X main.version=...).
// Leave it empty or "dev" to report the version from muxcore.json (ADR-0021).
var Version = ""

// ReportedVersion returns the version reported in Info(): the build-time
// override when set, otherwise the single source of truth, muxcore.json.
func ReportedVersion() string {
	switch Version {
	case "", "dev", "0.0.0-dev":
		return modulesdk.ManifestVersion(manifest.ManifestJSON)
	}
	return Version
}
