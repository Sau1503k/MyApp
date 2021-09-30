import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class AddImages extends StatefulWidget {
  @override
  _AddImagesState createState() => _AddImagesState();
}

class _AddImagesState extends State<AddImages> {
  File _imagefile;
  final picker=ImagePicker();
  Future pickImage() async{
    final pickedfile=await picker.getImage(source: ImageSource.gallery);


    setState(() {
      _imagefile=File(pickedfile.path);
    });
  }

  Future UploadImagetofirebase(BuildContext context) async{
    String filename=basename(_imagefile.path);
    firebase_storage.Reference firebaseStorafeRef=
    firebase_storage.FirebaseStorage.instance.ref().child("uploads/$filename");
    firebase_storage.UploadTask uploadtask= firebaseStorafeRef.putFile(_imagefile);
    firebase_storage.TaskSnapshot taskSnapshot = await uploadtask.whenComplete(() => null);
    taskSnapshot.ref.getDownloadURL().then((value) => print("Done:$value"));
    setState(() {
      _imagefile=null;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: [
            _imagefile != null?Container(height: 200,width:MediaQuery.of(context).size.width,child:Image.file(_imagefile)):FlatButton(onPressed: pickImage, child: Icon(Icons.add_a_photo,size: 20,)),
            FlatButton(onPressed:()=>UploadImagetofirebase(context) ,child: Text("Upload",style: TextStyle(fontSize: 30),),)
          ],
        ),
      );
  }
}
