import 'package:flutter/material.dart';
import 'package:Electrical/Helper/color_helper.dart';
import 'package:Electrical/Widget/user-mangment/user_listview.dart';

class UsersMangementScreen extends StatelessWidget {
  const UsersMangementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HelperColor.primaryColor,
      appBar: AppBar(
        backgroundColor: HelperColor.primaryColor,
        title: const Text('إدارة المستخدم'),
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
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: HelperColor.backgroundColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const ViewUserList(),
            ),
          ],
        ),
      ),
    );
  }
}
