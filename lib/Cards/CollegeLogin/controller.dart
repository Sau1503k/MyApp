import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'CollegeClass.dart';


class FormController{
  final void Function(String) callback;

  FormController(this.callback);
  static const String URL="https://script.google.com/macros/s/AKfycbxjvQF6tgalECWxJqaZZoOwgDTA6SWWvs5p23WURN-Rd899xfANoIBVIBJYtEhGZI0_zg/exec"
      // z"https://script.google.com/macros/s/AKfycbxEpM1FV2UMXn3LbtA9hYJJ_X9CtjRJUNxdfFuYknwZWvKz9QV0-DEQFKisho_AlQ4kew/exec"
  ;
  static const STATUS_SUCCESS="SUCCESS";
  void submitform(CollegeDetails Feedbacks)async{
    try{
      await http.get(URL + Feedbacks.toParams()).then((response){
        callback(convert.jsonDecode(response.body)["status"]);
      });
    }catch(e){
      print(e);

    }

  }

}
