import 'package:shared_preferences/shared_preferences.dart';

class NotificationPreferences {
  static const String _soundKey = 'notification_sound';
  static const String _channelKey = 'notification_channel';

  static Future<void> setDefaultNotificationSound(String sound) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_soundKey, sound);
  }

  static Future<void> setDefaultNotificationChannel(String channelId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_channelKey, channelId);
  }

  static Future<String> getDefaultNotificationSound() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_soundKey) ?? 'suara1ppl';
  }

  static Future<String> getDefaultNotificationChannel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_channelKey) ?? 'channel_id_5';
  }
}
