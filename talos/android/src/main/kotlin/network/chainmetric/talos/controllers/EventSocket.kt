package network.chainmetric.talos.controllers

import io.flutter.plugin.common.EventChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class EventSocketHandler(sdk: hyperledger.SDK) : EventChannel.StreamHandler {
    private val channels = mutableMapOf<String, events.EventChannel>()

    override fun onListen(event: Any?, events: EventChannel.EventSink?) {
        CoroutineScope(Dispatchers.IO).launch {
            val args = (event as String).split(".")
            when (val eventName = args[0]) {
                "posted" -> {
                    val chaincode = args[1]
                    val metric = args[2]
                    val channel = sdk.readings.subscribeFor(chaincode, metric)
                    channels[event] = channel
                    channel.setHandler {
                        artifact -> CoroutineScope(Dispatchers.Main).launch {
                        events?.success(artifact)
                    }
                    }
                }
                else -> throw IllegalStateException("Event '$eventName' unsupported")
            }
        }
    }

    override fun onCancel(event: Any?) {
        CoroutineScope(Dispatchers.IO).launch {
            channels[event]?.cancel()
        }
    }
}