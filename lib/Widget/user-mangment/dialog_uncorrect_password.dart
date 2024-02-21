import 'package:Electrical/Helper/color_helper.dart';
import 'package:Electrical/Helper/text_style_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              'غير صحيحة',
              style: HelperText.ts18f(fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const SizedBox(height: 8.0),
            const Text(
              'كلمة المرور التي أدخلتها غير صحيحة',
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
              child: const Text('إغلاق'),
            ),
          ],
        ),
      ),
    );
  }
}
