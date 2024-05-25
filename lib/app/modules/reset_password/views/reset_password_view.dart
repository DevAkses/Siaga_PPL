import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:coba_uas/app/controllers/auth_controller.dart';
import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF30E5D0),
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.all(0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LogoWidget(),
                  Expanded(
                    child:
                        ResetPasswordForm(controller: controller, authC: authC),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: BackButtonWidget(),
          ),
        ],
      ),
    );
  }
}

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png',
      height: MediaQuery.of(context).size.height * 0.2,
    );
  }
}

class ResetPasswordForm extends StatelessWidget {
  final ResetPasswordController controller;
  final AuthController authC;

  ResetPasswordForm({required this.controller, required this.authC});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: 0),
              child: Text(
                "Lupa Kata Sandi",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(left: 0),
              child: Text(
                "Silakan masukkan email Anda untuk mengatur ulang kata sandi",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            SizedBox(height: 20),
            EmailTextField(controller: controller),
            SizedBox(height: 30),
            ResetPasswordButton(controller: controller, authC: authC),
            SizedBox(height: 20),
            Image.asset(
              'assets/images/logowithlines.png',
              height: MediaQuery.of(context).size.height * 0.2,
            ),
          ],
        ),
      ),
    );
  }
}

class EmailTextField extends StatelessWidget {
  final ResetPasswordController controller;

  EmailTextField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Email",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        TextField(
          controller: controller.emailC,
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFFD9D9D9),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.all(10),
            hintText: 'Enter your email',
            hintStyle: TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}

class ResetPasswordButton extends StatelessWidget {
  final ResetPasswordController controller;
  final AuthController authC;

  ResetPasswordButton({required this.controller, required this.authC});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => authC.resetPassword(controller.emailC.text),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF30E5D0)),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      child: Text(
        "Reset Password",
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }
}

class BackButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.back(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.all(10),
        child: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
      ),
    );
  }
}
