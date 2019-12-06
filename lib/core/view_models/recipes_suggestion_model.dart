import 'package:tech_task/core/constant/mock_data.dart';
import 'package:tech_task/core/models/ingredient.dart';
import 'package:tech_task/core/services/api_service.dart';
import 'package:tech_task/core/services/preference_service.dart';
import 'package:tech_task/core/view_models/base_model.dart';

class RecipeSuggestionModel extends BaseModel {

  List<String> ingredientsPicked = [];

  List<Ingredient> _ingredientsList = [];

  List<Ingredient> get ingredientsList => _ingredientsList;

  set ingredientsList(List<Ingredient> value) {
    _ingredientsList.clear();
    _ingredientsList.addAll(value);
    notifyListeners();
  }

  DateTime _lunchDate = DateTime.now();

  void setLunchDate(DateTime value) async {
    final preference = await PreferenceService.getInstance();
    _lunchDate = value;
    preference.date = getLunchDate;
    notifyListeners();
  }

  String get getLunchDate => _lunchDate.toString().substring(0, 10);

  final _apiService = ApiService();

  void _descendingUseBy(){
    ingredientsList.sort((a, b) => b.usedBy.compareTo(a.usedBy));
  }

  Future<void> checkPreferenceDate() async {
    final preference = await PreferenceService.getInstance();
    if(preference.date == null){
      _lunchDate = DateTime.now();
      preference.date = getLunchDate;
    }else{
      _lunchDate = DateTime.parse(preference.date);
    }
    notifyListeners();
  }

  Future<void> getIngredients() async {
    setBusy();
    //TODO must use api to get ingredients
    //For now i use mock data
    await Future.delayed(Duration(milliseconds: 500));
    ingredientsList = ingredientsData.map((ing) => Ingredient.fromJson(ing)).toList();
    _descendingUseBy();

    setIdle();
  }

  void ingredientTogglePicked(String title){
    bool isPicked;
    ingredientsList.forEach((ing){
      if(ing.title == title){
        ing.picked = !ing.picked;
        isPicked = ing.picked;
      }
    });
    if(isPicked){
      ingredientsPicked.add(title);
    }else{
      ingredientsPicked.remove(title);
    }
    notifyListeners();
  }

  bool isGoodIngredient(int index){
    var status = ingredientsList[index].usedBy.compareTo(_lunchDate);
    if(status.isNegative){
      return false;
    }else{
      return true;
    }
  }

}