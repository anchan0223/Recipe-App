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
 final TextEditingController _searchController = TextEditingController();
  String _search = '';
  Set<String> _allergies = {};

  //list of allergies
  final Set<String> _allergens = {
    for (var recipe in lunchRecipes)
      for (var ingredient in recipe.ingredients)
        if (ingredient.toLowerCase().contains(RegExp(r'\bmilk\b|\bcheese\b|\bbutter\b')))
          'Dairy'
        else if (ingredient.toLowerCase().contains('peanut'))
          'Peanuts'
        else if (ingredient.toLowerCase().contains('egg'))
          'Egg'
        else if (ingredient.toLowerCase().contains(RegExp(r'\bflour\b|\bbread\b|\bpasta\b')))
        'Gluten'
        else if (ingredient.toLowerCase().contains('shellfish'))
          'Shellfish'
        else if (ingredient.toLowerCase().contains('soy'))
          'Soy'
        else if (ingredient.toLowerCase().contains('nut') && !ingredient.toLowerCase().contains('peanut'))
          'Tree Nuts'
        else if (ingredient.toLowerCase().contains('fish'))
          'Fish'
  };

  //filter based on search and return filtered recipes
  List<Recipe> get filteredRecipes {
    return lunchRecipes.where((recipe) {
      final matchesSearch = _search.isEmpty || recipe.name.toLowerCase().contains(_search.toLowerCase());
      final excludesAllergen = !recipe.ingredients.any((ingredient) =>
          _allergies.any((allergen) {
            if (allergen == 'Dairy') {
              return ingredient.toLowerCase().contains(RegExp(r'\bmilk\b|\bcheese\b|\bbutter\b'));
            } else if (allergen == 'Gluten') {
              return ingredient.toLowerCase().contains(RegExp(r'\bflour\b|\bbread\b|\bpasta\b'));
            } else {
              return ingredient.toLowerCase().contains(allergen.toLowerCase());
            }
          }));
      return matchesSearch && excludesAllergen;
    }).toList();
  }

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
      body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                      labelText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search for a recipe',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  onChanged: (input) {
                    setState(() {
                      _search = input;
                    });
                  }),
              const SizedBox(height: 10),
              //alergy filter
              const Text('Filter by Allergen:'),
              Wrap(
                spacing: 10,
                children: _allergens
                    .map((allergen) => FilterChip(
                          label: Text(allergen),
                          selected: _allergies.contains(allergen),
                          onSelected: (isSelected) {
                            setState(() {
                              if (isSelected) {
                                _allergies.add(allergen);
                              } else {
                                _allergies.remove(allergen);
                              }
                            });
                          },
                        ))
                    .toList(),
              ),

              const SizedBox(height: 10),

              Expanded(
                child: ListView.builder(
                  itemCount: filteredRecipes.length,
                  itemBuilder: (context, index) {
                    final recipe = filteredRecipes[index];
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
                            recipe.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
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
              )
            ],
          ),
        )
    );
  }
}
