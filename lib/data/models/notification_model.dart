// ignore_for_file: inference_failure_on_function_return_type

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  final _localNotificationService = FlutterLocalNotificationsPlugin();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
    final details = await notificationDetails();
    await _localNotificationService.show(
      id,
      title,
      body,
      details,
      payload: payload,
    );
  }

  Future<void> initialize({
    required Function(NotificationResponse)? onDidReceiveNotificationResponse,
  }) async {
    const androidInitialize =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final initializationSettingsDarwin = DarwinInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    final initializationsSettings = InitializationSettings(
      android: androidInitialize,
      iOS: initializationSettingsDarwin,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationsSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

  Future<NotificationDetails> notificationDetails() async {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'Neighbrs App', //CHANNEL ID
      'Neighbrs App ', // CHANNEL NAME
      enableLights: true,
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );
    return const NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: DarwinNotificationDetails(),);
  }

  Future<void> showNotification({
    // required int id,
    required String title,
    required String body,
    required dynamic payload,
  }) async {
    final details = await notificationDetails();
    await _localNotificationService.show(
      2,
      title,
      body,
      details,
      payload: payload.toString(),
    );
  }
}
