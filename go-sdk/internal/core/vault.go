package core

import vault "github.com/hashicorp/vault/api"

// Vault is an instance of the Vault client for managing secrets.
var Vault *vault.Client

func initVault() {
	var (
		addr = "https://vault.chainmetric.network:443"
		err error
	)

	if Vault, err = vault.NewClient(&vault.Config{
		Address: addr,
	}); err != nil {
		panic("failed to initialize Vault client")
	}
}
