import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void requestNotification(context) async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      sound: true,
      provisional: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint("User granted permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint("User granted proviosnal");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Notifications denied by users.....Please allow notifications to access the services",
          ),
        ),
      );
      Future.delayed(Duration(seconds: 2), () {
        AppSettings.openAppSettings(type: AppSettingsType.notification);
      });
    }
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    print("Device token is $token");
    return token!;
  }

  void initLocalNotification(
    BuildContext context,
    RemoteMessage remoteMessage,
  ) async {
    var androidSettings = AndroidInitializationSettings("launcher_icon");

    var iosSettings = DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) {},
    );
    showNotification(context, remoteMessage);
  }

  Future<void> showNotification(
    BuildContext context,
    RemoteMessage message,
  ) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      const AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
            "high_importance_channel",
            "High Importance Notifications", // channel name
            importance: Importance.max,
            priority: Priority.high,
          );

      const NotificationDetails platformDetails = NotificationDetails(
        android: androidDetails,
      );

      await flutterLocalNotificationsPlugin.show(
        1,
        notification.title,
        notification.body,
        platformDetails,
      );
      handleMessage(context, message);
    }
  }

  void firebaseInit(context) async {
    FirebaseMessaging.onMessage.listen((message) {
      debugPrint("📩 Foreground message: ${message.notification?.title}");
      initLocalNotification(context, message);
    });

    //Terminated Stages
    Future<void> setupInteractionImage(BuildContext context) async {
      FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? rm) {
        if (rm != null && rm.data.isNotEmpty) {
          handleMessage(context, rm);
        }
      });
    }
  }

  Future<void> handleMessage(
    BuildContext context,
    RemoteMessage remoteMessage,
  ) async {
    context.pushNamed('homepage');
  }
}
