// ignore_for_file: library_prefixes

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzData;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    tzData.initializeTimeZones(); // Initialize timezone database
    final location = tz.getLocation('Asia/Tehran'); // Set your default location
    tz.setLocalLocation(location);

    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings = InitializationSettings(android: androidSettings);

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'task_channel',
      'Task Reminders',
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
    );
    await _notifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

    await _notifications.initialize(settings);
  }

  Future<void> scheduleTaskNotification({
    required int id,
    required String title,
    required String body,
    required DateTime dueDate,
  }) async {
    try {
      final tehran = tz.getLocation('Asia/Tehran');
      final now = tz.TZDateTime.now(tehran);
      debugPrint('Current Tehran time: $now');
      final scheduledTime = tz.TZDateTime.from(dueDate, tehran).add(const Duration(minutes: 60));
      debugPrint('Attempting to schedule for: $scheduledTime');
      // Validate the scheduled time
      if (scheduledTime.isBefore(now)) {
        debugPrint('Cannot schedule notification in the past');
        return;
      }

      await _notifications.zonedSchedule(
        id,
        title,
        body,
        scheduledTime,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'task_channel',
            'Task Reminders',
            channelDescription: 'Notifications for upcoming tasks',
            importance: Importance.high,
            priority: Priority.high,
          ),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      );
      debugPrint('Notification successfully scheduled for $scheduledTime');
    } catch (e) {
      debugPrint('Error scheduling notification: $e');
    }
  }

  Future<void> cancelNotification(int id) async {
    await _notifications.cancel(id);
  }
}
