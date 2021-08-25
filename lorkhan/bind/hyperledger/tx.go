package hyperledger

import (
	"fmt"
)

func (sdk *SDK) EvaluateTransaction(chaincode, transaction string, args string) (string, error) {
	contract := sdk.network.GetContract(chaincode)
	data, err := contract.EvaluateTransaction(transaction, args)
	return string(data), fmt.Errorf("EvaluateTransaction: execute contract: %w", err)
}

func (sdk *SDK) SubmitTransaction(chaincode, transaction string, args string) (string, error) {
	contract := sdk.network.GetContract(chaincode)
	data, err := contract.SubmitTransaction(transaction, args)
	return string(data), fmt.Errorf("SubmitTransaction: execute contract: %w", err)
}
