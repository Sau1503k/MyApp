import 'package:MyApp/Cards/EventPage/Paths.dart';
import 'package:flutter/material.dart';

import 'collegelist.dart';

class Colleges extends StatefulWidget {
  String collegetype;
  Colleges(this.collegetype);
  @override
  _CollegesState createState() => _CollegesState();
}

class _CollegesState extends State<Colleges> {
  DatabaseMethods databaseMethods=DatabaseMethods();
  var eventstream;
  int len;

  @override
  void initState() {
    getcollegename();

    super.initState();
  }




  getcollegename()async{
    await databaseMethods.getcollegelist(widget.collegetype).then((val){
      setState(() {
        eventstream=val;
        len=eventstream.docs.length;



      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: eventstream,
      builder: (context, snapshot) {
        return snapshot.hasData?ListView.builder(itemCount: 1
        ,itemBuilder: (context,index){
          return null;
            }):
        Container(height:50,width:50,child: CircularProgressIndicator());
      }
    );
  }
}
