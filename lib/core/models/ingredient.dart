import 'package:json_annotation/json_annotation.dart';

part 'ingredient.g.dart';

@JsonSerializable()
class Ingredient {
  String title;
  @JsonKey(name: 'use-by')
  DateTime usedBy;
  @JsonKey(ignore: true)
  bool picked;

  Ingredient({this.title, this.usedBy, this.picked : false});

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);
  Map<String, dynamic> toJson() => _$IngredientToJson(this);
}
