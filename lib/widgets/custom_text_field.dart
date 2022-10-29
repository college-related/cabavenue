import 'package:cabavenue/helpers/validator.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.iconColor = Colors.blue,
    this.borderType = 'full',
    this.isSecuredText = false,
    this.colors = Colors.grey,
    this.validations = const [],
    this.length = 8,
    this.hasError = false,
    this.errorMessage = '',
    this.focusNode,
    this.onTap,
    this.readOnly = false,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final IconData icon;
  final Color iconColor;
  final String borderType;
  final bool isSecuredText;
  final Color colors;
  final List<String> validations;
  final int length;
  final bool hasError;
  final String errorMessage;
  final FocusNode? focusNode;
  final Function? onTap;
  final bool readOnly;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        readOnly: widget.readOnly,
        onTap: widget.onTap != null
            ? () {
                widget.onTap!();
              }
            : null,
        focusNode: widget.focusNode,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: widget.controller,
        decoration: InputDecoration(
          errorText: widget.hasError ? widget.errorMessage : null,
          filled: true,
          fillColor: const Color.fromARGB(47, 96, 125, 139),
          isDense: true,
          prefixIcon: Icon(
            widget.icon,
            color: widget.colors,
          ),
          suffixIcon: widget.isSecuredText
              ? IconButton(
                  icon: Icon(isHidden ? Iconsax.eye_slash : Iconsax.eye),
                  onPressed: () {
                    setState(() {
                      isHidden = !isHidden;
                    });
                  },
                )
              : const SizedBox(height: 0, width: 0),
          border: widget.borderType == 'full'
              ? const OutlineInputBorder()
              : const UnderlineInputBorder(),
          labelText: widget.hintText,
          labelStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14.0,
          ),
        ),
        obscureText: (isHidden && widget.isSecuredText),
        keyboardType: widget.keyboardType,
        validator: (val) {
          if (val == null || val.isEmpty) {
            return 'Enter your ${widget.hintText}';
          }
          var validation = validator(
            validations: widget.validations,
            value: val,
            length: widget.length,
          );
          if (!validation['isValidate']) {
            return validation['message'];
          }
          return null;
        },
      ),
    );
  }
}
