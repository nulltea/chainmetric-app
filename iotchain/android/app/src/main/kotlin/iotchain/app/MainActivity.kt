package iotchain.app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


const val BLOCKCHAIN_CHANNEL = "iotchain.app.blockchain-native-sdk"

class MainActivity : FlutterActivity() {
    private val blockchainHandler = BlockchainHandler()

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, BLOCKCHAIN_CHANNEL)
                .setMethodCallHandler(blockchainHandler)
    }
}
