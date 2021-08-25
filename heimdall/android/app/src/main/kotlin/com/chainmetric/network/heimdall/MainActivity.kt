package chainmetric.app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import app.loup.streams_channel.StreamsChannel

class MainActivity : FlutterActivity() {
    private val blockchainHandler = BlockchainHandler()
    private val readingsContractHandler = ReadingsContractHandler()

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, BLOCKCHAIN_CHANNEL)
                .setMethodCallHandler(blockchainHandler)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, READINGS_CHANNEL)
                .setMethodCallHandler(readingsContractHandler)
        StreamsChannel(flutterEngine.dartExecutor.binaryMessenger, READINGS_EVENTS_CHANNEL)
                .setStreamHandlerFactory {
                    ReadingsEventsHandler()
                }
    }
}
