import 'package:frideos_core/frideos_core.dart';
import 'package:jocker_app/src/model/category.dart';
import '../API/trivia_api.dart';


class SettingsBloc {

  SettingsBloc({this.categories}){
    _loadCategories();
  }
  final StreamedList<Category> categories;
  final TriviaAPI api = new TriviaAPI();


  void _loadCategories(){
    api.getCategories(categories);
  }
}