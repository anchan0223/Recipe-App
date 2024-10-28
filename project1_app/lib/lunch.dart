import 'package:flutter/material.dart';
import 'recipe_detail.dart';
import 'recipe.dart';

// Sample lunch recipes
List<Recipe> lunchRecipes = [
  Recipe(
    name: 'Grilled Cheese',
    imageUrl: 'assets/grilled-cheese.jpg',
    servings: 2,
    cookTime: 10,
    prepTime: 5,
    ingredients: [
      '2 slices of white bread',
      '2 tablespoons of butter',
      '2 slices of cheeder cheese'
    ],
    instructions: [
      'Butter one slide of bread. Place that butter side down on hot skillet.',
      'Add slice of cheese. Butter the second slice and place butter side up on top of cheese.',
      'Cook then flip until lightly browned.',
    ],
  ),
  Recipe(
    name: 'Chicken Noodle Soup',
    imageUrl: 'assets/chicken-noodle-soup.jpg',
    servings: 6,
    cookTime: 30,
    prepTime: 10,
    ingredients: [
      '2 cups cooked chicken, shredded',
      '4 cups chicken broth',
      '1 cup carrots, sliced',
      '1 cup celery, sliced',
      '1 cup egg noodles',
      '1 onion, chopped',
      '2 cloves garlic, minced'
    ],
    instructions: [
      'In a large pot, sauté onion and garlic until soft.',
      'Add carrots and celery, cooking for 5 minutes.',
      'Pour in chicken broth and bring to a boil.',
      'Add egg noodles and cook according to package instructions.',
      'Stir in chicken.',
      'Simmer for 10 minutes.',
    ],
  ),
  Recipe(
    name: 'Pasta Salad',
    imageUrl: 'assets/pasta-salad.jpg',
    servings: 6,
    cookTime: 10,
    prepTime: 20,
    ingredients: [
      '2 cups cooked pasta (any type)',
      '1 cup cherry tomatoes, halved',
      '1 cup cucumber, diced',
      '1/2 cup red onion, diced',
      '1 cup bell pepper, diced',
      '1/4 cup olive oil',
      '2 tablespoons red wine vinegar',
      '1 teaspoon Italian seasoning'
    ],
    instructions: [
      'In a large bowl, combine the cooked pasta, cherry tomatoes, cucumber, bell pepper, red onion.',
      'In a small bowl, whisk together olive oil, red wine vinegar, Italian seasoning, salt, and pepper.',
      'Pour the dressing over the pasta salad and toss to combine.',
      'Chill in the refrigerator for at least 30 minutes before serving.',
    ],
  ),
];

class LunchScreen extends StatefulWidget {
  //toggle favorite
  final Function(Recipe) toggleFavorite;

  //add to grocery list
  final Function(String) addToGroceryList;

  //constructor
  const LunchScreen(
      {Key? key, required this.toggleFavorite, required this.addToGroceryList})
      : super(key: key);

  @override
  _LunchScreenState createState() => _LunchScreenState();
}

class _LunchScreenState extends State<LunchScreen> {
  //open recipe details
  void _openRecipeDetail(BuildContext context, Recipe recipe) async {
    //wait for favorite status change
    final updatedRecipe = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipeDetailScreen(
          recipe: recipe,
          toggleFavorite: widget.toggleFavorite,
          addToGroceryList: widget.addToGroceryList,
        ),
      ),
    );

    //referesh if favorite status changed
    if (updatedRecipe != null) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lunch Recipes'),
        backgroundColor: Colors.amber[100],
      ),
      body: ListView.builder(
        itemCount: lunchRecipes.length,
        itemBuilder: (context, index) {
          final recipe = lunchRecipes[index];
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
                  //toggle favorite and update ui
                  widget.toggleFavorite(recipe);
                  setState(() {});
                },
              ),
              //open recipe details
              onTap: () => _openRecipeDetail(context, recipe),
            ),
          );
        },
      ),
    );
  }
}
