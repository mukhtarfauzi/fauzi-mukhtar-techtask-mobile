import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tech_task/core/constant/api_url.dart';
import 'package:tech_task/core/models/ingredient.dart';
import 'package:tech_task/core/models/recipe.dart';

class ApiService {

  Future<List<Ingredient>> fetchIngredients() async {
    final response =  await http.get(baseUrl + ingredient);
    print(response.body);
    if(response.statusCode == 200){
      List<dynamic> json = jsonDecode(response.body);
      var result = json.map((ingredient) => Ingredient.fromJson(ingredient)).toList();
      return result;
    }else{
      throw Exception('Failed to load post');
    }
  }

  Future<List<Recipe>> fetchRecipes(List<String> params) async {
    final response =  await http.get('$baseUrl$recipe?$ingredient=$params');
    print(response.body);
    if(response.statusCode == 200){
      List<dynamic> json = jsonDecode(response.body);
      var result = json.map((ingredient) => Recipe.fromJson(ingredient)).toList();
      return result;
    }else{
      throw Exception('Failed to load post');
    }
  }
}

