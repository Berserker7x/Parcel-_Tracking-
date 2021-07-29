 import 'package:apk/Services/GeoLocator_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class Applicationbloc with ChangeNotifier{
  final geoLocatorService= GeolocatorService();
  Position currentLocation;
  Applicationbloc(){
    SetCurrentLocation();
  }
  SetCurrentLocation()async{
    currentLocation=await geoLocatorService.getCurrentLocation();
    notifyListeners();
  }
}