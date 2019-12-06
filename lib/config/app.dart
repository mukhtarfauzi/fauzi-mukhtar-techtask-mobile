import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_task/config/router.dart';
import 'package:tech_task/core/view_models/recipes_suggestion_model.dart';
import 'package:tech_task/ui/shared/colors.dart';
import 'package:tech_task/ui/shared/fonts.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RecipeSuggestionModel>(
      create: (_) => RecipeSuggestionModel(),
      child: MaterialApp(
        title: 'Lunch Recipes Suggestion',
        theme: ThemeData(
          primaryColor: primaryColor,
          accentColor: accentColor,
          fontFamily: quicksand,
          textTheme: TextTheme(

          )
        ),
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}