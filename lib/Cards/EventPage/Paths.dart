

import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_core/firebase_core.dart';

class DatabaseMethods{
  uploadEventInfo(eventInfo,String collegename,String Category,String EventName,String collegetype)async{
    // return await FirebaseFirestore.instance.collection("CollegeName").doc(collegename).collection(Category).doc(EventName).collection(EventName).
    // add(eventInfo).catchError((e){print(e.toString());});
    // return await FirebaseFirestore.instance.collection("CollegeName").doc(collegename).collection(Category).doc(EventName).set(eventInfo).catchError((e){print(e.toString());});
    return await FirebaseFirestore.instance.collection("CollegeName").doc(collegetype).collection(collegename).doc(Category).collection(EventName).doc(EventName).set(eventInfo);


  }

  geteventDetails(String collegename,String Category,String EventName,String Collegetype) async{
    // return await FirebaseFirestore.instance.collection("CollegeName").doc("IIT GOA").snapshots();
    // return await FirebaseFirestore.instance.collection("CollegeName").doc(collegename).collection(Category).doc(EventName).
    // snapshots();
    // return await FirebaseFirestore.instance.collection("CollegeName").doc(collegename).collection(Category).doc(EventName)
    //     .snapshots();
    return await FirebaseFirestore.instance.collection("CollegeName").doc(Collegetype).collection(collegename).doc(Category).collection(EventName).doc(EventName)
        .snapshots();

  }
  getMainCategoryEvents(String collegename,String Category) async{
    return await FirebaseFirestore.instance.collection("CollegeName").doc(collegename).collection(Category).snapshots();
  }
  getUserbyuserEmail(String userEmail)async{
    return await FirebaseFirestore.instance.collection("users").
    where("email",isEqualTo:userEmail).get();
  }
  getuserinfobycollegename(String collegeEmail)async{
    return await FirebaseFirestore.instance.collection("Colleges").
    where("email",isEqualTo: collegeEmail).get();
  }
  uploadUserInfo(userMap){
    FirebaseFirestore.instance.collection("users").add(userMap).catchError((e){
      print(e.toString());
    });
  }
  getsubcategoryEventInfo(String collegename,String maincategory,String Eventname)async{
    return await FirebaseFirestore.instance.collection("CollegeName").doc(collegename).collection(maincategory).
    doc(Eventname).snapshots();
  }
  getsubcategorylinks(String Subcategory)async{
    return await FirebaseFirestore.instance.collection("Links").doc(Subcategory).snapshots();
  }
  geteventDetailsforsub(String collegename,String Category,String EventName,String Collegetype) async{
    return await FirebaseFirestore.instance.collection("CollegeName").doc(Collegetype).collection(collegename).doc(Category).collection(EventName).doc(EventName)
        .snapshots();

  }
  getcollegelist(String Collegetype)async{
    return await FirebaseFirestore.instance.collection(Collegetype).snapshots();
  }

}