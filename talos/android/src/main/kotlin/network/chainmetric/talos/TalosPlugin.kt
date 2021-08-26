package network.chainmetric.talos

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodChannel
import network.chainmetric.talos.controllers.AuthVault
import network.chainmetric.talos.controllers.HyperledgerHandler
import app.loup.streams_channel.StreamsChannel;
import network.chainmetric.talos.controllers.EventSocketHandler

const val BLOCKCHAIN_CHANNEL = "network.chainmetric.talos/hyperledger"
const val VAULT_CHANNEL = "network.chainmetric.talos/plugins/auth_vault"
const val EVENTSOCKET_CHANNEL = "network.chainmetric.talos/plugins/eventsocket"

class TalosPlugin: FlutterPlugin {
  private val hyperledgerSDK = hyperledger.SDK();
  private val hyperledgerHandler = HyperledgerHandler(hyperledgerSDK);
  private val vaultHandler = AuthVault(hyperledgerSDK)

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    MethodChannel(flutterPluginBinding.binaryMessenger, BLOCKCHAIN_CHANNEL)
            .setMethodCallHandler(hyperledgerHandler)
    MethodChannel(flutterPluginBinding.binaryMessenger, VAULT_CHANNEL)
            .setMethodCallHandler(vaultHandler)
    StreamsChannel(flutterPluginBinding.binaryMessenger, EVENTSOCKET_CHANNEL)
            .setStreamHandlerFactory {
              EventSocketHandler(hyperledgerSDK)
            }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {}
}