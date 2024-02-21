// ignore_for_file: avoid_print

import 'package:Electrical/Widget/auth/verify_dialog.dart';
import 'package:Electrical/Widget/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Electrical/Controller/auth_controller.dart';
import 'package:Electrical/Helper/color_helper.dart';
import 'package:Electrical/Helper/padding_helper.dart';
import 'package:Electrical/Helper/text_style_helper.dart';
import 'package:Electrical/Widget/custom_text_field.dart';
import 'package:Electrical/Widget/spinket_indecator.dart';

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
                  Text(
                    'تسجيل الدخول',
                    style: TextStyle(fontSize: 30.0),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    'أهلا بك مجدداً',
                    style: TextStyle(fontSize: 20.0),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
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
                  padding: const EdgeInsets.all(HelperPadding.defaultPadding * (2 / 2)),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      const SizedBox(height: 10.0),
                      Container(
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
                              child: CustomTextField(
                                labelText: 'البريد الألكتروني',
                                hintText: 'example@ex.mp',
                                icon: Icons.email,
                                controller: authController.email,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
                              ),
                              child: CustomTextField(
                                labelText: 'كلمة المرور',
                                hintText: '****',
                                icon: Icons.password,
                                controller: authController.password,
                                isPassword: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      InkWell(
                        child: Center(
                          child: Text(
                            'نسيت كلمة المرور؟',
                            style: HelperText.ts12f(color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        onTap: () {
                          print('Forget Password');
                          if (authController.isVaildToResetPassword) {
                            print(authController.resetPassword());
                          } else {
                            print('not Valid for reset password');
                            Get.dialog(const CustomDialog(
                              title: 'المعلومات غير صحيحة',
                              subtitle: "يبدو أن حقل البريد فارغ أو أنك لم تدخل البريد بالشكل الصحيح",
                            ));
                          }
                        },
                      ),
                      const SizedBox(height: 20.0),
                      GetBuilder<AuthController>(
                        builder: (c) => InkWell(
                          child: c.isLoading
                              ? const SpinIndecator()
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
                                  child: Center(
                                    child: Text(
                                      'تسجيل الدخول',
                                      style: HelperText.ts14f(fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                          onTap: () async {
                            print('Login Button');
                            if (authController.isVaildForSignIn) {
                              print('valid for login');
                              var v = await authController.login();
                              if (v == 'done') {
                                Get.offNamed('/home');
                              } else if (v == 'not-verified') {
                                Get.dialog(VerifyDialog(email: authController.email.text));
                              } else if (v == 'user-not-found') {
                                Get.dialog(const CustomDialog(
                                  title: 'ليس لديك حساب',
                                  subtitle: 'يبدو أنه ليس لديك حساب أو أدخلت حسابك بشكل خاطئ',
                                ));
                              } else if (v == 'wrong-password') {
                                Get.dialog(CustomDialog(
                                  title: 'كلمة المرور خاطئة',
                                  subtitle: 'يبدو أن كلمة المرور التي أدخلنها خاطئة لحسابك ${authController.email.text}',
                                ));
                              } else {
                                Get.dialog(const CustomDialog(
                                  title: 'كلمة المرور خاطئة أو ليس لديك حساب',
                                  subtitle: 'يبدو أنه ليس لديك حساب أو كلمة المرور لديك خاطئة',
                                ));
                              }
                            } else {
                              print('not valid for login');
                              Get.dialog(const CustomDialog(
                                title: 'المعلومات غير صحيحة',
                                subtitle: 'الرجاء ملئ الحقول المطلوبة بالمعلومات الصحيحة',
                              ));
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 50.0),
                      Center(
                        child: Text(
                          'جرب التسجيل بطرق أخرى',
                          style: HelperText.ts12f(color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                print('is not avalible for now');
                                Get.dialog(const CustomDialog(
                                  title: 'الخيار غير متاح',
                                  subtitle: 'هذا الخيار غير متاح حالياً',
                                ));
                              },
                              child: Container(
                                height: 50.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.0),
                                  color: Colors.black,
                                ),
                                child: Center(
                                  child: Text(
                                    'Google',
                                    style: HelperText.ts18f(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 30.0),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                print('is not avalible for now');
                                Get.dialog(const CustomDialog(
                                  title: 'الخيار غير متاح',
                                  subtitle: 'هذا الخيار غير متاح حالياً',
                                ));
                              },
                              child: Container(
                                height: 50.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.0),
                                  color: Colors.blue,
                                ),
                                child: Center(
                                  child: Text(
                                    'Facebook',
                                    style: HelperText.ts18f(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40.0),
                      InkWell(
                        child: Center(
                          child: Text(
                            'ليس لدي حساب ,إنشاء حساب جديد',
                            style: HelperText.ts12f(color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
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
