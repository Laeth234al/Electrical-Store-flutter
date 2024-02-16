import 'package:flutter/material.dart';
import 'package:store_app/Helper/text_style_helper.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });
  final String title;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: HelperText.ts18f(),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      leading: Icon(icon),
      onTap: onTap,
    );
  }
}
