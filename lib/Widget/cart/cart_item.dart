import 'package:flutter/material.dart';
import 'package:store_app/Helper/color_helper.dart';
import 'package:store_app/Helper/padding_helper.dart';
import 'package:store_app/Models/cart.dart';
import 'package:store_app/Widget/cart/item_button.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.cart,
    required this.onTapDelete,
    required this.onTapCheckout,
  });

  final Cart cart;
  final void Function() onTapDelete;
  final void Function() onTapCheckout;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: HelperPadding.defaultPadding,
        vertical: HelperPadding.defaultPadding / 2,
      ),
      height: 180.0,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 160.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22.0),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0.0, 15.0),
                  blurRadius: 25.0,
                  color: Colors.black26,
                ),
              ],
            ),
          ),
          Positioned(
            top: 0.0,
            left: 0.0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: HelperPadding.defaultPadding),
              height: 144.0,
              width: 180.0,
              child: Image.asset(
                cart.product.image, // image
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            right: 0.0,
            child: SizedBox(
              height: 140.0,
              width: size.width - 180.0,
              child: Column(
                children: [
                  Text(
                    cart.product.title, // title
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: HelperColor.secondaryColor,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'price : ${cart.product.price}\$', // price
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          'quantity : ${cart.quantity}', // quantity
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Spacer(),
                      CartItemButton(
                        color: Colors.red,
                        icon: Icons.delete_outline_rounded,
                        onTap: onTapDelete,
                      ),
                      const Spacer(),
                      CartItemButton(
                        color: Colors.green,
                        icon: Icons.shopping_cart_checkout,
                        onTap: onTapCheckout,
                      ),
                      const Spacer(),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
