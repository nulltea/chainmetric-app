package go_sdk

import "context"

type EventHandler interface {
	HandleEvent(string) error
}

type EventChannel struct {
	handler EventHandler
	cancel context.CancelFunc
}

func NewEventsChannel() *EventChannel {
	return &EventChannel{}
}

func (ec *EventChannel) SetHandler(handler EventHandler) {
	ec.handler = handler
}

func (ec *EventChannel) SetCancel(cancel context.CancelFunc) {
	ec.cancel = cancel
}

func (ec *EventChannel) Cancel() {
	ec.cancel()
}

