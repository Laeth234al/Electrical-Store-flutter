import 'package:flutter/material.dart';
import 'package:store_app/Helper/color_helper.dart';
import 'package:store_app/Helper/padding_helper.dart';

class ColorDot extends StatelessWidget {
  const ColorDot({
    super.key,
    this.isSelected = false,
    required this.fillColor,
  });
  final Color fillColor;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: HelperPadding.defaultPadding / 2.5),
      padding: const EdgeInsets.all(3.0),
      width: 20.0,
      height: 20.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? HelperColor.textLightColor : Colors.transparent,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: fillColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
