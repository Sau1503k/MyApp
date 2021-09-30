import 'package:MyApp/Cards/studentLogin/studentlogin.dart';
import 'package:MyApp/Cards/studentLogin/studentsignup.dart';
import 'package:MyApp/hekper/authentication.dart';
import 'package:flutter/material.dart';


class FirstCard extends StatefulWidget {
  @override
  _FirstCardState createState() => _FirstCardState();
}

class _FirstCardState extends State<FirstCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(height: MediaQuery.of(context).size.height,
        width:MediaQuery.of(context).size.width,
        // color: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.only(left:10.0,right:10,top: 150),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Login/SignUp",
              style: TextStyle(fontSize: 30,
                  fontWeight: FontWeight.bold
                  ,color: Colors.lightBlueAccent),),
            SizedBox(height: 30,)
            ,GestureDetector(onTap:(){
                // Authenticate();
              },child: Cont("Student")),
              SizedBox(height: 20,),
              Cont("College")

            ],
          ),
        ),
      ),
    );
  }
}
class Cont extends StatelessWidget {
  String Message;
  Cont(this.Message);
  @override
  Widget build(BuildContext context) {
    return Container(alignment: Alignment.center,width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              colors: [
                const Color(0xff007EF4),
                const Color(0xff2A75BC)
              ],
            )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical:15.0,horizontal: 30),
          child: Text(Message,style: TextStyle(
              fontSize: 30,
              fontWeight:FontWeight.bold,
              color: Colors.white
          ),),
        ),
      );
  }
}



