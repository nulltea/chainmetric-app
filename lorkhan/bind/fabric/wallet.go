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

// IdentityRequired determines whether the signing identity is required for using SDK.
func (sdk *SDK) IdentityRequired() bool {
	if identities, err := sdk.Wallet.List(); err == nil && len(identities) > 0 {
		return false
	}

	return true
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
	fmt.Println("username:", username, "org:", org)
	fmt.Println("Cert:")
	fmt.Println(string(cert))
	fmt.Println("Key:")
	fmt.Println(string(key))
	identity := gateway.NewX509Identity(org, cert, key)
	return sdk.Put(username, identity)
}

// RemoveIdentity removes signing identity from the gateway.Wallet.
func (sdk *SDK) RemoveIdentity(username string) error {
	if !sdk.Exists(username) {
		return sdk.Remove(username)
	}

	return nil
}
