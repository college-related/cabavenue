import 'package:flutter/material.dart';

class CustomFAB extends StatelessWidget {
  const CustomFAB({
    Key? key,
    required this.bgColor,
    required this.icon,
    required this.herotag,
    this.bottom,
    this.left,
    this.right,
    this.top,
    required this.onClick,
  }) : super(key: key);

  final double? left;
  final double? right;
  final double? top;
  final double? bottom;
  final Color bgColor;
  final onClick;
  final String herotag;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: right,
      top: top,
      bottom: bottom,
      left: left,
      child: FloatingActionButton(
        backgroundColor: bgColor,
        onPressed: onClick,
        heroTag: herotag,
        child: icon,
      ),
    );
  }
}
