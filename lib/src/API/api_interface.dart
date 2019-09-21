import 'package:frideos_core/frideos_core.dart';

import '../model/question.dart';
import '../model/category.dart';

abstract class QuestionAPI{

  Future<bool> getCategories(StreamedList<Category> categories);
  Future<bool> getQuestions({
    StreamedList<Question> questions,
    int number,
    QuestionDifficult difficulty,
    QuestionType type,
  });
}