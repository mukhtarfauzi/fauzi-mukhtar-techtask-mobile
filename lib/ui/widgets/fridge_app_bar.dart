import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_task/core/view_models/recipes_suggestion_model.dart';

class FridgeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  final bool enableDatePicker;

  const FridgeAppBar({Key key,
    @required this.title,
    @required this.subtitle,
    this.enableDatePicker : true
  }) : super(key: key);

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
    return Material(
      elevation: 0.8,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        if(ModalRoute.of(context).canPop)BackButton(),
                        Flexible(
                          child: FittedBox(
                            child: Text(title,
                                style: Theme.of(context).textTheme.display1),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        if(enableDatePicker)InkWell(
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
                      subtitle,
                      style: Theme.of(context).textTheme.subhead,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(90);
}
