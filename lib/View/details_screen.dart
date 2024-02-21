import 'package:Electrical/Widget/spinket_indecator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Electrical/Controller/cart_controller.dart';
import 'package:Electrical/Controller/favorite_controller.dart';
import 'package:Electrical/Helper/color_helper.dart';
import 'package:Electrical/Helper/padding_helper.dart';
import 'package:Electrical/Helper/text_style_helper.dart';
import 'package:Electrical/Models/product.dart';
import 'package:Electrical/Widget/details/details_body.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.product, required this.page});
  final Product product;
  final String page;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GetBuilder<CartController>(
        builder: (cartController) => FloatingActionButton(
          onPressed: () {
            if (cartController.isAddedInCartBefor(product.id)) {
              print('added before carts');
            } else {
              print('add to Cart');
              cartController.addToCart(product);
            }
          },
          backgroundColor: cartController.isAddedInCartBefor(product.id) ? Colors.green : HelperColor.secondaryColor,
          child: cartController.isLoading
              ? const SpinIndecator()
              : Icon(
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
                  print('remove');
                  favoriteController.removeFromFavo(product);
                } else {
                  print('add');
                  favoriteController.addToFavo(product);
                }
              },
              icon: favoriteController.isLoading
                  ? const SpinIndecator()
                  : Icon(
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
        page: page,
      ),
    );
  }
}
