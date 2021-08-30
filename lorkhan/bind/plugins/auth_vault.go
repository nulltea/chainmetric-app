package plugins

import (
	"fmt"

	vault "github.com/hashicorp/vault/api"
	"github.com/hyperledger/fabric-sdk-go/pkg/gateway"
	"github.com/timoth-y/chainmetric-app/lorkhan/bind/hyperledger"
	"github.com/timoth-y/chainmetric-app/lorkhan/internal/infrastructure/repositories"
)

type (
	// AuthVault defines a plugin for authenticating to Fabric network via Vault.
	AuthVault struct {
		sdk *hyperledger.SDK
		client *vault.Client
	}

	// VaultConfig defines properties for initializing Vault client.
	VaultConfig struct {
		Address      string
		DefaultToken string
	}
)

// NewAuthVault constructs new instance of AuthVault plugin.
func NewAuthVault(sdk *hyperledger.SDK) *AuthVault {
	client, _ := vault.NewClient(vault.DefaultConfig())

	return &AuthVault{
		sdk: sdk,
		client: client,
	}
}

// Init performs initialization of the AuthVault plugin.
func (p *AuthVault) Init(config *VaultConfig) error {
	if err := p.client.SetAddress(config.Address); err != nil {
		return fmt.Errorf("invalid address given: %w", err)
	}

	if len(config.DefaultToken) != 0 {
		p.client.SetToken(config.DefaultToken)
	}

	return nil
}

// Authenticate requests Fabric identity x509 credentials and puts those into the hyperledger.SDK wallet.
func (p *AuthVault) Authenticate(orgID, secretPath, userToken string) error {
	cert, key, err := repositories.NewIdentitiesVault(p.client, userToken).
		RetrieveFrom(secretPath)
	if err != nil {
		return fmt.Errorf("failed to get credentials from Vault: %w", err)
	}

	identity := gateway.NewX509Identity(orgID, string(cert), string(key))
	return p.sdk.Put(hyperledger.UserID, identity)
}
