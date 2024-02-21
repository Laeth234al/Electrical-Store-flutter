import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Electrical/Controller/product_controller.dart';
import 'package:Electrical/Helper/color_helper.dart';
import 'package:Electrical/Widget/spinket_indecator.dart';

class FilterProductOnPrice extends StatelessWidget {
  const FilterProductOnPrice({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (animationController) => animationController.isLoading
          ? const SpinIndecator()
          : AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: animationController.isExpanded[0] ? 60.0 : 136.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 50.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('ترتيب حسب السعر : '),
                        GetBuilder<ProductController>(
                          builder: (controller) => CupertinoSwitch(
                            value: controller.switchValues[0],
                            onChanged: (val) {
                              controller.switchOn(0, val);
                              if (val == true) {
                                controller.filterProductsByPrice();
                              } else {
                                // make it without this filter
                                controller.withoutFilter();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  if (!animationController.isExpanded[0])
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: HelperColor.secondaryColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          children: [
                            // min
                            Expanded(
                              child: GetBuilder<ProductController>(
                                builder: (minController) => Container(
                                  decoration: BoxDecoration(
                                    color: HelperColor.backgroundColor,
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(),
                                  ),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          // arrow up
                                          Expanded(
                                            child: GestureDetector(
                                              onVerticalDragUpdate: (d) {
                                                minController.addToMinPriceFilter(100.0);
                                              },
                                              onTap: () {
                                                minController.addToMinPriceFilter(100.0);
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.all(2.0),
                                                decoration: const BoxDecoration(
                                                  border: Border(bottom: BorderSide(), left: BorderSide()),
                                                  color: HelperColor.backgroundColor,
                                                  borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(10.0),
                                                  ),
                                                ),
                                                child: const Icon(Icons.keyboard_arrow_up_rounded),
                                              ),
                                            ),
                                          ),
                                          // arrow down
                                          Expanded(
                                            child: GestureDetector(
                                              onVerticalDragUpdate: (d) {
                                                minController.addToMinPriceFilter(-100.0);
                                              },
                                              onTap: () {
                                                minController.addToMinPriceFilter(-100.0);
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.all(2.0),
                                                decoration: const BoxDecoration(
                                                  color: HelperColor.backgroundColor,
                                                  border: Border(left: BorderSide()),
                                                  borderRadius: BorderRadius.only(
                                                    bottomRight: Radius.circular(10.0),
                                                  ),
                                                ),
                                                child: const Icon(Icons.keyboard_arrow_down_rounded),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // minimum value
                                      Expanded(
                                        child: Center(
                                          child: Text(minController.minPrice.toString()),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            //max
                            Expanded(
                              child: GetBuilder<ProductController>(
                                builder: (maxController) => Container(
                                  decoration: BoxDecoration(
                                    color: HelperColor.backgroundColor,
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(),
                                  ),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          //arrow up
                                          Expanded(
                                            child: GestureDetector(
                                              onVerticalDragUpdate: (d) {
                                                maxController.addToMaxPriceFilter(100.0);
                                              },
                                              onTap: () {
                                                maxController.addToMaxPriceFilter(100.0);
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.all(2.0),
                                                decoration: const BoxDecoration(
                                                  border: Border(bottom: BorderSide(), left: BorderSide()),
                                                  color: HelperColor.backgroundColor,
                                                  borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(10.0),
                                                  ),
                                                ),
                                                child: const Icon(Icons.keyboard_arrow_up_rounded),
                                              ),
                                            ),
                                          ),
                                          // arrow down
                                          Expanded(
                                            child: GestureDetector(
                                              onVerticalDragUpdate: (d) {
                                                maxController.addToMaxPriceFilter(-100.0);
                                              },
                                              onTap: () {
                                                maxController.addToMaxPriceFilter(-100.0);
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.all(2.0),
                                                decoration: const BoxDecoration(
                                                  color: HelperColor.backgroundColor,
                                                  border: Border(left: BorderSide()),
                                                  borderRadius: BorderRadius.only(
                                                    bottomRight: Radius.circular(10.0),
                                                  ),
                                                ),
                                                child: const Icon(Icons.keyboard_arrow_down_rounded),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // maximum value
                                      Expanded(
                                        child: Center(
                                          child: Text(maxController.maxPrice.toString()),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}
