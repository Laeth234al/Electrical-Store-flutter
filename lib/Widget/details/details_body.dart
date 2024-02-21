import 'package:flutter/material.dart';
import 'package:Electrical/Helper/color_helper.dart';
import 'package:Electrical/Helper/padding_helper.dart';
import 'package:Electrical/Helper/text_style_helper.dart';
import 'package:Electrical/Models/product.dart';
import 'package:Electrical/Widget/details/color_dot.dart';
import 'package:Electrical/Widget/details/product_image.dart';

class DetailsBody extends StatelessWidget {
  const DetailsBody({super.key, required this.product, required this.page});
  final Product product;
  final String page;

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
                      tag: page == 'home'
                          ? product.id
                          : page == 'favo'
                              ? 'favo ${product.id}'
                              : 'cart ${product.id}',
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
                    child: Text(product.title, style: HelperText.ts16f(fontWeight: FontWeight.bold)),
                  ),
                  Text(
                    'السعر: \$${product.price}',
                    style: HelperText.ts16f(
                      color: HelperColor.secondaryColor,
                      fontWeight: FontWeight.w600,
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
                style: HelperText.ts12f(color: Colors.white),
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
