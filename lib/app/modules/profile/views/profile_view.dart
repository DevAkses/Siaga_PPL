import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:coba_uas/app/controllers/auth_controller.dart';
import 'package:coba_uas/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key) {
    authC = Get.find<AuthController>();
  }

  late final AuthController authC;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(260),
        child: Container(
          padding: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            color: Color(0xFF30E5D0),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(100),
            ),
          ),
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(
                'Profil',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: authC.getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.hasData) {
            var userData = snapshot.data!.data()!;
            _usernameController.text = userData['username'];
            _emailController.text = userData['email'];

            return Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Username',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF30E5D0),
                        fontFamily: 'Poppins',
                      ),
                    ),
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        hintText: 'Masukkan username',
                      ),
                      onEditingComplete: () async {
                        await _updateUsername();
                      },
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Email',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF30E5D0),
                        fontFamily: 'Poppins',
                      ),
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Masukkan email',
                      ),
                      enabled: false, // Email tidak dapat diubah
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              title: Text(
                                'Yakin anda ingin keluar?',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    // Fungsi logout
                                    authC.logout();
                                    // Tutup dialog
                                    Get.back();
                                  },
                                  child: Text(
                                    'Keluar',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFFF83E3E),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text(
                                    'Kembali',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF30E5D0),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.logout, color: Colors.white),
                          SizedBox(width: 10),
                          Text(
                            'Keluar',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFF83E3E),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return Center(child: Text('No data available'));
        },
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
              onPressed: () {
                Get.offNamed(Routes.PANGGILAN_DARURAT);
              },
            ),
            BottomNavItem(
              icon: Icons.person,
              active: true,
              onPressed: () {
                Get.offNamed(Routes.PROFILE);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateUsername() async {
    try {
      await authC.updateUsername(_usernameController.text);
      Get.snackbar(
        'Berhasil',
        'Username berhasil diubah',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      print('Error updating username: $e');
      Get.snackbar(
        'Error',
        'Terjadi kesalahan saat mengubah username',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
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
