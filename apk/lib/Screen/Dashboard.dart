import 'package:apk/Screen/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../register.dart';
import 'map.dart';
class DashBoard extends StatefulWidget {
  const DashBoard({Key  key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final Keyss = GlobalKey<FormState>();

  TextEditingController writeTrackcode = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
            title: Text('Dashboard'),



            actions: <Widget>[
              RaisedButton(
                  child: Text('Log out',
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                  color: Colors.orange,
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  }
              )

            ]


        ),
            body:   Container(
                padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
    color: const Color(0xff7c94b6),
    image: DecorationImage(
    colorFilter:ColorFilter.mode(Colors.black.withOpacity(0.8),
    BlendMode.dstATop),
    image: ExactAssetImage("assets/images/amana.jpg"),
    fit: BoxFit.cover),
    ),
    child: Form(
    key: Keyss,

    child: Column(

    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
    TextFormField(
    controller: writeTrackcode,
    decoration: InputDecoration(
    hintText: 'write your code Here',
    ),

    ),
      SizedBox(
        height: 50,
      ),

        RaisedButton(

          color: Colors.orange,
          child: Text('Start Tracking',style: TextStyle(color: Colors.white),), onPressed: () async {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>ToMap() ) );
        },

        ),
      RaisedButton(
        color: Colors.orange,
        child: Text('Track yourself',style: TextStyle(color: Colors.white),),
          onPressed: (){}

      ),   RaisedButton(
        color: Colors.orange,
        child: Text('Track Barid centers near your zone  ',style: TextStyle(color: Colors.white),),
          onPressed: (){}

      ),

  ]
    )
            )
    ));
  }

}
