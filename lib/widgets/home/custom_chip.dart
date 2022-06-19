import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({
    Key? key,
    required this.label,
    required this.icon,
  }) : super(key: key);

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Chip(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        shape: const StadiumBorder(
          side: BorderSide(
            color: Colors.blueAccent,
          ),
        ),
        avatar: Icon(
          icon,
          color: Colors.blueAccent,
        ),
        label: Text(
          label,
          style: const TextStyle(
            color: Colors.blueAccent,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 4.0,
        shadowColor: Colors.blueAccent,
      ),
    );
  }
}
