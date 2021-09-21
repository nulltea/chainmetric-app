package fabric

import (
	"fmt"
)

// EvaluateTransaction will evaluate a transaction `tx` with given `args` passed as JSON on specified `chaincode`.
func (sdk *SDK) EvaluateTransaction(chaincode, tx string, args string) (string, error) {
	var contract = sdk.GetContract(chaincode)

	data, err := contract.EvaluateTransaction(tx, args)
	if err != nil {
		return "", fmt.Errorf("EvaluateTransaction: execute contract: %w", err)
	}

	return string(data), nil
}

// SubmitTransaction will submit a transaction `tx` to the ledger with given `args` passed as JSON on specified `chaincode`.
func (sdk *SDK) SubmitTransaction(chaincode, tx string, args string) (string, error) {
	var contract = sdk.GetContract(chaincode)

	data, err := contract.SubmitTransaction(tx, args)
	if err != nil {
		return "", fmt.Errorf("SubmitTransaction: execute contract: %w", err)
	}

	return string(data), nil
}
