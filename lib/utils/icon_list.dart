import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class IconList {
  final List<Icon> _icons = const [
    Icon(Iconsax.home),
    Icon(Iconsax.house),
    Icon(Iconsax.house_2),
    Icon(Iconsax.airplane),
    Icon(Iconsax.building),
    Icon(Iconsax.building_3),
    Icon(Iconsax.tree),
    Icon(Iconsax.bag),
  ];

  List<Icon> get getList => _icons;
}
