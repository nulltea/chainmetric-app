import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Notifications {
  late final FirebaseMessaging _messaging;

  Notifications(): _messaging = FirebaseMessaging.instance;

  Future<void> registerNotification() async {
    await Firebase.initializeApp();

    _messaging = FirebaseMessaging.instance;

    final settings = await _messaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      // TODO: handle the received notifications
    } else {
      print('User declined or has not accepted permission');
    }
  }
}