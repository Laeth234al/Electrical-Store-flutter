import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app/Controller/Binding/auth_binding.dart';
import 'package:store_app/Controller/Binding/home_binding.dart';
import 'package:store_app/Controller/Binding/user_mange_binding.dart';
import 'package:store_app/Helper/color_helper.dart';
import 'package:store_app/View/about_screen.dart';
import 'package:store_app/View/add_data_screen.dart';
import 'package:store_app/View/cart_screen.dart';
import 'package:store_app/View/favorite_screen.dart';
import 'package:store_app/View/home_screen.dart';
import 'package:store_app/View/register_screen.dart';
import 'package:store_app/View/setting_screen.dart';
import 'package:store_app/View/sign_in_screen.dart';
import 'package:store_app/View/users_mangement_screen.dart';
import 'package:store_app/firebase_options.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:store_app/services/auth_service.dart';

late bool isLogin;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  isLogin = await AuthServic.isLogin();
  runApp(const StoreApp());
}

class StoreApp extends StatelessWidget {
  const StoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Electrical Store',
      theme: ThemeData(
        fontFamily: "ElMessiri",
        primaryColor: HelperColor.primaryColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: HelperColor.primaryColor),
      ),
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale("ar", "AE")],
      locale: const Locale("ar", "AE"),
      initialRoute: isLogin ? '/home' : '/',
      getPages: [
        GetPage(name: '/', page: () => SignInScreen(), binding: AuthBinding()),
        GetPage(name: '/register', page: () => RegisterScreen(), binding: AuthBinding()),
        GetPage(name: '/home', page: () => const HomeScreen(), binding: HomeBinding()),
        GetPage(name: '/cart', page: () => const CartScreen()),
        GetPage(name: '/favo', page: () => const FavoriteScreen()),
        GetPage(name: '/addData', page: () => const AddDataScreen()),
        GetPage(name: '/userMange', page: () => const UsersMangementScreen(), binding: UserBinding()),
        GetPage(name: '/setting', page: () => const SettingScreen()),
        GetPage(name: '/about', page: () => const AboutScreen()),
      ],
    );
  }
}
