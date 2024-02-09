import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app/Controller/cart_controller.dart';
import 'package:store_app/Helper/color_helper.dart';
import 'package:store_app/Helper/padding_helper.dart';
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
            print('add to Cart');
            cartController.addToCart(product);
          },
          backgroundColor: HelperColor.secondaryColor,
          child: const Icon(
            Icons.shopping_cart_checkout,
            color: Colors.white,
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: HelperColor.backgroundColor,
        elevation: 0.0,
        title: Text(
          'الرجوع',
          style: Theme.of(context).textTheme.bodySmall,
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
      ),
      body: DetailsBody(
        product: product,
      ),
    );
  }
}
