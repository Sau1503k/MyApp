import 'package:MyApp/Cards/CHomePage/AddEvents.dart';
import 'package:MyApp/Cards/EventPage/Paths.dart';
import 'package:MyApp/Cards/EventPage/Posters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CHomePage extends StatefulWidget {
  String collegename;
  String Category;
  CHomePage(this.collegename,this.Category);
  @override
  _CHomePageState createState() => _CHomePageState();
}

class _CHomePageState extends State<CHomePage> with TickerProviderStateMixin{
  TabController _tabController;
  DatabaseMethods databaseMethods=DatabaseMethods();
  var eventstream;

  Widget CHomePageView(){
    return  Container(height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Card(margin: EdgeInsets.symmetric(horizontal:0,vertical: 10),
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30)
          ),
          child: StreamBuilder(stream: eventstream,builder: (context,snapshot){

            return snapshot.hasData?Padding(
              padding: const EdgeInsets.only(left:8.0,right:8,top:10,bottom: 150),
              child: ListView.builder(itemCount: snapshot.data.docs.length,itemBuilder: (context,index){
                return Container(height: MediaQuery.of(context).size.height/2,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal:0,vertical: 10),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)
                    ),
                    child: Column(
                      children:[
                        // Poster(),
                        Center(child: Text(snapshot.data.docs[index]["EventName"]))]
                    ),
                  ),
                );
              })

            ):Container(height:50,width:50,child: CircularProgressIndicator()) ;
          }),
        ),
      );
  }


  @override
  void initState() {
    _tabController=TabController(length:6, vsync: this);
    super.initState();
    geteventinfo();
  }

  geteventinfo() async{
    await databaseMethods.getMainCategoryEvents(widget.collegename,
        widget.Category).then((val){
      setState(() {
        eventstream=val;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(floatingActionButton: FloatingActionButton(onPressed: (){
      Navigator.of(context).push(MaterialPageRoute(builder: (context){
        return AddEvent();
      }));
    },
    child: Icon(Icons.add),),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [SizedBox(height: 50,),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Events",style: TextStyle(fontSize: 30),)],),
            SizedBox(height:30,),
              SizedBox(height: 40,
              child: TabBar(isScrollable: true,
                  labelColor: Colors.grey,
                  controller: _tabController,
                  tabs: [Tab(child: Text("Cultural",style: TextStyle(fontSize: 15),),),
                    Tab(child: Text("Technical",style: TextStyle(fontSize: 15)),),
                    Tab(child: Text("Esports",style: TextStyle(fontSize: 15),),),
                    Tab(child: Text("Sports",style: TextStyle(fontSize: 15),),),
                    Tab(child: Text("Workshop",style: TextStyle(fontSize: 15),),),
                    Tab(child: Text("ProEvents",style: TextStyle(fontSize: 15),),)]),),
              SizedBox(height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.height,
                child: TabBarView(controller: _tabController,
                children: [CHomePageView(),
                  _buildContainer(),
                  _buildContainer(),
                _buildContainer(),
                  _buildContainer(),
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
        margin: EdgeInsets.symmetric(horizontal:0,vertical: 10),
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
        ),
        child: Text(""),
      ),
    );
  }


}

