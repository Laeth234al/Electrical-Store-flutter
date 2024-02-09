import 'package:get/get.dart';
import 'package:store_app/Models/cart.dart';
import 'package:store_app/Models/product.dart';

class CartController extends GetxController {
  List<Cart> carts = <Cart>[];

  // logic
  bool addToCart(Product product) {
    for (int i = 0; i < carts.length; i++) {
      if (carts[i].product.id == product.id) {
        carts[i].quantity += 1;
        print('add to quantity +1');
        return false;
      }
    }
    carts.add(Cart(product: product));
    print('add to cart one product');
    return true;
  }

  void deleteItemFormCart(int index) {
    carts.removeAt(index);
    update();
  }

  void checkout() {
    //checkout code
  }
}
