import 'package:flutter/material.dart';
import 'package:frideos/frideos.dart';

import 'model/appState.dart';
import 'model/models.dart';
import 'screen/main_page.dart';
import 'screen/joker_page.dart';
import 'screen/summary_page.dart';
import 'screen/categories.dart';




class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of<AppState>(context);

    Widget _switchTab(AppTab tab, AppState appState) {

      switch(tab) {
        case AppTab.main:
          //return MainPage();
          return MainPage();
          break;
        case AppTab.joker:
          return JokerPage();
          break;
        case AppTab.categories:
          return CategoriesPage();
          break;
        case AppTab.summary:
          return SummaryPage(bloc: appState.bloc,);
          break;

        default:
          return MainPage();
      }

    }

    return ValueBuilder(
      streamed: appState.tabController,
      builder: (context, snapshot) => Scaffold(
        body: _switchTab(snapshot.data,appState),
      ),
    );
  }

}

