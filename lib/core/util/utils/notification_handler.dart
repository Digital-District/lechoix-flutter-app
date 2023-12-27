import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../cache/user_cache.dart';

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHandler {
  static final NotificationHandler _instance = NotificationHandler._private();

  static NotificationHandler get instance {
    return _instance;
  }

  NotificationHandler._private();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    await initFirebaseNotifications();
  }

  Future<String?> getToken() async {
    return await _firebaseMessaging.getToken();
  }

  Future<void> initFirebaseNotifications() async {
    // To request permission
    // NotificationSettings settings =
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    // get FCM token
    String? token = await _firebaseMessaging.getToken();
    UserCache.instance.saveFCMToken(token ?? "");
    // Sve to DB
    print("Notification Token $token");

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _handleNotification(message);
    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  void _handleNotification(RemoteMessage message) async {
    // String title = message.notification?.title ?? "";
    // String body = message.notification?.body ?? "";

    // const AndroidNotificationDetails androidPlatformChannelSpecifics =
    //     AndroidNotificationDetails("1", "lechoix");
    // const NotificationDetails platformChannelSpecifics =
    //     NotificationDetails(android: androidPlatformChannelSpecifics);
    // await flutterLocalNotificationsPlugin.show(
    //   0,
    //   title,
    //   body,
    //   platformChannelSpecifics,
    // );
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
  }
}
