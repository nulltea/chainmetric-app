import 'package:chainmetric/app/utils/utils.dart';
import 'package:chainmetric/app/pages/readings/readings_page.dart';
import 'package:chainmetric/infrastructure/repositories/certificates_vault.dart';
import 'package:chainmetric/infrastructure/services/subscriber_grpc.dart';
import 'package:chainmetric/models/assets/asset.dart';
import 'package:chainmetric/models/notifications/subscription.pb.dart';
import 'package:chainmetric/platform/repositories/identities_shared.dart';
import 'package:chainmetric/shared/logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';

class NotificationsManager {
  final String _organization;
  static final FirebaseMessaging _fcmClient = FirebaseMessaging.instance;

  NotificationsManager(this._organization);

  static Future<void> registerDriver(GlobalKey<NavigatorState> key) async {
    await Firebase.initializeApp();

    final settings = await _fcmClient.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        openPage(key.currentContext!,
            ReadingsPage(
                pageView: true,
                asset: Asset.empty(id: event.data["asset_id"])
            ));
      });
    } else {
      logger.i('User declined or has not accepted permission');
    }
  }

  Future<bool> subscribeToRequirementsViolationOf(String assetID,
      {List<String>? metrics}) async {

    try {
      await SubscriberService(_organization,
          certificate: await CertificatesResolver(_organization)
              .resolveBytes("notifications-client"),
          accessToken: IdentitiesRepo.accessToken,
          firebaseToken: await _fcmClient.getToken()
      ).subscribe(SubscriptionRequest(
          requirementsViolation: SubscriptionRequest_RequirementsViolationEventArgs(
            assetID: assetID,
            metrics: metrics,
          )
      ));
    } on GrpcError catch (e) {
      switch (e.code) {
        case StatusCode.invalidArgument:
          throw Exception(e.message);
        default:
          logger.e("failed auth with x509: [${e.codeName}] ${e.message}");
      }

      return false;
    }

    return true;
  }
}