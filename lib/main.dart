import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:logger/logger.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'services/router.dart';
import 'services/firebase_options.dart';
import 'services/firebase.dart';
import 'services/notification.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
  NotificationManager notification = NotificationManager();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
      if (notificationResponse.payload != null) {
        print('Notification Payload: ${notificationResponse.payload}');
      }
    },
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(notification.firebaseMessagingBackgroundHandler);
  runApp(SerenMindApp());
}

class SerenMindApp extends StatefulWidget {
  const SerenMindApp({Key? key}) : super(key: key);

    @override
  State<SerenMindApp> createState() => _SerenMindAppState();
}

class _SerenMindAppState extends State<SerenMindApp> {
var logger = Logger();
FirebaseControler firebase = FirebaseControler();
NotificationManager notification = NotificationManager();

@override
  initState() {
    firebase.signInAnonymously();
    notification.initState();
  }

  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.router,
    );
  }
}
