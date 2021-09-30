

import 'package:MyApp/Cards/EventPage/Paths.dart';
import 'package:flutter/material.dart';

class InputEventInfo extends StatefulWidget {
  @override
  _InputEventInfoState createState() => _InputEventInfoState();
}

class _InputEventInfoState extends State<InputEventInfo> {
  DatabaseMethods databaseMethods=DatabaseMethods();
  TextEditingController categorycontroller=TextEditingController();
  TextEditingController eventnamecontroller=TextEditingController();
  TextEditingController modecontroller=TextEditingController();
  TextEditingController eventdatecontroller=TextEditingController();
  TextEditingController collegenamecontroller=TextEditingController();
  final formkey=GlobalKey<FormState>();

  sendinfo(){
    if(formkey.currentState.validate()){
      String collegename=collegenamecontroller.text;
      String eventcategory=categorycontroller.text;
      String eventName=eventnamecontroller.text;
      Map<String,String> Eventinfo={
        "EventName":eventnamecontroller.text,
        "Category":categorycontroller.text,
        "EventDate":eventdatecontroller.text,
        "Mode":modecontroller.text
      };
      // databaseMethods.uploadEventInfo(Eventinfo,collegename,eventcategory,eventName);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical:50.0,horizontal: 10),
            child: Column(
              children: [
                TextFormField(controller: categorycontroller
                  ,validator: (value){
                  if(value.isEmpty){
                    return "Enter Valid Category";
                  }else{
                    return null;
                  }
                },decoration: InputDecoration(
                  labelText: "Category"
                ),),
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
                RaisedButton(onPressed: (){
                  sendinfo();
                },
                child: Text("send"),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
