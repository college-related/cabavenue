import 'package:flutter/material.dart';

class FavoritePlaces extends StatefulWidget {
  const FavoritePlaces({Key? key}) : super(key: key);

  @override
  State<FavoritePlaces> createState() => _FavoritePlacesState();
}

class _FavoritePlacesState extends State<FavoritePlaces> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Text('Hello'),
        ),
      )),
    );
  }
}
