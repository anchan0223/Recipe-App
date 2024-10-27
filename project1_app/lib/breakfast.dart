import 'package:flutter/material.dart';

class Recipe {
  final String name;
  final String imageUrl;
  final String description;
  bool isFavorite;

  Recipe({
    required this.name,
    required this.imageUrl,
    required this.description,
    this.isFavorite = false,
  });
}

// Sample breakfast recipes
List<Recipe> breakfastRecipes = [
  Recipe(
    name: 'Pancakes',
    imageUrl: 'assets/pancakes.jpg',
    description:
        'Delicious fluffy pancakes served with maple syrup and fresh berries.',
  ),
  Recipe(
    name: 'Omelette',
    imageUrl: 'assets/omelette.jpg',
    description:
        'Scrambled eggs with spinach, bell peppers, and onions, served with toast.',
  ),
  Recipe(
    name: 'French Toast',
    imageUrl: 'assets/frenchtoast.jpg',
    description:
        'A hearty mix of rolled oats, nuts, and dried fruits, served with milk or yogurt.',
  ),
];

class BreakfastScreen extends StatefulWidget {
  @override
  _BreakfastScreenState createState() => _BreakfastScreenState();
}

class _BreakfastScreenState extends State<BreakfastScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breakfast Recipes'),
        backgroundColor: Colors.amber[100],
      ),
      body: ListView.builder(
        itemCount: breakfastRecipes.length,
        itemBuilder: (context, index) {
          final recipe = breakfastRecipes[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: Image.asset(
                recipe.imageUrl,
                width: 100,
                fit: BoxFit.cover,
              ),
              title: Text(recipe.name),
              subtitle: Text(recipe.description),
              trailing: IconButton(
                icon: Icon(
                  recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: recipe.isFavorite ? Colors.red : null,
                ),
                onPressed: () {
                  setState(() {
                    recipe.isFavorite = !recipe.isFavorite;
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
