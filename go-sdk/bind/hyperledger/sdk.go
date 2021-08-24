package hyperledger

//go:generate gomobile bind --target=android -tags=mobile -o ../app/android/app/src/main/libs/blockchainSDK.aar

import (
	"fmt"

	"github.com/hyperledger/fabric-sdk-go/pkg/core/config"
	"github.com/hyperledger/fabric-sdk-go/pkg/gateway"
	"github.com/timoth-y/chainmetric-app/go-sdk/bind/chainmetric"
)

type SDK struct {
	wallet *gateway.Wallet
	gateway *gateway.Gateway
	network *gateway.Network

	Readings *chainmetric.ReadingsContract
}

func (sdk *SDK) Init() {
	sdk.Readings = chainmetric.NewReadingsContract(sdk)
}

func (sdk *SDK) InitWallet(path string) error {
	wallet, err := gateway.NewFileSystemWallet(path)
	if err != nil {
		return err
	}
	sdk.wallet = wallet
	return nil
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
