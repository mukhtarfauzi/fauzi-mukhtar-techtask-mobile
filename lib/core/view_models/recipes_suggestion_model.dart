import 'package:tech_task/core/constant/mock_data.dart';
import 'package:tech_task/core/models/ingredient.dart';
import 'package:tech_task/core/services/api_service.dart';
import 'package:tech_task/core/services/preference_service.dart';
import 'package:tech_task/core/view_models/base_model.dart';

class RecipeSuggestionModel extends BaseModel {

  List<String> ingredientsPicked = [];

  List<Ingredient> _ingredients = [];

  List<Ingredient> get ingredients => _ingredients;

  set ingredients(List<Ingredient> value) {
    _ingredients.clear();
    _ingredients.addAll(value);
    notifyListeners();
  }

  DateTime lunchDate = DateTime.now();

  final _apiService = ApiService();

  Future<void> checkPreferenceDate() async {
    final preference = await PreferenceService.getInstance();
    if(preference.date == null){
      lunchDate = DateTime.now();
      preference.date = lunchDate.toString().trim();
    }else{
      lunchDate = DateTime.parse(preference.date);
    }
    notifyListeners();
  }

  void _descendingUseBy(){
    ingredients.sort((a, b) => b.usedBy.compareTo(a.usedBy));
  }

  Future<void> getIngredients() async {
    setBusy();
    //TODO must use api to get ingredients
    //For now i use mock data
    await Future.delayed(Duration(milliseconds: 500));
    ingredients = ingredientsData.map((ing) => Ingredient.fromJson(ing)).toList();
    _descendingUseBy();

    setIdle();
  }

  void ingredientTogglePicked(int index){
    ingredients[index].picked = !ingredients[index].picked;
    if(ingredients[index].picked){
      ingredientsPicked.add(ingredients[index].title);
    }else{
      ingredientsPicked.remove(ingredients[index].title);
    }
    notifyListeners();
  }
}