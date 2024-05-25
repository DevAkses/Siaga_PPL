// import 'dart:async';
// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_background_service_android/flutter_background_service_android.dart';
// import 'package:coba_uas/background.dart';
// import 'package:firebase_database/firebase_database.dart';

// Future<void> initializeService() async {
//   final service = FlutterBackgroundService();
//   await service.configure(
//     iosConfiguration: IosConfiguration(
//       autoStart: true,
//       onForeground: onStart,
//       onBackground: onIosBackground,
//     ),
//     androidConfiguration: AndroidConfiguration(
//         onStart: onStart, isForegroundMode: true, autoStart: true),
//   );
// }

// @pragma('vm:entry-point')
// bool onIosBackground(ServiceInstance service) {
//   WidgetsFlutterBinding.ensureInitialized();
//   DartPluginRegistrant.ensureInitialized();
//   return true;
// }

// @pragma('vm:entry-point')
// void onStart(ServiceInstance service) async {
//   DartPluginRegistrant.ensureInitialized();
//   if (service is AndroidServiceInstance) {
//     service.on('setAsBackground').listen((event) {
//       service.setAsBackgroundService();
//     });
//   }
//   service.on('stopService').listen((event) {
//     service.stopSelf();
//   });
//   Timer.periodic(const Duration(seconds: 1), (timer) async {
//     if (service is AndroidServiceInstance) {
//       final DatabaseReference _databaseReference =
//       FirebaseDatabase.instance.ref().child('sensor_data');

//     Future<void> initDatabase() async {
//     _databaseReference.onValue.listen((event) {
//       NotificationService().showNotification(
//           title: 'Peringatan', body: 'Ada Penambahan Data');
//     });
//   }
//     }
//     print("background service running");
//     service.invoke('update');
//   });
// }
