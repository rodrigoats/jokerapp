import 'package:flutter/material.dart';
import 'package:frideos/frideos.dart';
import 'package:jocker_app/src/model/category.dart';
import 'package:jocker_app/src/model/models.dart';
import '../model/appState.dart';


import 'package:flutter/cupertino.dart';


class CategoriesPage extends StatefulWidget{

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage>{

  Category _category;

  @override
  Widget build(BuildContext context) {

    AppState appState = AppStateProvider.of<AppState>(context);
    List<Category> categories = appState.categoriesStream.value;
    categories.sort();
    Category category = appState.categoryChosen.value;
    if(_category == null)
        _category = category;

    return Scaffold(
      appBar: AppBar(
        title: Text('Choose your categories'),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: categories.length,
            itemBuilder: (BuildContext ctx, int index){
              Category cat = categories.elementAt(index);
              List<String> nameSplited = cat.name.split(":");
              return Card(
                  child: RadioListTile<Category>(
                    title: Text( nameSplited.length > 1 ? nameSplited[1] : nameSplited[0] ,style: TextStyle(color: Colors.white)),
                    secondary: _getMap(cat.id),
                    value: cat,
                    groupValue: _category,
                    subtitle: Text(nameSplited.length > 1 ? nameSplited[0] : '' ,style: TextStyle(color: Colors.white),),
                    onChanged: (Category value){
                      setState(() {
                        _category = value;
                        appState.chooseCategory(value);
                      });
                    },
                  )
              );
            }
        )
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){appState.tabController.value = AppTab.main;},child: Icon(Icons.arrow_back_ios),),
    );
  }

  Widget _getMap(int idCategory){
    var mapIconCategory = {
      0 : Icon(Icons.all_inclusive),
      9 : Icon(Icons.desktop_mac),
      10 : Icon(Icons.book),
      11 : Icon(Icons.movie_creation),
      12 : Icon(Icons.music_note),
      13 : Icon(Icons.art_track),
      14 : Icon(Icons.tv),
      15 : Icon(Icons.games),
      16 : Icon(Icons.dashboard),
      17 : Icon(Icons.school),
      18 : Icon(Icons.computer),
      19 : Icon(Icons.border_color),
      20 : Icon(Icons.visibility),
      21 : Icon(Icons.directions_run),
      22 : Icon(Icons.assistant_photo),
      23 : Icon(Icons.history),
      24 : Icon(Icons.account_balance),
      25 : Icon(Icons.local_bar),
      26 : Icon(Icons.local_bar),
      27 : Icon(Icons.adb),
      28 : Icon(Icons.directions_car),
      29 : Icon(Icons.brush),
      30 : Icon(Icons.tablet_android),
      31 : Icon(Icons.directions_run),
      32 : Icon(Icons.accessibility),
    };
    return mapIconCategory[idCategory];
  }
}