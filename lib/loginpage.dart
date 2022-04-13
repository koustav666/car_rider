// ignore_for_file: prefer_const_constructors

import 'package:car_rider/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:car_rider/brand_colors.dart';
import 'package:flutter/services.dart';
import 'Widgets/Taxibutton.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'Login';


  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  var emailController = TextEditingController();
  var passwordController =TextEditingController();
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> scaffoldkey= new GlobalKey<ScaffoldState>();
  void showSnackBar(String title)async{
    final snackbar= SnackBar(content: Text(title, textAlign: TextAlign.center,style: const TextStyle(fontSize: 14,fontFamily: "Brand-Regular"),));
    // ignore: deprecated_member_use
    scaffoldkey.currentState?.showSnackBar(snackbar);
  }
  void signIn()async{
    final User? user=(await _auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text).catchError((ex){Exception thisEx= ex;showSnackBar('Wrong credentials');})).user;
    if(user!=null){
      DatabaseReference userRef=FirebaseDatabase.instance.reference().child('users/${user.uid}');
      userRef.once().then((DataSnapshot datasnapshot){
        if(datasnapshot.value!=null)
          {
            print('Login successful');
          }
        else{
          showSnackBar('Wrong credentials');
        }
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // ignore: prefer_const_constructors
    return Scaffold(
      key: scaffoldkey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              // ignore: duplicate_ignore
              children: <Widget>[
                SizedBox(
                  height: 70,
                ),
                Image.asset(
                  'images/logo.png',
                  alignment: Alignment.center,
                  height: 100,
                  width: 100,
                ),
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 40,
                ),
                // ignore: prefer_const_constructors
                Text(
                  'Sign in as rider',
                  textAlign: TextAlign.center,
                  // ignore: prefer_const_constructors
                  style: TextStyle(fontSize: 25, fontFamily: 'Brand-Regular'),
                ),
                Padding(
                  // ignore: prefer_const_constructors
                  padding: EdgeInsets.all(20),
                  child: Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: 'Email address',
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 10.0)),
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 10.0)),
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      // ignore: deprecated_member_use
                      TaxiButton(
                        buttonColor: BrandColors.colorGreen,
                        onPressed: (){
                          signIn();
                        },
                        text: 'LOGIN',
                      )
                    ],
                  ),
                ),
                // ignore: deprecated_member_use
                FlatButton(
                  onPressed: ()async {
                    Navigator.pushNamedAndRemoveUntil(
                        context, SignUpPage.id, (route) => false);
                  },
                  child: Text(
                      'Don\'t have an account? Click here to create account'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
