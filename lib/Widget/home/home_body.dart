import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Electrical/Controller/product_controller.dart';
import 'package:Electrical/Helper/color_helper.dart';
import 'package:Electrical/Helper/padding_helper.dart';
import 'package:Electrical/Widget/home/product_card.dart';
import 'package:Electrical/View/details_screen.dart';
import 'package:Electrical/Widget/spinket_indecator.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

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
                  builder: (c) => c.isLoading
                      ? const SpinIndecator()
                      : ListView.builder(
                          itemCount: c.filtered.length,
                          itemBuilder: (context, index) => ProductCard(
                            product: c.filtered[index],
                            press: () {
                              Get.to(
                                () => DetailsScreen(
                                  product: c.filtered[index],
                                  page: 'home',
                                ),
                              );
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
