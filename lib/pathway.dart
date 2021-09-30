import 'package:MyApp/Cards/SubCategory/Subcategory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Cards/EventPage/Paths.dart';
import 'Cards/SubCategory/subcategoryModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class extractdata extends StatefulWidget {
  String Subcategory;
  extractdata(this.Subcategory);
  @override
  _extractdataState createState() => _extractdataState();
}

class _extractdataState extends State<extractdata> {
  List<SubCatModel> subcatmodel=List<SubCatModel>();
  var raw;
  String Url;
  DatabaseMethods databaseMethods=DatabaseMethods();
  var eventstream;
  @override
  void initState() {
    _getlinks();
    getlink();
    getsubcatmodel();
    super.initState();
  }



  _getlinks()async{
    await databaseMethods.getsubcategorylinks(widget.Subcategory).then((val){
      setState(() {
        eventstream=val;
      });
    });
  }
  Widget getlink(){
    return StreamBuilder(stream: eventstream,builder: (context,snapshot){
      return snapshot.hasData?getraw(snapshot.data['Link']):
      Container(height:50,width:50,child: CircularProgressIndicator());
      // if(snapshot.hasData){
      //   setState(() {
      //     Url=snapshot.data['Link'];
      //   });
      //   return getraw();
      // }else{
      //   return Container(height:50,width:50,child: CircularProgressIndicator());
      // }
    });

  }
  getraw(val)async{
    Url=await val;

    raw= await http.get(Url);
  }

  getsubcatmodel(){
    var subcat= convert.jsonDecode(raw.body);
    print("this is json feedback$subcat");
    subcat.forEach((element){
      print("$element This is Nexttttt");
      SubCatModel subModel= new SubCatModel();
      subModel.collegename=element['CollegeName'];
      subModel.maincategory=element['MainCategory'];
      subModel.subcategory=element['SubCategory'];
      subModel.eventname=element['EventName'];

      subcatmodel.add(subModel);
    });
    print("${subcatmodel[0].eventname}");
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [Text(subcatmodel[0].collegename),
        Text(subcatmodel[0].maincategory),
        ],
      ),
    );
  }
}

