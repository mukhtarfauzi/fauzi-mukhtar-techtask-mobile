import 'package:flutter/material.dart';
import 'package:tech_task/ui/views/fridge_view.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lunch Recipes Suggestion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FridgeView(),
    );
  }
}