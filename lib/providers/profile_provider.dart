import 'dart:convert';

import 'package:cabavenue/models/user_model.dart';
import 'package:flutter/cupertino.dart';

class ProfileProvider with ChangeNotifier {
  UserModel user = UserModel(
    name: '',
    isEmailVerified: false,
    isPhoneVerified: false,
    email: '',
    phone: 0,
    address: '',
    accessToken: '',
    id: '',
    profileUrl:
        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png',
    rideHistory: [],
    favoritePlaces: [],
  );

  UserModel get getUserData => user;

  List getIconIndexList() {
    List iconIndexList = [];

    for (var icon in user.favoritePlaces!) {
      iconIndexList.add(icon['iconIndex']);
    }

    return iconIndexList;
  }

  void setUserData(UserModel newUser) {
    user = newUser;
    notifyListeners();
  }
}
