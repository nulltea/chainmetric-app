package chainmetric.app

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

const val READINGS_CHANNEL = "chainmetric.app.blockchain-native-sdk/contracts/readings"
const val READINGS_EVENTS_CHANNEL = "chainmetric.app.blockchain-native-sdk/events/readings"

class ReadingsContractHandler : MethodChannel.MethodCallHandler {
    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        CoroutineScope(Dispatchers.IO).launch {
            when (call.method) {
                "for_asset" -> try {
                    val response = blockchainSDK.readings.forAsset(call.argument("asset"))
                    withContext(Dispatchers.Main) {
                        result.success(response)
                    }
                } catch (e: Exception) {
                    withContext(Dispatchers.Main) {
                        result.error("ReadingsContract_forAsset", e.message, null)
                    }
                }
                "for_metric" -> try {
                    val response = blockchainSDK.readings.forMetric(call.argument("asset"), call.argument("metric"))
                    withContext(Dispatchers.Main) {
                        result.success(response)
                    }
                } catch (e: Exception) {
                    withContext(Dispatchers.Main) {
                        result.error("ReadingsContract_evaluateTransaction", e.message, null)
                    }
                }
                else -> throw IllegalStateException("Transaction '${call.method}' unsupported")
            }
        }
    }
}
