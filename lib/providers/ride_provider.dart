import 'package:flutter/cupertino.dart';

class RideProvider with ChangeNotifier {
  dynamic ride;
  dynamic driver;

  dynamic get getRide => ride;
  dynamic get getDriver => driver;

  void setRide(dynamic newRide) {
    ride = newRide;
    notifyListeners();
  }

  void setDriver(dynamic newDriver) {
    driver = newDriver;
    notifyListeners();
  }
}
