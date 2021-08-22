package sdk

import (
	"fmt"

	"github.com/hyperledger/fabric-sdk-go/pkg/gateway"
	"github.com/pkg/errors"
	"github.com/timoth-y/chainmetric-app/go-sdk/internal"
)

func (sdk *ChainmentricSDK) AuthRequired() bool {
	return !sdk.wallet.Exists(userID)
}

func (sdk *ChainmentricSDK) AuthX509(orgID, key, cert string) error {
	if !sdk.wallet.Exists(userID) {
		identity := gateway.NewX509Identity(orgID, cert, key)
		return sdk.wallet.Put(userID, identity)
	}
	return nil
}

func (sdk *ChainmentricSDK) AuthVault(orgID, userID, secretToken string) error {
	cert, key, err := internal.RequestIdentityVault(fmt.Sprintf("auth/%s/login"), secretToken)
	if err != nil {
		return errors.Wrap(err, "failed to get credentials from Vault")
	}

	identity := gateway.NewX509Identity(orgID, string(cert), string(key))
	return sdk.wallet.Put(userID, identity)
}
