import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app/Controller/Binding/auth_binding.dart';
import 'package:store_app/Controller/Binding/home_binding.dart';
import 'package:store_app/Helper/color_helper.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:store_app/View/cart_screen.dart';
import 'package:store_app/View/home_screen.dart';
import 'package:store_app/View/register_screen.dart';
import 'package:store_app/View/sign_in_screen.dart';

void main() {
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
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SignInScreen(), binding: AuthBinding()),
        GetPage(name: '/register', page: () => RegisterScreen(), binding: AuthBinding()),
        GetPage(name: '/home', page: () => const HomeScreen(), binding: ProductBinding()),
        GetPage(name: '/cart', page: () => CartScreen()),
        // ...other routes
      ],
    );
  }
}



/// Tasks

//// add Sign in Page 
//// add Register Page
//// add Cart Page
//// - Cart Page :
////     - remove item
////     - get order
//// create controller for product model
//// create controller for cart model
/// add Setting Page /
/// - Setting Page :/
///     - filter :
///       - with price
///       - with name
///       - has discount
///     - language :
///        - ar
///        - en
/// add About Page /
/// - About Page :
///     - write from Bard about my app
