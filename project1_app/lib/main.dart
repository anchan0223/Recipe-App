import 'package:flutter/material.dart';
import 'package:project1_app/favorites_screen.dart';
import 'breakfast.dart';
import 'meal_prep.dart'; // Ensure this import matches your meal prep screen file

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
  
  //favorite recipes
  final List<Recipe> favoriteRecipes = [];
 

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      // Navigate to the Meal Prep screen if the Meal Prep tab is clicked
      if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MealPrepScreen()),
        );
      }
      //navigate to favorites screen
      if(index == 2){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FavoritesScreen(favoriteRecipes: favoriteRecipes, toggleFavorite: toggleFavorite,)),
        );
      }
    });
  }

  void toggleFavorite(Recipe recipe) {
    setState(() {
      recipe.isFavorite = !recipe.isFavorite;
      if (recipe.isFavorite) {
        favoriteRecipes.add(recipe);
      } else {
        favoriteRecipes.remove(recipe);
      }
    });
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
            // Search Row
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
                        builder: (context) => BreakfastScreen(
                          toggleFavorite: toggleFavorite,
                        ),
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
