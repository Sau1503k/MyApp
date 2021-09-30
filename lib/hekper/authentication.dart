import 'package:MyApp/Cards/FirstPage.dart';
import 'package:MyApp/Cards/studentLogin/studentlogin.dart';
import 'package:MyApp/Cards/studentLogin/studentsignup.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn=true;
  void toggleView(){
    setState(() {
      showSignIn=!showSignIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showSignIn){
       return StudentLogin(toggleView);
    }else{
      return
        // FirstCard(toggleView);
        SignUp(toggleView);
    }
  }
}