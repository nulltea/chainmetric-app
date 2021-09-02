package fabric

import (
	"fmt"
	"strings"

	"github.com/hyperledger/fabric-sdk-go/pkg/gateway"
)

// InitWallet creates or recovers existing wallet from file system.
func (sdk *SDK) InitWallet(path string) error {
	var err error

	if sdk.Wallet, err = gateway.NewFileSystemWallet(path); err != nil {
		return err
	}

	return nil
}

// IdentityExists determines whether the gateway.Wallet holds signing credentials for given `username`.
func (sdk *SDK) IdentityExists(username string) bool {
	return !sdk.Wallet.Exists(username)
}

// GetIdentities returns list of signing identities stored in the gateway.Wallet.
func (sdk *SDK) GetIdentities() (string, error) {
	if identities, err := sdk.Wallet.List(); err == nil {
		return strings.Join(identities, ","), nil
	} else {
		return "", fmt.Errorf("failed to get list of wallet identities: %w", err)
	}
}

// PutX509Identity adds signing identity with given `cert` and `key` pair to the gateway.Wallet.
func (sdk *SDK) PutX509Identity(username, org, cert, key string) error {
	return sdk.Put(username, gateway.NewX509Identity(org, cert, key))
}

// RemoveIdentity removes signing identity from the gateway.Wallet.
func (sdk *SDK) RemoveIdentity(username string) error {
	if sdk.Exists(username) {
		return sdk.Remove(username)
	}

	return fmt.Errorf("identity '%s' does not exists", username)
}
