import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class MapZone extends StatefulWidget {
  const MapZone({Key key}) : super(key: key);

  @override
  _MapZoneState createState() => _MapZoneState();
}

class _MapZoneState extends State<MapZone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height/3,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(target: LatLng(29.97792,31.1342) ,
              zoom:16.0,),

            zoomGesturesEnabled: true,
          ),
        )
      ],),
    );
  }
}
