import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

TextStyle simpleText(){
  return TextStyle(
    color: Colors.black54,
    fontSize: 22,
    letterSpacing: 1
  );
}

InputDecoration textFieldInputDecoration(String hintText){
  return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
          color:Colors.black
      ),
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:Colors.black54))

  );
}

TextStyle simpleTextStyle(){
  return TextStyle(color: Colors.black,fontSize: 16);
}
