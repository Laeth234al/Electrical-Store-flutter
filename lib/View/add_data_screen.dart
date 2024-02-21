import 'package:flutter/material.dart';
import 'package:Electrical/Helper/color_helper.dart';
import 'package:Electrical/Widget/addData/add_data_form.dart';

class AddDataScreen extends StatelessWidget {
  const AddDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HelperColor.primaryColor,
      appBar: AppBar(
        backgroundColor: HelperColor.primaryColor,
        title: const Text("إضافة بيانات"),
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
            Container(
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: HelperColor.backgroundColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const AddDataForm(),
            ),
          ],
        ),
      ),
    );
  }
}
