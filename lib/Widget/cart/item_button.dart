import 'package:flutter/material.dart';

class CartItemButton extends StatelessWidget {
  const CartItemButton({
    super.key,
    this.onTap,
    required this.color,
    required this.icon,
  });
  final void Function()? onTap;
  final Color color;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50.0,
        width: 50.0,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 30.0,
        ),
      ),
    );
  }
}
