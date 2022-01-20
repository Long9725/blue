import 'package:flutter/material.dart';

class LocationProvider with ChangeNotifier {
  List _addressList = [];

  LocationProvider();

  set addressList(List addressList) {
    _addressList = addressList;
  }

  List get addressList {
    return _addressList;
  }
}