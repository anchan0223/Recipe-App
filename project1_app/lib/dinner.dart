import 'package:flutter/material.dart';
import 'recipe_detail.dart';
import 'recipe.dart';

// Sample dinner recipes
List<Recipe> dinnerRecipes = [
  Recipe(
    name: 'Chili',
    imageUrl: 'assets/chili.jpg',
    servings: 8,
    cookTime: 45,
    prepTime: 15,
    ingredients: [
      '1 pound ground beef (or turkey)',
      '1 can kidney beans, drained and rinsed',
      '1 can diced tomatoes (with juice)',
      '1 can (8 oz) tomato sauce',
      '1 onion, chopped',
      '2 cloves garlic, minced',
      '2 tablespoons chili powder',
      '1 teaspoon cumin'
    ],
    instructions: [
      'In a large pot, brown the ground meat over medium heat. Drain excess fat.',
      'Add chopped onion and garlic. Cook until onion is soft.',
      'Stir in chili powder, cumin, salt, and pepper. Cook for 1 minute.',
      'Add kidney beans, diced tomatoes, and tomato sauce. Stir well.',
      'Bring to a boil, then reduce heat. Simmer for 20-30 minutes, stirring occasionally.'
    ],
  ),
  Recipe(
    name: 'Fried Rice',
    imageUrl: 'assets/fried-rice.jpg',
    servings: 8,
    cookTime: 15,
    prepTime: 5,
    ingredients: [
      '2 cups cooked rice (preferably day-old)',
      '2 tablespoons vegetable oil',
      '2 eggs, beaten',
      '1 cup mixed vegetables (like peas and carrots)',
      '3 green onions, chopped',
      '3 tablespoons soy sauce'
    ],
    instructions: [
      'Heat 1 tablespoon of oil in a large pan over medium heat. Add the beaten eggs and scramble until fully cooked. Remove eggs and set aside.',
      'In the same pan, add the remaining oil. Add mixed vegetables and cook for 2-3 minutes until tender.',
      'Add the cooked rice to the pan. Stir-fry for 3-5 minutes until heated through.',
      'Add the scrambled eggs back to the pan along with the chopped green onions and soy sauce. Mix well.'
    ],
  ),
  Recipe(
    name: 'Stuffed Bell Peppers',
    imageUrl: 'assets/stuffed-bell-peppers.jpg',
    servings: 4,
    cookTime: 40,
    prepTime: 15,
    ingredients: [
      '4 bell peppers',
      '1 lb ground beef (or turkey)',
      '1 cup cooked rice',
      '1 can diced tomatoes (drained)',
      '1 tsp Italian seasoning',
      '1 cup shredded cheese'
    ],
    instructions: [
      'Preheat oven to 375°F (190°C).',
      'Cut tops off bell peppers and remove seeds.',
      'Cook ground beef until browned; drain fat. Mix in rice, tomatoes, seasoning, salt, and pepper.',
      'Stuff peppers with the mixture and place in a baking dish. Top with cheese.',
      'Cover with foil and bake for 30 mins; remove foil and bake 10 more mins.'
    ],
  ),
];

class DinnerScreen extends StatefulWidget {
  //toggle favorite
  final Function(Recipe) toggleFavorite;

  //add to grocery list
  final Function(String) addToGroceryList;

  //constructor
  const DinnerScreen(
      {Key? key, required this.toggleFavorite, required this.addToGroceryList})
      : super(key: key);

  @override
  _DinnerScreenState createState() => _DinnerScreenState();
}

class _DinnerScreenState extends State<DinnerScreen> {
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
        title: const Text('Dinner Recipes'),
        backgroundColor: Colors.amber[100],
      ),
      body: ListView.builder(
        itemCount: dinnerRecipes.length,
        itemBuilder: (context, index) {
          final recipe = dinnerRecipes[index];
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
