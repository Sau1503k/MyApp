import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';


class Poster extends StatefulWidget {
  @override
  _PosterState createState() => _PosterState();
}

class _PosterState extends State<Poster> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/1.9,
      width:MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        //   boxShadow: [BoxShadow(color: Colors.blue
        // ,blurRadius: 10,offset: const Offset(0,10)),
        // ],
        // color:Colors.blueGrey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: FutureBuilder(future:_getImage(context, "Colleges/IIT's/IIT Goa/"
          "Cultural/film_wars.png"),
          builder: (context, snapshot) {
            if (snapshot.connectionState ==
                ConnectionState.done)
              return Container(
                height:
                MediaQuery.of(context).size.height ,
                width: MediaQuery.of(context).size.width,
                child: snapshot.data,
              );

            if (snapshot.connectionState ==
                ConnectionState.waiting)
              return Container(
                // height: MediaQuery.of(context).size.height,
                // width: MediaQuery.of(context).size.width,

                  child: CircularProgressIndicator());

            return Container();
          }),);
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
  print("${name} jsjdsajdfkjhashdfiuhaiushdfluhasuf");

  return m;
}



class FireStorageService extends ChangeNotifier {
  FireStorageService();

  static Future<dynamic> loadFromStorage(BuildContext context, String image) async {
    return await FirebaseStorage.instance.ref().child(image).getDownloadURL();
  }
}
