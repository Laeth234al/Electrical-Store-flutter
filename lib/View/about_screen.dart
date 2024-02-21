import 'package:Electrical/Helper/text_style_helper.dart';
import 'package:flutter/material.dart';
import 'package:Electrical/Helper/color_helper.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HelperColor.primaryColor,
      appBar: AppBar(
        backgroundColor: HelperColor.primaryColor,
        title: const Text('حول'),
        centerTitle: true,
      ),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    HelperColor.primaryColor,
                    HelperColor.blueColor,
                  ],
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: CircleAvatar(
                      maxRadius: 100.0,
                      child: Image.asset(
                        'images/electrical_store.png',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'أسم التطبيق : Electrial Store',
                    style: HelperText.ts16f(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'الأصدار : 1.0.0v',
                    style: HelperText.ts14f(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
