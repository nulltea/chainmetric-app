package hyperledger

import "github.com/pkg/errors"

func (sdk *SDK) EvaluateTransaction(chaincode, transaction string, args string) (string, error) {
	contract := sdk.network.GetContract(chaincode)
	data, err := contract.EvaluateTransaction(transaction, args)
	return string(data), errors.Wrap(err, "EvaluateTransaction: execute contract")
}

func (sdk *SDK) SubmitTransaction(chaincode, transaction string, args string) (string, error) {
	contract := sdk.network.GetContract(chaincode)
	data, err := contract.SubmitTransaction(transaction, args)
	return string(data), errors.Wrap(err, "SubmitTransaction: execute contract")
}
