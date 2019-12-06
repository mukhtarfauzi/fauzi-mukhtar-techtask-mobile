import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_task/core/view_models/recipes_suggestion_model.dart';
import 'package:tech_task/ui/widgets/fridge_app_bar.dart';

class RecipeView extends StatefulWidget {
  @override
  _RecipeViewState createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {

  @override
  void initState() {
    Provider.of<RecipeSuggestionModel>(context, listen: false).getRecipe();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FridgeAppBar(
        title: 'Recipe',
        subtitle: 'Result :',
        enableDatePicker: false,
      ),
      body: Consumer<RecipeSuggestionModel>(
        builder: (context, model, _) => StreamBuilder<bool>(
          stream: model.isLoading,
          builder: (context, snapshot) {
            if(snapshot.data == true){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: model.recipeList.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(model.recipeList[index].title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Ingredients: '),
                    Wrap(
                      children: <Widget>[
                        for(String ingredient in model.recipeList[index].ingredients)Chip(
                          backgroundColor:  model.ingredientsPicked.contains(ingredient)?Theme.of(context).accentColor:Theme.of(context).dividerColor,
                          label: Text(ingredient),
                        )
                      ],
                    )
                    ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
