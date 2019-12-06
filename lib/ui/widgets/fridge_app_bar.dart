import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_task/core/view_models/recipes_suggestion_model.dart';

class FridgeAppBar extends StatelessWidget implements PreferredSizeWidget {

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
    return SafeArea(
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
                      SizedBox(
                        width: 16,
                      ),
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
                                SizedBox(
                                  width: 3,
                                ),
                                Icon(
                                  Icons.settings,
                                  size: 16,
                                ),
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
                  Text(
                    'Ingredients: ',
                    style: Theme.of(context).textTheme.subhead,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(90);
}
