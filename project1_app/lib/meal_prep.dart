import 'package:flutter/material.dart';
import 'recipe_detail.dart';
import 'breakfast.dart' hide RecipeDetailScreen;

class MealPrepScreen extends StatefulWidget {
  @override
  _MealPrepScreenState createState() => _MealPrepScreenState();
}

class _MealPrepScreenState extends State<MealPrepScreen> {
  // Map to hold the selected breakfast recipe for each day
  Map<String, Recipe?> mealPlan = {
    'Monday': null,
    'Tuesday': null,
    'Wednesday': null,
    'Thursday': null,
    'Friday': null,
    'Saturday': null,
    'Sunday': null,
  };

  // Selected breakfast recipe for each day
  Map<String, String?> selectedBreakfast = {
    'Monday': null,
    'Tuesday': null,
    'Wednesday': null,
    'Thursday': null,
    'Friday': null,
    'Saturday': null,
    'Sunday': null,
  };

  void selectRecipe(String day, Recipe recipe) {
    setState(() {
      mealPlan[day] = recipe; // Set the selected recipe for the specific day
      selectedBreakfast[day] = recipe.name; // Store the selected recipe name
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Prep'),
        backgroundColor: Colors.amber[100],
      ),
      body: ListView(
        children: mealPlan.keys.map((day) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                ListTile(
                  title: Text(day, style: TextStyle(fontSize: 24)),
                  subtitle: selectedBreakfast[day] != null
                      ? Text('Selected Recipe: ${selectedBreakfast[day]}')
                      : const Text('No recipe selected'),
                ),
                // Dropdown for breakfast recipes
                DropdownButton<Recipe>(
                  hint: const Text('Select a Breakfast Recipe'),
                  value: mealPlan[day],
                  onChanged: (Recipe? newValue) {
                    if (newValue != null) {
                      selectRecipe(day, newValue);
                    }
                  },
                  items: breakfastRecipes
                      .map<DropdownMenuItem<Recipe>>((Recipe recipe) {
                    return DropdownMenuItem<Recipe>(
                      value: recipe,
                      child: Text(recipe.name),
                    );
                  }).toList(),
                ),
                const Divider(),
                // Placeholders for Lunch and Dinner sections
                const Text('Lunch',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                const Text('No lunch recipes added yet.',
                    style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 10),
                const Text('Dinner',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                const Text('No dinner recipes added yet.',
                    style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 10),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
