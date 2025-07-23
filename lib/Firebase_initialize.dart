import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class FirebaseInitialize {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(alert: true, badge: true, sound: true, criticalAlert: true);
    print('User granted permission: ${settings.authorizationStatus}');
  }

  Future<void> FireBaseNotification() async {
    final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(requestAlertPermission: false, requestBadgePermission: false, requestSoundPermission: false, defaultPresentSound: true);

    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    InitializationSettings initSettings = InitializationSettings(android: androidSettings, iOS: initializationSettingsDarwin);

    await flutterLocalNotificationsPlugin.initialize(initSettings, onDidReceiveNotificationResponse: onDidReceiveNotificationResponse, onDidReceiveBackgroundNotificationResponse: onDidReceiveBackgroundResponse);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Message data: ${message.data}');
      if (message.notification != null) {
        // showSimpleNotification(message: message);
        print('Message also contained a notification: ${message.notification}');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked! ${message.messageId}');
      if (message.notification != null) {
        // showSimpleNotification(message: message);
        print('Message clicked: ${message.notification}');
      }
    });
    FirebaseMessaging.instance.getToken().then((token) {
      if (kDebugMode) {
        print("FCM Token: $token");
      }
    });
  }

  Future<void> showSimpleNotification({required RemoteMessage message}) async {
    final title = message.data['driver_name'] ?? 'New Notification';
    final body = message.data['descriptions'] ?? '';
    final imageUrl = message.data['image'];
    var bigPictureStyle;
    var largeIcon;
    String? imagePath;
    if (imageUrl != null) {
      final response = await http.get(Uri.parse(imageUrl));
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/profile.jpg';
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      imagePath = filePath;
      bigPictureStyle = BigPictureStyleInformation(FilePathAndroidBitmap(imagePath), largeIcon: FilePathAndroidBitmap(imagePath), contentTitle: title, summaryText: body);
      largeIcon = FilePathAndroidBitmap(imagePath);
    }

    final androidDetails = AndroidNotificationDetails('profile_img_channel', 'Profile Image Notifications', channelDescription: 'Notifications with user profile images', styleInformation: bigPictureStyle, importance: Importance.max, priority: Priority.high, largeIcon: largeIcon);

    // const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    //   'channel_id',
    //   'channel_name',
    //   channelDescription: 'Channel description',
    //   importance: Importance.max,
    //   priority: Priority.high,
    // );

    NotificationDetails notificationDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(message.hashCode, message.notification?.title, message.data["driver_name"], notificationDetails);
  }

  Future<void> requestAndroidNotificationPermission() async {
    final plugin = flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    print(plugin);
  }

  void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload on : $payload');
    }
    // await Navigator.push(
    //   context,
    //   MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
    // );
  }
}

void onDidReceiveBackgroundResponse(NotificationResponse notificationResponse) async {
  final String? payload = notificationResponse.payload;
  if (notificationResponse.payload != null) {
    debugPrint('notification payload background: $payload');
  }
  // await Navigator.push(
  //   context,
  //   MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
  // );
}

// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// Future<void> sendFCMNotification({
//   required String token,
//   required String title,
//   required String body,
// }) async {
//   final serverKey = 'YOUR_SERVER_KEY_HERE'; // 🛑 NEVER expose this in production apps
//
//   final url = Uri.parse('https://fcm.googleapis.com/fcm/send');
//
//   final response = await http.post(
//     url,
//     headers: {
//       'Content-Type': 'application/json',
//       'Authorization': 'key=$serverKey',
//     },
//     body: jsonEncode({
//       "to": token,
//       "data": {
//         "title": title,
//         "body": body,
//         "click_action": "FLUTTER_NOTIFICATION_CLICK",
//         "userId": "user_123", // optional custom data
//       }
//     }),
//   );
//
//   print('FCM status: ${response.statusCode}');
//   print('FCM body: ${response.body}');
// }
