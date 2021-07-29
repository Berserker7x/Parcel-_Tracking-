import 'package:apk/block/apkBlck.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';


class MapZone extends StatefulWidget {
  const MapZone({Key  key}) : super(key: key);

  @override
  _MapZoneState createState() => _MapZoneState();
}

class _MapZoneState extends State<MapZone> {

  @override
  Widget build(BuildContext context) {
    final applicationbloc=Provider.of<Applicationbloc>(context);
    return Scaffold(
      body:ListView(
        children: [
          TextField(
            decoration:InputDecoration(hintText: 'Search Location'),
          ),
          Container(
            height: 300.0,
            child:GoogleMap(
              mapType: MapType.normal,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                target: LatLng(applicationbloc.currentLocation.latitude, applicationbloc.currentLocation.longitude),
                zoom:14
              ),


            )
          )
        ],
      )
    );
  }
}
