import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  AuthTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.icon,
    required this.controller,
  });
  final String labelText;
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4.0),
    borderSide: const BorderSide(
      color: Colors.white,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        onTapOutside: (e) {
          FocusScope.of(context).unfocus();
        },
        controller: controller,
        // cursorColor: Colors.white,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: const BorderSide(width: 1.0),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
          focusedBorder: outlineInputBorder,
          enabledBorder: outlineInputBorder,
          labelText: labelText,
          labelStyle: const TextStyle(fontSize: 18.0, color: Colors.black),
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 14.0, color: Colors.black),
          prefixIcon: Icon(
            icon,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
