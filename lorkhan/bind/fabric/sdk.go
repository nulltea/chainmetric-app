package fabric

import (
	"fmt"

	"github.com/hyperledger/fabric-sdk-go/pkg/core/config"
	"github.com/hyperledger/fabric-sdk-go/pkg/gateway"
)

// SDK defines Fabric SDK client.
type SDK struct {
	gateway *gateway.Gateway
	*gateway.Wallet
	*gateway.Network
}

// New constructs new instance of an SDK client.
func New() *SDK {
	return &SDK{}
}

// SetupConnectionToChannel preforms initialization of Fabric gateway.Gateway client with given `config`,
// and makes connection attempt to gateway.Network on specified `channel`.
func (sdk *SDK) SetupConnectionToChannel(configRaw, channel, username string) error {
	fmt.Println("SetupConnectionToChannel ->", "username:", username)
	gw, err := gateway.Connect(
		gateway.WithConfig(config.FromRaw([]byte(configRaw), "yaml")),
		gateway.WithIdentity(sdk.Wallet, username),
	); if err != nil {
		return fmt.Errorf("InitConnectionFor: connect to gateway: %w", err)
	}

	sdk.Network, err = gw.GetNetwork(channel); if err != nil {
		return fmt.Errorf("InitConnectionFor: connect to network: %w", err)
	}

	return nil
}
