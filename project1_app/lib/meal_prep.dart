import 'package:flutter/material.dart';
import 'recipe_detail.dart';
import 'breakfast.dart' hide RecipeDetailScreen;
import 'lunch.dart' hide RecipeDetailScreen;
import 'dinner.dart';
import 'recipe.dart';

class MealPrepScreen extends StatefulWidget {
  final Map<String, Recipe?> breakfast;
  final Map<String, Recipe?> lunch;
  final Map<String, Recipe?> dinner;
  final Function(String, Recipe, String) updateMealPlan;

  MealPrepScreen({required this.breakfast, required this.lunch, required this.dinner, required this.updateMealPlan});
  @override
  _MealPrepScreenState createState() => _MealPrepScreenState( );
}

class _MealPrepScreenState extends State<MealPrepScreen> {
  late Map<String, Recipe?> selectedBreakfast;
  late Map<String, Recipe?> selectedLunch;
  late Map<String, Recipe?> selectedDinner;

  @override
  void initState() {
    super.initState();
    selectedBreakfast = Map.from(widget.breakfast);
    selectedLunch = Map.from(widget.lunch);
    selectedDinner = Map.from(widget.dinner);
  }

  void _updateMealPlan(String day, Recipe recipe, String mealTime) {
    setState(() {
      if (mealTime == 'breakfast') {
        selectedBreakfast[day] = recipe;
      } else if (mealTime == 'lunch') {
        selectedLunch[day] = recipe;
      } else if (mealTime == 'dinner') {
        selectedDinner[day] = recipe;
      }
    });
    widget.updateMealPlan(day, recipe, mealTime);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Prep'),
        backgroundColor: Colors.amber[100],
      ),
      body: ListView(
        children: selectedBreakfast.keys.map((day) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                ListTile(
                  title: Text(day, style: TextStyle(fontSize: 24)),
                 
                ),
                //breakfast
                DropdownButton<Recipe>(
                  hint: const Text('Select a Breakfast Recipe'),
                  value: selectedBreakfast[day],
                  onChanged: (Recipe? newValue) {
                    if (newValue != null) {
                      _updateMealPlan(day, newValue, 'breakfast');
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
                //lunch
                DropdownButton<Recipe>(
                  hint: const Text('Select a Lunch Recipe'),
                  value: selectedLunch[day],
                  onChanged: (Recipe? newValue) {
                    if (newValue != null) {
                      _updateMealPlan(day, newValue, 'lunch');
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
                //dinner
                DropdownButton<Recipe>(
                  hint: const Text('Select a Dinner Recipe'),
                  value: selectedDinner[day],
                  onChanged: (Recipe? newValue) {
                    if (newValue != null) {
                      _updateMealPlan(day, newValue, 'dinner');
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
