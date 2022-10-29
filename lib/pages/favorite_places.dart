// ignore_for_file: unnecessary_const

import 'dart:convert';

import 'package:cabavenue/models/favorite_model.dart';
import 'package:cabavenue/services/favorite_service.dart';
import 'package:cabavenue/utils/icon_list.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class FavoritePlaces extends StatefulWidget {
  const FavoritePlaces({Key? key}) : super(key: key);

  @override
  State<FavoritePlaces> createState() => _FavoritePlacesState();
}

class _FavoritePlacesState extends State<FavoritePlaces> {
  late Future<List<FavoriteModel>> favoritePlaces;

  Future<List<FavoriteModel>> getFavoritePlaces() async {
    var favs = await FavoriteService().getFavorites(context);
    List<FavoriteModel> favPlaces = [];
    for (var fav in favs['favoritePlaces']) {
      favPlaces
          .add(await FavoriteModel.deserialize(jsonEncode(fav).toString()));
    }
    return favPlaces;
  }

  @override
  void initState() {
    super.initState();
    favoritePlaces = getFavoritePlaces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Places'),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 50.0,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Add new place",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'Your favorite places',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              FutureBuilder<List<FavoriteModel>>(
                future: favoritePlaces,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: IconList()
                                .getList[snapshot.data![index].iconIndex],
                            title: Text(snapshot.data![index].givenName),
                            subtitle: Text(
                                '${snapshot.data![index].latitude}, ${snapshot.data![index].longitude}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Iconsax.edit),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Iconsax.trash),
                                ),
                              ],
                            ),
                            tileColor: index % 2 != 0
                                ? Colors.white
                                : Colors.teal[100],
                          );
                        },
                      ),
                    );
                  }
                  return SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                child: ListView.builder(
                  itemCount: IconList().getList.length,
                  itemBuilder: (contex, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: IconList().getList[index],
                  ),
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
