import 'package:flutter/material.dart';
import 'breakfast.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  RecipeDetailScreen({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
        backgroundColor: Colors.amber[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                recipe.name,
                style:
                    const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '# of servings | Cook time: # | Prep time: #',
              style: const TextStyle(fontSize: 16),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: recipe.isFavorite ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    // Toggle favorite functionality
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add to meal plan functionality
                  },
                  child: const Text('Add to Meal Plan'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber[300],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: Image.asset(
                recipe.imageUrl,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            const Text('Ingredients:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 1;
                    i <= 3;
                    i++) // Replace 3 with actual ingredient count
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Ingredient $i'), // Replace with actual ingredient
                      ElevatedButton(
                        onPressed: () {
                          // Add ingredient to grocery list functionality
                        },
                        child: const Text('Add to grocery list'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber[200],
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Instructions:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 1;
                    i <= 3;
                    i++) // Replace 3 with actual instruction count
                  Text('$i. Instruction $i'), // Replace with actual instruction
              ],
            ),
          ],
        ),
      ),
    );
  }
}
