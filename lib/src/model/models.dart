enum AppTab {main, summary, joker,stats}

enum ApiType {mock, remote}

class TriviaState{
  bool isTriviaPlaying = false;
  bool isTriviaEnd = false;
  bool isAnswerChosen = false;
  int questionIndex = 1;
}

class AnswerAnimation{
  AnswerAnimation({this.chosenAnswerIndex,this.startPlaying});
  
  int chosenAnswerIndex;
  bool startPlaying = false;
}