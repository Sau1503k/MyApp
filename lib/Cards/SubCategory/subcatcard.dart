import 'package:MyApp/Cards/EventPage/Paths.dart';
import 'package:MyApp/Cards/EventPage/Posters.dart';
import 'package:MyApp/Cards/SubCategory/demo.dart';
import 'package:MyApp/Cards/SubCategory/subcategoryModel.dart';
import 'package:MyApp/Classes/Eventtile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

//working subcategory page
class SubCatCard extends StatefulWidget {
  @override
  _SubCatCardState createState() => _SubCatCardState();
}

class _SubCatCardState extends State<SubCatCard> {
  List<SubCatModel> subcatmodel=List<SubCatModel>();
  DatabaseMethods databaseMethods=DatabaseMethods();
  QuerySnapshot snapshots;


  getsubcatmodel()async{

    var raw = await http.get(
       // "https://script.google.com/macros/s/AKfycbxVr127Yh_7A7z3Nj57YqHvsELtSTRnjNGWh8LWTpLKxDsQDomB2sXW8NOw2nWWiBsw/exec"
    "https://script.google.com/macros/s/AKfycbyHaW3NkuVIrGeujDOE9QrAx0trElZ3Pwk6wNLJCePgZ5duCQh5iVdhOdw-PzKNY9I2/exec"
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
      subModel.collegetype=element['collegetype'];

      subcatmodel.add(subModel);
    });
    print("${subcatmodel[0].eventname}");
  }
   var eventdate;
   var mode;

  @override
  void initState() {
    getsubcatmodel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical:15.0,horizontal: 8),
          child: Column(
            children: [Container(height:MediaQuery.of(context).size.height/2.6,alignment: Alignment.topCenter,child: Poster()),
              Expanded(
                child: ListView.builder(shrinkWrap: true,itemCount: subcatmodel.length,itemBuilder: (context,index){
                //    Future<void> get()async{
                //   await databaseMethods.geteventDetailsforsub(subcatmodel[index].collegename,
                //       subcatmodel[index].maincategory,
                //       subcatmodel[index].eventname,
                //       subcatmodel[index].collegetype).then((val){
                //         setState(() {
                //           snapshots=val;
                //           mode= snapshots.docs[0]["Mode"];
                //           eventdate=snapshots.docs[0]["Eventdate"];
                //         });
                //
                //
                // });
                //
                //
                // }
                // print(eventdate.toString());
                  return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Container(
                        child: Stack(
                          children: [Positioned(bottom: 0,child:
                          Demo(subcatmodel[index].eventname,
                              subcatmodel[index].collegename,
                              subcatmodel[index].maincategory,
                              subcatmodel[index].collegetype)),
                            poster(),
                          ],
                        ),
                      )

                  );
                // );
              }),)
            ],
          ),
        ),
      ),

    );
  }
}

class eventTile extends StatelessWidget {
  String Eventname;
  String Collegename;
  String EventDate;
  String Mode;
  eventTile(this.Eventname,this.Collegename,this.EventDate,this.Mode);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/8,
      width: MediaQuery.of(context).size.width,
      color: Colors.green,
      child: Row(
        children: [SizedBox(width:MediaQuery.of(context).size.width/4 + 20 ),
          Container(height:MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Text(Eventname,style: TextStyle(fontSize: 20)),
            Text(Collegename,style: TextStyle(fontSize: 15),),
            Text("Date:${EventDate}",style: TextStyle(fontSize: 10),),
            Text("Mode:${Mode}",style: TextStyle(fontSize: 8),)
          ],
        ),)],
      )

      ,

    );

  }


}
class poster extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(height: MediaQuery.of(context).size.height/6.5,
    width: MediaQuery.of(context).size.width/4,
    color: Colors.blue,
    child: Poster(),);
  }
}








