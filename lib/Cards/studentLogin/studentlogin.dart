import 'package:MyApp/Cards/EventPage/Paths.dart';
import 'package:MyApp/Cards/HomePAGE/HomePage.dart';
import 'package:MyApp/Cards/bgwidget/slider.dart';
import 'package:MyApp/Contants.dart';
import 'package:MyApp/Services/Auth.dart';
import 'package:MyApp/hekper/helperfuntion.dart';
import 'package:MyApp/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class StudentLogin extends StatefulWidget {
  final Function toggle;
  StudentLogin(this.toggle);
  @override
  _StudentLoginState createState() => _StudentLoginState();
}

class _StudentLoginState extends State<StudentLogin> {
  AuthMethod authmethod=AuthMethod();
  TextEditingController EmailTextEditing=new TextEditingController();
  TextEditingController PasswordTextEditing=new TextEditingController();
  final _formkey=GlobalKey<FormState>();
  QuerySnapshot snapshotUserInfo;
  QuerySnapshot snapshotcol;
  bool isloading=false;
  DatabaseMethods databaseMethods= new DatabaseMethods();
  signIn(){
    if(_formkey.currentState.validate()){
      HelperFuntion.saveUserEmailsharedpreference(EmailTextEditing.text);
      setState(() {
        isloading=true;
      });
      // databaseMethods.getUserbyuserEmail(EmailTextEditing.text).then((val){
      //   snapshotUserInfo=val;
      //   HelperFuntion.saveUserNamesharedpreference(snapshotUserInfo.docs[0]["name"]);
      //
      // });
      authmethod.signInwithEmailandPassword(EmailTextEditing.text, PasswordTextEditing.text).then((val){
        if(val!=null){

          HelperFuntion.saveUserLoggedInsharedpreference(true);
          databaseMethods.getUserbyuserEmail(EmailTextEditing.text).then((val){
            snapshotUserInfo=val;
            HelperFuntion.saveUserNamesharedpreference(snapshotUserInfo.docs[0]["name"]);

          });
          databaseMethods.getuserinfobycollegename(EmailTextEditing.text).then((val){
            snapshotcol=val;
            Constants.collegename=snapshotcol.docs[0]['collegename'];
            Constants.collegetype=snapshotcol.docs[0]['collegetype'];

          });



          // print("${val.uid}");
          Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>
               HomePage()
            // slider()
          ));


        }
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
                  child: Column(mainAxisSize: MainAxisSize.min,children: [TextFormField(validator:(val){
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
                      signIn();

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
                      children: [Text("Don't have account?  ",
                          style:TextStyle(color: Colors.black,
                              fontSize: 17)),
                        GestureDetector(onTap: (){
                           widget.toggle();
                        },
                          child: Text("Register Now",style:TextStyle(color:Colors.black,
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
