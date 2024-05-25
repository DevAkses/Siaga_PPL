import 'package:firebase_database/firebase_database.dart';
import 'notification_service.dart';

class DatabaseService {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref().child('sensor_data');
  dynamic _lastData;
  final NotificationService notificationService = NotificationService();

  Future<void> initDatabase() async {
    _databaseReference.onValue.listen((event) async {
      final newData = event.snapshot.value;

      if (_lastData != null && _lastData != newData) {
        await notificationService.showNotification(
            title: 'Peringatan', body: 'Ada gerakan mencurigakan di sekitar kandang anda');
      }

      _lastData = newData;
    });
  }
}
