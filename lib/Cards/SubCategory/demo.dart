import 'package:MyApp/Cards/EventPage/Paths.dart';
import 'package:flutter/material.dart';


class Demo extends StatefulWidget {
  String Eventname;
  String Collegename;
  String Category;
  String collegetype;
  Demo(this.Eventname,this.Collegename,this.Category,this.collegetype);
  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  DatabaseMethods databaseMethods=DatabaseMethods();
  var eventstream;

  @override
  void initState() {
    getsubevent();
    super.initState();
  }
  getsubevent() async{
    await databaseMethods.geteventDetailsforsub(widget.Collegename,
        widget.Category, widget.Eventname,widget.collegetype).then((val){
          setState(() {
            eventstream=val;

          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: eventstream,builder: (context,snapshot){
      return snapshot.hasData?Container(
        height: MediaQuery.of(context).size.height/8,
        width: MediaQuery.of(context).size.width,
         // color: Colors.grey,
        child: Card(elevation: 1.0,
          child: Row(
            children: [SizedBox(width:MediaQuery.of(context).size.width/4 + 20 ),
              Container(
                height: MediaQuery.of(context).size.height,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(widget.Eventname,style: TextStyle(fontSize: 20,
                      letterSpacing: 0.5),),Divider(height: 2,),
                    Text(widget.Collegename,style: TextStyle(fontSize: 15,
                        letterSpacing: 0.5),),
                    Divider(height: 2,),
                    Text("EventDate:${snapshot.data["EventDate"]}",style: TextStyle(
                      fontSize: 10,
                      letterSpacing: 0.5
                    ),),
                    Divider(height: 2,),
                    Text("Mode:${snapshot.data['Mode']}",style: TextStyle(fontSize:10,
                        letterSpacing: 0.5),)
                  ],
                ),
              )
             ],
          ),
        ),
      ):Container(child: CircularProgressIndicator(),);
    });
  }
}
