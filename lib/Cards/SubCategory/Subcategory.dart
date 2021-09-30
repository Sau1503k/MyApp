import 'package:MyApp/Cards/EventPage/Paths.dart';
import 'package:MyApp/Cards/SubCategory/subcategoryModel.dart';
import 'package:flutter/material.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class SubCategoryPage extends StatefulWidget {
  String Subcategory;
  SubCategoryPage(this.Subcategory);
  @override
  _SubCategoryPageState createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {
  List<SubCatModel> subcatmodel=List<SubCatModel>();
  DatabaseMethods databaseMethods=DatabaseMethods();
  var raw1;
  var eventstream;
  getlinks()async{
    await databaseMethods.getsubcategorylinks(widget.Subcategory).then((val){
      setState(() {
        eventstream=val;
      });
    });
  }

  @override
  void initState() {
    getlinks();
    super.initState();
  }
  Widget Infosection(){
    return Container(
      child: StreamBuilder(stream: eventstream,
      builder: (context,snapshot){
        return snapshot.hasData? getsubcatmodel(snapshot.data['Link']):
            Container(height:50,width:50,child: CircularProgressIndicator());
      },),
    );
  }








  
  getsubcatmodel(String url)async{

    var raw = await http.get(url
          // "https://script.google.com/macros/s/AKfycbxVr127Yh_7A7z3Nj57YqHvsELtSTRnjNGWh8LWTpLKxDsQDomB2sXW8NOw2nWWiBsw/exec"
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
    return  Scaffold(
      appBar: AppBar(
          title:Text("Goodlesheetdata")
      ),
      body: Container(
        child: ListView.builder(itemCount: subcatmodel.length,itemBuilder: (context,index){
          return Container(
            child: Column(
              children: [Text("marr ja saale"),
                FeedbackTile(
                  collegename:subcatmodel[index].collegename,
                  maincategory: subcatmodel[index].maincategory,
                  subcategory: subcatmodel[index].subcategory,
                  eventname: subcatmodel[index].eventname,
                ),
              ],
            ),
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
