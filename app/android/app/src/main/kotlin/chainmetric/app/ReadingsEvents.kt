package chainmetric.app

import io.flutter.plugin.common.EventChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch


class ReadingsEventsHandler : EventChannel.StreamHandler {
    private val channels = mutableMapOf<String, sdk.EventChannel>()

    override fun onListen(event: Any?, events: EventChannel.EventSink) {
        CoroutineScope(Dispatchers.IO).launch {
            val args = (event as String).split(".")
            when (val eventName = args[0]) {
                "posted" -> {
                    val assetID = args[1]
                    val metric = args[2]
                    val channel = blockchainSDK.readings.subscribeFor(assetID, metric)
                    channels[event] = channel
                    channel.setHandler {
                        artifact -> events.success(artifact)
                    }
                }
                else -> throw IllegalStateException("Event '$eventName' unsupported")
            }
        }
    }

    override fun onCancel(event: Any?) {
        channels[event]?.cancel()
    }
}
