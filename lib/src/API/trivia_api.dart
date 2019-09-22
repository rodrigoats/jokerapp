import 'dart:async';

import 'dart:convert' as convert;

import 'package:frideos_core/frideos_core.dart';
import 'package:http/http.dart' as http;
import 'package:jocker_app/src/model/category.dart';

import '../model/question.dart';
import 'api_interface.dart';


class TriviaAPI implements QuestionAPI{
  @override
  Future<bool> getQuestions({StreamedList<Question> questions, int number, QuestionDifficult difficulty, int idCategory,QuestionType type}) async{

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

    String url;
    if(questions.value == null){
      url = 'https://opentdb.com/api.php?amount=$number&difficulty=easy&type=$qType&encode=base64';
    } else {
      url = 'https://opentdb.com/api.php?amount=$number&difficulty=$qDifficult&type=$qType&encode=base64';
    }

    if(idCategory != null && idCategory > 0){
      url = url + '&category='+ idCategory.toString();
    }

    print(idCategory);
    print(url);

    final response = await http.get(url);

    if(response.statusCode == 200){
      final jsonResponse = convert.jsonDecode(response.body);
      final result = (jsonResponse['results'] as List)
          .map((question)=>QuestionModel.fromJson(question)).toList();

      var questionsResult = result
          .map((question)=>Question.fromQuestionModel(question)).toList();
      if(questions.value == null){
        questions.value = questionsResult;
      } else {
        questions.value.addAll(questionsResult);
      }

    } else {
      print('Request failed with status: ${response.statusCode}.');
      return false;
    }

    return true;
  }

  @override
  Future<bool> getCategories(StreamedList<Category> categories) async{
    const categoriesURL = 'https://opentdb.com/api_category.php';
    final response = await http.get(categoriesURL);
    if(response.statusCode == 200){
      final jsonResponse = convert.jsonDecode(response.body);
      final result = (jsonResponse['trivia_categories'] as List)
          .map((category)=>Category.fromJson(category));
      categories.value = [];
      categories
        ..addAll(result)
        ..addElement(Category(0, 'Any Category'));
      return true;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return false;
    }

  }

}