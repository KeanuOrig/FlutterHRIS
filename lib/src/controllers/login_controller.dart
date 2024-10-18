import 'package:flutter/material.dart';

class LoginController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
  }

  String? validateUsername(String value) {
    if (value.isEmpty) {
      return 'Username cannot be empty';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password cannot be empty';
    }
    return null;
  }
}
