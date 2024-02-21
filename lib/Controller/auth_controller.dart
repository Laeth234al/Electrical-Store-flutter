import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Electrical/Controller/Validator/form_validator.dart';
import 'package:Electrical/services/auth_service.dart';

class AuthController extends GetxController {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController username = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool get isVaildForSignIn => FormValidator().isValidEmail(email.text) && FormValidator().isValidPassword(password.text);

  bool get isVaildForRegister => isVaildForSignIn && FormValidator().isValidUserName(username.text);

  bool get isVaildToResetPassword => FormValidator().isValidPassword(password.text);

  void _changeLoading() {
    _isLoading = !_isLoading;
    update();
  }

  Future<String> login() async {
    // sign in code
    _changeLoading();
    var connection = await AuthServic.login(email: email.text, password: password.text);
    update();
    _changeLoading();
    return connection;
  }

  Future<String> register() async {
    _changeLoading();
    print('email : ${email.text} pass : ${password.text}');
    var connection = await AuthServic.register(email: email.text, password: password.text, username: username.text);
    update();
    _changeLoading();
    return connection;
  }

  Future<void> signOut() async {
    await AuthServic.signOut();
  }

  Future<bool> resetPassword() async {
    _changeLoading();
    var connection = await AuthServic.resetPassword(email.text);
    update();
    _changeLoading();
    return connection;
  }
}
