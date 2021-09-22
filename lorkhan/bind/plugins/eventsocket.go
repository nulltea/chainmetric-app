package plugins

import (
	"context"
	"fmt"

	"github.com/hyperledger/fabric-sdk-go/pkg/gateway"
	"github.com/timoth-y/chainmetric-app/lorkhan/bind/events"
	"github.com/timoth-y/chainmetric-app/lorkhan/bind/fabric"
	"github.com/timoth-y/chainmetric-app/lorkhan/internal/utils"
)
// EventSocket defines plugin for subscribing to events on Hyperledger network.
type EventSocket struct {
	sdk      *fabric.SDK
	contract *gateway.Contract
}

// NewEventSocket constructs new EventSocket instance.
func NewEventSocket(sdk *fabric.SDK, chaincode string) *EventSocket {
	return &EventSocket{
		sdk: sdk,
		contract: sdk.GetContract(chaincode),
	}
}

// Bind makes 'BindToEventSocket' transaction to request events streaming subscription,
// and subscribes to event, which name corresponds received event token.
func (p *EventSocket) Bind(arguments string) (*events.EventChannel, error) {
	args, err := utils.TryParseArgs(arguments)
	if err != nil {
		return nil, err
	}

	eventToken, err := p.contract.SubmitTransaction("BindToEventSocket", args...)
	if err != nil {
		return nil, fmt.Errorf("failed executing 'BindToEventSocket' transaction: %w", err)
	}

	ch, err := p.Subscribe(string(eventToken))
	if err != nil {
		return nil, fmt.Errorf("failed subscribe to events with token '%s': %w", eventToken, err)
	}

	ch.SetCancel(func() {
		p.close(string(eventToken))
	})

	return ch, nil
}

// Subscribe subscribes to generic event on network with given `event` name.
func (p *EventSocket) Subscribe(event string) (*events.EventChannel, error) {
	var channel = events.NewChannel()

	reg, notifier, err := p.contract.RegisterEvent(event); if err != nil {
		return nil, fmt.Errorf("failed executing 'SubscribeFor' transaction: %w", err)
	}

	ctx, cancel := context.WithCancel(context.Background())
	channel.SetCancel(cancel)

	go func() {
		defer p.contract.Unregister(reg)

		for {
			select {
			case e := <-notifier:
				channel.HandleEvent(string(e.Payload))
			case <- ctx.Done():
				return
			}
		}
	}()

	return channel, nil
}

// close makes 'CloseEventSocket' transaction to close subscription.
func (p *EventSocket) close(eventToken string) error {
	_, err := p.contract.SubmitTransaction("CloseEventSocket", eventToken)
	return fmt.Errorf("failed executing 'CloseEventSocket' transaction: %w", err)
}
