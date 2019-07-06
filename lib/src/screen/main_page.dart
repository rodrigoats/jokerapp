import 'package:flutter/material.dart';
import 'package:frideos/frideos.dart';

import '../model/appState.dart';


class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of<AppState>(context);


    return Scaffold(
      appBar: AppBar(
        title: Text('Joker'),
        leading: Icon(Icons.widgets),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            height: 100,
            top: 10,
            left: MediaQuery.of(context).size.width/3.5,
            child: Image.asset('images/joker.png'),
          ),Positioned(
            top: 150,
            left: MediaQuery.of(context).size.width/4.2,
            child: Text('O melhor jogo do mundo ever',style: TextStyle(fontSize: 28),),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed:appState.startTrivia, child: Icon(Icons.arrow_forward_ios),),
      bottomNavigationBar:  Container(
        height: 40,
        decoration: BoxDecoration(color: Colors.blue),
          child: Text('Aqui vai ter um adsense nao essa coisa feia'),
      ),
    );
  }
}