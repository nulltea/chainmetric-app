package chainmetric

import (
	"context"

	"github.com/hyperledger/fabric-sdk-go/pkg/gateway"
	"github.com/pkg/errors"
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
	return string(data), errors.Wrap(err, "failed executing 'ForAsset' transaction")
}

func (rc *ReadingsContract) ForMetric(assetID, metric string) (string, error) {
	data, err := rc.contract.EvaluateTransaction("ForMetric", assetID, metric)
	return string(data), errors.Wrap(err, "failed executing 'ForMetric' transaction")
}

func (rc *ReadingsContract) BindToEventSocket(assetID, metric string) (string, error) {
	eventToken, err := rc.contract.SubmitTransaction("BindToEventSocket", assetID, metric)
	return string(eventToken), errors.Wrap(err, "failed executing 'BindToEventSocket' transaction")
}

func (rc *ReadingsContract) CloseEventSocket(eventToken string) error {
	_, err := rc.contract.SubmitTransaction("CloseEventSocket", eventToken)
	return errors.Wrap(err, "failed executing 'CloseEventSocket' transaction")
}

func (rc *ReadingsContract) SubscribeFor(assetID, metric string) (*events.EventChannel, error) {
	var (
		channel = events.NewChannel()
	)

	eventToken, err := rc.BindToEventSocket(assetID, metric); if err != nil {
		return nil, err
	}

	reg, notifier, err := rc.contract.RegisterEvent(eventToken); if err != nil {
		return nil, errors.Wrap(err, "failed executing 'SubscribeFor' transaction")
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

