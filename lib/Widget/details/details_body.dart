import 'package:flutter/material.dart';
import 'package:store_app/Helper/color_helper.dart';
import 'package:store_app/Helper/padding_helper.dart';
import 'package:store_app/Helper/text_style_helper.dart';
import 'package:store_app/Models/product.dart';
import 'package:store_app/Widget/details/color_dot.dart';
import 'package:store_app/Widget/details/product_image.dart';

class DetailsBody extends StatelessWidget {
  const DetailsBody({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                HelperColor.primaryColor,
                HelperColor.blueColor,
              ],
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: HelperPadding.defaultPadding * 1.5),
              decoration: const BoxDecoration(
                color: HelperColor.backgroundColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Hero(
                      tag: product.id,
                      child: ProductImage(
                        size: size,
                        image: product.image,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: HelperPadding.defaultPadding / 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ColorDot(
                          fillColor: HelperColor.textLightColor,
                          isSelected: true,
                        ),
                        ColorDot(
                          fillColor: Colors.blue,
                          isSelected: false,
                        ),
                        ColorDot(
                          fillColor: Colors.red,
                          isSelected: false,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: HelperPadding.defaultPadding / 2),
                    child: Text(product.title, style: HelperText.ts14f(fontWeight: FontWeight.bold)),
                  ),
                  Text(
                    'السعر: \$${product.price}',
                    style: const TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                      color: HelperColor.secondaryColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: HelperPadding.defaultPadding),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: HelperPadding.defaultPadding / 2),
              padding: const EdgeInsets.symmetric(
                horizontal: HelperPadding.defaultPadding * 1.5,
                vertical: HelperPadding.defaultPadding / 2,
              ),
              child: Text(
                product.description,
                style: HelperText.ts16f(color: Colors.white),
                overflow: TextOverflow.ellipsis,
                maxLines: 8,
              ),
            )
          ],
        ),
      ],
    );
  }
}
