import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_task/core/view_models/recipes_suggestion_model.dart';
import 'package:tech_task/ui/widgets/fridge_app_bar.dart';
import 'package:tech_task/ui/widgets/get_recipe_button.dart';

class FridgeView extends StatefulWidget {
  @override
  _FridgeViewState createState() => _FridgeViewState();
}

class _FridgeViewState extends State<FridgeView> {
  @override
  void initState() {
    Provider.of<RecipeSuggestionModel>(context, listen: false)
        .checkPreferenceDate();
    Provider.of<RecipeSuggestionModel>(context, listen: false).getIngredients();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GetRecipeButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      appBar: FridgeAppBar(
        title: 'My Lunch Suggestion',
        subtitle: 'Ingredients: ',
      ),
      body: Stack(
        children: <Widget>[_IngredientsList(), _IngredientsPicked()],
      ),
    );
  }
}

class _IngredientsList extends StatelessWidget {
  const _IngredientsList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: Provider.of<RecipeSuggestionModel>(context).isLoading,
        builder: (context, snapshot) {
          if (snapshot.data == false) {
            return Consumer<RecipeSuggestionModel>(
              builder: (context, model, _) => ListView.builder(
                itemCount: model.ingredientsList.length,
                itemBuilder: (context, index) => ListTile(
                  enabled: model.isGoodIngredient(index),
                  title: Text(model.ingredientsList[index].title),
                  subtitle: Text(
                      'Use By: ${model.ingredientsList[index].usedByString}'),
                  trailing: model.ingredientsList[index].picked
                      ? Icon(
                          Icons.check_circle,
                          color: Theme.of(context).primaryColor,
                        )
                      : null,
                  onTap: () => model.ingredientTogglePicked(
                      model.ingredientsList[index].title),
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

class _IngredientsPicked extends StatelessWidget {
  const _IngredientsPicked({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.25,
      builder: (context, controller) => Container(
        color: Colors.white,
        child: SingleChildScrollView(
          controller: controller,
          child: Consumer<RecipeSuggestionModel>(
            builder: (context, model, _) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Your ingredients picked: '),
                    if (model.ingredientsPicked.isNotEmpty)
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children: <Widget>[
                          for (String picked in model.ingredientsPicked)
                            ActionChip(
                              avatar: CircleAvatar(
                                backgroundColor: Colors.grey.shade800,
                                child: Icon(Icons.close),
                              ),
                              label: Text(picked),
                              onPressed: () =>
                                  model.ingredientTogglePicked(picked),
                            )
                        ],
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
