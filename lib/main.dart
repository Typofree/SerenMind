import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';

import 'package:serenmind/generated/l10n.dart';
import 'services/router.dart';
import 'services/firebase_options.dart';
import 'services/firebase.dart';
import 'services/notification.dart';
import 'package:serenmind/screens/mood/moodController.dart';
import 'package:serenmind/screens/profil/profilController.dart';


NotificationManager notification = NotificationManager();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialiser Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Préférences d'orientation de l'écran
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
  User? _user; // Variable pour suivre l'utilisateur actuel

  @override
  void initState() {
    super.initState();

    // S'assurer que Firebase gère la connexion persistante
    _checkUserStatus();

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

  // Vérifier si un utilisateur est connecté et s'il est anonyme
  Future<void> _checkUserStatus() async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      _user = user; // Mise à jour de l'utilisateur actuel
    });

    if (user != null && !user.isAnonymous) {
      logger.i('Utilisateur connecté avec un compte Firebase');
    } else if (user == null) {
      logger.i('Aucun utilisateur connecté. Connexion anonyme.');
      await firebase.signInAnonymously();
    }
  }

  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MoodController()),
        ChangeNotifierProvider(create: (_) => ProfilController()),
      ],
      child: MaterialApp.router(
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
      ),
    );
  }
}
