import 'package:apk/Screen/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class DashBoard extends StatefulWidget {
  const DashBoard({Key  key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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

        )
    );
  }
}
