package hyperledger

import (
	"fmt"

	"github.com/hyperledger/fabric-sdk-go/pkg/gateway"
	"github.com/timoth-y/chainmetric-app/lorkhan/internal/core"
	"github.com/timoth-y/chainmetric-app/lorkhan/internal/infrastructure/repositories"
)

const userID = "appUser"

func (sdk *SDK) InitWallet(path string) error {
	wallet, err := gateway.NewFileSystemWallet(path)
	if err != nil {
		return err
	}
	sdk.wallet = wallet
	return nil
}

func (sdk *SDK) AuthRequired() bool {
	return !sdk.wallet.Exists(userID)
}

func (sdk *SDK) AuthX509(orgID, key, cert string) error {
	if !sdk.wallet.Exists(userID) {
		identity := gateway.NewX509Identity(orgID, cert, key)
		return sdk.wallet.Put(userID, identity)
	}
	return nil
}

func (sdk *SDK) AuthVault(orgID, userID, secretToken string) error {
	cert, key, err := repositories.NewIdentitiesVault(core.Vault, secretToken).
		RetrieveFrom(fmt.Sprintf("auth/%s/login", userID))
	if err != nil {
		return fmt.Errorf("failed to get credentials from Vault: %w", err)
	}

	identity := gateway.NewX509Identity(orgID, string(cert), string(key))
	return sdk.wallet.Put(userID, identity)
}
