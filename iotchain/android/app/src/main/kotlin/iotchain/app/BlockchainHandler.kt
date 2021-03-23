package chainmetric.app

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import sdk.IoTChainClient

class BlockchainHandler : MethodChannel.MethodCallHandler {
    private val client = IoTChainClient()

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        CoroutineScope(Dispatchers.IO).launch {
            when (call.method) {
                "wallet_init" -> try {
                    client.initWallet(call.argument("path"))
                    withContext(Dispatchers.Main) {
                        result.success("Wallet ready")
                    }
                } catch (e: Exception) {
                    withContext(Dispatchers.Main) {
                        result.error("IoTChainClient_initWallet", e.message, null)
                    }
                }
                "auth_required" -> withContext(Dispatchers.Main) {
                    result.success(withContext(Dispatchers.IO) { client.authRequired() })
                }
                "auth_identity" -> try {
                    client.authIdentity(call.argument("orgID"), call.argument("key"), call.argument("cert"))
                    withContext(Dispatchers.Main) {
                        result.success("Authenticated")
                    }
                } catch (e: Exception) {
                    withContext(Dispatchers.Main) {
                        result.error("IoTChainClient_authIdentity", e.message, null)
                    }
                }
                "connection_init" -> try {
                    val channel = call.argument<String>("channel")
                    client.initConnectionOn(call.argument("config"), channel)
                    withContext(Dispatchers.Main) {
                        result.success("Connected to $channel")
                    }
                } catch (e: Exception) {
                    withContext(Dispatchers.Main) {
                        result.error("IoTChainClient_initConnectionFor", e.message, null)
                    }
                }
                "transaction_evaluate" -> try {
                    val response = client.evaluateTransaction(call.argument("contract"), call.argument("method"), call.argument("args"))
                    withContext(Dispatchers.Main) {
                        result.success(response)
                    }
                } catch (e: Exception) {
                    withContext(Dispatchers.Main) {
                        result.error("IoTChainClient_evaluateTransaction", e.message, null)
                    }
                }
                "transaction_submit" -> try {
                    val response = client.submitTransaction(call.argument("contract"), call.argument("method"), call.argument("args"))
                    withContext(Dispatchers.Main) {
                        result.success(response)
                    }
                } catch (e: Exception) {
                    withContext(Dispatchers.Main) {
                        result.error("IoTChainClient_submitTransaction", e.message, null)
                    }
                }
                else -> throw IllegalStateException("Unexpected value: " + call.method)
            }
        }
    }
}
