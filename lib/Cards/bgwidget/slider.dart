import 'package:MyApp/Cards/HomePAGE/HomePage.dart';
import 'package:MyApp/Cards/bgwidget/bgwidget.dart';
import 'package:MyApp/Cards/bgwidget/frontwidget.dart';
import 'package:flutter/material.dart';


class slider extends StatefulWidget {

  @override
  _sliderState createState() => _sliderState();
}

class _sliderState extends State<slider> with TickerProviderStateMixin{
  double MAX_LEFT=0;
  double left=0;
  double direction;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context){
        MAX_LEFT=MediaQuery.of(context).size.width*1.0-80;
        return _buildbody();
      }),
    );
  }
  _buildbody(){
    return GestureDetector(onHorizontalDragUpdate: (update){
      left=left + update.delta.dx;
      if(left<=0){
        left=0;
      }
      if(left>MAX_LEFT){
        left=MAX_LEFT;
      }
    },
    onHorizontalDragEnd: (end){

    },
    child: Container(
      color: Colors.black,
      child: Stack(
        children: [Container(child:BgWidget(open)),
        // Positioned(left: left,top: left*0.2,bottom:left*0.2, child: HomePage())
        ],
      ),
    ),);
  }
  void open(){
    if(left==MAX_LEFT){
      direction=1;
    }else{
      direction=0;
    }
    animatedWidget();
  }
  Animation _animation;
  void animatedWidget(){
    bool increment=direction<=0;
    AnimationController _controller=AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300))..addListener(() {
        left=_animation.value;
    });
    double temp_left=left;
    _animation = Tween(
      begin: temp_left,
      end: !increment? MAX_LEFT:0.0
    ).animate(CurvedAnimation(curve: Curves.fastLinearToSlowEaseIn,parent: _controller));
    _controller.forward();
  }
}
