package chainmetric.app

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import sdk.BlockchainSDK

val blockchainSDK = BlockchainSDK()
const val BLOCKCHAIN_CHANNEL = "chainmetric.app.blockchain-native-sdk"

class BlockchainHandler : MethodChannel.MethodCallHandler {
    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        CoroutineScope(Dispatchers.IO).launch {
            when (call.method) {
                "wallet_init" -> try {
                    blockchainSDK.initWallet(call.argument("path"))
                    withContext(Dispatchers.Main) {
                        result.success("Wallet ready")
                    }
                } catch (e: Exception) {
                    withContext(Dispatchers.Main) {
                        result.error("BlockchainSDK_initWallet", e.message, null)
                    }
                }
                "auth_required" -> withContext(Dispatchers.Main) {
                    result.success(withContext(Dispatchers.IO) { blockchainSDK.authRequired() })
                }
                "auth_identity" -> try {
                    blockchainSDK.authIdentity(call.argument("orgID"), call.argument("key"), call.argument("cert"))
                    withContext(Dispatchers.Main) {
                        result.success("Authenticated")
                    }
                } catch (e: Exception) {
                    withContext(Dispatchers.Main) {
                        result.error("BlockchainSDK_authIdentity", e.message, null)
                    }
                }
                "connection_init" -> try {
                    val channel = call.argument<String>("channel")
                    blockchainSDK.initConnectionOn(call.argument("config"), channel)
                    blockchainSDK.init()
                    withContext(Dispatchers.Main) {
                        result.success("Connected to $channel")
                    }
                } catch (e: Exception) {
                    withContext(Dispatchers.Main) {
                        result.error("BlockchainSDK_initConnectionFor", e.message, null)
                    }
                }
                "transaction_evaluate" -> try {
                    val response = blockchainSDK.evaluateTransaction(call.argument("contract"), call.argument("method"), call.argument("args"))
                    withContext(Dispatchers.Main) {
                        result.success(response)
                    }
                } catch (e: Exception) {
                    withContext(Dispatchers.Main) {
                        result.error("BlockchainSDK_evaluateTransaction", e.message, null)
                    }
                }
                "transaction_submit" -> try {
                    val response = blockchainSDK.submitTransaction(call.argument("contract"), call.argument("method"), call.argument("args"))
                    withContext(Dispatchers.Main) {
                        result.success(response)
                    }
                } catch (e: Exception) {
                    withContext(Dispatchers.Main) {
                        result.error("BlockchainSDK_submitTransaction", e.message, null)
                    }
                }
                else -> throw IllegalStateException("Invalid operation: ${call.method}")
            }
        }
    }
}
