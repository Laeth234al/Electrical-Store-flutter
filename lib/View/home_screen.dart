// ignore_for_file: avoid_print

import 'package:Electrical/Helper/text_style_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Electrical/Helper/color_helper.dart';
import 'package:Electrical/Widget/home/drawer_item.dart';
import 'package:Electrical/Widget/home/home_body.dart';
import 'package:Electrical/services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HelperColor.primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: HelperColor.primaryColor,
        title: Text(
          'مرحبا بكم في متجر الألكترونيات',
          style: HelperText.ts18f(),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
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
                style: HelperText.ts18f(),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
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
              title: 'المفضلة',
              icon: Icons.favorite,
              onTap: () {
                print('favorite');
                Get.toNamed('/favo');
              },
            ),
            // isManger or admin
            FutureBuilder(
              future: AuthServic.canAddData(),
              builder: (context, snapshot) => Visibility(
                visible: snapshot.data ?? false,
                child: DrawerItem(
                  title: 'إضافة بيانات',
                  icon: Icons.add,
                  onTap: () {
                    print('add data');
                    Get.toNamed('/addData');
                  },
                ),
              ),
            ),
            // isManger
            FutureBuilder(
              future: AuthServic.canGivePermission(),
              builder: (context, snapshot) => Visibility(
                visible: snapshot.data ?? false,
                child: DrawerItem(
                  title: 'إدارة المستخدم',
                  icon: Icons.emoji_people,
                  onTap: () {
                    print('give permission');
                    Get.toNamed('/userMange');
                  },
                ),
              ),
            ),
            DrawerItem(
              title: 'الأعدادات',
              icon: Icons.settings,
              onTap: () {
                print('setting');
                Get.toNamed('/setting');
              },
            ),
            DrawerItem(
              title: 'حول',
              icon: Icons.error,
              onTap: () {
                print('about');
                Get.toNamed('/about');
              },
            ),
            DrawerItem(
              title: 'تسجيل الخروج',
              icon: Icons.logout,
              onTap: () async {
                print('log out');
                await AuthServic.signOut();
                print('log out111');
                Get.offAllNamed('/');
              },
            ),
          ],
        ),
      ),
      body: const HomeBody(),
    );
  }
}
