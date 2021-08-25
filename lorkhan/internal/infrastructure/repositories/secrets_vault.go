package repositories

import (
	"encoding/base64"
	"fmt"

	vault "github.com/hashicorp/vault/api"
)

// IdentitiesVault defines identity repository for Vault secret manager.
type IdentitiesVault struct {
	client *vault.Client
	token  string
}

// NewIdentitiesVault constructs new IdentitiesVault repository instance.
func NewIdentitiesVault(client *vault.Client, token string) *IdentitiesVault {
	client.SetToken(token)

	return &IdentitiesVault{
		client: client,
		token: token,
	}
}

// RetrieveFrom requests identity certificate and key from secret located on given `path`.
func (r *IdentitiesVault) RetrieveFrom(path string) ([]byte, []byte, error) {
	secret, err := r.client.Logical().Read(path)
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
