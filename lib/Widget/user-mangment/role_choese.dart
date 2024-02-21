import 'package:Electrical/Widget/user-mangment/dialog_uncorrect_password.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Electrical/Controller/users_controller.dart';
import 'package:Electrical/Helper/color_helper.dart';
import 'package:Electrical/Helper/text_style_helper.dart';
import 'package:Electrical/Widget/custom_text_field.dart';

class RoleChoese extends StatelessWidget {
  const RoleChoese({
    super.key,
    required this.value,
    required this.index,
    required this.username,
    required this.uid,
  });
  final String value;
  final int index;
  final String username;
  final String uid;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      builder: (controller) => Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'تعيين ك $value',
              style: HelperText.ts12f(),
            ),
            const SizedBox(width: 12.0),
            Radio(
              value: value,
              groupValue: controller.roles[index],
              onChanged: (value) async {
                // ask before set
                await Get.dialog(
                  Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    elevation: 0.0,
                    backgroundColor: Colors.transparent,
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2.0,
                        ),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            HelperColor.primaryColor,
                            HelperColor.blueColor,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'حفظ',
                            style: HelperText.ts18f(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            "هل انت متأكد من تعيين $username ك $value",
                            style: HelperText.ts16f(),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16.0),
                          if (value! == 'manger')
                            Container(
                              padding: const EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                color: HelperColor.backgroundColor,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: CustomTextField(
                                labelText: 'أدخل كلمة المرور',
                                hintText: '****',
                                controller: controller.passwordOfManger,
                                isPassword: true,
                                doBlackColor: true,
                                icon: Icons.password,
                              ),
                            ),
                          const SizedBox(height: 16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  if (value == 'manger') {
                                    bool isManger = await controller.checkIfHeManger();
                                    if (isManger) {
                                      Get.back();
                                      await controller.setUserAs(role: value, uid: uid);
                                      controller.toggleRoles(index: index, role: value);
                                    } else {
                                      Get.back();
                                      Get.dialog(const PasswordNotCorrectDialog());
                                    }
                                  } else {
                                    Get.back();
                                    await controller.setUserAs(role: value, uid: uid);
                                    controller.toggleRoles(index: index, role: value);
                                  }
                                  controller.passwordOfManger.text = "";
                                },
                                child: const Text('حفظ'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  controller.passwordOfManger.text = "";
                                  Get.back();
                                },
                                child: const Text('إغلاق'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
