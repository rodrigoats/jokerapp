
import 'dart:math';

import 'package:flutter/material.dart';

class EndingWidget extends StatefulWidget {

  EndingWidget({this.prize});
  int prize;
  @override
  State<StatefulWidget> createState() {
    return EndingWidgetState();
  }
}

class EndingWidgetState extends State<EndingWidget> with SingleTickerProviderStateMixin{

  Animation<double> animation;
  AnimationController controller;


  @override
  void initState() {
     controller = new AnimationController(
      duration: Duration(seconds: 3),
      vsync: this
    );

    animation = Tween<double>(
      begin: 1,
      end: 1.5,
    ).animate(controller)
        ..addListener((){
          setState(() {});
        });
     super.initState();
     controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: animation.value,
      child: cardWidget(context),
    );
  }

  Widget cardWidget(BuildContext context){
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width/2,
        height: MediaQuery.of(context).size.height/2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.0),),
          image: DecorationImage(image: ExactAssetImage('images/card.png'),fit: BoxFit.contain,),
        ),
        alignment: Alignment.topCenter,
        child: Center(
          child:Text(widget.prize.toString() + ' €',
            style: TextStyle(
              color: Colors.yellow,
              fontSize: 55,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}