import 'package:store_app/Models/product.dart';

class Cart {
  final Product product;
  int quantity;
  Cart({
    required this.product,
    this.quantity = 1,
  });
}
