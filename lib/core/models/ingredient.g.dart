// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ingredient _$IngredientFromJson(Map<String, dynamic> json) {
  return Ingredient(
    title: json['title'] as String,
    usedBy: json['use-by'] == null
        ? null
        : DateTime.parse(json['use-by'] as String),
  );
}

Map<String, dynamic> _$IngredientToJson(Ingredient instance) =>
    <String, dynamic>{
      'title': instance.title,
      'use-by': instance.usedBy?.toIso8601String(),
    };
