package sdk

import (
	"context"
	"fmt"

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
	cancelToken, err := rc.contract.SubmitTransaction("RequestEventEmittingFor", assetID, metric)
	return string(cancelToken), errors.Wrap(err, "failed executing 'RequestEventEmittingFor' transaction")
}

func (rc *ReadingsContract) SubscribeFor(assetID, metric string) (*EventChannel, error) {
	var (
		channel = NewEventsChannel()
	)

	reg, notifier, err := rc.contract.RegisterEvent(fmt.Sprintf("readings.posted.%s.%s", assetID, metric))
	if err != nil {
		return nil, errors.Wrap(err, "failed executing 'SubscribeFor' transaction")
	}

	ctx, cancel := context.WithCancel(context.Background())
	channel.SetCancel(cancel)

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

