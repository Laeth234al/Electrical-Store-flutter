import 'package:get/get.dart';
import 'package:Electrical/Controller/cart_controller.dart';
import 'package:Electrical/Controller/favorite_controller.dart';
import 'package:Electrical/Controller/product_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ProductController>(ProductController());
    Get.put<CartController>(CartController());
    Get.put<FavoriteController>(FavoriteController());
  }
}
