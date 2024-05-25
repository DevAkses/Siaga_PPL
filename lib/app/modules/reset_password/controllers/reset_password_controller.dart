import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  TextEditingController emailC =
      TextEditingController(text: "devaksesmikail12@gmail.com");

  @override
  void onClose() {
    emailC.dispose();
    super.onClose();
  }
}
