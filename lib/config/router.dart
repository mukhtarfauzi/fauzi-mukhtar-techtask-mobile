import 'package:flutter/material.dart';
import 'package:tech_task/ui/views/fridge_view.dart';
import 'package:tech_task/ui/views/recipe_view.dart';

class Router {
  static const String root = '/';
  static const String recipe = '/recipe';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case root:
        return MaterialPageRoute(builder: (_) => FridgeView());
      case recipe:
        return MaterialPageRoute(builder: (_) => RecipeView());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }

}