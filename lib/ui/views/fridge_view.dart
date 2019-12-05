import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_task/core/view_models/recipes_suggestion_model.dart';

class FridgeView extends StatefulWidget {
  @override
  _FridgeViewState createState() => _FridgeViewState();
}

class _FridgeViewState extends State<FridgeView> {
  @override
  void initState() {
    Provider.of<RecipeSuggestionModel>(context, listen: false).checkPreferenceDate();
    Provider.of<RecipeSuggestionModel>(context, listen: false).getIngredients();
    super.initState();
  }

  void _showLunchDatePicker(BuildContext context, RecipeSuggestionModel model) async {
    var datePicked = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2018), lastDate: DateTime(2020));
    model.setLunchDate(datePicked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){},
        label: Text('Get Recipe'),
        icon: Icon(Icons.send),

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Container(
          color: Colors.redAccent,
          child: SafeArea(
            child: Consumer<RecipeSuggestionModel>(
              builder: (__, model, _) => Row(
                children: <Widget>[
                  Text(model.getLunchDate,
                    style: TextStyle(color: Colors.black),
                  ),
                  IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () => _showLunchDatePicker(context, model),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          StreamBuilder<bool>(
              stream: Provider.of<RecipeSuggestionModel>(context).isLoading,
              builder: (context, snapshot) {
                if (snapshot.data == false) {
                  return Consumer<RecipeSuggestionModel>(
                    builder: (context, model, _) => ListView.builder(
                        itemCount: model.ingredients.length,
                        itemBuilder: (context, index) => ListTile(
                              title: Text(model.ingredients[index].title),
                              subtitle: Text(model.ingredients[index].usedByString),
                              trailing: model.ingredients[index].picked?Icon(Icons.check_circle, color: Theme.of(context).primaryColor,):null,
                              onTap: () => model.ingredientTogglePicked(index),
                            )),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
          DraggableScrollableSheet(
            initialChildSize: 0.25,
            builder: (context, controller) => Container(
              color: Colors.white,
              child: SingleChildScrollView(
                controller: controller,
                child: Consumer<RecipeSuggestionModel>(
                  builder: (context, model, _) {
                    if (model.ingredientsPicked.isNotEmpty) {
                      return Column(
                        children: <Widget>[

                          Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            runSpacing: 0.2,
                            spacing: 0.2,
                            children: <Widget>[
                              for (String picked in model.ingredientsPicked)
                                Chip(label: Text(picked))
                            ],
                          ),
                        ],
                      );
                    }
                    return SizedBox();
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
