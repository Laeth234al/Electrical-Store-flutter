// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app/Controller/auth_controller.dart';
import 'package:store_app/Helper/color_helper.dart';
import 'package:store_app/Helper/padding_helper.dart';
import 'package:store_app/Widget/auth/auth_text_field.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            colors: [
              HelperColor.primaryColor,
              HelperColor.blueColor,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80.0),
            const Padding(
              padding: EdgeInsets.all(HelperPadding.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('تسجيل الدخول', style: TextStyle(fontSize: 30.0)),
                  Text('أهلا بك مجدداً', style: TextStyle(fontSize: 20.0)),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(HelperPadding.defaultPadding * (3 / 2)),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const SizedBox(height: 40.0),
                      Container(
                        //padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: HelperColor.primaryColor.withOpacity(0.3),
                              blurRadius: 20.0,
                              offset: const Offset(0.0, 10.0),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
                              ),
                              child: AuthTextField(
                                labelText: 'Email',
                                hintText: 'example@ex.mp',
                                icon: Icons.email,
                                controller: authController.email,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
                              ),
                              child: AuthTextField(
                                labelText: 'Password',
                                hintText: '****',
                                icon: Icons.password,
                                controller: authController.password,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      InkWell(
                        child: const Center(
                          child: Text(
                            '?Forget Password',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        onTap: () {
                          print('Forget Password');
                        },
                      ),
                      const SizedBox(height: 20.0),
                      GetBuilder<AuthController>(
                        builder: (c) => InkWell(
                          child: c.isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : Container(
                                  height: 50.0,
                                  margin: const EdgeInsets.symmetric(horizontal: 50.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      colors: [
                                        HelperColor.primaryColor,
                                        HelperColor.blueColor,
                                      ],
                                    ),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                          onTap: () async {
                            print('Login Button');
                            if (authController.isVaildForSignIn) {
                              print('valid for login');
                              c.changeLoading();
                              var v = await authController.login();
                              c.changeLoading();
                              if (v) Get.offNamed('/home');
                            } else {
                              print('not valid for login');
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 50.0),
                      const Center(
                        child: Text(
                          'continue with another way',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 50.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.0),
                                color: Colors.black,
                              ),
                              child: const Center(
                                child: Text(
                                  'Github',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 30.0),
                          Expanded(
                            child: Container(
                              height: 50.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.0),
                                color: Colors.blue,
                              ),
                              child: const Center(
                                child: Text(
                                  'Facebook',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40.0),
                      InkWell(
                        child: const Center(
                          child: Text(
                            'doesn\'t have account create one',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        onTap: () {
                          print('create one');
                          Get.toNamed('/register');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
