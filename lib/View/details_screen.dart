import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app/Controller/cart_controller.dart';
import 'package:store_app/Controller/favorite_controller.dart';
import 'package:store_app/Helper/color_helper.dart';
import 'package:store_app/Helper/padding_helper.dart';
import 'package:store_app/Helper/text_style_helper.dart';
import 'package:store_app/Models/product.dart';
import 'package:store_app/Widget/details/details_body.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: HelperColor.primaryColor,
      floatingActionButton: GetBuilder<CartController>(
        builder: (cartController) => FloatingActionButton(
          onPressed: () {
            if (cartController.isAddedInCartBefor(product.id)) {
              print('added before');
            } else {
              print('add to Cart');
              cartController.addToCart(product);
            }
          },
          backgroundColor: cartController.isAddedInCartBefor(product.id) ? Colors.green : HelperColor.secondaryColor,
          child: Icon(
            cartController.isAddedInCartBefor(product.id) ? Icons.check : Icons.shopping_cart_checkout,
            color: Colors.white,
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: HelperColor.backgroundColor,
        elevation: 0.0,
        title: Text(
          'الرجوع',
          style: HelperText.ts12f(),
        ),
        leading: IconButton(
          padding: const EdgeInsets.only(right: HelperPadding.defaultPadding),
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: HelperColor.primaryColor,
          ),
        ),
        actions: [
          GetBuilder<FavoriteController>(
            builder: (favoriteController) => IconButton(
              onPressed: () {
                if (favoriteController.isAddIn(product.id)) {
                  favoriteController.removeFromFavo(product);
                } else {
                  favoriteController.addToFavo(product);
                }
              },
              icon: Icon(
                favoriteController.isAddIn(product.id) ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
            ),
          ),
          const SizedBox(width: 10.0),
        ],
      ),
      body: DetailsBody(
        product: product,
      ),
    );
  }
}
