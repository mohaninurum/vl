import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:visual_learning/screen/notifications/notifications_screen/notifications_screen.dart';

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();
  Future<void> initialize(BuildContext context) async {
    const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings("@mipmap/ic_launcher");

    const InitializationSettings initializationSettings = InitializationSettings(android: androidInitializationSettings);

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        print("onSelectNotification: ${details.payload}");
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotificationScreen()));
        // ✅ Navigate to NotificationScreen when payload is available
        if (details.payload != null && details.payload!.isNotEmpty) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotificationScreen()));
        }
      },
    );
  }

  // Future<void> initialize(BuildContext context) async {
  //   // initializationSettings  for Android
  //
  //   const InitializationSettings initializationSettings = InitializationSettings(android: AndroidInitializationSettings("@mipmap/ic_launcher"));
  //
  //   await _notificationsPlugin.initialize(
  //     initializationSettings,
  //     onDidReceiveNotificationResponse: (details) {
  //       print("onSelectNotification");
  //       print("Click.............");
  //       Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotificationScreen()));
  //       if (details.id.toString().isNotEmpty) {
  //         print("Router Value1234 ${details.id}");
  //
  //         Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotificationScreen()));
  //       }
  //     },
  //   );
  // }

  void onDidReceiveBackgroundResponse(NotificationResponse notificationResponse) async {
    print("onSelectNotification");
    //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotificationScreen()));
    if (notificationResponse.data.isNotEmpty) {
      print("Router Value1234");

      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (context) => DemoScreen(
      //       id: id,
      //     ),
      //   ),
      // );
    }
  }

  // onDidReceiveBackgroundNotificationResponse: (details) {
  // print("onSelectBackgroundNotification");
  // if (details.id.toString().isNotEmpty) {
  // print("Router Value1234 ${details.id}");
  //
  // // Navigator.of(context).push(
  // //   MaterialPageRoute(
  // //     builder: (context) => DemoScreen(
  // //       id: id,
  // //     ),
  // //   ),
  // // );
  // }
  // },

  void createanddisplaynotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      Color notificationColor;
      switch (message.data["notification_status"]) {
        case '102':
          notificationColor = Colors.green;
          break;
        case '2':
          notificationColor = Colors.green;
          break;
        case '3':
          notificationColor = Colors.blue;
          break;
        default:
          notificationColor = Colors.grey;
      }

      NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "vroomo",
          "pushnotificationappchannel",
          importance: Importance.max,
          priority: Priority.high,
          color: notificationColor, // 🔴 Color based on payload
          colorized: true,
        ),
      );

      await _notificationsPlugin.show(id, message.notification!.title, message.notification!.body, notificationDetails, payload: message.data["notification_status"]);
    } on Exception catch (e) {
      print(e);
    }
  }
}
