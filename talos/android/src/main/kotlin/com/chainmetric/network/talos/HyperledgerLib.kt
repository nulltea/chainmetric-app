package com.chainmetric.network.talos

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

val hyperledgerSDK = hyperledger.SDK();
const val BLOCKCHAIN_CHANNEL = "com.chainmetric.network.talos/hyperledger"

class BlockchainHandler : MethodChannel.MethodCallHandler {
    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        CoroutineScope(Dispatchers.IO).launch {
            when (call.method) {
                "wallet_init" -> try {
                    hyperledger.initWallet(call.argument("path"))
                    withContext(Dispatchers.Main) {
                        result.success("Wallet ready")
                    }
                } catch (e: Exception) {
                    withContext(Dispatchers.Main) {
                        result.error("BlockchainSDK_initWallet", e.message, null)
                    }
                }
                "auth_required" -> withContext(Dispatchers.Main) {
                    result.success(withContext(Dispatchers.IO) { hyperledger.authRequired() })
                }
                "auth_identity" -> try {
                    hyperledger.authIdentity(call.argument("orgID"), call.argument("key"), call.argument("cert"))
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
                    hyperledger.initConnectionOn(call.argument("config"), channel)
                    hyperledger.init()
                    withContext(Dispatchers.Main) {
                        result.success("Connected to $channel")
                    }
                } catch (e: Exception) {
                    withContext(Dispatchers.Main) {
                        result.error("BlockchainSDK_initConnectionFor", e.message, null)
                    }
                }
                "transaction_evaluate" -> try {
                    val response = hyperledger.evaluateTransaction(call.argument("contract"), call.argument("method"), call.argument("args"))
                    withContext(Dispatchers.Main) {
                        result.success(response)
                    }
                } catch (e: Exception) {
                    withContext(Dispatchers.Main) {
                        result.error("BlockchainSDK_evaluateTransaction", e.message, null)
                    }
                }
                "transaction_submit" -> try {
                    val response = hyperledger.submitTransaction(call.argument("contract"), call.argument("method"), call.argument("args"))
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
