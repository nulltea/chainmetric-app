package plugins

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/hyperledger/fabric-sdk-go/pkg/gateway"
	"github.com/timoth-y/chainmetric-app/lorkhan/bind/events"
	"github.com/timoth-y/chainmetric-app/lorkhan/bind/hyperledger"
)
// EventSocket defines plugin for subscribing to events on Hyperledger network.
type EventSocket struct {
	sdk      *hyperledger.SDK
	contract *gateway.Contract
}

// NewEventSocket constructs new EventSocket instance.
func NewEventSocket(sdk *hyperledger.SDK, chaincode string) *EventSocket {
	return &EventSocket{
		sdk: sdk,
		contract: sdk.GetContract(chaincode),
	}
}

// Bind makes 'BindToEventSocket' transaction to request events streaming subscription,
// and subscribes to event, which name corresponds received event token.
func (p *EventSocket) Bind(args string) (*events.EventChannel, error) {
	var (
		argsSlice []string
	)

	if err := json.Unmarshal([]byte(args), &argsSlice); err != nil {
		return nil, err
	}

	eventToken, err := p.contract.SubmitTransaction("BindToEventSocket", argsSlice...)
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
			case event := <-notifier:
				channel.HandleEvent(string(event.Payload))
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
