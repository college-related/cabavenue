import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.iconColor = Colors.blue,
    this.borderType = 'full',
    this.isSecuredText = false,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final IconData icon;
  final Color iconColor;
  final String borderType;
  final bool isSecuredText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isSecuredText,
      decoration: InputDecoration(
        icon: Icon(
          icon,
          color: iconColor,
        ),
        border: borderType == 'full'
            ? const OutlineInputBorder()
            : const UnderlineInputBorder(),
        labelText: hintText,
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your $hintText';
        }
        return null;
      },
    );
  }
}
