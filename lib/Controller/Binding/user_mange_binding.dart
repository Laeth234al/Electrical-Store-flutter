import 'package:get/get.dart';
import 'package:Electrical/Controller/users_controller.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<UserController>(UserController());
  }
}
