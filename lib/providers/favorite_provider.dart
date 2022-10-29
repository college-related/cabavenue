import 'package:cabavenue/models/favorite_model.dart';
import 'package:flutter/cupertino.dart';

class FavoriteProvider with ChangeNotifier {
  FavoriteModel favplace = FavoriteModel(
    name: '',
    givenName: '',
    iconIndex: 0,
    latitude: 28.2624061,
    longitude: 83.9687894,
  );
  bool isEdit = false;

  FavoriteModel get getFavoritePlace => favplace;

  void setFavPlace(FavoriteModel newFavPlace) {
    favplace = newFavPlace;
    notifyListeners();
  }

  void setIconIndex(int index) {
    favplace.iconIndex = index;
    notifyListeners();
  }

  void setLatLng(double lat, double lng) {
    favplace.latitude = lat;
    favplace.longitude = lng;
    notifyListeners();
  }

  void setIsEdit(bool changeEdit) {
    isEdit = changeEdit;
    notifyListeners();
  }
}
