package plugins

import (
	"fmt"

	vault "github.com/hashicorp/vault/api"
	"github.com/timoth-y/chainmetric-app/lorkhan/bind/fabric"
	"github.com/timoth-y/chainmetric-app/lorkhan/internal/infrastructure/repositories"
)

type (
	// VaultAuthenticator defines a plugin for authenticating to Fabric network via Vault.
	VaultAuthenticator struct {
		sdk *fabric.SDK
		client *vault.Client
	}

	// VaultConfig defines properties for initializing Vault client.
	VaultConfig struct {
		Address      string
		DefaultToken string
	}
)

// NewVaultAuthenticator constructs new instance of VaultAuthenticator plugin.
func NewVaultAuthenticator(sdk *fabric.SDK) *VaultAuthenticator {
	client, _ := vault.NewClient(vault.DefaultConfig())

	return &VaultAuthenticator{
		sdk: sdk,
		client: client,
	}
}

// Init performs initialization of the AuthVault plugin.
func (p *VaultAuthenticator) Init(config *VaultConfig) error {
	if err := p.client.SetAddress(config.Address); err != nil {
		return fmt.Errorf("invalid address given: %w", err)
	}

	if len(config.DefaultToken) != 0 {
		p.client.SetToken(config.DefaultToken)
	}

	return nil
}

// FetchVaultIdentity requests Fabric identity x509 credentials and puts those into the fabric.SDK wallet.
func (p *VaultAuthenticator) FetchVaultIdentity(username, org, secretPath, userToken string) error {
	cert, key, err := repositories.NewIdentitiesVault(p.client, userToken).
		RetrieveFrom(secretPath)
	if err != nil {
		return fmt.Errorf("failed to get credentials from Vault: %w", err)
	}

	return p.sdk.PutX509Identity(username, org, string(cert), string(key))
}
