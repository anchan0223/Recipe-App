import 'package:flutter/material.dart';
import 'recipe_detail.dart';
import 'breakfast.dart' hide RecipeDetailScreen;

class MealPrepScreen extends StatefulWidget {
  @override
  _MealPrepScreenState createState() => _MealPrepScreenState();
}

class _MealPrepScreenState extends State<MealPrepScreen> {
  // Map to hold the meal plan for each day
  Map<String, List<Recipe>> mealPlan = {
    'Monday': [],
    'Tuesday': [],
    'Wednesday': [],
    'Thursday': [],
    'Friday': [],
    'Saturday': [],
    'Sunday': [],
  };

  void addRecipe(String day, Recipe recipe) {
    setState(() {
      mealPlan[day]?.add(recipe);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Prep'),
        backgroundColor: Colors.amber[100],
      ),
      body: ListView(
        children: [
          for (var day in mealPlan.keys) ...[
            Text(day,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Column(
              children: [
                // Breakfast Section
                Text('Breakfast',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                ...breakfastRecipes.map((recipe) {
                  return ListTile(
                    title: Text(recipe.name),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeDetailScreen(
                            recipe: recipe,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),

                // Placeholder for Lunch Section
                Text('Lunch',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                Text('No lunch recipes added yet.',
                    style: TextStyle(color: Colors.grey)),

                // Placeholder for Dinner Section
                Text('Dinner',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                Text('No dinner recipes added yet.',
                    style: TextStyle(color: Colors.grey)),

                Divider(),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
