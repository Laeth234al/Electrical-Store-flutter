import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app/Helper/color_helper.dart';
import 'package:store_app/Widget/home/drawer_item.dart';
import 'package:store_app/Widget/home/home_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HelperColor.primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: HelperColor.primaryColor,
        title: const Text('مرحبا بكم في متجر الألكترونيات'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  colors: [
                    HelperColor.primaryColor,
                    HelperColor.blueColor,
                  ],
                ),
              ),
              child: Text(
                'القائمة الرئيسية',
                style: TextStyle(fontSize: 28.0),
              ),
            ),
            DrawerItem(
              title: 'السلة',
              icon: Icons.shopping_cart,
              onTap: () {
                print('cart');
                Get.toNamed('/cart');
              },
            ),
            DrawerItem(
              title: 'الأعدادات',
              icon: Icons.settings,
              onTap: () {
                print('setting');
              },
            ),
            DrawerItem(
              title: 'حول',
              icon: Icons.error,
              onTap: () {
                print('about');
              },
            ),
            DrawerItem(
              title: 'تسجيل الخروج',
              icon: Icons.logout,
              onTap: () {
                print('log out');
                Get.offAllNamed('/');
              },
            ),
          ],
        ),
      ),
      body: HomeBody(),
    );
  }
}
