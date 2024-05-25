import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'notification_preferences.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings('flutter_logo');

    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {},
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: (NotificationResponse notificationsResponse) async {});
  }

  Future<NotificationDetails> notificationDetails() async {
    String sound = await NotificationPreferences.getDefaultNotificationSound();
    String channelId = await NotificationPreferences.getDefaultNotificationChannel();

    return NotificationDetails(
        android: AndroidNotificationDetails(channelId, 'channel_name',
            playSound: true,
            sound: RawResourceAndroidNotificationSound(sound),
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification({int id = 0, String? title, String? body, String? payLoad}) async {
    return notificationsPlugin.show(id, title, body, await notificationDetails(), payload: payLoad);
  }

  Future<void> updateNotificationSound(String sound, String channelId) async {
    await NotificationPreferences.setDefaultNotificationSound(sound);
    await NotificationPreferences.setDefaultNotificationChannel(channelId);
    showNotification(title: 'Notification Sound Changed', body: 'The notification sound has been changed');
  }
}
