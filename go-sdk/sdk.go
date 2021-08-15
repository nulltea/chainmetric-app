package sdk

//go:generate gomobile bind --target=android -tags=mobile -o ../app/android/app/src/main/libs/blockchainSDK.aar

import (
	"github.com/hyperledger/fabric-sdk-go/pkg/core/config"
	"github.com/hyperledger/fabric-sdk-go/pkg/gateway"
	"github.com/pkg/errors"
)

const userID = "appUser"

type ChainmentricSDK struct {
	wallet *gateway.Wallet
	gateway *gateway.Gateway
	network *gateway.Network

	Readings *ReadingsContract
}

func (sdk *ChainmentricSDK) Init() {
	sdk.Readings = NewReadingsContract(sdk)
}

func (sdk *ChainmentricSDK) InitWallet(path string) error {
	wallet, err := gateway.NewFileSystemWallet(path)
	if err != nil {
		return err
	}
	sdk.wallet = wallet
	return nil
}

func (sdk *ChainmentricSDK) AuthRequired() bool {
	return !sdk.wallet.Exists(userID)
}

func (sdk *ChainmentricSDK) AuthIdentity(orgID, key, cert string) error {
	if !sdk.wallet.Exists(userID) {
		identity := gateway.NewX509Identity(orgID, cert, key)
		return sdk.wallet.Put(userID, identity)
	}
	return nil
}

func (sdk *ChainmentricSDK) InitConnectionOn(configRaw, channel string) error {
	gw, err := gateway.Connect(
		gateway.WithConfig(config.FromRaw([]byte(configRaw), "yaml")),
		gateway.WithIdentity(sdk.wallet, userID),
	); if err != nil {
		return errors.Wrap(err, "InitConnectionFor: connect to gateway")
	}

	sdk.network, err = gw.GetNetwork(channel); if err != nil {
		return errors.Wrap(err, "InitConnectionFor: connect to network")
	}

	return nil
}

func (sdk *ChainmentricSDK) EvaluateTransaction(chaincode, transaction string, args string) (string, error) {
	contract := sdk.network.GetContract(chaincode)
	data, err := contract.EvaluateTransaction(transaction, args)
	return string(data), errors.Wrap(err, "EvaluateTransaction: execute contract")
}

func (sdk *ChainmentricSDK) SubmitTransaction(chaincode, transaction string, args string) (string, error) {
	contract := sdk.network.GetContract(chaincode)
	data, err := contract.SubmitTransaction(transaction, args)
	return string(data), errors.Wrap(err, "SubmitTransaction: execute contract")
}
