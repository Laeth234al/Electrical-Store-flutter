import 'package:get/get.dart';
import 'package:Electrical/Models/cart.dart';
import 'package:Electrical/Models/product.dart';
import 'package:Electrical/services/storage_service.dart';

class CartController extends GetxController {
  List<Cart> carts = <Cart>[];

  bool _isLoading = false;

  @override
  void onInit() async {
    _isLoading = true;
    update();
    carts = await StorageService.getCartProducts;
    print('cart[0] : ${carts[0].toJson2()}');
    _isLoading = false;
    update();
    super.onInit();
  }

  bool get isLoading => _isLoading;

  void _toggleLoading() {
    _isLoading = !_isLoading;
    update();
  }

  void addToCart(Product product) async {
    _toggleLoading();
    carts.add(Cart(product: product));
    await StorageService.uploadCart(carts);
    print('add to cart one product');
    _toggleLoading();
    update();
  }

  bool isAddedInCartBefor(String productId) {
    for (var cart in carts) {
      if (cart.product.id == productId) {
        return true;
      }
    }
    return false;
  }

  void deleteItemFormCart(int index) async {
    _toggleLoading();
    carts.removeAt(index);
    await StorageService.uploadCart(carts);
    _toggleLoading();
    update();
  }

  void addQuantity(int index, bool add) async {
    _toggleLoading();
    if (add) {
      // true = add
      carts[index].quantity++;
      await StorageService.uploadCart(carts);
    } else {
      // false = remove
      if (carts[index].quantity > 1) {
        carts[index].quantity--;
        await StorageService.uploadCart(carts);
      } else {
        deleteItemFormCart(index);
      }
    }
    _toggleLoading();
    update();
  }

  void checkout() {
    _toggleLoading();
    //checkout code
    _toggleLoading();
  }
}
