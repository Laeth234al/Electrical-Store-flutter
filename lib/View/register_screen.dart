// ignore_for_file: avoid_print

import 'package:Electrical/Widget/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Electrical/Controller/auth_controller.dart';
import 'package:Electrical/Helper/color_helper.dart';
import 'package:Electrical/Helper/padding_helper.dart';
import 'package:Electrical/Helper/text_style_helper.dart';
import 'package:Electrical/Widget/custom_text_field.dart';
import 'package:Electrical/Widget/spinket_indecator.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
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
                    'إنشاء حساب',
                    style: TextStyle(fontSize: 30.0),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    'أهلاً بك',
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
                  padding: const EdgeInsets.all(HelperPadding.defaultPadding),
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
                                labelText: 'أسم المستخدم',
                                hintText: 'جاسم بن عبد الرحمن',
                                icon: Icons.person,
                                controller: authController.username,
                              ),
                            ),
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
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      GetBuilder<AuthController>(
                        builder: (c) => c.isLoading
                            ? const SpinIndecator()
                            : InkWell(
                                child: Container(
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
                                      'إنشاء حساب',
                                      style: HelperText.ts14f(fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                                onTap: () async {
                                  print('Create Account');
                                  if (authController.isVaildForRegister) {
                                    print('valid for register');
                                    var v = await authController.register();
                                    print('ok');
                                    if (v == 'done') {
                                      Get.back();
                                      Get.dialog(const CustomDialog(title: 'أنشاء حساب', subtitle: "تم أنشاء الحساب بنجاح"));
                                    } else if (v == 'weak-password') {
                                      Get.dialog(const CustomDialog(
                                        title: 'كلمة المرور ضعيفة',
                                        subtitle: 'يبدو أن كلمة المرور التي أدخلتها ضعيفة للغاية',
                                      ));
                                    } else if (v == 'email-already-in-use') {
                                      Get.dialog(const CustomDialog(
                                        title: 'الحساب مستخدم بالفعل',
                                        subtitle: 'يبدو أن هذا الحساب مستخدم بالفعل',
                                      ));
                                    } else {
                                      Get.dialog(const CustomDialog(
                                        title: 'المعلومات غير صحيحة',
                                        subtitle: 'الرجاء ملئ الحقول المطلوبة بالمعلومات الصحيحة',
                                      ));
                                    }
                                  } else {
                                    print('not valid for register');
                                    Get.dialog(const CustomDialog(
                                      title: 'المعلومات غير صحيحة',
                                      subtitle: 'الرجاء ملئ الحقول المطلوبة بالمعلومات الصحيحة',
                                    ));
                                  }
                                },
                              ),
                      ),
                      const SizedBox(height: 40.0),
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
