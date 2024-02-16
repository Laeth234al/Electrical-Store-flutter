// ignore_for_file: avoid_print, unused_local_variable

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';

class AuthServic {
  static Future<bool> canGivePermission() async {
    var snapshot = await SharedPreferences.getInstance();
    String uid = snapshot.getString('uid')!;
    DocumentSnapshot<Map<String, dynamic>> df = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    try {
      if (df['role'] != null && df['role'] == 'manger') {
        print('man give pre');
        return true;
      }
    } catch (e) {
      print(e);
    }
    print('other cannot');
    return false;
  }

  static Future<bool> canAddData() async {
    print('can');
    var snapshot = await SharedPreferences.getInstance();
    String uid = snapshot.getString('uid')!;
    DocumentSnapshot<Map<String, dynamic>> df = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    print('cannn');
    try {
      if (df['role'] != null) {
        if (df['role'] == 'manger') {
          print('manger');
          return true;
        }
        if (df['role'] == 'admin') {
          print('admin');
          return true;
        }
      }
    } catch (e) {
      print(e);
    }
    print('user');
    return false;
  }

  static Future<bool> register({required String email, required String password, required String username}) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseFirestore.instance.collection('users').doc(credential.user!.uid).set(
        {
          "email": email,
          "username": username,
          "password": sha256.convert(utf8.encode(password)).toString(),
          "role": "user",
        },
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
      await preferences.setString('uid', FirebaseAuth.instance.currentUser!.uid);
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
    await preferences.remove('uid');
  }

  static Future<bool> isLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool('isLogin') ?? false;
  }

  static Future<bool> checkIfHeManger({required String password}) async {
    var user = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
    if (user.exists) {
      String userPassword = sha256.convert(utf8.encode(password)).toString();
      print('password After sha256 : $userPassword');
      return userPassword == user['password'];
    }
    return false;
  }
}
