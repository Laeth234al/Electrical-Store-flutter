import 'package:get/get.dart';
import 'package:store_app/Controller/cart_controller.dart';
import 'package:store_app/Controller/favorite_controller.dart';
import 'package:store_app/Controller/product_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ProductController>(ProductController());
    Get.put<CartController>(CartController());
    Get.put<FavoriteController>(FavoriteController());
  }
}
