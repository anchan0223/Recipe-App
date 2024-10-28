import 'package:flutter/material.dart';
import 'recipe_detail.dart';
import 'breakfast.dart' hide RecipeDetailScreen;
import 'lunch.dart' hide RecipeDetailScreen;
import 'dinner.dart';
import 'recipe.dart';

class MealPrepScreen extends StatefulWidget {
  @override
  _MealPrepScreenState createState() => _MealPrepScreenState();
}

class _MealPrepScreenState extends State<MealPrepScreen> {
  // Map to hold the selected recipe for each day
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
  Map<String, String?> selectedRecipe = {
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
      selectedRecipe[day] = recipe.name; // Store the selected recipe name
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
                  subtitle: selectedRecipe[day] != null
                      ? Text('Selected Recipe: ${selectedRecipe[day]}')
                      : const Text('No recipe selected'),
                ),
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
                DropdownButton<Recipe>(
                  hint: const Text('Select a Lunch Recipe'),
                  value: mealPlan[day],
                  onChanged: (Recipe? newValue) {
                    if (newValue != null) {
                      selectRecipe(day, newValue);
                    }
                  },
                  items: lunchRecipes
                      .map<DropdownMenuItem<Recipe>>((Recipe recipe) {
                    return DropdownMenuItem<Recipe>(
                      value: recipe,
                      child: Text(recipe.name),
                    );
                  }).toList(),
                ),
                DropdownButton<Recipe>(
                  hint: const Text('Select a Dinner Recipe'),
                  value: mealPlan[day],
                  onChanged: (Recipe? newValue) {
                    if (newValue != null) {
                      selectRecipe(day, newValue);
                    }
                  },
                  items: dinnerRecipes
                      .map<DropdownMenuItem<Recipe>>((Recipe recipe) {
                    return DropdownMenuItem<Recipe>(
                      value: recipe,
                      child: Text(recipe.name),
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
