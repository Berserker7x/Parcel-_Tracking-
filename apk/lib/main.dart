
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screen/HomeScreen.dart';

import 'Screen/onHomeBoarding.dart';

import 'package:firebase_core/firebase_core.dart';


 //@dart=2.9


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  SharedPreferences.setMockInitialValues({});


  SharedPreferences prefs=await SharedPreferences.getInstance();
  bool seen=prefs.getBool('seen');
  Widget _screen;
  if(seen == null || seen == false ){
     _screen=onHomeBoarding();
  }else{
   _screen=LoginScreen();
  }


  runApp(MyApp(_screen));
}

class MyApp extends StatelessWidget {


  final Widget _screen;
  MyApp(this._screen);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

      return MaterialApp(
         debugShowCheckedModeBanner: false,
         home:this._screen ,

     );
  }

}
