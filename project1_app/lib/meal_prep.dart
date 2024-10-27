import 'package:flutter/material.dart';

class MealPrepScreen extends StatelessWidget {
  final List<String> daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  final List<String> meals = ['Breakfast', 'Lunch', 'Dinner'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Prep'),
        backgroundColor: Colors.amber[100],
      ),
      body: ListView.builder(
        itemCount: daysOfWeek.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    daysOfWeek[index], // Display day of the week
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  ...meals
                      .map((meal) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              meal, // Display meal type
                              style: TextStyle(fontSize: 18),
                            ),
                          ))
                      .toList(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
