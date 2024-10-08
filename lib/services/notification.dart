import 'package:logger/logger.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io' show Platform;

class NotificationManager {
FirebaseMessaging messaging = FirebaseMessaging.instance;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
  var logger = Logger();

  void initState() {

    notificationOption();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      logger.d('Un message a été reçu alors que l\'app est en premier plan: ${message.notification?.title}, ${message.notification?.body}');
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      logger.d('Notification cliquée, l\'app est en arrière-plan : ${message.notification?.title}');
    });
    showNotification();

  }

  Future<void> notificationOption () async {
    await Permission.notification.request();
    if (Platform.isAndroid && (await _isAndroid13OrAbove())) {
    await requestNotificationPermissionAndroid13();
  }
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      logger.d('L\'utilisateur a autorisé les notifications');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      logger.d('L\'utilisateur a accordé une autorisation provisoire');
    } else {
      logger.d('L\'utilisateur a refusé les notifications');
    }
  }

  Future<void> requestNotificationPermissionAndroid13() async {
  PermissionStatus status = await Permission.notification.request();

  if (status.isGranted) {
      logger.d('Permission de notification accordée sur Android 13');
  } else if (status.isDenied) {
      logger.d('Permission de notification refusée sur Android 13');
  } else if (status.isPermanentlyDenied) {
      logger.d('Permission de notification refusée de façon permanente sur Android 13');
    openAppSettings();
  }
}

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    logger.d("Un message a été reçu en arrière-plan : ${message.messageId}");
  }

  Future<bool> _isAndroid13OrAbove() async {
  if (Platform.isAndroid) {
    var androidInfo = await DeviceInfoPlugin().androidInfo;
    return androidInfo.version.sdkInt >= 33;
  }
  return false;
}

Future<void> showNotification() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'your_channel_id',
    'your_channel_name',
    channelDescription:'',
    importance: Importance.max,
    priority: Priority.high,
    showWhen: false,
  );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Titre de la notification',
      'Voici le corps de la notification',
      platformChannelSpecifics,
      payload: 'Données supplémentaires',
    );
  }
}