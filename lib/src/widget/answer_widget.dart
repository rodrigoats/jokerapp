import 'package:flutter/material.dart';

import '../blocs/joker_bloc.dart';
import '../model/question.dart';
import '../model/models.dart';

class AnswerWidget extends StatefulWidget {

  const AnswerWidget({this.question, this.bloc,this.answerAnimation, this.isJokerEnd});

  final Question question;
  final JokerBloc bloc;
  final AnswerAnimation answerAnimation;
  final bool isJokerEnd;

  @override
  _AnswerWidgetState createState() => _AnswerWidgetState();

}

class _AnswerWidgetState extends State<AnswerWidget> with TickerProviderStateMixin {

  bool isCorrect = false;

  AnimationController controller;
  Animation<Color> colorAnimation;
  Animation<Color> colorAnimationCorrect;

  Color color;
  Color answerBoxColor =  Color(0xff111740);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration : Duration(milliseconds: 3000),vsync: this);
    _initAnimation();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initAnimation();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _checkCorrectAnswer(){
    isCorrect = widget.question.correctAnswerIndex == widget.answerAnimation.chosenAnswerIndex ? true : false;
  }

  Future _initAnimation() async {
    colorAnimation = ColorTween(
      begin: answerBoxColor,
      end: answerBoxColor,
    ).animate(controller);

    colorAnimationCorrect = ColorTween(
      begin: answerBoxColor,
      end: answerBoxColor,
    ).animate(controller);

  }

  Future _startAnimation() async {

    var newColor;

    _checkCorrectAnswer();
    controller.reset();

    if(isCorrect) {
      newColor = Colors.green;
    } else {
      newColor = Colors.red;
    }

    colorAnimation =  TweenSequence<Color>(
      [
        TweenSequenceItem(
            weight: 1.0,
            tween: ColorTween(
                begin: answerBoxColor,
                end: newColor
            )
        ),TweenSequenceItem(
          weight: 1.0,
          tween: ColorTween(
              begin: newColor,
              end: answerBoxColor
          )
      ),TweenSequenceItem(
          weight: 1.0,
          tween: ColorTween(
              begin: answerBoxColor,
              end: newColor
          )
      ),TweenSequenceItem(
          weight: 1.0,
          tween: ColorTween(
              begin: newColor,
              end: answerBoxColor
          )
      )
      ]
    ).animate(controller);

    colorAnimationCorrect =  TweenSequence<Color>(
        [
          TweenSequenceItem(
              weight: 1.0,
              tween: ColorTween(
                  begin: answerBoxColor,
                  end: Colors.green
              )
          ),TweenSequenceItem(
            weight: 1.0,
            tween: ColorTween(
                begin: Colors.green,
                end: answerBoxColor
            )
        ),TweenSequenceItem(
            weight: 1.0,
            tween: ColorTween(
                begin: answerBoxColor,
                end: Colors.green
            )
        ),TweenSequenceItem(
            weight: 1.0,
            tween: ColorTween(
                begin: Colors.green,
                end: answerBoxColor
            )
        )
        ]
    ).animate(controller)..addListener((){
      setState(() {});
    })..addStatusListener((status){
      if(status == AnimationStatus.completed && widget.bloc.triviaState.value.isAnswerChosen){
        if(!isCorrect){
          widget.bloc.onChosenAnswerAnimationEnd();
        }
        controller.reset();
      }
    });

    await controller.forward();
  }

  @override
  void didUpdateWidget(AnswerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void _playAnimation(String answer) async {
    widget.bloc.onChosenAnswer(answer);
    widget.bloc.answered = true;
    if(widget.question.isCorrect(widget.bloc.chosenAnswer)){
      widget.bloc.answersAnimation.value.startPlaying = true;
    }

    await _startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    int index = 0;
    double boxHeight = MediaQuery.of(context).size.height /6;
    double boxWidth = MediaQuery.of(context).size.width /3.7;
      return Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                GestureDetector(
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height /18),
                        height: boxHeight,
                        width: boxWidth,
                        margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            gradient: LinearGradient(
                              colors: _getColor(index++),
                            ),
                        ),
                        child:Text(widget.question.answers[0],style: TextStyle(color: Colors.white,fontFamily: 'Roboto',fontSize: 16),textAlign: TextAlign.center, ),
                      )
                    ],
                  ),
                  onTap: () {
                    if(!widget.isJokerEnd && !widget.bloc.answered){
                      _playAnimation(widget.question.answers[0]);
                    }
                  },
                ),GestureDetector(
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height /18),
                        height: boxHeight,
                        width: boxWidth,
                        margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(5.0),),
                            gradient: LinearGradient(
                              colors: _getColor(index++),
                            ),
                        ),
                        child:Text(widget.question.answers[1],style: TextStyle(color: Colors.white,fontFamily: 'Roboto',fontSize: 16),textAlign: TextAlign.center,),
                      )
                    ],
                  ),
                  onTap: () {
                    if(!widget.isJokerEnd && !widget.bloc.answered){
                      _playAnimation(widget.question.answers[1]);
                    }
                  },
                )
              ],
            ),
            Row(
              children: <Widget>[
                GestureDetector(
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height /18),
                        height: boxHeight,
                        width: boxWidth,
                        margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            gradient: LinearGradient(
                              colors: _getColor(index++),
                            ),
                        ),
                        child:Text(widget.question.answers[2],style: TextStyle(color: Colors.white,fontFamily: 'Roboto',fontSize: 16),textAlign: TextAlign.center,),
                      )
                    ],
                  ),
                  onTap: () {
                    if(!widget.isJokerEnd && !widget.bloc.answered){
                      _playAnimation(widget.question.answers[2]);
                    }
                  },
                ),GestureDetector(
                  child: Row(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height /18),
                          height: boxHeight,
                          width: boxWidth,
                          margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: _getColor(index),
                              ),
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          ),
                          child:Text(widget.question.answers[3],style: TextStyle(color: Colors.white,fontFamily: 'Roboto',fontSize: 16),textAlign: TextAlign.center,),
                        ),
                    ],
                  ),
                  onTap: () {
                    if(!widget.isJokerEnd && !widget.bloc.answered){
                      _playAnimation(widget.question.answers[3]);
                    }
                  },
                )
              ],
            )
          ],
        ),
      );
  }

  List<Color> _getColor(int index){
    if(index == widget.answerAnimation.chosenAnswerIndex)
      return [colorAnimation.value, Colors.blue];
    if(index == widget.question.correctAnswerIndex)
      return [colorAnimationCorrect.value, Colors.blue];
    return [answerBoxColor, Colors.blue];
  }

}
