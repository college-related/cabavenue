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
    Icon(Iconsax.dollar_circle),
    Icon(Iconsax.people),
    Icon(Iconsax.gas_station),
    Icon(Iconsax.teacher),
    Icon(Iconsax.shop),
    Icon(Iconsax.bank),
    Icon(Iconsax.coffee),
    Icon(Iconsax.cake),
    Icon(Iconsax.shopping_cart),
    Icon(Iconsax.gallery),
  ];

  List<Icon> get getList => _icons;
}
