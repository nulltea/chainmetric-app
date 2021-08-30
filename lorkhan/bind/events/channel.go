package events

import "context"

// EventHandler defines interface for binding Event channel between platform and gomobile backend.
type EventHandler interface {
	HandleEvent(string) error
}

// EventChannel defines event channel with passing events to platform.
type EventChannel struct {
	EventHandler
	cancel  []context.CancelFunc
}

// NewChannel contracts new EventChannel instance.
func NewChannel() *EventChannel {
	return &EventChannel{}
}

// SetHandler binds platform-side EventHandler implementation to EventChannel.
func (ec *EventChannel) SetHandler(handler EventHandler) {
	ec.EventHandler = handler
}

// SetCancel allows adding cancel action executed closing EventChannel.
func (ec *EventChannel) SetCancel(cancel context.CancelFunc) {
	ec.cancel = append(ec.cancel, cancel)
}

// Cancel closes EventChannel and executed actions assigned with SetCancel.
func (ec *EventChannel) Cancel() {
	for i := range ec.cancel {
		ec.cancel[i]()
	}
}

