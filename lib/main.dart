import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:logger/logger.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:serenmind/screens/splash/splashView.dart';

import 'services/router.dart';
import 'services/firebase_options.dart';
import 'services/firebase.dart';
import 'services/notification.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
NotificationManager notification = NotificationManager();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(
      notification.firebaseMessagingBackgroundHandler);

  runApp(SplashApp());
}

class SplashApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SerenMind',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      routes: {
        '/home': (context) => SerenMindApp(),
      },
    );
  }
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
    super.initState();

    firebase.signInAnonymously();

    FirebaseMessaging.instance.getToken().then((token) {
      logger.i("Firebase Token: $token");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      logger.i(
          'Un message a ouvert l\'application : ${message.notification?.title}');
    });

    Permission.notification.request();
    notification.initState(context);
  }

  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: _appRouter.router.routeInformationParser,
      routerDelegate: _appRouter.router.routerDelegate,
    );
  }
}
