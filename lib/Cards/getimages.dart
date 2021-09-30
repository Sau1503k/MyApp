import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';


class GetImage extends StatefulWidget {
  String Collegetype;
  String Collegename;
  String foldername;
  String ImageName;
  GetImage({this.Collegetype,this.Collegename,this.foldername,this.ImageName});
  @override
  _GetImageState createState() => _GetImageState();
}

class _GetImageState extends State<GetImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(future: _getImage(context, "Colleges/${widget.Collegetype}/${widget.Collegename}/${widget.foldername}/${widget.ImageName}"),
      builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.done)
          return Container(
            child: snapshot.data,
          );
        if(snapshot.connectionState==ConnectionState.waiting)
          return Container(child: CircularProgressIndicator(),);
        return Container();
      },),
    );
  }
}


Future<Widget> _getImage(BuildContext context, String image) async {
  String name;
  Image m;
  await FireStorageService.loadFromStorage(context, image).then((downloadUrl) {
    m = Image.network(
      // "https://firebasestorage.googleapis.com/v0/b/myapp-86e87.appspot.com/o/Colleges%2FIIT's%2FIIT%20Goa%2FCultural%2FBrushHour.png?alt=media&token=fd94b64a-1526-4d2a-9800-05c28ee803a0"
      downloadUrl.toString()
      ,fit: BoxFit.cover,
    );
    name=downloadUrl.toString();
  });


  return m;
}


class FireStorageService extends ChangeNotifier {
  FireStorageService();

  static Future<dynamic> loadFromStorage(BuildContext context, String image) async {
    return await FirebaseStorage.instance.ref().child(image).getDownloadURL();
  }
}