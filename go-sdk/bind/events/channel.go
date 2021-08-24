package events

import "context"

type EventHandler interface {
	HandleEvent(string) error
}

type EventChannel struct {
	EventHandler
	cancel  context.CancelFunc
}

func NewChannel() *EventChannel {
	return &EventChannel{}
}

func (ec *EventChannel) SetHandler(handler EventHandler) {
	ec.EventHandler = handler
}

func (ec *EventChannel) SetCancel(cancel context.CancelFunc) {
	ec.cancel = cancel
}

func (ec *EventChannel) Cancel() {
	ec.cancel()
}

