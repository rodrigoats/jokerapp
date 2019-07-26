import 'package:flutter/material.dart';
import 'dart:async';
import '../blocs/joker_bloc.dart';


class RollingNumbers extends StatefulWidget{

  RollingNumbers({this.value,this.bloc});
  final double value;
  final JokerBloc bloc;
  @override
  State<StatefulWidget> createState() {
    return RollingNumbersSate();
  }
}

class RollingNumbersSate extends State<RollingNumbers> with SingleTickerProviderStateMixin {

  Animation<double> animation;
  AnimationController controller;


  @override
  void initState() {
    controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300)
    );
    animation = Tween<double>(begin: 0, end: widget.value)
        .animate(controller)..addListener((){
          setState(() {});
    })..addStatusListener((status){

      if(status == AnimationStatus.completed){
        widget.bloc.answersAnimation.value.startPlayingHero = true;
        Navigator.of(context).pop();
        widget.bloc.onChosenAnswerAnimationEnd();
        controller.reset();
      }
    });
    controller.forward();
    super.initState();
  }

  @override
  void didUpdateWidget(RollingNumbers oldWidget) {
    super.didUpdateWidget(oldWidget);
    controller.reset();
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child:Text(animation.value.toStringAsFixed(0) + ' €',
        style: TextStyle(
          color: Colors.yellow,
          fontSize: 120,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

