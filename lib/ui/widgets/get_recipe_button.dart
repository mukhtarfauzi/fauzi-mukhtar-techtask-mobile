import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_task/config/router.dart';
import 'package:tech_task/core/view_models/recipes_suggestion_model.dart';

class GetRecipeButton extends StatelessWidget {
  const GetRecipeButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeSuggestionModel>(
      builder: (context, model, _) => FloatingActionButton.extended(
        onPressed: model.ingredientsPicked.isEmpty?null:()=> Navigator.pushNamed(context, Router.recipe),
        backgroundColor: model.ingredientsPicked.isEmpty?Theme.of(context).disabledColor:Theme.of(context).accentColor,
        label: Text('Get Recipe', style: TextStyle(color: model.ingredientsPicked.isEmpty?Colors.white:Colors.black,),),
        icon: Icon(Icons.send, color: model.ingredientsPicked.isEmpty?Colors.white:Colors.black),
      ),
    );
  }
}