package chainmetric

import (
	"context"
	"fmt"

	"github.com/hyperledger/fabric-sdk-go/pkg/gateway"
	"github.com/timoth-y/chainmetric-app/go-sdk/bind/events"
	"github.com/timoth-y/chainmetric-app/go-sdk/bind/hyperledger"
)

type ReadingsContract struct {
	sdk      *hyperledger.SDK
	contract *gateway.Contract
}

func NewReadingsContract(sdk *hyperledger.SDK) *ReadingsContract {
	return &ReadingsContract{
		sdk:      sdk,
		contract: sdk.GetContract("readings"),
	}
}

func (rc *ReadingsContract) ForAsset(assetID string) (string, error) {
	data, err := rc.contract.EvaluateTransaction("ForAsset", assetID)
	return string(data), fmt.Errorf("failed executing 'ForAsset' transaction: %w", err)
}

func (rc *ReadingsContract) ForMetric(assetID, metric string) (string, error) {
	data, err := rc.contract.EvaluateTransaction("ForMetric", assetID, metric)
	return string(data), fmt.Errorf("failed executing 'ForMetric' transaction: %w", err)
}

func (rc *ReadingsContract) BindToEventSocket(assetID, metric string) (string, error) {
	eventToken, err := rc.contract.SubmitTransaction("BindToEventSocket", assetID, metric)
	return string(eventToken), fmt.Errorf("failed executing 'BindToEventSocket' transaction: %w", err)
}

func (rc *ReadingsContract) CloseEventSocket(eventToken string) error {
	_, err := rc.contract.SubmitTransaction("CloseEventSocket", eventToken)
	return fmt.Errorf("failed executing 'CloseEventSocket' transaction: %w", err)
}

func (rc *ReadingsContract) SubscribeFor(assetID, metric string) (*events.EventChannel, error) {
	var (
		channel = events.NewChannel()
	)

	eventToken, err := rc.BindToEventSocket(assetID, metric); if err != nil {
		return nil, err
	}

	reg, notifier, err := rc.contract.RegisterEvent(eventToken); if err != nil {
		return nil, fmt.Errorf("failed executing 'SubscribeFor' transaction: %w", err)
	}

	ctx, cancel := context.WithCancel(context.Background())
	channel.SetCancel(func() {
		cancel()
		rc.CloseEventSocket(eventToken)
	})

	go func() {
		defer rc.contract.Unregister(reg)

		for {
			select {
			case event := <-notifier:
				channel.HandleEvent(string(event.Payload))
			case <- ctx.Done():
				return
			}
		}
	}()

	return channel, nil
}

