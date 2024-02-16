import 'package:flutter/material.dart';
import 'package:store_app/Helper/padding_helper.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.size,
    required this.image,
  });

  final Size size;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: HelperPadding.defaultPadding),
      height: size.width * 0.7,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: size.width * 0.7,
            width: size.width * 0.7,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          image.startsWith('https://')
              ? Image.network(
                  image,
                  height: size.width * 0.7,
                  width: size.width * 0.7,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  image,
                  height: size.width * 0.7,
                  width: size.width * 0.7,
                  fit: BoxFit.cover,
                ),
        ],
      ),
    );
  }
}
