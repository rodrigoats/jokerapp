import 'dart:async';

import 'package:frideos_core/frideos_core.dart';

import '../model/models.dart';
import '../model/question.dart';
import '../model/jokerStats.dart';
import '../API/trivia_api.dart';


const refreshTime = 100;

class JokerBloc {
  
  JokerBloc({this.countdownStream,this.questions,this.tabController}){
    questions.onChange((data) {
      if(data.isNotEmpty){
        final questions = data..shuffle();
        _startJoker(questions);
      }
    });

    countdownStream.outTransformed.listen((data){
      countdown = int.parse(data)*2500;
    });
  }

  // STREAMS
  final StreamedValue<AppTab> tabController;
  final triviaState = StreamedValue<TriviaState>(initialData: TriviaState());
  final StreamedList<Question> questions;
  final currentQuestion = StreamedValue<Question>();
  final currentTime = StreamedValue<int>(initialData: 0);
  final countdownBar = StreamedValue<double>();
  final answersAnimation = StreamedValue<AnswerAnimation>(
      initialData: AnswerAnimation(chosenAnswerIndex: 0, startPlaying: false, startPlayingHero: false));

  // QUESTIONS, ANSWERS, STATS
  int index = 0;
  String chosenAnswer;
  bool answered = false;
  JokerStats stats = new JokerStats(leftColumn: 0,rightColumn: 6);

  // TIMER, COUNTDOWN
  final StreamedTransformed<String, String> countdownStream;
  int countdown; // Milliseconds
  Timer timer;
  double dilation = 1.0;

  //START ANIMATIONS
  bool startLeftColumnAnimation = false;

  void _startJoker(List<Question> data){
    index = 0;
    triviaState.value.questionIndex = 1;
    triviaState.value.isTriviaEnd = false;
    stats.reset();
    currentQuestion.value = data.first;

    Timer(Duration(milliseconds: 1000), () {
      triviaState.value.isTriviaPlaying = true;
      currentQuestion.value = data[index];
      playJoker();
    });
  }
  void playJoker() {
    timer = Timer.periodic(Duration(milliseconds: refreshTime), (Timer t){
      currentTime.value = refreshTime * t.tick;
      if(currentTime.value > countdown) {
        currentTime.value = 0;
        timer.cancel();
        notAnswered(currentQuestion.value);
        _nextQuestion();
      }
    });
  }

  void _endJoker(){
    timer.cancel();
    currentTime.value = 0;
    triviaState.value.isTriviaEnd = true;
    triviaState.refresh();
    stopTimer();

    Timer(Duration(milliseconds: 1500),(){
      triviaState.value.isAnswerChosen = false;
      tabController.value = AppTab.summary;
      currentQuestion.value = null;
    });
  }

  void notAnswered(Question question) {
    print('--------------notAnswered--------------------');
    startLeftColumnAnimation = true;
    stats.addWrong();
  }

  void checkAnswer(Question question, String answer) {
    if(!triviaState.value.isTriviaEnd) {
      question.chosenAnswerIndex =  question.answers.indexOf(answer);
      if(question.isCorrect(answer)) {
        answersAnimation.value.startPlayingHero = true;
        startLeftColumnAnimation = false;
        stats.addCorrect();
      } else {
        startLeftColumnAnimation = true;
        stats.addWrong();
      }
      timer.cancel();
      currentTime.value = 0;
      _nextQuestion();
    }
  }
  void _nextQuestion(){
    dilation = 1.0;
    index++;
    answered = false;
    print('-------------- _nextQuestion: $index --------------------');
    if(index < questions.length) {
      triviaState.value.questionIndex++;
      currentQuestion.value = _getCurrentQuestion();
      playJoker();
    } else {
      _endJoker();
    }
  }
  void stopTimer() {
    timer.cancel();
    triviaState.value.isAnswerChosen = true;
    triviaState.refresh();
  }

  void onChosenAnswer(String answer){
    chosenAnswer = answer;
    currentQuestion.value.chosenAnswerIndex = currentQuestion.value.answers.indexOf(answer);

    stopTimer();

    answersAnimation.value.chosenAnswerIndex =
        currentQuestion.value.answers.indexOf(answer);
    answersAnimation.refresh();
  }

  void onChosenAnswerAnimationEnd(){
    triviaState.value.isAnswerChosen = false;
    triviaState.refresh();
    checkAnswer(currentQuestion.value,chosenAnswer);
  }

  int getRightColumn(){
    return stats.rightColumn;
  }

  int getLeftColumn(){
    return stats.leftColumn;
  }

  Question _getCurrentQuestion(){
    final TriviaAPI api = new TriviaAPI();
    QuestionDifficult difficult;
    if(getRightColumn() > 2) {
      difficult = QuestionDifficult.easy;
    } else if(getRightColumn() > 0){
      difficult = QuestionDifficult.medium;
    } else {
      difficult = QuestionDifficult.hard;
    }
    //api.getQuestions(difficulty: difficult,number: 1, type: QuestionType.multiple, questions: questions);
    return questions.value[index];
  }

  void dispose() {
    answersAnimation.dispose();
    countdownBar.dispose();
    countdownStream.dispose();
    currentQuestion.dispose();
    currentTime.dispose();
    questions.dispose();
    triviaState.dispose();
    tabController.dispose();
  }
}