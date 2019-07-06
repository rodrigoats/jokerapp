import 'package:flutter/material.dart';

import '../blocs/joker_bloc.dart';
import '../model/question.dart';
import '../model/models.dart';

const questionsLeading = ['A','B','C','D'];
const boxHeight = 72.0;

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

  final Map<int, Animation<double>> animations = {};
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
    ).animate(controller);

    await controller.forward().orCancel;
    
  }

  @override
  void didUpdateWidget(AnswerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void _playAnimation(String answer) async {
    widget.bloc.onChosenAnswer(answer);
    await _startAnimation();
  }

  @override
  Widget build(BuildContext context) {
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
                              colors: [(0 == widget.answerAnimation.chosenAnswerIndex) ? colorAnimation.value : (0 == widget.question.correctAnswerIndex) ? colorAnimationCorrect.value : answerBoxColor, Colors.blue],
                            ),
                        ),
                        child:Text(widget.question.answers[0],style: TextStyle(color: Colors.white,fontFamily: 'Roboto',fontSize: 16),textAlign: TextAlign.center, ),
                      )
                    ],
                  ),
                  onTap: () {
                    if(!widget.isJokerEnd){
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
                              colors: [(1 == widget.answerAnimation.chosenAnswerIndex) ? colorAnimation.value : (1 == widget.question.correctAnswerIndex) ? colorAnimationCorrect.value : answerBoxColor, Colors.blue],
                            ),
                        ),
                        child:Text(widget.question.answers[1],style: TextStyle(color: Colors.white,fontFamily: 'Roboto',fontSize: 16),textAlign: TextAlign.center,),
                      )
                    ],
                  ),
                  onTap: () {
                    if(!widget.isJokerEnd){
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
                              colors: [(2 == widget.answerAnimation.chosenAnswerIndex) ? colorAnimation.value : (2 == widget.question.correctAnswerIndex) ? colorAnimationCorrect.value : answerBoxColor, Colors.blue],
                            ),
                        ),
                        child:Text(widget.question.answers[2],style: TextStyle(color: Colors.white,fontFamily: 'Roboto',fontSize: 16),textAlign: TextAlign.center,),
                      )
                    ],
                  ),
                  onTap: () {
                    if(!widget.isJokerEnd){
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
                                  colors: [(3 == widget.answerAnimation.chosenAnswerIndex) ? colorAnimation.value : (3 == widget.question.correctAnswerIndex) ? colorAnimationCorrect.value : answerBoxColor, Colors.blue],
                              ),
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          ),
                          child:Text(widget.question.answers[3],style: TextStyle(color: Colors.white,fontFamily: 'Roboto',fontSize: 16),textAlign: TextAlign.center,),
                        ),
                    ],
                  ),
                  onTap: () {
                    if(!widget.isJokerEnd){
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
}
