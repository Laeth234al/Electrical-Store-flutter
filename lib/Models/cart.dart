import 'package:Electrical/Models/product.dart';

class Cart {
  final Product product;
  int quantity;
  Cart({
    required this.product,
    this.quantity = 1,
  });
  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        quantity: json["quantity"],
        product: Product.fromJson(json["Product"]),
      );

  factory Cart.fromJson2(Map<String, dynamic> json) => Cart(
        quantity: json['quantity'],
        product: json['Product'],
      );

  Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "Product": product.toJson(),
      };
  Map<String, dynamic> toJson2() => {
        "quantity": quantity,
        "Product": product.toJson2(),
      };
}
