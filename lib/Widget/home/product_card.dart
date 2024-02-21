import 'package:flutter/material.dart';
import 'package:Electrical/Helper/color_helper.dart';
import 'package:Electrical/Helper/padding_helper.dart';
import 'package:Electrical/Helper/text_style_helper.dart';
import 'package:Electrical/Models/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.press,
  });

  final Product product;
  final void Function() press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: HelperPadding.defaultPadding,
        vertical: HelperPadding.defaultPadding / 2,
      ),
      height: 160.0,
      child: InkWell(
        onTap: press,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 140.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22.0),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0.0, 15.0),
                    blurRadius: 25.0,
                    color: Colors.black26,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0.0,
              left: 0.0,
              child: Hero(
                tag: product.id,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: HelperPadding.defaultPadding),
                  height: 144.0,
                  width: 180.0,
                  child: Image.network(
                    product.image,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              right: 0.0,
              child: SizedBox(
                height: 122.0,
                // our image width is 180.0 ,then the box width is size - 180.0
                width: size.width - 180,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: HelperPadding.defaultPadding),
                      child: Text(
                        product.title,
                        style: HelperText.ts14f(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: HelperPadding.defaultPadding),
                      child: Text(
                        product.subTitle,
                        style: HelperText.ts12f(),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(HelperPadding.defaultPadding),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: HelperPadding.defaultPadding * 1.5, // 30 px
                          vertical: HelperPadding.defaultPadding / 5, // 4 px
                        ),
                        decoration: BoxDecoration(
                          color: HelperColor.secondaryColor,
                          borderRadius: BorderRadius.circular(22.0),
                        ),
                        child: Text(
                          'السعر: \$${product.price}',
                          style: HelperText.ts12f(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
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
