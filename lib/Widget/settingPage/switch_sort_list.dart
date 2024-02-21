import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Electrical/Controller/product_controller.dart';
import 'package:Electrical/Helper/color_helper.dart';
import 'package:Electrical/Helper/text_style_helper.dart';
import 'package:Electrical/Widget/spinket_indecator.dart';

class SortProductList extends StatelessWidget {
  const SortProductList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (animationController) => animationController.isLoading
          ? const SpinIndecator()
          : AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: animationController.isExpanded[1] ? 60.0 : 120.0,
              child: Column(
                children: [
                  SizedBox(
                    height: 50.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('ترتيب المنتجات : '),
                        GetBuilder<ProductController>(
                          builder: (controller) => CupertinoSwitch(
                            value: controller.switchValues[1],
                            onChanged: (val) {
                              controller.switchOn(1, val);
                              if (val == true) {
                                // sort
                                controller.sortProductsByPrice(); // no item there
                              } else {
                                // unSort
                                controller.sortProductsByIds();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  if (!animationController.isExpanded[1])
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: HelperColor.secondaryColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: GetBuilder<ProductController>(
                          builder: (ascendingController) => CheckboxListTile(
                            title: Text(
                              'ترتيب تصاعدي : ',
                              style: HelperText.ts14f(),
                            ),
                            value: ascendingController.ascending,
                            onChanged: (val) {
                              ascendingController.toggelAscending();
                            },
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
