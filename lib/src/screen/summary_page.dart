import 'package:flutter/material.dart';

import 'package:frideos/frideos.dart';
import '../widget/summary_widget.dart';
import '../model/appState.dart';


var landing = [
  'images/cinquentamil.png',
  'images/dezmil.png',
  'images/tresmil.png',
  'images/mil.png',
  'images/quinhentos.png',
  'images/duzentos.png',
  'images/zero.png',
];

class SummaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = AppStateProvider.of<AppState>(context).bloc;

    return Scaffold(
      body: ColumnLeftWidget(bloc: bloc,),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.flight),
          onPressed: () {
          print('Pressed');
         // bloc.startLeftColumnAnimation = !bloc.startLeftColumnAnimation;
          }
      )
    );

  }

}