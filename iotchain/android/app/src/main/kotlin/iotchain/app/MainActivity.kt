package iotchain.app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import sdk.IoTChainClient

const val CHANNEL = "iotchain.app/sdk-go"

class MainActivity: FlutterActivity() {
    private val client = IoTChainClient()

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            when (call.method) {
                "wallet_init" -> try {
                    client.initWallet(call.argument("path"))
                    result.success("Wallet ready")
                } catch (e: Exception) {
                    result.error("IoTChainClient_initWallet", e.message, null)
                }
                "auth_required" -> result.success(client.authRequired())
                "auth_identity" -> try {
                    client.authIdentity(call.argument("orgID"), call.argument("key"), call.argument("cert"))
                    result.success("Authenticated")
                } catch (e: Exception) {
                    result.error("IoTChainClient_initWallet", e.message, null)
                }
                "connection_init" -> try {
                    val channel = call.argument<String>("channel")
                    client.initConnectionOn(call.argument("config"), channel)
                    result.success("Connected to $channel");
                } catch (e: Exception) {
                    result.error("IoTChainClient_initConnectionFor", e.message, null)
                }
                "transaction_evaluate" -> try {
                    result.success(client.evaluateTransaction(call.argument("contract"), call.argument("method"), ""))
                } catch (e: Exception) {
                    result.error("IoTChainClient_evaluateTransaction", e.message, null)
                }
                else -> throw IllegalStateException("Unexpected value: " + call.method)
            }
        }
    }
}
