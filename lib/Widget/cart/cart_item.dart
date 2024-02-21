import 'package:flutter/material.dart';
import 'package:Electrical/Helper/padding_helper.dart';
import 'package:Electrical/Helper/text_style_helper.dart';
import 'package:Electrical/Models/cart.dart';
import 'package:Electrical/Widget/cart/item_button.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.cart,
    required this.onTapDelete,
    required this.onTapDec,
    required this.onTapInc,
  });

  final Cart cart;
  final void Function() onTapDelete;
  final void Function() onTapInc;
  final void Function() onTapDec;

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
              child: Hero(
                tag: 'cart ${cart.product.id}',
                child: Image.network(
                  cart.product.image,
                  height: size.width * 0.7,
                  width: size.width * 0.7,
                  fit: BoxFit.cover,
                ),
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
                    style: HelperText.ts14f(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  Text(
                    'السعر : ${cart.product.price}\$', // price
                    style: HelperText.ts12f(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    'الكمية : ${cart.quantity}', // quantity
                    style: HelperText.ts12f(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CartItemButton(
                        color: Colors.green,
                        icon: Icons.add,
                        onTap: onTapInc,
                      ),
                      const SizedBox(width: 18.0),
                      CartItemButton(
                        color: Colors.red,
                        icon: Icons.delete_outline_rounded,
                        onTap: onTapDelete,
                      ),
                      const SizedBox(width: 18.0),
                      CartItemButton(
                        color: Colors.green,
                        icon: Icons.remove,
                        onTap: onTapDec,
                      ),
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
