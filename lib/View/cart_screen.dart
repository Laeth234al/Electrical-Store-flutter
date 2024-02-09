import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app/Controller/cart_controller.dart';
import 'package:store_app/Helper/color_helper.dart';
import 'package:store_app/Helper/padding_helper.dart';
import 'package:store_app/Widget/cart/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HelperColor.primaryColor,
      appBar: AppBar(
        backgroundColor: HelperColor.primaryColor,
        elevation: 0.0,
        title: const Text(
          'السلة',
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const SizedBox(height: HelperPadding.defaultPadding / 2),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          HelperColor.primaryColor,
                          HelperColor.blueColor,
                        ],
                      ),
                    ),
                  ),
                  GetBuilder<CartController>(
                    builder: (cartController) => cartController.carts.isNotEmpty
                        ? ListView.builder(
                            clipBehavior: Clip.none,
                            itemCount: cartController.carts.length,
                            itemBuilder: (context, cardIndex) {
                              return CartItem(
                                cart: cartController.carts[cardIndex],
                                onTapDelete: () {
                                  cartController.deleteItemFormCart(cardIndex);
                                },
                                onTapCheckout: () {},
                              );
                            },
                          )
                        : const Center(
                            child: Text(
                              'Empty Cart',
                              style: TextStyle(fontSize: 30.0),
                            ),
                          ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: HelperColor.backgroundColor,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: InkWell(
                onTap: () {
                  print("check check");
                },
                child: Container(
                  height: 70.0,
                  decoration: BoxDecoration(
                    color: HelperColor.secondaryColor,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'توصيل',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Icon(
                          Icons.shopping_cart_checkout_outlined,
                          size: 30.0,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
