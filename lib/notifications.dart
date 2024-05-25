// import 'package:coba_uas/app/routes/app_pages.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:timezone/timezone.dart' as tz;

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
// final databaseReference = FirebaseDatabase.instance.reference();

// Future<void> initializeService() async {
//   var initializationSettingsAndroid =
//       const AndroidInitializationSettings('@mipmap/ic_launcher');
//   var initializationSettings =
//       InitializationSettings(android: initializationSettingsAndroid);
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//       onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

//   await listenToSensorData();
// }

// Future<void> listenToSensorData() async {
//   databaseReference.child('sensor_data').onChildAdded.listen((event) {
//     showNotification();
//   });
// }

// Future<void> showNotification() async {
//   var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
//     'sensor_notifications',
//     'Sensor Notifications',
//     channelDescription: 'Receive notifications related to sensor data changes',
//     importance: Importance.max,
//     priority: Priority.high,
//   );

//   var platformChannelSpecifics = NotificationDetails(
//     android: androidPlatformChannelSpecifics,
//   );

//   var scheduledTime = tz.TZDateTime.now(tz.local).add(const Duration(days: 7));

//   await flutterLocalNotificationsPlugin.zonedSchedule(
//     0,
//     'Peringatan',
//     'Terdapat gerakan mencurigakan di sekitar peternakan Anda!',
//     scheduledTime,
//     platformChannelSpecifics,
//     androidAllowWhileIdle: true,
//     uiLocalNotificationDateInterpretation:
//         UILocalNotificationDateInterpretation.absoluteTime,
//     matchDateTimeComponents: DateTimeComponents.time,
//   );
// }

// Future<void> onDidReceiveNotificationResponse(
//     NotificationResponse response) async {
//   Get.toNamed(Routes.HOME);
// }
