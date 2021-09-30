import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';


enum AnimationToPlay{
  Activate,
  Deactivate,
  CameraTapped,
  PulseTapped,
  ImageTapped
}

class SmartFlareAnimation extends StatefulWidget {
  @override
  _SmartFlareAnimationState createState() => _SmartFlareAnimationState();
}

class _SmartFlareAnimationState extends State<SmartFlareAnimation> {
  bool _isopen=false;
  final FlareControls animationcontrols=FlareControls();
  AnimationToPlay _animationToPlay=AnimationToPlay.Deactivate;
  AnimationToPlay _lastPlayedAnimation;
  static const double AnimationWidth=295.0;
  static const double AnimationHeight=251.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: AnimationWidth,
      height: AnimationHeight,
      child: GestureDetector(onTapUp: (tapinfo){
        setState(() {
          var localTouchPosition=(context.findRenderObject() as RenderBox).
          globalToLocal(tapinfo.globalPosition);
          var topHalfTouched= localTouchPosition.dy < AnimationHeight/2;
          var leftSideTouched = localTouchPosition.dx<AnimationWidth/3;
          var rightSideTouched = localTouchPosition.dx> (AnimationWidth/3)*2;
          var middleTouched=!leftSideTouched && !rightSideTouched;

          if(leftSideTouched && topHalfTouched){
            print("TopLeft");
            _setAnimationToPlay(AnimationToPlay.CameraTapped);
          }else if(middleTouched && topHalfTouched){
            print("TopMiddle");
            _setAnimationToPlay(AnimationToPlay.PulseTapped);
          }else if(rightSideTouched && topHalfTouched){
            print("TopRight");
            _setAnimationToPlay(AnimationToPlay.ImageTapped);
          }else{
            if(_isopen){
              print("Bottom Close");
              _setAnimationToPlay(AnimationToPlay.Deactivate);
            }else{
              print("Bottom Open");
              _setAnimationToPlay(AnimationToPlay.Activate);
            }
            _isopen=!_isopen;
          }
        });
        // setState(() {
        //   _isopen=!_isopen;
        // });

      },
          child: FlareActor("images/button-animation.flr",
              controller: animationcontrols,
              animation:_getanimaitonName(_animationToPlay)
          // _isopen?"activate":"deactivate",
          )),
    );
  }
  String _getanimaitonName(AnimationToPlay animationToPlay){
    switch (animationToPlay){
      case AnimationToPlay.Activate:
        return "activate";
      case AnimationToPlay.Deactivate:
        return "deactivate";
      case AnimationToPlay.CameraTapped:
        return "camera_tapped";
      case AnimationToPlay.PulseTapped:
        return "pulse_tapped";
      case AnimationToPlay.ImageTapped:
        return "image_tapped";
      default:
        return "deactivate";

    }
  }
  void _setAnimationToPlay(AnimationToPlay animation){
    var isTappedAnimation = _getanimaitonName(animation).contains("_tapped");
    if(isTappedAnimation && _lastPlayedAnimation == AnimationToPlay.Deactivate){
      return;
    }
    animationcontrols.play(_getanimaitonName(animation));
    // setState(() {
    //   _animationToPlay=animation;
    // });
    _lastPlayedAnimation = animation;
  }
}
