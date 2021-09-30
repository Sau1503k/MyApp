import 'package:flutter/material.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'SubCategory/subcategoryModel.dart';

class ExtractData extends StatefulWidget {
  @override
  _ExtractDataState createState() => _ExtractDataState();
}

class _ExtractDataState extends State<ExtractData> {
  List<SubCatModel> subcatmodel=List<SubCatModel>();

  @override
  void initState() {
    getsubcatmodel();
    super.initState();
  }



  getsubcatmodel()async{

    var raw = await http.get(
      "https://script.google.com/macros/s/AKfycbxVr127Yh_7A7z3Nj57YqHvsELtSTRnjNGWh8LWTpLKxDsQDomB2sXW8NOw2nWWiBsw/exec"
    );
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
    return Scaffold(
      appBar: AppBar(
          title:Text("Goodlesheetdata")
      ),
      body: Container(
        child: ListView.builder(itemCount: subcatmodel.length,itemBuilder: (context,index){
          return FeedbackTile(
                  collegename:subcatmodel[index].collegename,
                  maincategory: subcatmodel[index].maincategory,
                  subcategory: subcatmodel[index].subcategory,
                  eventname: subcatmodel[index].eventname,
                );


        }),
      ),
    );
  }
}


class FeedbackTile extends StatelessWidget {
  final String collegename,maincategory,subcategory,eventname;
  FeedbackTile({this.collegename,this.maincategory,this.subcategory,this.eventname});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [Text(collegename),Text("from $maincategory",style: TextStyle(color: Colors.black)),
          Text(eventname)
        ],
      ),
    );
  }
}
