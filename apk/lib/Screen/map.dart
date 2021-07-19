
import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


class ToMap extends StatefulWidget {
  const ToMap({Key key}) : super(key: key);

  @override
  _ToMapState createState() => _ToMapState();
}

class _ToMapState extends State<ToMap> {
  void initState() {
    super.initState();
    storeUserLcation();




    //checkLocationServicesIndevice();
  }
  StreamSubscription _locationSubscription;
  Location _locationTracker=Location();
  Marker marker;
  Circle circle;

  GoogleMapController _controller;





static  final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
 //static final CameraPosition _kLake = CameraPosition(
   //   bearing: 192.8334901395799,
     // target: LatLng(37.43296265331129, -122.08832357078792),
      //tilt: 59.440717697143555,
      //zoom: 19.151926040649414);


  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: GoogleMap(
          mapType: MapType.normal,

          initialCameraPosition:_kGooglePlex,
          markers: Set.of((marker!=null)?[marker]:[]),
          circles: Set.of((circle!=null)?[circle]:[]),


        onMapCreated: (GoogleMapController controller){
           _controller=controller;
        },


        ),
    floatingActionButton: FloatingActionButton(
    child: Icon(Icons.location_searching),
    onPressed: (){
      getCurentLocation();
    },
    ),


    );
  }
  bool _serviceEnabled;
 // LocationData _location;
  void checkLocationServicesIndevice()async{
    Location location= new Location();
    _serviceEnabled  = await location.serviceEnabled();
    if(_serviceEnabled){

    }
    else{
      _serviceEnabled=await location.requestService();

    if(_serviceEnabled){
      //location =lonfitude&latitude
      // _location=await location.getLocation();
      location.onLocationChanged.listen((LocationData currentLocation){
        print(currentLocation.latitude.toString()+""+currentLocation.longitude.toString()+"");

      });


    }else{
      //back to dashboard
      SystemNavigator.pop();
    }
    }
  }
  storeUserLcation(){
    Location location= new Location();
    location.onLocationChanged.listen((LocationData currentLocation) {




      FirebaseFirestore.instance.collection("Users").doc('pRWTNaymgPOYiO63vgm3').set({

        'location':GeoPoint(currentLocation.latitude,currentLocation.longitude)
      });
    });


  }
  Future<Uint8List> getMarker()async{
    ByteData byteData=await DefaultAssetBundle.of(context).load("assets/images/car_icon.png");
    return byteData.buffer.asUint8List();

  }
  void updateMarkerAndcircles(LocationData newlocalData,Uint8List imageData){
    LatLng latLng=LatLng((newlocalData.latitude), (newlocalData.longitude));
    this.setState(() {
      marker=Marker(
        markerId: MarkerId("home"),
        position: latLng,
        rotation: newlocalData.heading,
        draggable: false,
        zIndex: 2,
        flat:true,
        anchor: Offset(0.5,0.5),
        icon:BitmapDescriptor.fromBytes(imageData));
      circle:Circle(
        circleId: CircleId("car"),
        radius: newlocalData.accuracy,
        zIndex: 1,
        strokeColor: Colors.blue,
        center: latLng,
        fillColor: Colors.blue.withAlpha(70));




    });

  }

  void getCurentLocation() async{
    try{
      Uint8List imageData=await getMarker();
      var location=await _locationTracker.getLocation();
      updateMarkerAndcircles(location,imageData);
      if(_locationSubscription != null){
        _locationSubscription.cancel();
      }
      _locationSubscription=_locationTracker.onLocationChanged.listen((newLocalData) {
        if(_controller != null){
       _controller.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
         bearing:192.8334901395799,
         target:LatLng(newLocalData.latitude,newLocalData.longitude),
         tilt:0,
         zoom:18.0)));
       updateMarkerAndcircles(newLocalData, imageData);

        }

      });
    } on PlatformException catch (e){
      if(e.code=='PERMISSION_DENIED'){
        debugPrint("Permission Denied");
      }
    }
  }
  void dispose(){
    if(_locationSubscription !=null){
      _locationSubscription.cancel();
    }
    super.dispose();
  }
}
