import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:serenmind/generated/l10n.dart';
import 'services/router.dart';
import 'services/firebase_options.dart';
import 'services/firebase.dart';
import 'services/notification.dart';

NotificationManager notification = NotificationManager();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  FirebaseMessaging.onBackgroundMessage(
      notification.firebaseMessagingBackgroundHandler);

  runApp(const SerenMindApp());
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
      debugShowCheckedModeBanner: false,
      routerConfig: _appRouter.router,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('fr', ''),
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale != null) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode) {
              return supportedLocale;
            }
          }
        }
        return const Locale('en', '');
      },
    );
  }
}
