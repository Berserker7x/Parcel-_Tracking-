import 'package:apk/Screen/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget{
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
        title: Text('Register New Account'),
        centerTitle: true,
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
                      return 'Please Fill Email Input';
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
                    hintText: 'Password',
                  ),
                  validator: (value){
                    if(value.isEmpty){
                      return 'Please Fill Password Input';
                    }
                  },
                ),
                SizedBox(
                  height: 100,
                ),
                RaisedButton(
                  color: Colors.orange,
                  child: Text('Register New Account',style: TextStyle(color: Colors.white),),
                  onPressed: () async {
                    if (_formkey.currentState.validate()) {
                      try {
                        //Create Get Firebase Auth User
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                            email: _emailcontroller.text,
                            password: _passwordcontroller.text);

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      } on FirebaseAuthException catch (error) {
                        _showDialog(error.message);
                      }
                    }
                  }
                ),
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
              child: new Text("Close"),
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