package plugins

import (
	"fmt"

	"github.com/hyperledger/fabric-sdk-go/pkg/gateway"
	"github.com/timoth-y/chainmetric-app/lorkhan/bind/hyperledger"
	"github.com/timoth-y/chainmetric-app/lorkhan/internal/core"
	"github.com/timoth-y/chainmetric-app/lorkhan/internal/infrastructure/repositories"
)

type AuthVault struct {
	sdk *hyperledger.SDK
}

func NewAuthVault(sdk *hyperledger.SDK) *AuthVault {
	return &AuthVault{
		sdk: sdk,
	}
}

func (p *AuthVault) Authenticate(orgID, secretPath, secretToken string) error {
	cert, key, err := repositories.NewIdentitiesVault(core.Vault, secretToken).
		RetrieveFrom(secretPath)
	if err != nil {
		return fmt.Errorf("failed to get credentials from Vault: %w", err)
	}

	identity := gateway.NewX509Identity(orgID, string(cert), string(key))
	return p.sdk.Put(hyperledger.UserID, identity)
}
