import 'package:MyApp/Cards/EventPage/Paths.dart';
import 'package:flutter/material.dart';



class listview extends StatefulWidget {
  int index;
  String CollegeType;
  listview(this.index,this.CollegeType);
  @override
  _listviewState createState() => _listviewState();
}

class _listviewState extends State<listview> {


  DatabaseMethods databaseMethods=DatabaseMethods();
  var eventstream;
  @override
  void initState() {
    getcollegename();

    super.initState();
  }


  getcollegename()async{
    await databaseMethods.getcollegelist(widget.CollegeType).then((val){
      setState(() {
        eventstream=val;

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: eventstream,builder: (context,snapshot){
      return Padding(
        padding: const EdgeInsets.only(bottom:8.0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10,
              vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.greenAccent
          ),
          child:Row(crossAxisAlignment: CrossAxisAlignment.start,
            children: [Container(decoration: BoxDecoration(
                shape:BoxShape.circle,
                color: Colors.redAccent
            ),
              child: FlutterLogo(size: 50,),
            ),
              SizedBox(width: 15,),
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${snapshot.data.docs[widget.index]["CollegeName"]}",style: TextStyle(
                      fontSize: 18
                  ),),SizedBox(height: 3,),
                  Text("Followers-23",style:TextStyle(fontSize:14
                  ),)],
              )],
          ) ,
        ),
      );
    });
  }
}
