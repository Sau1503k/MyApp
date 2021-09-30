import 'package:MyApp/main.dart';

class SubCatModel{
  String collegename;
  String maincategory;
  String subcategory;
  String eventname;
  String collegetype;
  SubCatModel({this.collegename,this.maincategory,this.subcategory,
  this.eventname,this.collegetype});

  factory SubCatModel.fromJson(dynamic json){
    return SubCatModel(
      collegename: "${json['CollegeName']}",
      maincategory: "${json['MainCategory']}",
      subcategory: "${json['SubCategory']}",
      eventname: "${json['EventName']}",
      collegetype: "${json['collegetype']}"
    );
  }
  Map toJson()=>{
    "CollegeName":collegename,
    'MainCategory':maincategory,
    'SubCategory':subcategory,
    'EventName':eventname,
    "collegetype":collegetype
  };
}