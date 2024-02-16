// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_app/Helper/color_helper.dart';
import 'package:store_app/Helper/text_style_helper.dart';
import 'package:store_app/Widget/addData/pickimage_button.dart';
import 'package:store_app/Widget/custom_text_field.dart';
import 'package:store_app/services/storage_service.dart';

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
      child: ListView(
        children: [
          CustomTextField(
            controller: title,
            hintText: 'title',
            labelText: 'Title',
            icon: Icons.title_rounded,
            doBlackColor: true,
          ),
          CustomTextField(
            controller: subTitle,
            hintText: 'subtitle',
            labelText: 'Subtitle',
            icon: Icons.title_rounded,
            doBlackColor: true,
          ),
          CustomTextField(
            controller: description,
            hintText: 'description',
            labelText: 'Description',
            icon: Icons.description_rounded,
            isBigText: true,
            doBlackColor: true,
          ),
          CustomTextField(
            controller: price,
            hintText: 'price',
            labelText: 'Price',
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
            hintText: 'tags',
            labelText: 'Tags',
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
              onTap: () {
                if (_globalKey.currentState!.validate()) {
                  if (file != null) {
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
                      StorageService.uploadProductData(
                        title: title.text,
                        subTitle: subTitle.text,
                        description: description.text,
                        tags: tags,
                        price: parsedDouble,
                        image: file!,
                      );
                    } catch (e) {
                      print("Error: Failed to parse string to double. Reason: $e");
                    }
                  } else {
                    print('file is null');
                  }
                } else {
                  print('do not add it');
                }
                print('add this data if it\'s valid'); // add tags to pop menu
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
                    style: HelperText.ts18f(fontWeight: FontWeight.w700),
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
