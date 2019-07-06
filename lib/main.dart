import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frideos/frideos.dart';

import 'src/homepage.dart';
import 'src/model/appState.dart';
import 'src/model/theme.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final appState = AppState();

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight]);


    return AppStateProvider<AppState>(
      appState: appState,
      child: MaterialPage(),
    );
  }
}
ThemeData _buildThemeData(MyTheme appTheme){
  return ThemeData(
    brightness: appTheme.brightness,
    backgroundColor: appTheme.backgroundColor,
    scaffoldBackgroundColor: appTheme.scaffoldBackgroundColor,
    primaryColor: appTheme.primaryColor,
    primaryColorBrightness: appTheme.primaryColorBrightness,
    accentColor: appTheme.accentColor,
  );
}


class MaterialPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final theme = AppStateProvider.of<AppState>(context).currentTheme;

    return ValueBuilder<MyTheme>(
      streamed: theme,
      builder: (context, snapshot){
        return MaterialApp(
          title: 'Joker App',
          theme: _buildThemeData(snapshot.data),
          home: HomePage(),
        );
      },
    );
  }
}





