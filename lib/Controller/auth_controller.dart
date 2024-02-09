import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app/Controller/Validator/form_validator.dart';

class AuthController extends GetxController {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController username = TextEditingController();
  bool get isVaildForSignIn => FormValidator().isValidEmail(email.text) && FormValidator().isValidPassword(password.text);

  bool get isVaildForRegister => isVaildForSignIn && FormValidator().isValidUserName(username.text);

  void signIn() {
    // sign in code
  }

  void signUp() {
    // sign up code
  }
}
