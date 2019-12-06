import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_task/core/view_models/recipes_suggestion_model.dart';
import 'package:tech_task/ui/shared/fonts.dart';

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

  void _showLunchDatePicker(
      BuildContext context, RecipeSuggestionModel model) async {
    var datePicked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime(2020));
    model.setLunchDate(datePicked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text('Get Recipe'),
        icon: Icon(Icons.send),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: SafeArea(
          child: Consumer<RecipeSuggestionModel>(
            builder: (__, model, _) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: FittedBox(
                              child: Text('My Lunch Suggestion',

                                  style: Theme.of(context).textTheme.display1),
                            ),
                          ),
                          SizedBox(width: 16,),
                          InkWell(
                            onTap: () => _showLunchDatePicker(context, model),
                            child: Material(
                              color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      model.getLunchDate.replaceAll('-', '/'),
                                      style: TextStyle(fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(width: 3,),
                                    Icon(Icons.settings, size: 16,),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text('Ingredients: ', style: Theme.of(context).textTheme.subhead,),


                    ],
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
                        trailing: model.ingredients[index].picked
                            ? Icon(
                                Icons.check_circle,
                                color: Theme.of(context).primaryColor,
                              )
                            : null,
                        onTap: () => model.ingredientTogglePicked(model.ingredients[index].title),
                      ),
                    ),
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
                                    label: Text(picked), onPressed: () => model.ingredientTogglePicked(picked),)
                              ],
                            ),
                        ],
                      ),
                    );
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
