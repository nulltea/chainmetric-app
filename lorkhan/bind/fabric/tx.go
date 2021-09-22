package fabric

import (
	"fmt"

	"github.com/timoth-y/chainmetric-app/lorkhan/internal/utils"
)

// EvaluateTransaction will evaluate a transaction `tx` with given `arguments` passed as JSON on specified `chaincode`.
func (sdk *SDK) EvaluateTransaction(chaincode, tx string, arguments string) (string, error) {
	var (
		contract  = sdk.GetContract(chaincode)
		args, err = utils.TryParseArgs(arguments)
	)

	if err != nil {
		return "", err
	}

	data, err := contract.EvaluateTransaction(tx, args...)
	if err != nil {
		return "", fmt.Errorf("EvaluateTransaction: execute contract: %w", err)
	}

	return string(data), nil
}

// SubmitTransaction will submit a transaction `tx` to the ledger with given `arguments` passed as JSON on specified `chaincode`.
func (sdk *SDK) SubmitTransaction(chaincode, tx string, arguments string) (string, error) {
	var (
		contract  = sdk.GetContract(chaincode)
		args, err = utils.TryParseArgs(arguments)
	)

	if err != nil {
		return "", err
	}

	data, err := contract.SubmitTransaction(tx, args...)
	if err != nil {
		return "", fmt.Errorf("SubmitTransaction: execute contract: %w", err)
	}

	return string(data), nil
}
