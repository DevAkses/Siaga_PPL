import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class SensorController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var isSensorActive = false.obs;
  

  @override
  void onInit() {
    super.onInit();
    // Panggil getDataSensor saat Controller diinisialisasi
    getDataSensor();
  }

  void tambahRiwayat() {
    CollectionReference history = firestore.collection("histories");
    String title = 'Sensor';
    String message = isSensorActive.value 
      ? 'Sensor berhasil dinonaktifkan'
      : 'Sensor berhasil diaktifkan';
    // Mendapatkan waktu saat ini
    DateTime currentTime = DateTime.now();
    String currentTimeStr = DateTime.now().toIso8601String();

    history.add({
      'title': title,
      'description': message,
      'timestamp': FieldValue.serverTimestamp(),
      'date': '${currentTime.day}-${currentTime.month}-${currentTime.year}', 
      'time': '${currentTime.hour}:${currentTime.minute}:${currentTime.second}', 
      'currentTimeStr': currentTimeStr, 
    });
  }

  void getDataSensor() async {
    Uri url = Uri.parse(
        "https://coba-uas-2e05c-default-rtdb.asia-southeast1.firebasedatabase.app/status_sensor.json");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Periksa apakah data['isSensorActive'] tidak null
        if (data != null && data['isSensorActive'] != null) {
          isSensorActive.value = data['isSensorActive'];
        }
      } else {
        throw Exception('Failed to get sensor data');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  void updateSensor(bool sensor) async {
    Uri url = Uri.parse(
        "https://coba-uas-2e05c-default-rtdb.asia-southeast1.firebasedatabase.app/status_sensor.json");
    try {
      final response = await http.patch(
        url,
        body: json.encode({
          "isSensorActive": sensor,
        }),
      );
      if (response.statusCode == 200) {
        isSensorActive.value = sensor;
      } else {
        throw Exception('Failed to update sensor status');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  
}
