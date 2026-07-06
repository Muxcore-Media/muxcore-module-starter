module github.com/yourorg/your-module

go 1.26.4

require (
	github.com/Muxcore-Media/core v0.4.0
	github.com/Muxcore-Media/core/pkg/contracts v0.0.0
	github.com/Muxcore-Media/core/sdk/go/module v0.1.0
	google.golang.org/grpc v1.82.0
)

require (
	golang.org/x/net v0.55.0 // indirect
	golang.org/x/sys v0.45.0 // indirect
	golang.org/x/text v0.37.0 // indirect
	google.golang.org/genproto/googleapis/rpc v0.0.0-20260414002931-afd174a4e478 // indirect
	google.golang.org/protobuf v1.36.11 // indirect
)

replace github.com/Muxcore-Media/core => ../core

replace github.com/Muxcore-Media/core/sdk/go/module => ../core/sdk/go/module

replace github.com/Muxcore-Media/core/pkg/contracts => ../core/pkg/contracts
