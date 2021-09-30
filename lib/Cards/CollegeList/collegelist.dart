import 'package:MyApp/Cards/EventPage/Paths.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'collegelistclass.dart';

class CollegeList extends StatefulWidget {
  String Collegetype;
  CollegeList(this.Collegetype);
  @override
  _CollegeListState createState() => _CollegeListState();
}

class _CollegeListState extends State<CollegeList> {
  DatabaseMethods databaseMethods=DatabaseMethods();
  var eventstream;

  List colleges;
  // Widget collegelist(){
  //   return StreamBuilder(stream: eventstream,builder: (context,snapshot){
  //     return snapshot.hasData?Container(
  //       child:ListView.builder(itemCount: snapshot.data.docs.length,itemBuilder: (context,index){
  //         var collegename;
  //         if (snapshot.hasData){
  //           setState(() {
  //             colleges[index]=snapshot.data.docs[index]['CollegeName'];
  //
  //           });
  //           return colleges[index];
  //
  //         }else{
  //           return Container(child:CircularProgressIndicator());
  //         }
  //       }),
  //     ):
  //         Container(child: CircularProgressIndicator(),);
  //   });
  // }
  @override
  void initState() {
    getcollegename();

    super.initState();
  }




  getcollegename()async{
    await databaseMethods.getcollegelist(widget.Collegetype).then((val){
      setState(() {
        eventstream=val;

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:StreamBuilder(
        stream: eventstream,
        builder: (context, snapshot) {
          return Stack(
                children: [CustomScrollView(
                  slivers: [SliverPersistentHeader(delegate: CustomSliverDelegate(expandedHeight:300),
                    pinned: true,),
                  // _collegecard()
                   SliverList(
                       delegate: SliverChildBuilderDelegate(
                           (context,index){
                     return listview( index,widget.Collegetype);
                   },childCount:snapshot.hasData?snapshot.data.docs.length:0),
                   )
                  ],
                ),]
              );
        }
      )

      );

  }
  
  
  
  Widget _collegecard(){
    return SliverGrid(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 1,
      childAspectRatio: 5

    ),
      delegate: SliverChildBuilderDelegate(
        (context,index)=> Padding(
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
                Text("IIT Goa",style: TextStyle(
                  fontSize: 18
                ),),SizedBox(height: 3,),
                  Text("Followers-23",style:TextStyle(fontSize:14
                  ),)],
              )],
            ) ,
          ),
        ),childCount:20
    ),);
  }
  Widget _collegenames(){
    return StreamBuilder(stream: eventstream,builder: (context,snapshot){
      return snapshot.hasData? Expanded(
        child: ListView.builder(scrollDirection: Axis.vertical,shrinkWrap: true,itemCount:snapshot.data.docs.length,
              itemBuilder:(context,index){
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
                        Text("${snapshot.data.docs[index]['CollegeName']}",style: TextStyle(
                            fontSize: 18
                        ),),SizedBox(height: 3,),
                        Text("Followers-23",style:TextStyle(fontSize:14
                        ),)],
                    )],
                ) ,
              ),
            );
          }),
      ):Container(height:50,width:50,child: CircularProgressIndicator()) ;
    });
  }
}


class CustomSliverDelegate extends SliverPersistentHeaderDelegate{
  final double expandedHeight;
  const CustomSliverDelegate({@required this.expandedHeight});
  @override
  Widget build(BuildContext context,
      double shrinkOffset,
      bool overlapsContent) {
    // TODO: implement build
    final size=60;
    final top=expandedHeight - shrinkOffset-size/2 ;
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [buildBackground(shrinkOffset),BuildAppbar(shrinkOffset),
        ],
    );
  }
  double appear(double shrinkoffset)=>shrinkoffset/expandedHeight;
  double disappear(double shrinkoffset)=> 1-shrinkoffset/expandedHeight;


  Widget BuildAppbar(double shrinkoffset)=>Opacity(
    opacity: appear(shrinkoffset),
    child: AppBar(backgroundColor: Colors.black,
      title: Text("IIT Goa"),
      centerTitle: true,
    ),
  );

  Widget buildBackground(double shrinkoffset)=>Opacity(opacity: disappear(shrinkoffset),
      child:Image.network(
        'https://source.unsplash.com/random?mono+dark',
        fit: BoxFit.cover,
      ));




  @override
  // TODO: implement maxExtent
  double get maxExtent => expandedHeight;

  @override
  // TODO: implement minExtent
  double get minExtent => kToolbarHeight + 30;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate)=>true;
}



