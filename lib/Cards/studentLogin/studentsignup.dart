import 'package:MyApp/Cards/EventPage/Paths.dart';
import 'package:MyApp/Cards/HomePAGE/HomePage.dart';
import 'package:MyApp/Cards/bgwidget/slider.dart';
import 'package:MyApp/Cards/studentLogin/studentlogin.dart';
import 'package:MyApp/Services/Auth.dart';
import 'package:MyApp/hekper/helperfuntion.dart';
import 'package:flutter/material.dart';

import '../../widgets.dart';


class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController usernameTextEditing=new TextEditingController();
  TextEditingController EmailTextEditing=new TextEditingController();
  TextEditingController PasswordTextEditing=new TextEditingController();
  final _formkey=GlobalKey<FormState>();
  DatabaseMethods databaseMethods=DatabaseMethods();
  HelperFuntion helperFuntion=HelperFuntion();
  bool isloading=false;
  AuthMethod authMethod=new AuthMethod();

  signmeUp(){
    if(_formkey.currentState.validate()){
      Map<String,String> userInfoMap={
        "name":usernameTextEditing.text,
        "email":EmailTextEditing.text
      };
      HelperFuntion.saveUserEmailsharedpreference(EmailTextEditing.text);
      HelperFuntion.saveUserNamesharedpreference(usernameTextEditing.text);
      setState(() {
        isloading=true;
      });
      authMethod.signUpwithEmailandPassword(
          EmailTextEditing.text, PasswordTextEditing.text).then((val){
         databaseMethods. uploadUserInfo(userInfoMap);
         HelperFuntion.saveUserLoggedInsharedpreference(true);
         Navigator.pushReplacement(context,
             MaterialPageRoute(builder:(context)=>
                 // HomePage()
               slider()

             ));
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(alignment: Alignment.bottomCenter,
          height: MediaQuery.of(context).size.height-50,
          child: Container(padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(mainAxisSize: MainAxisSize.min,
              children: [
                Form(key: _formkey,
                  child: Column(mainAxisSize: MainAxisSize.min,children: [
                    TextFormField(validator: (val){
                      return val.isEmpty || val.length<2 ? "Please Provide UserName" : null;
                    },controller: usernameTextEditing,decoration:textFieldInputDecoration("UserName"),style: simpleTextStyle(),),
                    TextFormField(validator:(val){
                    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ? null:"Enter correct Email";
                  },controller: EmailTextEditing,decoration: textFieldInputDecoration("Email"),style: simpleTextStyle(),),
                    TextFormField(obscureText: true,validator: (val){
                      return val.length>6 ? null:"password should be 6+ character";
                    },controller: PasswordTextEditing,decoration:textFieldInputDecoration("Password"),style: simpleTextStyle(),),
                    SizedBox(height: 8,),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical:10),
                      child: Container(alignment: Alignment.centerRight
                        ,child:Text("Forgot Password",style:simpleTextStyle()) ,),
                    ),
                    SizedBox(height: 10,),
                    GestureDetector(onTap: (){
                      signmeUp();

                    },
                      child: Container(height: 50,width: MediaQuery.of(context).size.width,alignment:Alignment.center,
                        child:Text("SignIn",style: TextStyle(color: Colors.white,
                            fontSize: 16),),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xff007EF4),
                                const Color(0xff2A75BC)
                              ],
                            )
                        ),),
                    ),
                    SizedBox(height: 15,),
                    Container(height: 50,width: MediaQuery.of(context).size.width,alignment:Alignment.center,
                      child:Text("Sign in with google",style: TextStyle(color: Colors.white,
                          fontSize: 16),),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xff007EF4),
                              const Color(0xff2A75BC)
                            ],
                          )
                      ),),
                    SizedBox(height: 16,),
                    Container(child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("Already have an Account?  ",
                          style:TextStyle(color: Colors.black,
                              fontSize: 17)),
                        GestureDetector(onTap: (){
                          widget.toggle();
                        },
                          child: Text("SignIn",style:TextStyle(color:Colors.black,
                              fontSize: 17)),
                        )],),),
                    SizedBox(height:100,)


                  ],),
                ),
              ],
            ),),
        ),
      ),
    );
  }
}
