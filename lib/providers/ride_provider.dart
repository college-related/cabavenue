import 'package:flutter/cupertino.dart';

class RideProvider with ChangeNotifier {
  dynamic ride;

  dynamic get getRide => ride;

  void setRide(dynamic newRide) {
    ride = newRide;
    notifyListeners();
  }
}
