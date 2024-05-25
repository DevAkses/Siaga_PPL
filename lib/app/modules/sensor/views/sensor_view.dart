import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/sensor_controller.dart';
import 'package:coba_uas/app/routes/app_pages.dart';

class SensorView extends GetView<SensorController> {
  final SensorController sensorController = Get.put(SensorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pengaturan Sensor',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF30E5D0),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Tombol Sensor Utama
            Obx(() {
              return GestureDetector(
                onTap: () {
                  sensorController
                      .updateSensor(!sensorController.isSensorActive.value);
                  sensorController
                      .tambahRiwayat(); // Menambahkan pemanggilan fungsi tambahRiwayat
                },
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: sensorController.isSensorActive.value
                        ? Color(0xFF30E5D0)
                        : Color(0xFFF83E3E),
                    borderRadius: BorderRadius.circular(75),
                  ),
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Lingkaran Kecil
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: sensorController.isSensorActive.value
                                ? Color(0xFFD6FAF6)
                                : Color(0xFFFB7979),
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        // Label Status
                        Text(
                          sensorController.isSensorActive.value ? 'ON' : 'OFF',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: sensorController.isSensorActive.value
                                ? Colors.black
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),

            // Teks Status Sensor
            const SizedBox(height: 20),
            Obx(() {
              return Text(
                'Status Sensor: ${sensorController.isSensorActive.value ? 'Aktif' : 'Tidak Aktif'}',
                style: const TextStyle(fontSize: 20),
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFFAFF5ED),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomNavItem(
              icon: Icons.home,
              onPressed: () {
                Get.offAllNamed(Routes.HOME);
              },
            ),
            BottomNavItem(
              icon: Icons.sensors,
              active: true,
              onPressed: () {
                Get.offAllNamed(Routes.SENSOR);
              },
            ),
            BottomNavItem(
              icon: Icons.phone,
              onPressed: () {
                Get.offAllNamed(Routes.PANGGILAN_DARURAT);
              },
            ),
            BottomNavItem(
              icon: Icons.person,
              onPressed: () {
                Get.offAllNamed(Routes.PROFILE);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final IconData icon;
  final bool active;
  final VoidCallback onPressed;

  const BottomNavItem({
    required this.icon,
    this.active = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        color: active ? Colors.black : Colors.grey,
      ),
      onPressed: onPressed,
    );
  }
}
