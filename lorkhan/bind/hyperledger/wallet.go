package hyperledger

import (
	"github.com/hyperledger/fabric-sdk-go/pkg/gateway"
)

const UserID = "appUser"

func (sdk *SDK) InitWallet(path string) error {
	wallet, err := gateway.NewFileSystemWallet(path)
	if err != nil {
		return err
	}
	sdk.Wallet = wallet
	return nil
}

func (sdk *SDK) AuthRequired() bool {
	return !sdk.Exists(UserID)
}

func (sdk *SDK) AuthX509(orgID, key, cert string) error {
	if !sdk.Exists(UserID) {
		identity := gateway.NewX509Identity(orgID, cert, key)
		return sdk.Put(UserID, identity)
	}
	return nil
}
