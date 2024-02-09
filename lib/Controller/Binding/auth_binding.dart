import 'package:get/get.dart';
import 'package:store_app/Controller/auth_controller.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController());
  }
}
