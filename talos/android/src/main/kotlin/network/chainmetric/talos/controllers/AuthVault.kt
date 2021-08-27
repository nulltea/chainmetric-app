package network.chainmetric.talos.controllers

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import plugins.Plugins;

class AuthVault(sdk: hyperledger.SDK) : MethodChannel.MethodCallHandler {
    private val plugin = Plugins.newAuthVault(sdk)

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        CoroutineScope(Dispatchers.IO).launch {
            when (call.method) {
                "authenticate" -> try {
                    plugin.authenticate(call.argument("orgID"), call.argument("path"),
                            call.argument("token"))
                    withContext(Dispatchers.Main) {
                        result.success("Authenticated")
                    }
                } catch (e: Exception) {
                    withContext(Dispatchers.Main) {
                        result.error("AuthVault_authenticate", e.message, null)
                    }
                }
                else -> throw IllegalStateException("Invalid operation: ${call.method}")
            }
        }
    }
}