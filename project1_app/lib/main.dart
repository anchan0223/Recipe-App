import 'package:flutter/material.dart';
import 'breakfast.dart';

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
  int _selectedIndex = 0;
  String _searchQuery = '';
  bool _isGlutenFree = false;
  bool _isDairyFree = false;
  bool _isNutFree = false;
  bool _isVegan = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Filter by Dietary Restrictions',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  CheckboxListTile(
                    title: const Text("Gluten-Free"),
                    value: _isGlutenFree,
                    onChanged: (bool? value) {
                      setModalState(() {
                        _isGlutenFree = value ?? false;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text("Dairy-Free"),
                    value: _isDairyFree,
                    onChanged: (bool? value) {
                      setModalState(() {
                        _isDairyFree = value ?? false;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text("Nut-Free"),
                    value: _isNutFree,
                    onChanged: (bool? value) {
                      setModalState(() {
                        _isNutFree = value ?? false;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text("Vegan"),
                    value: _isVegan,
                    onChanged: (bool? value) {
                      setModalState(() {
                        _isVegan = value ?? false;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Add functionality to apply filters
                      Navigator.pop(context); // Close the filter modal
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFCD581),
                    ),
                    child: const Text('Apply Filters'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[100],
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
                Expanded(
                  child: Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFCD581),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search for a recipe...',
                        hintStyle: TextStyle(color: Colors.black54),
                        prefixIcon: Icon(Icons.search, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _showFilterSheet,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFCD581),
                  ),
                  child: const Text(
                    'Filter by dietary\nrestrictions / allergies',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            // Meal type section with buttons
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    'Meal Type',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 16),
                MealTypeButton(
                  label: 'Breakfast',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BreakfastScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                MealTypeButton(label: 'Lunch', onPressed: () {}),
                const SizedBox(height: 10),
                MealTypeButton(label: 'Snack', onPressed: () {}),
                const SizedBox(height: 10),
                MealTypeButton(label: 'Dinner', onPressed: () {}),
                const SizedBox(height: 10),
                MealTypeButton(label: 'Drinks', onPressed: () {}),
                const SizedBox(height: 10),
                MealTypeButton(label: 'Dessert', onPressed: () {}),
              ],
            ),
            // Bottom Navigation
            BottomNavigationBar(
              backgroundColor: const Color.fromARGB(255, 245, 247, 176),
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
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.black,
              onTap: _onItemTapped,
            ),
          ],
        ),
      ),
    );
  }
}

class MealTypeButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const MealTypeButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: 200,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 120, 182, 253),
          ),
          child: Text(
            label,
            style: const TextStyle(fontSize: 24, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
