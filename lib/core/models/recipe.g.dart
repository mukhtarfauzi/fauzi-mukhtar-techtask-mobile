// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recipe _$RecipeFromJson(Map<String, dynamic> json) {
  return Recipe(
    title: json['title'] as String,
    ingredients:
        (json['ingredients'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
      'title': instance.title,
      'ingredients': instance.ingredients,
    };
