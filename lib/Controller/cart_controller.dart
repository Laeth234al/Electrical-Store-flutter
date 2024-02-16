import 'package:get/get.dart';
import 'package:store_app/Models/cart.dart';
import 'package:store_app/Models/product.dart';

class CartController extends GetxController {
  List<Cart> carts = <Cart>[];

  // logic
  bool addToCart(Product product) {
    if (isAddedInCartBefor(product.id)) {
      print('added before');
      return false;
    }
    carts.add(Cart(product: product));
    print('add to cart one product');
    update();
    return true;
  }

  bool isAddedInCartBefor(String productId) {
    for (var cart in carts) {
      if (cart.product.id == productId) {
        return true;
      }
    }
    return false;
  }

  void deleteItemFormCart(int index) {
    carts.removeAt(index);
    update();
  }

  void addQuantity(int index, bool add) {
    if (add) {
      // true = add
      carts[index].quantity++;
    } else {
      // false = remove
      if (carts[index].quantity > 1) {
        carts[index].quantity--;
      } else {
        deleteItemFormCart(index);
      }
    }
    update();
  }

  void checkout() {
    //checkout code
  }
}
