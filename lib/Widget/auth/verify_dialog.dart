import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Electrical/Helper/color_helper.dart';
import 'package:Electrical/Helper/text_style_helper.dart';

class VerifyDialog extends StatelessWidget {
  const VerifyDialog({
    super.key,
    required this.email,
  });
  final String email;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(20.0),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'يرجى التحقق من البريد الإلكتروني',
              style: HelperText.ts16f(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Text(
              'يرجى الانتقال إلى بريدك الإلكتروني $email والنقر على الرابط للتحقق من بريدك الإلكتروني',
              maxLines: 3,
              textAlign: TextAlign.center,
              style: HelperText.ts14f(),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  onPressed: () {
                    Get.back();
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                  color: HelperColor.backgroundColor,
                  child: const Text(
                    'إغلاق',
                    style: TextStyle(
                      color: HelperColor.textLightColor,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
