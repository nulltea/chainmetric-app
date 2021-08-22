package internal

import (
	"encoding/base64"
	"fmt"

	vault "github.com/hashicorp/vault/api"
)

// vaultClient is an instance of the vaultClient client for managing secrets.
var vaultClient *vault.Client

func init() {
	var (
		addr = "https://vault.chainmetric.network:443"
		err error
	)

	if vaultClient, err = vault.NewClient(&vault.Config{
		Address: addr,
	}); err != nil {
		panic("failed to initialize vaultClient client")
	}
}

func RequestIdentityVault(path, token string) ([]byte, []byte, error) {
	vaultClient.SetToken(token)
	secret, err := vaultClient.Logical().Read(path)
	if err != nil {
		return nil, nil, err
	}

	certBase64, ok := secret.Data["certificate"].(string)
	if !ok {
		return nil, nil, fmt.Errorf("certificate missing")
	}

	keyBase64, ok := secret.Data["signing_key"].(string)
	if !ok {
		return nil, nil, err
	}

	certBytes, err := base64.StdEncoding.DecodeString(certBase64)
	if err != nil {
		return nil, nil, err
	}

	keyBytes, err := base64.StdEncoding.DecodeString(keyBase64)
	if err != nil {
		return nil, nil, err
	}

	return certBytes, keyBytes, nil
}
