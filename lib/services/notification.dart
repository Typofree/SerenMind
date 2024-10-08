import 'package:logger/logger.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';

class NotificationManager {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  var logger = Logger();

  late BuildContext _context;

  void initState(BuildContext context) {
    _context = context;
    _requestNotificationPermissions();
    _configureFirebaseMessaging();
  }

  void _configureFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      logger.d(
          'Message reçu en premier plan : ${message.notification?.title}, ${message.notification?.body}');
    });

    // Rediriger l'utilisateur vers la page "Activité" lorsque la notification est cliquée
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      logger.d('Notification cliquée : ${message.notification?.title}');
      _handleNotificationRedirection(message);
    });

    // Si l'application a été fermée et ouverte via une notification
    _checkInitialMessage();
  }

  // Vérifier si l'application a été ouverte depuis une notification après avoir été fermée
  void _checkInitialMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      logger.d(
          'Application ouverte depuis une notification : ${initialMessage.notification?.title}');
      _handleNotificationRedirection(initialMessage);
    }
  }

  // Demander les autorisations de notifications
  Future<void> _requestNotificationPermissions() async {
    await Permission.notification.request();

    if (Platform.isAndroid && await _isAndroid13OrAbove()) {
      await _requestAndroid13Permissions();
    }

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    _logNotificationPermissionStatus(settings);
  }

  // Gérer les permissions de notifications sur Android 13
  Future<void> _requestAndroid13Permissions() async {
    PermissionStatus status = await Permission.notification.request();

    if (status.isGranted) {
      logger.d('Permission de notification accordée sur Android 13');
    } else if (status.isDenied) {
      logger.d('Permission de notification refusée sur Android 13');
    } else if (status.isPermanentlyDenied) {
      logger.d(
          'Permission de notification refusée de façon permanente sur Android 13');
      openAppSettings();
    }
  }

  void _handleNotificationRedirection(RemoteMessage message) {
    if (message.data['page'] == 'activity') {
      Navigator.of(_context).pushNamed('/activity');
    }
  }

  // Handler pour les messages reçus en arrière-plan
  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    logger.d('Message reçu en arrière-plan : ${message.messageId}');
  }

  // Vérifier si l'appareil utilise Android 13 ou plus
  Future<bool> _isAndroid13OrAbove() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      return androidInfo.version.sdkInt >= 33;
    }
    return false;
  }

  // Loguer le statut des permissions de notifications
  void _logNotificationPermissionStatus(NotificationSettings settings) {
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      logger.d('L\'utilisateur a autorisé les notifications');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      logger.d('L\'utilisateur a accordé une autorisation provisoire');
    } else {
      logger.d('L\'utilisateur a refusé les notifications');
    }
  }
}
