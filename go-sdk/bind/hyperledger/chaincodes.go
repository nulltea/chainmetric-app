package hyperledger

import "github.com/hyperledger/fabric-sdk-go/pkg/gateway"

func (sdk *SDK) GetContract(chaincode string) *gateway.Contract {
	return sdk.network.GetContract(chaincode)
}
