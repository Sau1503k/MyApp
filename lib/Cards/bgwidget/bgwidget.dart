import 'package:flutter/material.dart';

class BgWidget extends StatefulWidget {
  Function close;
  BgWidget(this.close);
  @override
  _BgWidgetState createState() => _BgWidgetState();
}

class _BgWidgetState extends State<BgWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(height: double.infinity,
    width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [SizedBox(height: 200,),
            Row(
              children: [GestureDetector(onTap: widget.close,
              child:Icon(Icons.arrow_back,color: Colors.white,),),
                CircleAvatar(
                  child: FlutterLogo(),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Saurabh Kuradkar",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16
                      ),),
                    Text("Open Dashboard",
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 12
                      ),)
                  ],
                )
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Text("Profile",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16
              ),),
            SizedBox(
              height: 20,
            ),
            Text("Help",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16
              ),),
            SizedBox(
              height: 20,
            ),
            Text("Support",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16
              ),),
            SizedBox(
              height: 20,
            ),
            Text("Contact",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16
              ),),
            SizedBox(
              height: 20,
            ),
            Text("Promote",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16
              ),),
            SizedBox(
              height: 20,
            ),
            Text("Connect",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16
              ),),
            SizedBox(
              height: 20,
            ),
            Text("IIT",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16
              ),),
            SizedBox(
              height: 20,
            ),
            Text("Medical",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16
              ),),
            SizedBox(
              height: 20,
            ),
            Text("NIT",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16
              ),),
            SizedBox(
              height: 20,
            ),
            Text("Other Colleges",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16
              ),),
            SizedBox(
              height: 20,
            ),
            Text("Report",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16
              ),),
            SizedBox(
              height: 20,
            ),
            Text("Suggestion",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16
              ),),

          ],
        ),
      ),
    );
  }
}
