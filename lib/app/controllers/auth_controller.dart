import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coba_uas/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<User?> get streamAuthStatus => auth.authStateChanges();

  void showCustomDialog(String title, String message) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        content: Text(
          message,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Poppins',
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              'OK',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF30E5D0),
            ),
          ),
        ],
      ),
    );
  }

  void signup(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      showCustomDialog(
        "Terjadi Kesalahan",
        "Email dan password tidak boleh kosong.",
      );
      return;
    }

    try {
      UserCredential myUser = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String username = email.split('@')[0];

      await firestore.collection('akun').doc(myUser.user!.uid).set({
        'id': myUser.user!.uid,
        'username': username,
        'email': email,
      });

      await myUser.user!.sendEmailVerification();
      showCustomDialog(
        "Verifikasi Email",
        "Kami telah mengirimkan email verifikasi ke $email",
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showCustomDialog(
          "Terjadi Kesalahan",
          "Password terlalu singkat.",
        );
      } else if (e.code == 'email-already-in-use') {
        showCustomDialog(
          "Terjadi Kesalahan",
          "Email telah ada.",
        );
      } else {
        showCustomDialog(
          "Terjadi Kesalahan",
          "Terjadi kesalahan. Silahkan coba lagi.",
        );
      }
    } catch (e) {
      showCustomDialog(
        "Terjadi Kesalahan",
        "Tidak dapat mendaftar dengan akun ini.",
      );
    }
  }

  void login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      showCustomDialog(
        "Terjadi Kesalahan",
        "Email dan password tidak boleh kosong.",
      );
      return;
    }

    try {
      UserCredential myUser = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (myUser.user!.emailVerified) {
        showCustomDialog(
          "Berhasil",
          "Anda berhasil login.",
        );
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.dialog(
          AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              "Verifikasi Email",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            content: Text(
              "Kamu perlu verifikasi email terlebih dahulu. Apakah kamu ingin dikirimkan verifikasi ulang?",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Poppins',
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () async {
                  await myUser.user!.sendEmailVerification();
                  Get.back();
                },
                child: Text(
                  'Kirim ulang',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF30E5D0),
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
                  backgroundColor: Color(0xFFF83E3E),
                ),
              ),
            ],
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showCustomDialog(
          "Terjadi Kesalahan",
          "Tidak ada pengguna yang ditemukan untuk email tersebut.",
        );
      } else if (e.code == 'wrong-password') {
        showCustomDialog(
          "Terjadi Kesalahan",
          "Password salah untuk email tersebut. Silahkan cek kembali dengan benar.",
        );
      } else {
        showCustomDialog(
          "Terjadi Kesalahan",
          "Terjadi kesalahan. Silahkan coba lagi.",
        );
      }
    } catch (e) {
      showCustomDialog(
        "Terjadi Kesalahan",
        "Tidak dapat login dengan akun ini.",
      );
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() async {
    User? user = auth.currentUser;
    if (user != null) {
      var userDoc = await firestore.collection('akun').doc(user.uid).get();
      if (!userDoc.exists) {
        String username = user.email!.split('@')[0];
        await firestore.collection('akun').doc(user.uid).set({
          'id': user.uid,
          'username': username,
          'email': user.email,
        });
        userDoc = await firestore.collection('akun').doc(user.uid).get();
      }
      return userDoc;
    } else {
      throw Exception('Tidak ada pengguna yang masuk');
    }
  }

  Future<void> updateUsername(String username) async {
    User? user = auth.currentUser;
    if (user != null) {
      await firestore.collection('akun').doc(user.uid).update({
        'username': username,
      });
    } else {
      throw Exception('Tidak ada pengguna yang masuk');
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    showCustomDialog(
      "Logout",
      "Berhasil Logout",
    );
    Get.offAllNamed(Routes.LOGIN);
  }

  void resetPassword(String email) async {
    if (email != "" && GetUtils.isEmail(email)) {
      try {
        await auth.sendPasswordResetEmail(email: email);
        showCustomDialog(
          "Berhasil",
          "Kami telah mengirimkan Reset Password ke email $email.",
        );
      } catch (e) {
        showCustomDialog(
          "Terjadi Kesalahan",
          "Tidak dapat mengirimkan Reset Password.",
        );
      }
    } else {
      showCustomDialog(
        "Terjadi Kesalahan",
        "Email tidak valid.",
      );
    }
  }
}
