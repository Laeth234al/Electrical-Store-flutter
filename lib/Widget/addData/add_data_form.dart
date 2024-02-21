// ignore_for_file: avoid_print

import 'dart:io';
import 'package:Electrical/Widget/custom_dialog.dart';
import 'package:Electrical/Widget/spinket_indecator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Electrical/Helper/color_helper.dart';
import 'package:Electrical/Helper/text_style_helper.dart';
import 'package:Electrical/Widget/addData/pickimage_button.dart';
import 'package:Electrical/Widget/custom_text_field.dart';
import 'package:Electrical/services/storage_service.dart';

class AddDataForm extends StatefulWidget {
  const AddDataForm({super.key});
  @override
  State<AddDataForm> createState() => _AddDataFormState();
}

class _AddDataFormState extends State<AddDataForm> {
  @override
  void initState() {
    title = TextEditingController();
    subTitle = TextEditingController();
    description = TextEditingController();
    price = TextEditingController();
    tags = TextEditingController();
    _globalKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    title.dispose();
    subTitle.dispose();
    description.dispose();
    price.dispose();
    tags.dispose();
    super.dispose();
  }

  late TextEditingController title;
  late TextEditingController subTitle;
  late TextEditingController description;
  late TextEditingController price;
  late TextEditingController tags;
  late final GlobalKey<FormState> _globalKey;
  File? file;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final RegExp decimalRegex = RegExp(r"^[+]?([0-9]*[.])?[0-9]+$");
    Future<void> pickImage({required ImageSource source}) async {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source);
      if (image != null) {
        setState(() {
          file = File(image.path);
        });
      }
    }

    return Form(
      key: _globalKey,
      child: isLoading
          ? const SpinIndecator()
          : ListView(
              children: [
                CustomTextField(
                  controller: title,
                  hintText: 'العنوان الرئيسي',
                  labelText: 'العنوان الرئيسي',
                  icon: Icons.title_rounded,
                  doBlackColor: true,
                ),
                CustomTextField(
                  controller: subTitle,
                  hintText: 'العنوان الفرعي',
                  labelText: 'العنوان الفرعي',
                  icon: Icons.title_rounded,
                  doBlackColor: true,
                ),
                CustomTextField(
                  controller: description,
                  hintText: 'الوصف',
                  labelText: 'الوصف',
                  icon: Icons.description_rounded,
                  isBigText: true,
                  doBlackColor: true,
                ),
                CustomTextField(
                  controller: price,
                  hintText: 'xxx.xx',
                  labelText: 'السعر',
                  icon: Icons.attach_money,
                  isNumber: true,
                  doBlackColor: true,
                  validator: (text) {
                    if (!decimalRegex.hasMatch(text!)) {
                      return "Enter decimal number";
                    }
                    try {
                      double parsedDouble = double.parse(text);
                      print('price : $parsedDouble');
                    } catch (e) {
                      print("Error: Failed to parse string to double. Reason: $e");
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  controller: tags,
                  hintText: 'علامة1,علامة2,...',
                  labelText: 'العلامات',
                  icon: Icons.tag_sharp,
                  doBlackColor: true,
                  isTags: true,
                ),
                // pick image
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      PickImageButton(
                        onTap: () {
                          print('pick image from gallery');
                          pickImage(source: ImageSource.gallery);
                        },
                        text: 'إختيار صورة',
                      ),
                      file == null
                          ? const Icon(Icons.image)
                          : Image.file(
                              file!,
                              width: 50.0,
                              height: 50.0,
                            ),
                      PickImageButton(
                        onTap: () {
                          print('pick image from camera');
                          pickImage(source: ImageSource.camera);
                        },
                        text: 'إلتقاط صورة',
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      if (_globalKey.currentState!.validate()) {
                        if (file != null) {
                          setState(() {
                            isLoading = true;
                          });
                          print('add this data');
                          // tags edit
                          String tagsText = this.tags.text;
                          List<String> tags = tagsText.split(',').map((e) => e.trim()).toList();
                          print(tags);
                          // price edit
                          double parsedDouble;
                          try {
                            parsedDouble = double.parse(price.text);
                            print('price : $parsedDouble');
                            var v = await StorageService.uploadProductData(
                              title: title.text,
                              subTitle: subTitle.text,
                              description: description.text,
                              tags: tags,
                              price: parsedDouble,
                              image: file!,
                            );
                            if (v == 'done') {
                              title.text = '';
                              subTitle.text = '';
                              description.text = '';
                              price.text = '';
                              this.tags.text = '';
                              file = null;
                              Get.dialog(const CustomDialog(
                                title: 'إضافة البيانات',
                                subtitle: "تم إضافة البيانات بنجاح",
                              ));
                            } else if (v == 'not-valid') {
                              Get.dialog(const CustomDialog(
                                title: 'حدث خطأ',
                                subtitle: 'حدث خطأ أثناء إضافة البيانات',
                              ));
                            } else {
                              Get.dialog(CustomDialog(
                                title: 'حدث خطأ',
                                subtitle: 'حدث خطأ أثناء إضافة البيانات $v',
                              ));
                            }
                          } catch (e) {
                            print("Error: Failed to parse string to double. Reason: $e");
                            Get.dialog(const CustomDialog(
                              title: 'حدث خطأ',
                              subtitle: 'حدث خطأ أثناء إضافة البيانات',
                            ));
                          }
                        } else {
                          Get.dialog(const CustomDialog(
                            title: 'الصورة',
                            subtitle: "لم تقم بتحميل ملف الصورة",
                          ));
                        }
                      } else {
                        Get.dialog(const CustomDialog(
                          title: 'المعلومات غير صحيحة',
                          subtitle: 'الرجاء ملئ الحقول المطلوبة بالمعلومات الصحيحة',
                        ));
                      }
                      setState(() {
                        isLoading = false;
                      });
                    },
                    child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            HelperColor.primaryColor,
                            HelperColor.blueColor,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Center(
                        child: Text(
                          'إضافة البيانات',
                          style: HelperText.ts16f(fontWeight: FontWeight.w700),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
