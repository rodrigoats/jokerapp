import 'dart:async';

import 'dart:convert' as convert;

import 'package:frideos_core/frideos_core.dart';
import 'package:http/http.dart' as http;

import '../model/question.dart';
import 'api_interface.dart';


class TriviaAPI implements QuestionAPI{
  @override
  Future<bool> getQuestions({StreamedList<Question> questions, int number, QuestionDifficult difficulty, QuestionType type}) async{

    var qDifficult;
    var qType = 'multiple';

    switch(difficulty){
      case QuestionDifficult.easy:
        qDifficult = 'easy';
        break;
      case QuestionDifficult.medium:
        qDifficult = 'medium';
        break;
      case QuestionDifficult.hard:
        qDifficult = 'hard';
        break;
      default:
        qDifficult = 'medium';
        break;
    }


    final url = 'https://opentdb.com/api.php?amount=$number&difficulty=$qDifficult&type=$qType&encode=base64';

    final response = await http.get(url);

    if(response.statusCode == 200){
      final jsonResponse = convert.jsonDecode(response.body);
      final result = (jsonResponse['results'] as List)
          .map((question)=>QuestionModel.fromJson(question)).toList();

      questions.value = result
          .map((question)=>Question.fromQuestionModel(question)).toList();
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return false;
    }

    return true;
  }

}