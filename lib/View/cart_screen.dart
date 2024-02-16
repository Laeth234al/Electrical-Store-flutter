import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app/Controller/cart_controller.dart';
import 'package:store_app/Helper/color_helper.dart';
import 'package:store_app/Helper/padding_helper.dart';
import 'package:store_app/View/details_screen.dart';
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
            Column(
              children: [
                const SizedBox(height: HelperPadding.defaultPadding / 2),
                Expanded(
                  child: GetBuilder<CartController>(
                    builder: (cartController) => cartController.carts.isNotEmpty
                        ? ListView.builder(
                            clipBehavior: Clip.none,
                            itemCount: cartController.carts.length,
                            itemBuilder: (context, cardIndex) {
                              return InkWell(
                                onTap: () {
                                  Get.to(() => DetailsScreen(product: cartController.carts[cardIndex].product));
                                },
                                child: CartItem(
                                  cart: cartController.carts[cardIndex],
                                  onTapDelete: () {
                                    cartController.deleteItemFormCart(cardIndex);
                                  },
                                  onTapDec: () {
                                    cartController.addQuantity(cardIndex, false);
                                  },
                                  onTapInc: () {
                                    cartController.addQuantity(cardIndex, true);
                                  },
                                ),
                              );
                            },
                          )
                        : const Center(
                            child: Text(
                              'السلة فارغة',
                              style: TextStyle(fontSize: 30.0),
                            ),
                          ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      // color: HelperColor.backgroundColor,
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
          ],
        ),
      ),
    );
  }
}
