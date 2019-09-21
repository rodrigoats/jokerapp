import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import '../blocs/joker_bloc.dart';

import '../model/appState.dart';
import '../widget/ending_widget.dart';


class SummaryPage extends StatefulWidget{

  SummaryPage({this.bloc});
  final JokerBloc bloc;

  @override
  _SummaryPage createState() => _SummaryPage();
}

class _SummaryPage extends State<SummaryPage> with TickerProviderStateMixin{

  Animation<Offset> animation;
  AnimationController controller;

  var offset = Offset(0,-1);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: Duration(milliseconds: 5000),vsync: this,);
    _initAnimation();
  }

  void _initAnimation() async {
    animation = _getOffsetAnimation(controller);

    animation = Tween<Offset>(
        begin: Offset(0, -1),
        end:  Offset(0, 0)
    ).animate(controller)
      ..addListener((){
        setState(() {
          offset = animation.value;
        });
      })..addStatusListener((status){
        if(status == AnimationStatus.completed)
          controller.stop();
      });
  }

  Animation<Offset> _getOffsetAnimation(AnimationController cont){

    return  Tween<Offset>(
        begin: Offset(0, -1),
        end:  Offset(0, 0)
    ).animate(cont);
  }

  @override
  Widget build(BuildContext context) {
    return EndingWidget(prize: widget.bloc.getPrize(),);
  }

}






