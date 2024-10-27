import 'package:flutter/material.dart';
import 'breakfast.dart'; // Make sure to import the Recipe class

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
              child: Image.asset(
                recipe.imageUrl,
                width: 200,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '${recipe.servings} servings | Cook time: ${recipe.cookTime} mins | Prep time: ${recipe.prepTime} mins',
              style: const TextStyle(fontSize: 18),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
                  ),
                  color: recipe.isFavorite ? Colors.red : Colors.black,
                  onPressed: () {
                    // Handle favorite toggle (if needed)
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Ingredients:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ...recipe.ingredients.map((ingredient) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(ingredient),
                    ElevatedButton(
                      onPressed: () {
                        // Handle add to grocery list action
                      },
                      child: const Text('Add to grocery list'),
                    ),
                  ],
                )),
            const SizedBox(height: 20),
            const Text(
              'Instructions:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ...recipe.instructions.map((instruction) => Text(instruction)),
          ],
        ),
      ),
    );
  }
}
