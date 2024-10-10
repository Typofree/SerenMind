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

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      logger.d('Notification cliquée : ${message.notification?.title}');
      _handleNotificationRedirection(message);
    });

    _checkInitialMessage();
  }

  void _checkInitialMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      logger.d(
          'Application ouverte depuis une notification : ${initialMessage.notification?.title}');
      _handleNotificationRedirection(initialMessage);
    }
  }

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

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    logger.d('Message reçu en arrière-plan : ${message.messageId}');
  }

  Future<bool> _isAndroid13OrAbove() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      return androidInfo.version.sdkInt >= 33;
    }
    return false;
  }

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
