package main

import (
	"github.com/timoth-y/chainmetric-app/go-sdk/internal/core"
	"golang.org/x/mobile/app"
	"golang.org/x/mobile/event/lifecycle"
)

func main() {
	app.Main(func(a app.App) {
		for e := range a.Events() {
			switch e := a.Filter(e).(type) {
			case lifecycle.Event:
				switch e.Crosses(lifecycle.StageVisible) {
				case lifecycle.CrossOn:
					core.Init()
					// TODO: init SDK
				}
			}
		}
	})
}
