import 'package:flutter/material.dart';
import 'package:frideos/frideos.dart';

import '../model/appState.dart';
import '../widget/question-widget.dart';
import '../widget/summary_widget.dart';
import '../model/models.dart';
import '../model/question.dart';
import '../blocs/joker_bloc.dart';


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
              child: _listViewRight(context,bloc),
            )
          ],
        ),
      );
  }


  Widget _listViewLeft(BuildContext ctx, JokerBloc bloc) {

    return ListView.builder(
        itemCount: 7,
        itemExtent: 45,
        padding: EdgeInsets.all(10),
        itemBuilder: (context, index){
          return ListTile(
              title:  index < bloc.getLeftColumn() ? _itemListAnimatedLeft(false): _itemListAnimatedLeft(true),
          );
        });
  }

  Widget _itemListAnimatedLeft(bool first) {
    return AnimatedCrossFade(
      firstChild: Image.asset('images/joker.png'),
      secondChild: Image.asset('images/joker-pb.png'),
      crossFadeState: first ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: Duration(milliseconds: 1000),
    );
  }

  Widget _listViewRight(BuildContext ctx, JokerBloc bloc) {
    var landingPb = [
      'images/cinquentamil-pb.png',
      'images/dezmil-pb.png',
      'images/tresmil-pb.png',
      'images/mil-pb.png',
      'images/quinhentos-pb.png',
      'images/duzentos-pb.png',
      'images/zero-pb.png',
    ];
    var landing = [
      'images/cinquentamil.png',
      'images/dezmil.png',
      'images/tresmil.png',
      'images/mil.png',
      'images/quinhentos.png',
      'images/duzentos.png',
      'images/zero.png',
    ];

    return ListView.builder(
        itemCount: 7,
        itemExtent: 45,
        itemBuilder: (context, index){
          return ListTile(
           title: bloc.getRightColumn() == index ? _itemAnimatedListRight(landing,landingPb,index, true): _itemAnimatedListRight(landing,landingPb,index, false),
            //title: _itemAnimatedListRight(landing,landingPb,index, true),
          );
        });
  }

  Widget _itemAnimatedListRight(var landing, var landingPb, int index, bool first) {
    return AnimatedCrossFade(
      firstChild: Image.asset(landing[index]),
      secondChild: Image.asset(landingPb[index]),
      crossFadeState: first ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: Duration(milliseconds: 1000),
    );
  }

}