import 'package:flutter/cupertino.dart';

class DestinationProvider with ChangeNotifier {
  dynamic destination;

  dynamic get getDestination => destination;

  void setDestination(dynamic newDestination) {
    destination = newDestination;
    notifyListeners();
  }
}
