import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app/Controller/product_controller.dart';
import 'package:store_app/Helper/color_helper.dart';
import 'package:store_app/Helper/padding_helper.dart';
import 'package:store_app/Widget/home/product_card.dart';
import 'package:store_app/View/details_screen.dart';

class HomeBody extends StatelessWidget {
  HomeBody({super.key});
  final ProductController productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          const SizedBox(height: HelperPadding.defaultPadding / 2),
          Expanded(
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 70.0),
                  decoration: const BoxDecoration(
                    color: HelperColor.backgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                  ),
                ),
                GetBuilder<ProductController>(
                  builder: (c) => ListView.builder(
                    itemCount: c.products.length,
                    itemBuilder: (context, index) => ProductCard(
                      itemIndex: index,
                      product: c.products[index],
                      press: () {
                        Get.to(() => DetailsScreen(product: c.products[index]));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
