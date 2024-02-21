import 'package:flutter/material.dart';
import 'package:Electrical/Helper/text_style_helper.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.icon,
    this.isPassword = false,
    this.isNumber = false,
    this.isBigText = false,
    this.doBlackColor = false,
    this.isTags = false,
    this.validator,
  });
  final String labelText;
  final String hintText;
  final IconData? icon;
  final bool isPassword;
  final bool isNumber;
  final bool isBigText;
  final bool isTags;
  final bool doBlackColor;
  final String? Function(String?)? validator;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.0),
      borderSide: BorderSide(
        color: doBlackColor ? Colors.black : Colors.white,
      ),
    );
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        validator: (text) {
          if (text!.isEmpty) {
            return "Empty";
          }
          void addProduct() {
            // استخراج نص tags من حقل النص
            String tagsText = controller.text;
            // تحويل نص tags إلى قائمة
            List<String> tags = tagsText.split(',');
            for (var tag in tags) {
              print('tag : "${tag.trim()}"');
            }
          }

          isTags ? addProduct() : null;
          return validator?.call(text) == null ? null : validator!(text);
        },
        onTapOutside: (e) {
          FocusScope.of(context).unfocus();
        },
        controller: controller,
        decoration: InputDecoration(
          // enabled: false,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: const BorderSide(width: 1.0),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
          focusedBorder: outlineInputBorder,
          enabledBorder: outlineInputBorder,
          labelText: labelText,
          labelStyle: HelperText.ts14f(),
          hintText: hintText,
          hintStyle: HelperText.ts12f(),
          prefixIcon: icon == null
              ? null
              : Icon(
                  icon,
                  color: Colors.black,
                ),
        ),
        obscureText: isPassword,
        maxLines: isBigText ? 3 : 1,
        keyboardType: isNumber ? TextInputType.number : null,
      ),
    );
  }
}
