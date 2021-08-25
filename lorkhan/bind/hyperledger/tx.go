package hyperledger

import (
	"fmt"
)

func (sdk *SDK) EvaluateTransaction(chaincode, tx string, args string) (string, error) {
	contract := sdk.network.GetContract(chaincode)
	data, err := contract.EvaluateTransaction(tx, args)
	return string(data), fmt.Errorf("EvaluateTransaction: execute contract: %w", err)
}

func (sdk *SDK) SubmitTransaction(chaincode, tx string, args string) (string, error) {
	contract := sdk.network.GetContract(chaincode)
	data, err := contract.SubmitTransaction(tx, args)
	return string(data), fmt.Errorf("SubmitTransaction: execute contract: %w", err)
}
