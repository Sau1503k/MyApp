import 'package:MyApp/Cards/EventPage/Evnetrules.dart';
import 'package:MyApp/Cards/EventPage/Posters.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Paths.dart';

class EventPage extends StatefulWidget {
  String collegename;
  String Category;
  String EventName;
  String Collegetype;
  EventPage(this.collegename,this.Category,this.EventName,this.Collegetype);
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> with TickerProviderStateMixin{
  TabController _tabController;
  DatabaseMethods databaseMethods=DatabaseMethods();
  // Stream <QuerySnapshot>eventstream;
  var eventstream;

  
  Widget Infosection(){
    return Container(
      child: StreamBuilder(stream: eventstream,builder: (context,snapshot){

        return snapshot.hasData?Padding(
          padding: const EdgeInsets.only(left:8.0,right:8,top:10),
          child: Container(
            // color: Colors.blueGrey,
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                Text(snapshot.data["EventName"],style: TextStyle(fontSize: 30),)],),
                SizedBox(height: 8,),
                Text(snapshot.data["EventDetails"],style: TextStyle(fontSize: 20)),
                SizedBox(height: 10,),
                // Text("Category: ${snapshot.data["Category"]}",style: TextStyle(fontSize: 20),),
                // SizedBox(height: 10,),
                Text("EventDate: ${snapshot.data["EventDate"]}",style: TextStyle(fontSize: 20)),
                SizedBox(height: 10,),
                Text("Mode: ${snapshot.data["Mode"]}",style: TextStyle(fontSize: 20)),
                SizedBox(height: 10,)
              ],
            ),
          ),
        ):Container(height:50,width:50,child: CircularProgressIndicator()) ;
      }),
    );
  }


  
  @override
  void initState() {
    geteventinfo();
    _tabController=TabController(length: 3, vsync: this);
    super.initState();
  }
  geteventinfo() async{
    await databaseMethods.geteventDetails(widget.collegename,
        widget.Category, widget.EventName,widget.Collegetype).then((val){
      setState(() {
        eventstream=val;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // SizedBox(height: 30,),
            //   Row(children: [Padding(
            //   padding: const EdgeInsets.only(left:8.0),
            //   child: Icon(Icons.arrow_back,size: 25,),
            // )],),
              SizedBox(height:0,),Padding(
              padding: const EdgeInsets.only(
                // left:8.0,right:8,
                  top:5),
              child: Poster(),
            ),
              SizedBox(height: 40,
              child: TabBar(isScrollable: true,
                  labelColor: Colors.grey,
                  controller: _tabController,
                  tabs: [Tab(child: Text("Event Details",style: TextStyle(fontSize: 15),),),
                  Tab(child: Text("Rules",style: TextStyle(fontSize: 15)),),
                    Tab(child: Text("Query",style: TextStyle(fontSize: 15),),)]),),
            SizedBox(height:500,child: TabBarView(controller: _tabController,
            children: [Infosection(),
            EventRule(widget.collegename, widget.Category, widget.EventName,widget.Collegetype),
            _buildContainer()],),),
            ],
          ),
        ),
      ),
    );
  }
  _buildContainer(){
    return Container(
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 50,vertical: 40),
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
        ),
        child: Text(""),
      ),

    );
  }

}
