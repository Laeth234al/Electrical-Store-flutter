import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app/Controller/Validator/form_validator.dart';
import 'package:store_app/services/auth_service.dart';

class AuthController extends GetxController {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController username = TextEditingController();
  bool isLoading = false;
  bool get isVaildForSignIn => FormValidator().isValidEmail(email.text) && FormValidator().isValidPassword(password.text);

  bool get isVaildForRegister => isVaildForSignIn && FormValidator().isValidUserName(username.text);

  void changeLoading() {
    isLoading = !isLoading;
    update();
  }

  Future<bool> login() async {
    // sign in code
    var connection = await AuthServic.login(email: email.text, password: password.text);
    update();
    return connection;
  }

  Future<bool> register() async {
    print('email : ${email.text} pass : ${password.text}');
    var connection = await AuthServic.register(email: email.text, password: password.text);
    update();
    return connection;
    // sign up code
  }

  Future<void> signOut() async {
    await AuthServic.signOut();
  }
}
