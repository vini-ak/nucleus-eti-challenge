import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  //Singleton pattern
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }
  NotificationService._internal();

  //instance of FlutterLocalNotificationsPlugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
}

const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('logo.jpeg');

const InitializationSettings notificationSettings = InitializationSettings(
  android: initializationSettingsAndroid,
);
