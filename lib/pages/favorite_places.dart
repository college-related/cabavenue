// ignore_for_file: unnecessary_const

import 'dart:convert';

import 'package:cabavenue/providers/favorite_provider.dart';
import 'package:cabavenue/providers/profile_provider.dart';
import 'package:cabavenue/services/favorite_service.dart';
import 'package:cabavenue/utils/icon_list.dart';
import 'package:cabavenue/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class FavoritePlaces extends StatefulWidget {
  const FavoritePlaces({Key? key}) : super(key: key);

  @override
  State<FavoritePlaces> createState() => _FavoritePlacesState();
}

class _FavoritePlacesState extends State<FavoritePlaces> {
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
                        showAlertForIcon(context, forNew: true);
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
              Consumer<ProfileProvider>(
                builder: (context, value, child) {
                  var favorite = value.getUserData.favoritePlaces;
                  return SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: ListView.builder(
                      itemCount: favorite!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: IconList().getList[value
                              .getUserData.favoritePlaces![index]['iconIndex']],
                          title: Text(favorite[index]['givenName']),
                          subtitle: Text(
                            '${favorite[index]['latitude']}, ${favorite[index]['longitude']}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Provider.of<FavoriteProvider>(context,
                                          listen: false)
                                      .setIconIndex(
                                    favorite[index]['iconIndex'],
                                  );
                                  Provider.of<FavoriteProvider>(context,
                                          listen: false)
                                      .setLatLng(favorite[index]['latitude'],
                                          favorite[index]['longitude']);
                                  showAlertDialogEditDelete(
                                    context,
                                    favorite[index],
                                    'Edit',
                                  );
                                },
                                icon: const Icon(Iconsax.edit),
                              ),
                              IconButton(
                                onPressed: () {
                                  showAlertDialogEditDelete(
                                    context,
                                    favorite[index],
                                    'delete',
                                  );
                                },
                                icon: const Icon(Iconsax.trash),
                              ),
                            ],
                          ),
                          tileColor:
                              index % 2 != 0 ? Colors.white : Colors.teal[100],
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

showAlertDialogEditDelete(
  BuildContext context,
  place,
  type,
) {
  TextEditingController givenNameController = TextEditingController();
  final placeKey = GlobalKey<FormState>();

  givenNameController.text = place['givenName'];

  Widget yesButton = ElevatedButton(
    onPressed: () {
      if (type == 'delete') {
        FavoriteService().deleteFavorite(context, place['iconIndex']);
      } else {
        FavoriteService().editFavorite(
          context,
          place['iconIndex'],
          Provider.of<FavoriteProvider>(context, listen: false)
              .getFavoritePlace
              .iconIndex,
          Provider.of<FavoriteProvider>(context, listen: false)
              .getFavoritePlace
              .latitude,
          Provider.of<FavoriteProvider>(context, listen: false)
              .getFavoritePlace
              .longitude,
          givenNameController.text,
          givenNameController.text,
        );
      }
      // Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pop();
      // });
    },
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.teal),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    ),
    child: const Text("Yes"),
  );

//  Create cancel button
  Widget cancelButton = ElevatedButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
    child: const Text("Cancel"),
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Want to $type this place?"),
    content: Consumer<FavoriteProvider>(
      builder: (context, value, child) => SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.25,
        child: Form(
          key: placeKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: givenNameController,
                hintText: 'Name',
                icon: Iconsax.text,
                readOnly: type == 'delete',
              ),
              Text(
                  '${value.getFavoritePlace.latitude}, ${value.getFavoritePlace.longitude}'),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (type == 'delete') {
                        return;
                      }
                      showAlertForIcon(context);
                    },
                    icon: IconList().getList[value.getFavoritePlace.iconIndex],
                  ),
                  IconButton(
                    onPressed: () {
                      if (type == 'delete') {
                        return;
                      }
                      Provider.of<FavoriteProvider>(context, listen: false)
                          .setLatLng(place['latitude'], place['longitude']);
                      Provider.of<FavoriteProvider>(context, listen: false)
                          .setIsEdit(true);
                      Navigator.pushNamed(context, '/favorite-map');
                    },
                    icon: const Icon(Iconsax.location),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
    actions: [
      cancelButton,
      yesButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertForIcon(BuildContext context, {bool forNew = false}) {
  Widget cancelButton = ElevatedButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
    child: const Text("Cancel"),
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Choose a icon for marker"),
    content: SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.25,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 4 / 5,
          crossAxisCount: 6,
        ),
        itemCount: IconList().getList.length,
        itemBuilder: (context, index) {
          return IconButton(
            onPressed: () {
              if (Provider.of<ProfileProvider>(context, listen: false)
                  .getIconIndexList()
                  .contains(index)) {
                Fluttertoast.showToast(
                  msg: 'Marker already used',
                  backgroundColor: Colors.red[500],
                );
                return;
              }
              Provider.of<FavoriteProvider>(context, listen: false)
                  .setIconIndex(index);
              if (forNew) {
                Provider.of<FavoriteProvider>(context, listen: false)
                    .setIsEdit(false);
                Navigator.of(context).pushNamed('/favorite-map');
              } else {
                Navigator.of(context).pop();
              }
            },
            icon: IconList().getList[index],
            color: Provider.of<ProfileProvider>(context, listen: false)
                    .getIconIndexList()
                    .contains(index)
                ? Colors.red[300]
                : Colors.black,
          );
        },
      ),
    ),
    actions: [
      cancelButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
