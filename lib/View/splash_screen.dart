import 'package:Electrical/Helper/color_helper.dart';
import 'package:Electrical/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late bool isLogin;
  @override
  void initState() {
    setIsLoading();
    Future.delayed(
      2.seconds,
      () {
        Get.offAllNamed(isLogin ? '/home' : '/');
      },
    );
    super.initState();
  }

  Future<void> setIsLoading() async {
    isLogin = await AuthServic.isLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              HelperColor.primaryColor,
              HelperColor.blueColor,
            ],
          ),
        ),
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(30.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40.0),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image.asset(
              'images/electrical_store.png',
            ),
          ),
        ),
      ),
    );
  }
}
