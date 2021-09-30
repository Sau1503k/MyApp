import 'package:flutter/material.dart';

import 'Paths.dart';


class EventRule extends StatefulWidget {
  String collegename;
  String Category;
  String EventName;
  String Collegetype;
  EventRule(this.collegename,this.Category,this.EventName,this.Collegetype);
  @override
  _EventRuleState createState() => _EventRuleState();
}

class _EventRuleState extends State<EventRule> with TickerProviderStateMixin {
  DatabaseMethods databaseMethods=DatabaseMethods();
  var eventRule;
  Widget EventRule(){
    return Container(
      child: StreamBuilder(stream: eventRule,builder: (context,snapshot){




        return snapshot.hasData?Padding(
          padding: const EdgeInsets.only(left:8.0,right:8,top:10),
          child: Container(
            // color: Colors.blueGrey,
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                  Text("Rules",style: TextStyle(fontSize: 30),)],),
                SizedBox(height: 8,),
                Text(snapshot.data["EventRule"],style: TextStyle(fontSize: 15)),

              ],
            ),
          ),
        ): Container(height:50,width:50,child: CircularProgressIndicator());
      }),
    );
  }

  @override
  void initState() {
    geteventrule();
    super.initState();
  }

  geteventrule() async{
    await databaseMethods.geteventDetails(widget.collegename,
        widget.Category, widget.EventName,widget.Collegetype).then((val){
      setState(() {
        eventRule=val;
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: EventRule(),
    );
  }
}
