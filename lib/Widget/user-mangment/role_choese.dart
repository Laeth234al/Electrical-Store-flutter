import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app/Controller/users_controller.dart';
import 'package:store_app/Helper/color_helper.dart';
import 'package:store_app/Helper/text_style_helper.dart';
import 'package:store_app/Widget/custom_text_field.dart';

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
            Text('set as $value'),
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
                            'Save',
                            style: HelperText.ts18f(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'Are you sure you want to set "$username" as a $value',
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
                                labelText: 'Your password',
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
                                      controller.toggleRoles(index: index, role: value);
                                      Get.back();
                                    } else {
                                      Get.back();
                                      Get.dialog(const PasswordNotCorrectDialog());
                                    }
                                  } else {
                                    controller.setUserAs(role: value, uid: uid);
                                    controller.toggleRoles(index: index, role: value);
                                    Get.back();
                                  }
                                  controller.passwordOfManger.text = "";
                                },
                                child: const Text('Save'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  controller.passwordOfManger.text = "";
                                  Get.back();
                                },
                                child: const Text('Close'),
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

class PasswordNotCorrectDialog extends StatelessWidget {
  const PasswordNotCorrectDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              HelperColor.primaryColor,
              HelperColor.blueColor,
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Not correct',
              style: HelperText.ts18f(fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const SizedBox(height: 8.0),
            const Text(
              'The password you insert is not correct',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}
