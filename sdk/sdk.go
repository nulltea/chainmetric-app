package sdk

//go:generate gomobile bind --target android -o ../iotchain/android/app/src/main/libs/iotchainClient.aar

import (
	"github.com/hyperledger/fabric-sdk-go/pkg/core/config"
	"github.com/hyperledger/fabric-sdk-go/pkg/gateway"
	"github.com/pkg/errors"
)

const userID = "appUser"

type IoTChainClient struct {
	wallet *gateway.Wallet
	gateway *gateway.Gateway
	network *gateway.Network
}

func (c *IoTChainClient) InitWallet(path string) error {
	wallet, err := gateway.NewFileSystemWallet(path)
	if err != nil {
		return err
	}
	c.wallet = wallet
	return nil
}

func (c *IoTChainClient) AuthRequired() bool {
	return c.wallet.Exists(userID)
}

func (c *IoTChainClient) AuthIdentity(orgID, key, cert string) error {
	if !c.wallet.Exists(userID) {
		identity := gateway.NewX509Identity(orgID, cert, key)
		return c.wallet.Put(userID, identity)
	}
	return nil
}

func (c *IoTChainClient) InitConnectionOn(configRaw, channel string) error {
	gw, err := gateway.Connect(
		gateway.WithConfig(config.FromRaw([]byte(configRaw), "yaml")),
		gateway.WithIdentity(c.wallet, userID),
	); if err != nil {
		return errors.Wrap(err, "InitConnectionFor: connect to gateway")
	}
	net, err := gw.GetNetwork(channel)
	if err != nil {
		return errors.Wrap(err, "InitConnectionFor: connect to network")
	}
	c.network = net

	return nil
}

func (c *IoTChainClient) EvaluateTransaction(chaincode, transaction string, args string) (string, error) {
	contract := c.network.GetContract(chaincode)
	data, err := contract.EvaluateTransaction(transaction, args)
	return string(data), errors.Wrap(err, "EvaluateTransaction: execute chaincode")
}