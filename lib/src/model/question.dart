import 'dart:convert' as convert;


enum QuestionDifficult {easy, medium, hard}

enum QuestionType {boolean, multiple}

class QuestionModel{
  QuestionModel({this.question,this.correctAnswer,this.difficulty,this.incorrectAnswers});

  String question;
  String correctAnswer;
  String difficulty;
  List<String> incorrectAnswers;


  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      question: convert.utf8.decode(convert.base64Url.decode(json['question'])),
      correctAnswer: convert.utf8.decode(convert.base64Url.decode(json['correct_answer'])),
      difficulty: convert.utf8.decode(convert.base64Url.decode(json['difficulty'])),
      incorrectAnswers: (json['incorrect_answers'] as List)
          .map((answer) =>  convert.utf8.decode(convert.base64Url.decode(answer.toString()))).toList()
    );
  }
}

class Question {

  Question({this.question,this.difficulty,this.answers,this.correctAnswerIndex});

  factory Question.fromQuestionModel(QuestionModel model){

    final List<String> answers = []
      ..add(model.correctAnswer)
      ..addAll(model.incorrectAnswers)
      ..shuffle();
    final index = answers.indexOf(model.correctAnswer);

    return Question(
        question: model.question,
        difficulty: model.difficulty,
        answers: answers,
        correctAnswerIndex: index
    );
  }

  String question;
  String difficulty;
  List<String> answers;
  int correctAnswerIndex;
  int chosenAnswerIndex;

  bool isCorrect(String answer){
    return answers.indexOf(answer) == correctAnswerIndex;
  }

  bool isChoosed(String answer){
    return answers.indexOf(answer) == chosenAnswerIndex;
  }
}