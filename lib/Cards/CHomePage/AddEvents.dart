import 'package:MyApp/Cards/CHomePage/AddImages.dart';
import 'package:MyApp/Cards/EventPage/Paths.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddEvent extends StatefulWidget {
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  DatabaseMethods databaseMethods=DatabaseMethods();
  TextEditingController eventnamecontroller=TextEditingController();
  TextEditingController eventRulecontroller=TextEditingController();
  TextEditingController modecontroller=TextEditingController();
  TextEditingController eventdatecontroller=TextEditingController();
  TextEditingController collegenamecontroller=TextEditingController();
  TextEditingController eventDetailscontroller=TextEditingController();
  final formkey=GlobalKey<FormState>();
  final _scaffoldkey= GlobalKey<ScaffoldState>();
  List collegetype=['Engineering',"IIT's",'Medical',"NIT's","other Colleges"];

  String subCategory;
  String MainCategory;
  String CollegeType;

  List subcategory=["Gaming","Technical","Painting/Sketching","Dance","Music","Drama","Sports","Art","Literature",
    "Workshop","Pro Events","Photography","Film Making","others"];
  List mainCategory=["Cultural","Gaming","Technical","Sports","Workshop","Pro Events"];


  void _sendinfo(){
    if(formkey.currentState.validate()){
      String collegename=collegenamecontroller.text;
      String eventcategory=MainCategory;
      String eventName=eventnamecontroller.text;
      String collegetype=CollegeType;
      Map<String,dynamic> Eventinfo={
        "EventName":eventnamecontroller.text,
        "MainCategory":MainCategory,
        "SubCategory":subCategory,
        "EventDate":eventdatecontroller.text,
        "Mode":modecontroller.text,
        "EventRule":eventRulecontroller.text,
        "EventDetails":eventDetailscontroller.text,
        "time":DateTime.now().millisecondsSinceEpoch
      };
      databaseMethods.uploadEventInfo(Eventinfo,collegename,eventcategory,eventName,collegetype);



    }
  }
  _showsnackbar(String Message){
    final snackbar=SnackBar(content: Text(Message));
    _scaffoldkey.currentState.showSnackBar(snackbar);

  }

  File _imagefile;
  final picker=ImagePicker();
  Future pickImage() async{
    final pickedfile=await picker.getImage(source: ImageSource.gallery);


    setState(() {
      _imagefile=File(pickedfile.path);
    });
  }

  Future UploadImagetofirebase(BuildContext context) async{
    String collegename=collegenamecontroller.text;
    String eventcategory=MainCategory;
    String eventName=eventnamecontroller.text;
    String collegetype=CollegeType;
    String filename=basename(_imagefile.path);
    firebase_storage.Reference firebaseStorafeRef=
    firebase_storage.FirebaseStorage.instance.ref().child("Colleges/IIT's/${collegenamecontroller.text}/${MainCategory}"
        "/${eventnamecontroller.text}/$filename");
    firebase_storage.UploadTask uploadtask= firebaseStorafeRef.putFile(_imagefile);
    firebase_storage.TaskSnapshot taskSnapshot = await uploadtask.whenComplete(() => null);
    taskSnapshot.ref.getDownloadURL().then((value) => print("Done:$value"));
    setState(() {
      _imagefile=null;
    });

    Future EN=databaseMethods.geteventDetails(collegename, eventcategory, eventName,collegetype);
    if(EN.toString().isNotEmpty){
      _showsnackbar("EventDetails Submitted");
      eventDetailscontroller.clear();
      eventnamecontroller.clear();
      eventdatecontroller.clear();
      eventRulecontroller.clear();
      modecontroller.clear();
      collegenamecontroller.clear();
      setState(() {
        MainCategory=null;
        subCategory=null;
        CollegeType=null;
      });

    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: formkey,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical:50.0,horizontal: 10),
              child: Column(
                children: [
                  TextFormField(controller:eventnamecontroller
                    ,validator: (value){
                      if(value.isEmpty){
                        return "Enter Valid EventName";
                      }else{
                        return null;
                      }
                    },decoration: InputDecoration(
                        labelText: "EventName"
                    ),),
                  TextFormField(controller: eventdatecontroller
                    ,validator: (value){
                      if(value.isEmpty){
                        return "Enter Valid EventDate";
                      }else{
                        return null;
                      }
                    },decoration: InputDecoration(
                        labelText: "EventDate"
                    ),),
                  TextFormField(controller: modecontroller,validator: (value){
                    if(value.isEmpty){
                      return "Enter Valid Mode";
                    }else{
                      return null;
                    }
                  },decoration: InputDecoration(
                      labelText: "Mode"
                  ),),
                  TextFormField(controller:collegenamecontroller
                    ,validator: (value){
                      if(value.isEmpty){
                        return "Enter Valid CollegeName";
                      }else{
                        return null;
                      }
                    },decoration: InputDecoration(
                        labelText: "CollegeName"
                    ),),
                  TextFormField(controller:eventDetailscontroller
                    ,validator: (value){
                      if(value.isEmpty){
                        return "Enter Valid EventDetails";
                      }else{
                        return null;
                      }
                    },decoration: InputDecoration(
                        labelText: "EventDetails"
                    ),),
                  TextFormField(controller:eventRulecontroller
                    ,validator: (value){
                      if(value.isEmpty){
                        return "Enter Valid EventName";
                      }else{
                        return null;
                      }
                    },decoration: InputDecoration(
                        labelText: "EventRules",
                    ),maxLines:2,),
                  Container(width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: DropdownButton(
                        hint: Text("Select MainCategory"),
                        value: MainCategory,
                        onChanged: (newvalue){
                          setState(() {
                            MainCategory=newvalue;
                          });
                        },
                        items:mainCategory.map((valueItem){
                          return DropdownMenuItem(child: Text(valueItem),
                            value: valueItem,);
                        }).toList(),

                      ),
                    ),
                  ),
              Container(width: MediaQuery.of(context).size.width,
                child: Center(
                  child: DropdownButton(
                    hint: Text("Select SubCategory"),
                    value: subCategory,
                    onChanged: (newvalue){
                      setState(() {
                        subCategory=newvalue;
                      });
                    },
                    items:subcategory.map((valueItem){
                      return DropdownMenuItem(child: Text(valueItem),
                        value: valueItem,);
                    }).toList(),

                  ),
                ),
              ),
                  Container(width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: DropdownButton(
                        hint: Text("Select SubCategory"),
                        value: CollegeType,
                        onChanged: (newvalue){
                          setState(() {
                            CollegeType=newvalue;
                          });
                        },
                        items:collegetype.map((valueItem){
                          return DropdownMenuItem(child: Text(valueItem),
                            value: valueItem,);
                        }).toList(),

                      ),
                    ),
                  ),

                  _imagefile != null?Container(height: 200,width:MediaQuery.of(context).size.width,child:Image.file(_imagefile)):FlatButton(onPressed: pickImage, child: Icon(Icons.add_a_photo,size: 20,)),
                  // FlatButton(onPressed:()=>UploadImagetofirebase(context) ,child: Text("Upload",style: TextStyle(fontSize: 30),),),

                  RaisedButton(onPressed: (){
                    UploadImagetofirebase(context);
                    _sendinfo();


                  },
                    child: Text("send"),)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

