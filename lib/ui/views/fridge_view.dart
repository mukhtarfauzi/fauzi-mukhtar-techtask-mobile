import 'package:flutter/material.dart';

class FridgeView extends StatefulWidget {
  @override
  _FridgeViewState createState() => _FridgeViewState();
}

class _FridgeViewState extends State<FridgeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<bool>(
        stream: null,
        builder: (context, snapshot) {
          return Center(
            child: Text('Lets Start'),
          );
        }
      ),
    );
  }
}
