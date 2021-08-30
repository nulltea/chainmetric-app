package fabric

import (
	"fmt"
)

// EvaluateTransaction will evaluate a transaction `tx` with given `args` passed as JSON on specified `chaincode`.
func (sdk *SDK) EvaluateTransaction(chaincode, tx string, args string) (string, error) {
	contract := sdk.GetContract(chaincode)
	data, err := contract.EvaluateTransaction(tx, args)
	return string(data), fmt.Errorf("EvaluateTransaction: execute contract: %w", err)
}

// SubmitTransaction will submit a transaction `tx` to the ledger with given `args` passed as JSON on specified `chaincode`.
func (sdk *SDK) SubmitTransaction(chaincode, tx string, args string) (string, error) {
	contract := sdk.GetContract(chaincode)
	data, err := contract.SubmitTransaction(tx, args)
	return string(data), fmt.Errorf("SubmitTransaction: execute contract: %w", err)
}
