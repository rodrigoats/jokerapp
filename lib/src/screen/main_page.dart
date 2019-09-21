import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:frideos/frideos.dart';

import '../model/appState.dart';
import '../model/category.dart';


class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of<AppState>(context);


    return Scaffold(
      /*drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Settings'),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              title: _getCategoriesDropDown(context,appState)
            ),
          ],
        ),
      ),*/
      /*appBar: AppBar(
        title: Text('Joker'),
        leading: Icon(Icons.menu),
      ),*/
      body: Stack(
        children: <Widget>[
          Positioned(
            top: MediaQuery.of(context).padding.top.toDouble()/2,
            left: MediaQuery.of(context).padding.top.toDouble(),
            child: Image.asset('images/fallingcoins2.png',height: MediaQuery.of(context).size.width/5,),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top.toDouble()*2.5,
            left: MediaQuery.of(context).padding.top.toDouble()/20,
            child: Image.asset('images/fallingcoins.png',height: MediaQuery.of(context).size.width/3.5,),
          ),
          Positioned(
            height: MediaQuery.of(context).size.height/3,
            width: MediaQuery.of(context).size.width/2,
            top: MediaQuery.of(context).size.height/6,
            left: MediaQuery.of(context).size.width/4,
            child: Image.asset('images/joker.png'),
          ),
          Positioned(
            height: MediaQuery.of(context).size.height/3,
            width: MediaQuery.of(context).size.width/4,
            top: MediaQuery.of(context).padding.top.toDouble()*5.5,
            left: MediaQuery.of(context).size.width/2.7,
            child: FlatButton(
              onPressed: (){appState.showCategories();},
              splashColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Image.asset('images/categoriesbtn.png',),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top.toDouble()/2,
            right: MediaQuery.of(context).padding.top.toDouble(),
            child: Image.asset('images/fallingcoins2.png',height:  MediaQuery.of(context).size.width/5,),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top.toDouble()*2.5,
            right: MediaQuery.of(context).padding.top.toDouble()/20,
            child: Image.asset('images/fallingcoins.png',height: MediaQuery.of(context).size.width/3.5,),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top.toDouble()*7,
            right: MediaQuery.of(context).padding.top.toDouble()/10,
            child: FlatButton(
              onPressed: appState.startTrivia,
              child: Image.asset('images/coinplay.png',width: MediaQuery.of(context).size.height/2,height: MediaQuery.of(context).size.height/2,),
            ),
          ),
        ],
      ),
      //floatingActionButton: FloatingActionButton(onPressed:appState.startTrivia,child: Icon(Icons.arrow_forward_ios),),
      bottomNavigationBar:  Container(
        height: MediaQuery.of(context).size.height/10,
        decoration: BoxDecoration(color: Colors.white10),
          //child: Text('Aqui vai ter um adsense nao essa coisa feia'),
      ),
    );
  }
}