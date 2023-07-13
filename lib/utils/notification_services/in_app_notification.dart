import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// import 'package:permission_handler/permission_handler.dart';

import 'fcm_services.dart';

const String channelId = 'com.assignment.pay';
const String channelName = 'Assignment Pay Notification';
const String channelDescription = 'Assignment Pay Notification Channel';
const String notificationTicker = 'ticker';

final AwesomeNotifications awesomeNotifications = AwesomeNotifications();

class InAppNotification {
  ///Configuration for flutter local notifications both android and ios
  static Future<void> configureInAppNotification(
      {bool reqAlert = true,
      bool reqBadge = true,
      bool reqSound = true}) async {
    await Firebase.initializeApp();

    awesomeNotifications.initialize(
        "resource://mipmap/ic_launcher",
        [
          NotificationChannel(
              channelGroupKey: 'default_channel',
              channelKey: channelId,
              channelName: channelName,
              channelDescription: channelDescription,
              importance: NotificationImportance.High,
              ledColor: Colors.white)
        ],
        // Channel groups are only visual and are not required
        channelGroups: [
          NotificationChannelGroup(
              channelGroupkey: 'default_channel',
              channelGroupName: 'General group')
        ],
        debug: !kReleaseMode);

    awesomeNotifications.isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        awesomeNotifications.requestPermissionToSendNotifications();
      }
    });

    awesomeNotifications.actionStream
        .listen((ReceivedNotification receivedNotification) {
      log("awesomeNotifications.actionStream ${receivedNotification.payload}");
      final data = receivedNotification.payload;
      onNotificationTapped(data);
    });
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static Future<void> showNotification(
      {String title = 'title',
      String description = 'description',
      String imageUrl = 'http://via.placeholder.com/128x128/00FF00/000000',
      Map<String, String>? data}) async {
    awesomeNotifications.createNotification(
        content: NotificationContent(
            id: 1,
            payload: data,
            channelKey: channelId,
            title: title,
            body: description));
  }
}

///downloads and saves the network image
// Future<String?> _downloadAndSaveFile(String url, String fileName) async {
//   final status = await Permission.storage.status;
//   if (status.isGranted) {
//     final directory = await getApplicationDocumentsDirectory();
//     final filePath = '${directory.path}/$fileName';
//     final response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200) {
//       final file = File(filePath);
//       await file.writeAsBytes(response.bodyBytes);
//       debugPrint('Download service done for : $url to $filePath.');
//       return filePath;
//     } else {
//       debugPrint(
//           'Download service received for : $url to $fileName but failed because of 404 url.');
//       return null;
//     }
//   } else {
//     debugPrint(
//         'Download service received for : $url to $fileName but denied because of Storage permission.');
//     return null;
//   }
// }
