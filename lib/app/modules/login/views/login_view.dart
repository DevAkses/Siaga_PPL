import 'package:coba_uas/app/controllers/auth_controller.dart';
import 'package:coba_uas/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF30E5D0),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LogoWidget(),
              Expanded(
                child: LoginFormWidget(controller: controller, authC: authC),
              ),
            ],
          ),
        ),
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

class LoginFormWidget extends StatefulWidget {
  final LoginController controller;
  final AuthController authC;

  LoginFormWidget({required this.controller, required this.authC});

  @override
  _LoginFormWidgetState createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _fadeInAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeInAnimation.value,
          child: Container(
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
                  FadeTransition(
                    opacity: _fadeInAnimation,
                    child: EmailTextField(controller: widget.controller),
                  ),
                  SizedBox(height: 20),
                  FadeTransition(
                    opacity: _fadeInAnimation,
                    child: PasswordTextField(controller: widget.controller),
                  ),
                  SizedBox(height: 20),
                  FadeTransition(
                    opacity: _fadeInAnimation,
                    child: ForgotPasswordButton(),
                  ),
                  SizedBox(height: 20),
                  FadeTransition(
                    opacity: _fadeInAnimation,
                    child: LoginButton(
                        controller: widget.controller, authC: widget.authC),
                  ),
                  SizedBox(height: 20),
                  FadeTransition(
                    opacity: _fadeInAnimation,
                    child: SignUpRow(),
                  ),
                  SizedBox(height: 10),
                  Image.asset(
                    'assets/images/logowithlines.png',
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class EmailTextField extends StatelessWidget {
  final LoginController controller;

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
            hintText: 'Masukkan Email',
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

class PasswordTextField extends StatefulWidget {
  final LoginController controller;

  PasswordTextField({required this.controller});

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Password",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        TextField(
          controller: widget.controller.passwordC,
          obscureText: _obscureText,
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFFD9D9D9),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.all(10),
            hintText: 'Masukkan Password',
            hintStyle: TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}

class ForgotPasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Get.toNamed(Routes.RESET_PASSWORD),
      child: Text(
        "Lupa Password?",
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final LoginController controller;
  final AuthController authC;

  LoginButton({required this.controller, required this.authC});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => authC.login(
        controller.emailC.text,
        controller.passwordC.text,
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF30E5D0)),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      child: Text(
        "Masuk",
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

class SignUpRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Belum punya akun?",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xFF7280CE),
          ),
        ),
        TextButton(
          onPressed: () => Get.toNamed(Routes.SIGNUP),
          child: Text(
            "Daftar",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFF7280CE),
            ),
          ),
        ),
      ],
    );
  }
}
