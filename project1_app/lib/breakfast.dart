import 'package:flutter/material.dart';

class Recipe {
  final String name;
  final String imageUrl;
  final int servings;
  final int cookTime;
  final int prepTime;
  final List<String> ingredients;
  final List<String> instructions;
  bool isFavorite;

  Recipe({
    required this.name,
    required this.imageUrl,
    required this.servings,
    required this.cookTime,
    required this.prepTime,
    required this.ingredients,
    required this.instructions,
    this.isFavorite = false,
  });
}

// Sample breakfast recipes
List<Recipe> breakfastRecipes = [
  Recipe(
    name: 'Pancakes',
    imageUrl: 'assets/pancakes.jpg',
    servings: 4,
    cookTime: 20,
    prepTime: 5,
    ingredients: [
      '1 ½ cups all-purpose flour',
      '3 ½ teaspoons baking powder',
      '1 tablespoon white sugar',
      '1 teaspoon salt',
      '1 ¼ cups milk',
      '3 tablespoons melted butter',
      '1 egg'
    ],
    instructions: [
      'Gather all ingredients',
      'Mix flour, baking powder, sugar, and salt in a large bowl. Whisk in milk, butter, and egg.',
      'Heat skillet over medium-high heat and spray with cooking spray. Pour batter into skillet and cook till golden brown.'
    ],
  ),
  Recipe(
    name: 'Ham & Cheese Omelette',
    imageUrl: 'assets/omelette.jpg',
    servings: 1,
    cookTime: 10,
    prepTime: 10,
    ingredients: [
      '2 teaspoons vegetable oil',
      '4 slices deli ham',
      '2 eggs',
      'fresh chives',
      'Chedder cheese'
    ],
    instructions: [
      'Whisk egg and chives into a bowl. Add ham into the bowl',
      'Pour mixture into skillet. Sprink cheddar on top and fold the omelette in half ',
      'Flip and cook until egg is set'
    ],
  ),
  Recipe(
    name: 'French Toast',
    imageUrl: 'assets/frenchtoast.jpg',
    servings: 3,
    cookTime: 10,
    prepTime: 5,
    ingredients: ['Bread', 'Eggs', 'Milk', 'Butter', 'Cinnamon'],
    instructions: [
      'Whisk milk, eggs, cinnamon into a bowl',
      'Dip bread into the mixture, soaking both sides',
      'Cook on hot skillet until golden brown'
    ],
  ),
];

class BreakfastScreen extends StatefulWidget {
  @override
  _BreakfastScreenState createState() => _BreakfastScreenState();
}

class _BreakfastScreenState extends State<BreakfastScreen> {
  void _openRecipeDetail(BuildContext context, Recipe recipe) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipeDetailScreen(recipe: recipe),
      ),
    );
  }

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
              onTap: () => _openRecipeDetail(context, recipe),
            ),
          );
        },
      ),
    );
  }
}

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({Key? key, required this.recipe}) : super(key: key);

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
                ElevatedButton(
                  onPressed: () {
                    // Handle add to meal plan action
                  },
                  child: const Text('Add to meal plan'),
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
