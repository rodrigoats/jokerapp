import 'package:flutter/material.dart';
import 'dart:async';
import 'package:frideos/frideos.dart';
import 'package:frideos_core/frideos_core.dart';

import '../model/theme.dart';
import '../API/api_interface.dart';
import '../API/mock_api.dart';
import '../model/question.dart';
import '../blocs/joker_bloc.dart';
import '../model/models.dart';


class AppState extends AppStateModel{
  factory AppState() => _singletonAppState;

  AppState._internal(){
    print('------ STARTING APP--------');
    _createThemes(themes);

    countdown.value = 10.toString();
    countdown.setTransformer(validateCountdown);

    questionsAmount.value = 12.toString();
    questionsAmount.setTransformer(validateAmount);

    bloc = JokerBloc(countdownStream: countdown,questions: questions, tabController: tabController);

  }

  static final AppState _singletonAppState = AppState._internal();

  //BLOC
  JokerBloc bloc;

  //Theme
  final themes = List<MyTheme>();
  final currentTheme = StreamedValue<MyTheme>();

  //API
  final QuestionAPI api = MockAPI();
  final apiType = StreamedValue<ApiType>(initialData: ApiType.mock);

  //Tabs
  final tabController = StreamedValue<AppTab>(initialData: AppTab.main);

  //Trivia
  final questions = StreamedList<Question>();
  final questionsDifficulty = StreamedValue<QuestionDifficult>(initialData: QuestionDifficult.easy);

  final questionsAmount = StreamedTransformed<String, String>();

  final validateAmount  = StreamTransformer<String,String>.fromHandlers(handleData: (str, sink){
    if(str.isNotEmpty) {
      final amount = int.tryParse(str);
      if(amount == 12){
        sink.add(str);
      } else {
        sink.addError('Need Questions');
      }
    } else {
      sink.addError('Need Questions');
    }
  });

  //COUNTDOWN
  final countdown = StreamedTransformed<String, String>();
  final validateCountdown = StreamTransformer<String, String>.fromHandlers(handleData: (str,sink){
    if(str.isNotEmpty){
      final time = int.tryParse(str);
      if(time > 3 && time < 60){
        sink.add(str);
      }else {
        sink.addError("Erro countdown maior que 80 ou menor que 3");
      }
    }else{
      sink.addError("Erro countdown srt vazia");
    }
  });

  @override
  Future<void> init() async {
    final String lastTheme = await Prefs.getPref('appTheme');
    if(lastTheme != null) {
      currentTheme.value = themes.firstWhere((theme) => theme.name==lastTheme, orElse: () => themes[0]);
    } else {
      currentTheme.value = themes[0];
    }
  }

  Future _loadQuestions() async {
    await api.getQuestions(
      questions: questions,
      number: int.parse(questionsAmount.value),
      difficulty: questionsDifficulty.value,
      type: QuestionType.multiple
    );
  }

  void setDifficulty(QuestionDifficult difficulty) => questionsDifficulty.value = difficulty;

  void _createThemes(List<MyTheme> themes) {
    themes.addAll([
        MyTheme(
          name: 'MyTheme',
          brightness: Brightness.dark,
          backgroundColor: const Color(0xff111740),
          scaffoldBackgroundColor: const Color(0xff111740),
          primaryColor: const Color(0xff283593),
          primaryColorBrightness: Brightness.dark,
          accentColor: Colors.blue[300],
        ),
        MyTheme(
          brightness: Brightness.dark,
          backgroundColor: Colors.black,
          scaffoldBackgroundColor: Colors.black,
          primaryColor: Colors.blueGrey[900],
          primaryColorBrightness: Brightness.dark,
          accentColor: Colors.blue[900],
        )
    ]);
  }

  void setTheme(MyTheme theme){
    currentTheme.value = theme;
    Prefs.savePref<String>('appTheme',theme.name);
  }

  set _changeTab(AppTab appTab) => tabController.value = appTab;

  void startTrivia(){
    print('START TRIVIA');
    _loadQuestions();
    _changeTab = AppTab.joker;
  }

  void endTrivia() => tabController.value = AppTab.summary;

  void showSummary() => tabController.value = AppTab.summary;

  @override
  void dispose() {
    print('---------APP STATE DISPOSE-----------');
    countdown.dispose();
    currentTheme.dispose();
    questions.dispose();
    questionsAmount.dispose();
    questionsDifficulty.dispose();
    bloc.dispose();
  }
}