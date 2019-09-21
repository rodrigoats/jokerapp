enum AppTab {main, summary, joker, stats, categories}

enum ApiType {mock, remote}

class TriviaState{
  bool isTriviaPlaying = false;
  bool isTriviaEnd = false;
  bool isAnswerChosen = false;
  int questionIndex = 1;
}

class AnswerAnimation{
  AnswerAnimation({this.chosenAnswerIndex,this.startPlaying, this.startPlayingHero});
  
  int chosenAnswerIndex;
  bool startPlaying = false;
  bool startPlayingHero = false;

}