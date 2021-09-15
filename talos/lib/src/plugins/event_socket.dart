import 'dart:convert';

import 'package:streams_channel2/streams_channel2.dart';

const socketChannel = "network.chainmetric.talos/plugins/eventsocket";
typedef SocketListener = void Function(dynamic val);
typedef CancelListening = void Function();

class EventSocket {
  static final _channel = StreamsChannel(socketChannel);

  static Future<CancelListening> bind(SocketListener listener,
      String chaincode, [dynamic args]) async {
    final subscription = _channel
        .receiveBroadcastStream(["bind", chaincode, json.encode(args)])
        .listen((eventArtifact) {
      listener(eventArtifact);
    }, cancelOnError: false);

    return subscription.cancel;
  }

  static Future<CancelListening> subscribe(SocketListener listener,
      String chaincode, String eventName) async {
    final subscription = _channel
        .receiveBroadcastStream(["subscribe", chaincode, eventName])
        .listen((eventArtifact) {
      listener(eventArtifact);
    }, cancelOnError: false);

    return subscription.cancel;
  }
}