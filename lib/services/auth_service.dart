// ignore_for_file: avoid_print, unused_local_variable

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';

class AuthServic {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<bool> canGivePermission() async {
    String uid = _auth.currentUser!.uid;
    DocumentSnapshot<Map<String, dynamic>> df = await _firestore.collection('users').doc(uid).get();
    try {
      if (df['role'] != null && df['role'] == 'manger') {
        print('Welcome To The Manger');
        return true;
      }
    } catch (e) {
      print(e);
    }
    print('Welcome to user||Admin');
    return false;
  }

  static Future<bool> canAddData() async {
    String uid = _auth.currentUser!.uid;
    DocumentSnapshot<Map<String, dynamic>> df = await _firestore.collection('users').doc(uid).get();
    try {
      if (df['role'] != null) {
        if (df['role'] == 'manger') {
          print('Manger');
          return true;
        }
        if (df['role'] == 'admin') {
          print('Admin');
          return true;
        }
      }
    } catch (e) {
      print(e);
    }
    print('User');
    return false;
  }

  static Future<String> register({required String email, required String password, required String username}) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _firestore.collection('users').doc(credential.user!.uid).set(
        {
          "email": email,
          "username": username,
          "password": sha256.convert(utf8.encode(password)).toString(),
          "role": "user",
          "cart": [],
          "favorites": [],
        },
      );
      return 'done';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return e.code;
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return e.code;
      }
    } catch (e) {
      print(e);
      return e.toString();
    }
    return '';
  }

  static Future<String> login({required String email, required String password}) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (credential.user!.emailVerified) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setBool('isLogin', true);
        _firestore.collection('users').doc(credential.user!.uid).set(
          {'password': sha256.convert(utf8.encode(password)).toString()},
          SetOptions(merge: true),
        );
        return 'done';
      } else {
        await credential.user!.sendEmailVerification();
        return 'not-verified';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return 'user-not-found';
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return 'wrong-password';
      }
    } catch (error) {
      print('error : $error');
      return error.toString();
    }
    return '';
  }

  static Future<void> signOut() async {
    await _auth.signOut();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('isLogin', false);
  }

  static Future<bool> isLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool('isLogin') ?? false;
  }

  static Future<bool> checkIfHeManger({required String password}) async {
    var user = await _firestore.collection('users').doc(_auth.currentUser!.uid).get();
    if (user.exists) {
      String userPassword = sha256.convert(utf8.encode(password)).toString();
      print('password After sha256 : $userPassword');
      return userPassword == user['password'];
    }
    return false;
  }

  static Future<bool> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      print('Password reset email sent to $email');
      return true;
    } catch (error) {
      print('Error sending password reset email: $error');
    }
    return false;
  }
}
