package network.chainmetric.talos.controllers

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

class FabricHandler(private val sdk: fabric.SDK): MethodChannel.MethodCallHandler {
    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        CoroutineScope(Dispatchers.IO).launch {
            when (call.method) {
                "wallet_init" -> try {
                    sdk.initWallet(call.argument("path"))
                    withContext(Dispatchers.Main) {
                        result.success(0)
                    }
                } catch (e: Exception) {
                    withContext(Dispatchers.Main) {
                        result.error("FabricSDK::initWallet", e.message, null)
                    }
                }
                "identity_required" -> withContext(Dispatchers.Main) {
                    result.success(withContext(Dispatchers.IO) { sdk.identityRequired() })
                }
                "identities_get" -> try {
                    withContext(Dispatchers.Main) {
                        result.success(sdk.identities)
                    }
                } catch (e: Exception) {
                    withContext(Dispatchers.Main) {
                        result.error("FabricSDK::getIdentities", e.message, null)
                    }
                }
                "identity_put" -> try {
                    sdk.putX509Identity(
                        call.argument("username"),
                        call.argument("org"),
                        call.argument("cert"),
                        call.argument("key"),
                    )
                    withContext(Dispatchers.Main) {
                        result.success(0)
                    }
                } catch (e: Exception) {
                    withContext(Dispatchers.Main) {
                        result.error("FabricSDK::putX509Identity", e.message, null)
                    }
                }
                "identity_remove" -> try {
                    sdk.removeIdentity(call.argument("username"))
                    withContext(Dispatchers.Main) {
                        result.success(0)
                    }
                } catch (e: Exception) {
                    withContext(Dispatchers.Main) {
                        result.error("FabricSDK::removeIdentity", e.message, null)
                    }
                }
                "connection_setup" -> try {
                    sdk.setupConnectionToChannel(
                        call.argument("config"),
                        call.argument("channel"),
                        call.argument("username")
                    )
                    withContext(Dispatchers.Main) {
                        result.success(0)
                    }
                } catch (e: Exception) {
                    withContext(Dispatchers.Main) {
                        result.error("FabricSDK::setupConnectionToChannel", e.message, null)
                    }
                }
                "transaction_evaluate" -> try {
                    val response = sdk.evaluateTransaction(call.argument("contract"), call.argument("method"), call.argument("args"))
                    withContext(Dispatchers.Main) {
                        result.success(response)
                    }
                } catch (e: Exception) {
                    withContext(Dispatchers.Main) {
                        result.error("FabricSDK::evaluateTransaction", e.message, null)
                    }
                }
                "transaction_submit" -> try {
                    val response = sdk.submitTransaction(call.argument("contract"), call.argument("method"), call.argument("args"))
                    withContext(Dispatchers.Main) {
                        result.success(response)
                    }
                } catch (e: Exception) {
                    withContext(Dispatchers.Main) {
                        result.error("FabricSDK::submitTransaction", e.message, null)
                    }
                }
                else -> throw IllegalStateException("Invalid operation: ${call.method}")
            }
        }
    }
}
