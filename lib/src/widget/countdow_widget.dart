import 'package:flutter/material.dart';

import '../model/models.dart';


class CountdownWidget extends StatefulWidget {

  const CountdownWidget({@required this.width,this.duration,this.triviaState});

  final double width;
  final int duration;
  final TriviaState triviaState;

  @override
  CountdownWidgetState  createState() {
    return CountdownWidgetState();
  }
}

class CountdownWidgetState extends State<CountdownWidget> with SingleTickerProviderStateMixin{
  Animation<double> animation;
  AnimationController controller;
  Color color;
  final double countdownBarHeight = 8.0;

  @override
  void initState(){
    super.initState();

    controller = AnimationController(
        duration: Duration(milliseconds: widget.duration),
        vsync: this);
    animation = Tween<double>(
      begin: widget.width,
      end: 0
    ).animate(controller)
      ..addListener((){
        setState(() {
          final value = (animation.value ~/2).toInt();
          color = Color.fromRGBO(255 - value, value > 255 ? 255 :value, 0, 1);
        });
        if(widget.triviaState.isAnswerChosen){
          controller.stop();
        }
      });
    color = Colors.green;
  }

  @override
  void didUpdateWidget(CountdownWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    color = Colors.green;
    if(widget.triviaState.isAnswerChosen){
      controller.stop();
    }else{
      controller
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     return Row(
       children: <Widget>[
         Container(
           height: countdownBarHeight,
           width: animation.value,
           child: Container(
             color: color,
           ),
         )
       ],
     );
  }
}