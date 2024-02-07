import 'package:flutter/material.dart';
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
      backgroundColor: HelperColor.primaryColor,
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
            Navigator.pop(context);
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
