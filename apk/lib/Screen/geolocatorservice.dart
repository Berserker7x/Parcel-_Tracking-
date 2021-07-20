import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
class Gelolocaorservice{
  Future<Position> getLocation() async{
     var geolocator=  Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high,forceAndroidLocationManager: true );

     return await geolocator;
}
}

