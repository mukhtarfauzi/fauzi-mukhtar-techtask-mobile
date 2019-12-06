import 'package:flutter_test/flutter_test.dart';
import 'package:tech_task/core/services/api_service.dart';
import 'package:tech_task/core/view_models/recipes_suggestion_model.dart';

void main() {
  group("API Test", () {
    var api = ApiService();
    test('Ingredient', () async {
      var result = await api.fetchIngredients();
      print('RESULT ${result.map((ingredient) => ingredient.title)}');
      expect(result != null, true);
    });

    test('Recipe', () async {
      var params = ['Ketchup', 'Cheese'];
      var result = await api.fetchRecipes(params);
      print('RESULT ${result.map((recipe) => recipe.title)}');
      expect(result != null, true);
    });
  });

  group("View Model Test", () {
    var recipesSuggestModel = RecipeSuggestionModel();
    test("Get Ingredients", () async {
      await recipesSuggestModel.getIngredients();
      print("Ingredient: ${recipesSuggestModel.ingredientsList.first.usedBy}");
      expect(recipesSuggestModel.ingredientsList.length, 6);
    });
  });
}
