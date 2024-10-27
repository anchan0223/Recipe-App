import 'package:flutter/material.dart';

class MealPrepScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Prep'),
        backgroundColor: Colors.amber[100],
      ),
      body: Center(
        child: Text(
          'Welcome to Meal Prep!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
