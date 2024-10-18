import 'package:flutter/material.dart';

void main() {
  runApp(MealMateApp());
}

class MealMateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MealMate',
      home: MealMateHome(),
    );
  }
}

class MealMateHome extends StatefulWidget {
  @override
  _MealMateHomeState createState() => _MealMateHomeState();
}

class _MealMateHomeState extends State<MealMateHome> {
  int _selectedIndex = 0; // To keep track of the selected bottom navigation tab

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // You can add navigation logic based on the selected index here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[100],
        centerTitle: true,
        title: const Text(
          'MealMate',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Search and Filter Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Implement search functionality here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[300], // background
                  ),
                  child: const Text('Search for a recipe!'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Implement filter functionality here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[100],
                  ),
                  child: const Text(
                    'Filter by dietary\nrestrictions / allergies',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            // Meal categories (Breakfast, Lunch, etc.)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.pink[300],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: const [
                  MealTypeButton('Breakfast'),
                  MealTypeButton('Lunch'),
                  MealTypeButton('Dinner'),
                  MealTypeButton('Dessert'),
                ],
              ),
            ),
            // Bottom Navigation Buttons
            BottomNavigationBar(
              backgroundColor: Colors.pink[100],
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.kitchen),
                  label: 'Meal Prep',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favs',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: 'Grocery List',
                ),
              ],
              currentIndex: _selectedIndex, // Update the current index
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.black,
              onTap: _onItemTapped, // Handle tab changes
            ),
          ],
        ),
      ),
    );
  }
}

class MealTypeButton extends StatelessWidget {
  final String label;

  const MealTypeButton(this.label);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        label,
        style: const TextStyle(fontSize: 24, color: Colors.black),
      ),
    );
  }
}
