import 'package:coba_uas/app/controllers/auth_controller.dart';
import 'package:coba_uas/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.NOTIFIKASI);
            },
            icon: Icon(Icons.notifications, color: Colors.orange),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Image.asset(
                'assets/images/logo.png',
                height: 200,
                width: 200,
              ),
              SizedBox(height: 10),
              HomeActionButton(
                onPressed: () {
                  Get.toNamed(Routes.ALARM);
                },
                label: "Alarm",
                image: 'assets/images/to_alarm_settings_page.png',
              ),
              SizedBox(height: 20),
              HomeActionButton(
                onPressed: () {
                  Get.toNamed(Routes.RIWAYAT);
                },
                label: "Riwayat Alarm",
                image: 'assets/images/to_alarm_history_page.png',
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFFAFF5ED),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomNavItem(
              icon: Icons.home,
              active: true,
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
}

class HomeActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final String image;

  const HomeActionButton({
    required this.onPressed,
    required this.label,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: SizedBox(
            width: 340,
            child: Column(
              children: [
                Image.asset(
                  image,
                  width: 340,
                ),
                SizedBox(height: 10),
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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
