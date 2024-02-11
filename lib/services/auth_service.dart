// ignore_for_file: avoid_print, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServic {
  static Future<bool> register({required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('Done email : $email');
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  static Future<bool> login({required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      print(await credential.user!.getIdToken());
      print('sign in OK lol');
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setBool('isLogin', true);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return false;
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('isLogin', false);
  }

  static Future<bool> isLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool('isLogin') ?? false;
  }
}
