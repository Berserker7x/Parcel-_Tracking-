import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapZone extends StatefulWidget {
  const MapZone({Key  key}) : super(key: key);

  @override
  _MapZoneState createState() => _MapZoneState();
}

class _MapZoneState extends State<MapZone> {
  @override
  Widget build(BuildContext context) {
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
                target: LatLng(33.351177, -7.577820)
              ),

            )
          )
        ],
      )
    );
  }
}
