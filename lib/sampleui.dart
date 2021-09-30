import 'package:MyApp/smart_flare_animation.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class sampleui extends StatefulWidget {
  @override
  _sampleuiState createState() => _sampleuiState();
}

class _sampleuiState extends State<sampleui> {
  bool _isopen=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 102, 18, 222),
      body:Align(alignment: AlignmentDirectional.bottomCenter,
          child: SmartFlareAnimation())
    );
  }
}
