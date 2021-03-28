package chainmetric.app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val blockchainHandler = BlockchainHandler()
    private val readingsContractHandler = ReadingsContractHandler()
    private val readingsEventsHandler = ReadingsEventsHandler()

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, BLOCKCHAIN_CHANNEL)
                .setMethodCallHandler(blockchainHandler)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, READINGS_CHANNEL)
                .setMethodCallHandler(readingsContractHandler)
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, READINGS_EVENTS_CHANNEL)
                .setStreamHandler(readingsEventsHandler)
    }
}
