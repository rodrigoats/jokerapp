import 'package:flutter/material.dart';
import 'package:frideos/frideos.dart';

import '../model/appState.dart';
import '../widget/question-widget.dart';
import '../widget/column_left_widget.dart';
import '../widget/column_right_widget.dart';
import '../model/models.dart';
import '../model/question.dart';



class JokerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = AppStateProvider.of<AppState>(context).bloc;

    return ValueBuilder<TriviaState>(
      streamed: bloc.triviaState,
      builder: (context, snapShotTrivia) {
        return ValueBuilder<Question>(
          streamed: bloc.currentQuestion,
          builder: (context, snapShotQuestion){
            return Container(
              child: JokerMain(
                triviaState: snapShotTrivia.data,
                question: snapShotQuestion.data,
                bloc: bloc,
              ),
            );
          },
        );
      },
    );
  }
}


class JokerMain extends StatelessWidget {

  const JokerMain({this.triviaState, this.question,this.bloc});

  final TriviaState triviaState;
  final Question question;
  final bloc;

  @override
  Widget build(BuildContext context) {

    return Container(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: ColumnLeftWidget(bloc: bloc,)//_listViewLeft(context,bloc),
            ),
            Expanded(
              flex: 6,
              child: QuestionWidget(triviaState: triviaState,bloc: bloc,),
            ),
            Expanded(
              flex: 2,
              child: ColumnRightWidget(bloc: bloc),//_listViewRight(context,bloc),
            )
          ],
        ),
      );
  }
}