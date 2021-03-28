package sdk

import (
	"context"

	"github.com/hyperledger/fabric-sdk-go/pkg/gateway"
	"github.com/pkg/errors"
)

const (
	ReadingsContractName = "readings"
)

type ReadingsContract struct {
	sdk      *BlockchainSDK
	contract *gateway.Contract
}

func NewReadingsContract(sdk *BlockchainSDK) *ReadingsContract {
	return &ReadingsContract{
		sdk:      sdk,
		contract: sdk.network.GetContract(ReadingsContractName),
	}
}

func (rc *ReadingsContract) ForAsset(assetID string) (string, error) {
	data, err := rc.contract.EvaluateTransaction("ForAsset", assetID)
	return string(data), errors.Wrap(err, "failed executing 'ForAsset' transaction")
}

func (rc *ReadingsContract) ForMetric(assetID, metric string) (string, error) {
	data, err := rc.contract.EvaluateTransaction("ForMetric", assetID, metric)
	return string(data), errors.Wrap(err, "failed executing 'ForMetric' transaction")
}

func (rc *ReadingsContract) RequestEventEmittingFor(assetID, metric string) (string, error) {
	eventToken, err := rc.contract.SubmitTransaction("RequestEventEmittingFor", assetID, metric)
	return string(eventToken), errors.Wrap(err, "failed executing 'RequestEventEmittingFor' transaction")
}

func (rc *ReadingsContract) CancelEventEmitting(eventToken string) error {
	_, err := rc.contract.SubmitTransaction("CancelEventEmitting", eventToken)
	return errors.Wrap(err, "failed executing 'RequestEventEmittingFor' transaction")
}

func (rc *ReadingsContract) SubscribeFor(assetID, metric string) (*EventChannel, error) {
	var (
		channel = NewEventsChannel()
	)

	eventToken, err := rc.RequestEventEmittingFor(assetID, metric); if err != nil {
		return nil, err
	}

	reg, notifier, err := rc.contract.RegisterEvent(eventToken)
	if err != nil {
		return nil, errors.Wrap(err, "failed executing 'SubscribeFor' transaction")
	}

	ctx, cancel := context.WithCancel(context.Background())
	channel.SetCancel(func() {
		cancel()
		rc.CancelEventEmitting(eventToken)
	})

	go func() {
		defer rc.contract.Unregister(reg)

		for {
			select {
			case event := <-notifier:
				if channel.handler != nil {
					channel.handler.HandleEvent(string(event.Payload))
				}
			case <- ctx.Done():
				return
			}
		}
	}()

	return channel, nil
}

