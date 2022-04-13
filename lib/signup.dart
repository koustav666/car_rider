import 'dart:io';

import 'package:car_rider/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Widgets/Taxibutton.dart';
import 'brand_colors.dart';

class SignUpPage extends StatefulWidget {


  static const String id='Signup';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuth _auth= FirebaseAuth.instance;

  final GlobalKey<ScaffoldState> scaffoldkey=new GlobalKey<ScaffoldState>();

  void showSnackBar(String title){
    final snackbar= SnackBar(content: Text(title, textAlign: TextAlign.center,style: const TextStyle(fontSize: 14,fontFamily: "Brand-Regular"),));
    // ignore: deprecated_member_use
    scaffoldkey.currentState?.showSnackBar(snackbar);
  }

  var firstnameController =TextEditingController();

  var lastnameController =TextEditingController();

  var emailController =TextEditingController();

  var phoneController =TextEditingController();

  var passwordController =TextEditingController();

  var confirmPasswordController =TextEditingController();

  void registerUser() async{
    final User? user = (await _auth.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text).catchError((ex){ PlatformException thisEx= ex; showSnackBar(thisEx.message!);})).user;
    if(user!=null){
        DatabaseReference newUser = FirebaseDatabase.instance.reference().child('users/${user.uid}');
        Map userInfo={
          'full_name':firstnameController.text+" "+lastnameController.text,
          'phone':phoneController.text,
          'email':emailController.text
        };
        newUser.set(userInfo);
        Navigator.pushNamedAndRemoveUntil(context, LoginPage.id, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                SizedBox(height: 70,),
                Image.asset(
                  'images/logo.png',
                  alignment:Alignment.center,
                  height: 100,
                  width: 100,
                ),
                // ignore: prefer_const_constructors
                SizedBox(height: 40,),
                // ignore: prefer_const_constructors
                Text('Create Your Account',
                  textAlign: TextAlign.center,
                  // ignore: prefer_const_constructors
                  style: TextStyle(
                      fontSize:25,fontFamily: 'Brand-Bold'
                  ),
                ),
                Padding(
                  // ignore: prefer_const_constructors
                  padding: EdgeInsets.all(20),
                  child: Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      TextField(
                        // ignore: prefer_const_constructors
                        controller: firstnameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            labelText: 'First Name',
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize:10.0
                            )
                        ),
                        style: TextStyle(fontSize: 14),
                      ),//FirstName
                      SizedBox(height: 10,),
                      TextField(
                        controller: lastnameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            labelText: 'Last Name',
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize:10.0
                            )
                        ),
                        style: TextStyle(fontSize: 14),
                      ),//LastName
                      SizedBox(height: 10,),
                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: 'Email Address',
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize:10.0
                            )
                        ),
                        style: TextStyle(fontSize: 14),
                      ),//email
                      SizedBox(height: 10,),
                      TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            labelText: 'Phone Number',
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize:10.0
                            )
                        ),
                        style: TextStyle(fontSize: 14),
                      ),//phone
                      SizedBox(height: 10,),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize:10.0
                            )
                        ),
                        style: TextStyle(fontSize: 14),
                      ), //password
                      SizedBox(height: 10,),
                      TextField(
                        controller: confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize:10.0
                            )
                        ),
                        style: TextStyle(fontSize: 14),
                      ),// confirm password
                      SizedBox(height: 40,),
                      // ignore: deprecated_member_use
                      TaxiButton(
                        buttonColor: BrandColors.colorGreen,
                        onPressed: () async {

                          var connectivityResult = await Connectivity().checkConnectivity();
                          if (connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi) {
                            showSnackBar("No internet connectivity");
                            return;
                          }
                          if((firstnameController.text.length + lastnameController.text.length)<5)
                          {
                            showSnackBar("Invalid Name must be atleast 5 letters");
                            return;
                          }
                          if(phoneController.text.length != 10)
                          {
                              showSnackBar("Invalid phone number");
                              return;
                          }
                          if(!(emailController.text.contains('@'))){
                            showSnackBar("Invalid email id");
                            return;
                          }
                          if(passwordController.text.length<8){
                            showSnackBar("Invalid password");
                            return;
                          }
                          if(passwordController.text!=confirmPasswordController.text){
                            showSnackBar("Invalid password");
                            return;
                          }
                          registerUser();

                        },
                        text: 'REGISTER',
                      )

                    ],
                  ),
                ),
                // ignore: deprecated_member_use
                FlatButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, LoginPage.id, (route) => false);
                  },
                  child: Text('Already Have an account? Sign in'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
