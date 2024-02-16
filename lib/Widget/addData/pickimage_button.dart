import 'package:flutter/material.dart';
import 'package:store_app/Helper/color_helper.dart';

class PickImageButton extends StatelessWidget {
  const PickImageButton({
    super.key,
    required this.onTap,
    required this.text,
  });
  final void Function()? onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40.0,
        width: 100.0,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              HelperColor.primaryColor,
              HelperColor.blueColor,
            ],
          ),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Center(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}
