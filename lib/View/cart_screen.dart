import 'package:Electrical/Helper/text_style_helper.dart';
import 'package:Electrical/Widget/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Electrical/Controller/cart_controller.dart';
import 'package:Electrical/Helper/color_helper.dart';
import 'package:Electrical/Helper/padding_helper.dart';
import 'package:Electrical/View/details_screen.dart';
import 'package:Electrical/Widget/cart/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HelperColor.primaryColor,
      appBar: AppBar(
        backgroundColor: HelperColor.primaryColor,
        elevation: 0.0,
        title: Text(
          'السلة',
          style: HelperText.ts18f(),
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
                                  Get.to(
                                    () => DetailsScreen(
                                      product: cartController.carts[cardIndex].product,
                                      page: 'cart',
                                    ),
                                  );
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
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: InkWell(
                    onTap: () {
                      Get.dialog(const CustomDialog(
                        title: 'الخيار غير متاح',
                        subtitle: 'هذا الخيار غير متاح حالياً',
                      ));
                      print("check check");
                    },
                    child: Container(
                      height: 70.0,
                      decoration: BoxDecoration(
                        color: HelperColor.secondaryColor,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'توصيل',
                              style: HelperText.ts18f(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 10.0),
                            const Icon(
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
