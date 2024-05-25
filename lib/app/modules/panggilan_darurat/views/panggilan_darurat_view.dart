import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/panggilan_darurat_controller.dart';
import 'package:coba_uas/app/routes/app_pages.dart';

class PanggilanDaruratView extends GetView<PanggilanDaruratController> {
  const PanggilanDaruratView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Panggilan Darurat',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF30E5D0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildEmergencyNumberItem("Nomor Panggilan\nDarurat", "112"),
            SizedBox(height: 20),
            _buildEmergencyNumberItem("Nomor Kepolisian", "110"),
            SizedBox(height: 20),
            _buildEmergencyNumberItem("Nomor Pemadam\nKebakaran", "113"),
            SizedBox(height: 20),
            _buildEmergencyNumberItem("Nomor Ambulans", "119"),
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
                Get.offNamed(Routes.HOME);
              },
            ),
            BottomNavItem(
              icon: Icons.sensors,
              onPressed: () {
                Get.offNamed(Routes.SENSOR);
              },
            ),
            BottomNavItem(
              icon: Icons.phone,
              active: true,
              onPressed: () {
                Get.offNamed(Routes.PANGGILAN_DARURAT);
              },
            ),
            BottomNavItem(
              icon: Icons.person,
              onPressed: () {
                Get.offNamed(Routes.PROFILE);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyNumberItem(String label, String number) {
    return GestureDetector(
      onTap: () {
        launch("tel:$number");
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xFF30E5D0),
        ),
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              number,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
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
