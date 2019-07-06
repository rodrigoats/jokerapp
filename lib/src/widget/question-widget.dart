import 'package:flutter/material.dart';
import 'package:frideos/frideos.dart';
import 'package:jocker_app/src/blocs/joker_bloc.dart';

import '../blocs/joker_bloc.dart';
import '../model/models.dart';
import '../widget/countdow_widget.dart';
import '../widget/answer_widget.dart';



class QuestionWidget extends StatelessWidget {

  const QuestionWidget({this.triviaState,this.bloc});

  final TriviaState triviaState;
  final JokerBloc bloc;

  @override
  Widget build(BuildContext context) {

    return new Container(
      padding: EdgeInsets.all(10),
      //decoration: BoxDecoration(color: Colors.white),
      child:
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _squareQuestion(context,bloc.currentQuestion.value.question,bloc),
          CountdownWidget(
              triviaState: triviaState,
              duration: bloc.countdown,
              width: MediaQuery.of(context).size.width/1.8),
              //_squaresAnswers(context,bloc),
          Expanded(
            child: ValueBuilder(
                streamed: bloc.answersAnimation,
                builder: (context, snapshot){
                  return Container(
                    child: AnswerWidget(
                      question: bloc.currentQuestion.value,
                      bloc: bloc,
                      answerAnimation: snapshot.data,
                      isJokerEnd: triviaState.isTriviaEnd,
                    ),
                  );
                }
            ),
          )
        ],
      ),
    );
  }

  Widget _squareQuestion(BuildContext context,String question, JokerBloc bloc){
    return Container(
      margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
      height:  MediaQuery.of(context).size.height/3,
      width:  MediaQuery.of(context).size.width/1.5,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(5.0),),
          gradient: LinearGradient(colors: [Color(0xff111740),Colors.blue]),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            child: _questionCard(context,bloc),
          ),
          Positioned(
            child:
            Align(
              alignment: Alignment.center,
              child: Text(
                question,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      )
    );
  }

  Widget _questionCard(BuildContext context, JokerBloc bloc) {
    int numberQuestion = bloc.triviaState.value.questionIndex;
    return new Container(
        margin:  EdgeInsets.fromLTRB(2, 2, 0, 0),
        child: Column(
          children: <Widget>[
            Text('$numberQuestion | 12',textAlign: TextAlign.center,style: TextStyle(fontSize: 12),),
          ],
        )
    );
  }
}
