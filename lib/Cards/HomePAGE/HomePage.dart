import 'dart:core';

import 'package:MyApp/Classes/Categorys.dart';
import 'package:MyApp/Services/Auth.dart';
import 'package:MyApp/hekper/authentication.dart';
import 'package:MyApp/helper/data.dart';
import 'package:MyApp/helper/loadingimages.dart';
import 'package:MyApp/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthMethod authMethod=AuthMethod();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(padding: EdgeInsets.only(top:20),
        child: SingleChildScrollView(
          child: Column(
            children: [Padding(
              padding: const EdgeInsets.symmetric(vertical:8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [GestureDetector(onTap: (){},child: Icon(Icons.menu)),
                GestureDetector(onTap: (){
                  authMethod.signout();
                  Navigator.pushReplacement(
                      context,MaterialPageRoute(builder:(context)=>Authenticate()) );
                },child: Icon(Icons.exit_to_app))],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical:7.0),
              child: Category(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:10.0,vertical:8),
              child: AddBar(),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical:10.0,horizontal: 10),
            //   child: BigEvents(),
            // )
            ],
          ),
        ),

      ),
    );
  }
}
class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<category> categorie = new List<category>();

  @override
  void initState() {
    categorie=getCategoryModel();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView.builder(scrollDirection: Axis.horizontal,itemCount:categorie.length
          ,itemBuilder: (context,index){
        return  CategoryTile(
          ImageUrl: categorie[index].imageUrl,
          categoryname: categorie[index].Category,
        );
      }),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String ImageUrl,categoryname;
  CategoryTile({this.ImageUrl,this.categoryname});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 14),
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
              child: ExtractImages(imageurl: ImageUrl,),
                // width: 120,
                width:MediaQuery.of(context).size.width/4,
                // height: 60,
                height: 90,
              )),
          Container(
            alignment: Alignment.center,
            height:90,
            width:MediaQuery.of(context).size.width/4,
            decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(15)),
            child: Text(
              "${categoryname}",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}


class ExtractImages extends StatefulWidget {
  String imageurl;
  ExtractImages({this.imageurl});

  @override
  _ExtractImagesState createState() => _ExtractImagesState();
}

class _ExtractImagesState extends State<ExtractImages> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(future:_getImage(context, widget.imageurl)
        ,            builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.done)
            return Container(
              height:
              MediaQuery.of(context).size.height / 1.25,
              width:
              MediaQuery.of(context).size.width / 1.25,
              child: snapshot.data,
            );

          if (snapshot.connectionState ==
              ConnectionState.waiting)
            return Container(
                // height: MediaQuery.of(context).size.height /
                //     1.25,
                // width: MediaQuery.of(context).size.width /
                //     1.25,
                child: CircularProgressIndicator());

          return Container();
        },),
    );
  }
}
Future<Widget> _getImage(BuildContext context, String image) async {
  Image m;
  await FireStorageService.loadFromStorage(context, image).then((downloadUrl) {
    m = Image.network(
      downloadUrl.toString(),
      fit: BoxFit.cover,
    );
  });

  return m;
}

class AddBar extends StatefulWidget {
  @override
  _AddBarState createState() => _AddBarState();
}

class _AddBarState extends State<AddBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/3,
      width: MediaQuery.of(context).size.width,
      color: Colors.orange,
      child: Stack(
        children: [Positioned(left: 5,child: Text("LATEST EVENTS",style: simpleText(),)),
        Positioned(top: 30,child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: MediaQuery.of(context).size.height/3-50,
            width:MediaQuery.of(context).size.width-35,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20,
              ),
              color: Colors.blue,
            ),
          ),
        ))],
      ),
    );
  }
}



class BigEvents extends StatefulWidget {
  @override
  _BigEventsState createState() => _BigEventsState();
}

class _BigEventsState extends State<BigEvents> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height:MediaQuery.of(context).size.height/3.5,
      width: MediaQuery.of(context).size.width,
      color:Colors.greenAccent,
      child: Stack(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("Interested",style: TextStyle(fontSize: 25,color: Colors.black54)),
            Text("ViewAll",style: TextStyle(fontSize:25,color: Colors.black54),)],
          ),
          Positioned(
            top: 30,
            child: ListView.builder(shrinkWrap: true,itemBuilder: (context,index){
              return EventTile();
            }),
          )

        ],
      ),
    );
  }
}


class EventTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}








