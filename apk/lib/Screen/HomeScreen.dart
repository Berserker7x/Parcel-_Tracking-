
import 'dart:async';

import 'package:apk/Screen/Dashboard.dart';
import 'package:apk/Screen/map.dart';


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';



import '../register.dart';

class LoginScreen extends StatefulWidget{
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  void initState()
  {
    super.initState();
  }

  final _formkey = GlobalKey<FormState>();

  TextEditingController _emailcontroller = TextEditingController();

  TextEditingController _passwordcontroller = TextEditingController();

  @override
  void dispose()
  {
    _emailcontroller.dispose();

    _passwordcontroller.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,

        title: Text('Connexion  '),
          centerTitle: true

      ),
      body: Container(
        padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xff7c94b6),
            image: DecorationImage(
                colorFilter:ColorFilter.mode(Colors.black.withOpacity(0.8),
                    BlendMode.dstATop),
                image: ExactAssetImage("assets/images/bariddd.jpg"),
                fit: BoxFit.cover),
          ),

        child: Form(
            key: _formkey,

            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: _emailcontroller,
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                  validator: (value){
                    if(value.isEmpty){
                      return 'Veuillez remplir la saisie de l e-mail ';
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: _passwordcontroller,
                  decoration: InputDecoration(
                    hintText: 'mot de passe ',
                  ),
                  validator: (value){
                    if(value.isEmpty){
                      return ' Veuillez remplir la saisie du mot de passe ';
                    }
                  },
                ),
                SizedBox(
                  height: 100,
                ),

                RaisedButton(
                  color: Colors.orange,
                  child: Text(' Connectez-vous ici ',style: TextStyle(color: Colors.white),),
                  onPressed: () async {
                    if(_formkey.currentState.validate()){
                      try {
                        //Create Get Firebase Auth User
                        await FirebaseAuth.instance
                            . signInWithEmailAndPassword(
                            email: _emailcontroller.text,
                            password: _passwordcontroller.text);
                        Navigator.of(context).popUntil((route) => route.isFirst);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DashBoard()),
                    );
                   } on FirebaseAuthException catch (error) {
                           _showDialog(error.message);
                      }
    }


    }





                ),
                RaisedButton(
                  color: Colors.orange,
                  child: Text('Inscrivez-vous ici ',style: TextStyle(color: Colors.white),),
                  onPressed: () async {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen() ) );
                  },
                ),
                SignInButton(


                  Buttons.Google,
                  text: "sign Up with google",

                  onPressed: ()async{
                   final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
                   final GoogleSignInAuthentication googleAuth = await googleUser.authentication ;
                    final GoogleAuthCredential credential=GoogleAuthProvider.credential(
                     accessToken: googleAuth.accessToken,
                     idToken: googleAuth.idToken

                        );
                    await FirebaseAuth.instance.signInWithCredential(credential);
                   Navigator.push(context, MaterialPageRoute(builder: (context) => DashBoard() ) );

                     },














                )



              ],
            )
        ),
      ),
    );
  }
  void _showDialog(String text) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert "),
          content: new Text(text),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Fermer"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}