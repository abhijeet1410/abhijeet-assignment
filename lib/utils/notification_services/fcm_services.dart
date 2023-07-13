import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'in_app_notification.dart';

Future<dynamic> backgroundMessageHandler(RemoteMessage message) async {
  try {
    await Firebase.initializeApp();
    RemoteNotification? notification = message.notification;
    log('notification data  --> ${message.data}');
    return InAppNotification.showNotification(
      title: notification?.title ?? 'Title',
      description: notification?.body ?? 'Description',
      data: {'path': '/profile', 'id': '1234567'},
    );
  } catch (e, s) {
    log('Notification StackTrace $e $s');
  }
}

void onNotificationTapped(dynamic activityDatum) {

}
