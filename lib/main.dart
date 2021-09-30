
import 'package:MyApp/Cards/CHomePage/AddEvents.dart';
import 'package:MyApp/Cards/CHomePage/ChomePage.dart';
import 'package:MyApp/Cards/CollegeList/collegelist.dart';
import 'package:MyApp/Cards/CollegeList/democlass.dart';
import 'package:MyApp/Cards/Collegecard/collegecard.dart';
import 'package:MyApp/Cards/DemoLogin/login.dart';
import 'package:MyApp/Cards/EventPage/Posters.dart';
import 'package:MyApp/Cards/EventPage/eventpage.dart';
import 'package:MyApp/Cards/Extractdata.dart';
import 'package:MyApp/Cards/FirstPage.dart';
import 'package:MyApp/Cards/SubCategory/Subcategory.dart';
import 'package:MyApp/Cards/bgwidget/slider.dart';

import 'package:MyApp/Cards/getimages.dart';
import 'package:MyApp/Classes/Eventtile.dart';
import 'package:MyApp/hekper/authentication.dart';
import 'package:MyApp/hekper/helperfuntion.dart';
import 'package:MyApp/pathway.dart';
import 'package:MyApp/sampleinputfield.dart';
import 'package:MyApp/sampleui.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;

import 'Cards/HomePAGE/HomePage.dart';
import 'Cards/CollegeLogin/collegeForm.dart';
import 'Cards/SubCategory/subcatcard.dart';
import 'Cards/studentLogin/studentlogin.dart';

// void main() {
//   runApp(MyApp());
// }
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   String collegename="IIT Bombay";
   String category="Cultural";
   String Subcat="Dance";
   String eventname="Etch a Sketch1";
  await firebase_core.Firebase.initializeApp();

  runApp(MyApp());
  //     MaterialApp(
  // debugShowCheckedModeBanner: false,
  //   // home:  EventPage(collegename,category,eventname),
  //   // home:CHomePage(collegename,category)
  //   home: StudentLogin(),
  // )
  // );
}
class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // bool userIsloggedIn;
  // @override
  // void initState() {
  //   getLoggedInstate();
  //   super.initState();
  // }
  // getLoggedInstate()async{
  //   await HelperFuntion.getUserLoggedInsharedpreference().then((val){
  //     setState(() {
  //       userIsloggedIn=val;
  //     });
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    String collegename="IIT Goa";
    String category="Cultural";
    String eventname="Brush";
    String collegetype="IIT's";

    return MaterialApp(
      // title: 'Flutter Demo',
      // theme: ThemeData(
      //
      //   primarySwatch: Colors.blue,
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      //
      // ),
       debugShowCheckedModeBanner: false,
      //  home:userIsloggedIn!=null ? userIsloggedIn ? HomePage() :
      //   Authenticate():
      // Container(
      //   child: Center(
      //     child: Authenticate(),
      //   ),
      // ),
         home:
         // HomePage()
         // SubCatCard()
         // LoginScreen()
         //  CollegeCard()
         //  EventPage(collegename,category,eventname,collegetype)
        // extractdata("Dance")
         // ExtractData()
         // SubCategoryPage( "Dance")
        CHomePage(collegename,category),
       // CollegeForm(),

    );
  }
}

