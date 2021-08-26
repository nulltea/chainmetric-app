package network.chainmetric.talos.controllers

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

class HyperledgerHandler(private val sdk: hyperledger.SDK): MethodChannel.MethodCallHandler {
    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        CoroutineScope(Dispatchers.IO).launch {
            when (call.method) {
                "wallet_init" -> try {
                    sdk.initWallet(call.argument("path"))
                    withContext(Dispatchers.Main) {
                        result.success("Wallet ready")
                    }
                } catch (e: Exception) {
                    withContext(Dispatchers.Main) {
                        result.error("HyperledgerSDK_initWallet", e.message, null)
                    }
                }
                "auth_required" -> withContext(Dispatchers.Main) {
                    result.success(withContext(Dispatchers.IO) { sdk.authRequired() })
                }
                "auth_identity" -> try {
                    sdk.authX509(call.argument("orgID"), call.argument("key"), call.argument("cert"))
                    withContext(Dispatchers.Main) {
                        result.success("Authenticated")
                    }
                } catch (e: Exception) {
                    withContext(Dispatchers.Main) {
                        result.error("HyperledgerSDK_authIdentity", e.message, null)
                    }
                }
                "connection_init" -> try {
                    val channel = call.argument<String>("channel")
                    sdk.initConnectionOn(call.argument("config"), channel)
                    withContext(Dispatchers.Main) {
                        result.success("Connected to $channel")
                    }
                } catch (e: Exception) {
                    withContext(Dispatchers.Main) {
                        result.error("HyperledgerSDK_initConnectionFor", e.message, null)
                    }
                }
                "transaction_evaluate" -> try {
                    val response = sdk.evaluateTransaction(call.argument("contract"), call.argument("method"), call.argument("args"))
                    withContext(Dispatchers.Main) {
                        result.success(response)
                    }
                } catch (e: Exception) {
                    withContext(Dispatchers.Main) {
                        result.error("HyperledgerSDK_evaluateTransaction", e.message, null)
                    }
                }
                "transaction_submit" -> try {
                    val response = sdk.submitTransaction(call.argument("contract"), call.argument("method"), call.argument("args"))
                    withContext(Dispatchers.Main) {
                        result.success(response)
                    }
                } catch (e: Exception) {
                    withContext(Dispatchers.Main) {
                        result.error("HyperledgerSDK_submitTransaction", e.message, null)
                    }
                }
                else -> throw IllegalStateException("Invalid operation: ${call.method}")
            }
        }
    }
}
