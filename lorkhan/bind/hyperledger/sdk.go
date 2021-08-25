package hyperledger

import (
	"fmt"

	"github.com/hyperledger/fabric-sdk-go/pkg/core/config"
	"github.com/hyperledger/fabric-sdk-go/pkg/gateway"
)

type SDK struct {
	wallet *gateway.Wallet
	gateway *gateway.Gateway
	network *gateway.Network
}

func (sdk *SDK) InitConnectionOn(configRaw, channel string) error {
	gw, err := gateway.Connect(
		gateway.WithConfig(config.FromRaw([]byte(configRaw), "yaml")),
		gateway.WithIdentity(sdk.wallet, userID),
	); if err != nil {
		return fmt.Errorf("InitConnectionFor: connect to gateway: %w", err)
	}

	sdk.network, err = gw.GetNetwork(channel); if err != nil {
		return fmt.Errorf("InitConnectionFor: connect to network: %w", err)
	}

	return nil
}
