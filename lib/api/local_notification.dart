import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  static late FlutterLocalNotificationsPlugin flutterNotificationPlugin;
  static late AndroidNotificationDetails androidSettings;

  static Initializer() {
    flutterNotificationPlugin = FlutterLocalNotificationsPlugin();
    androidSettings = AndroidNotificationDetails(
        "111", "Background_task_Channel", "Channel to test background task",
        importance: Importance.high, priority: Priority.max);
    var androidInitialization = AndroidInitializationSettings('app_icon');
    flutterNotificationPlugin.initialize(
      InitializationSettings(android: androidInitialization),
    );
  }

  static ShowOneTimeNotification(DateTime scheduledDate) async {
    var notificationDetails = NotificationDetails(android: androidSettings);
    await flutterNotificationPlugin.schedule(1, "Background Task notification",
        "Data saved to database", scheduledDate, notificationDetails,
        androidAllowWhileIdle: true);
  }
}
