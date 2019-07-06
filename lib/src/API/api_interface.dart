import 'package:frideos_core/frideos_core.dart';

import '../model/question.dart';

abstract class QuestionAPI{
  Future<bool> getQuestions({
    StreamedList<Question> questions,
    int number,
    QuestionDifficult difficulty,
    QuestionType type,
  });
}