import 'package:flutter/material.dart';
import 'recipe_detail.dart';
import 'recipe.dart';

// Sample breakfast recipes
List<Recipe> breakfastRecipes = [
  Recipe(
    name: 'Pancakes',
    imageUrl: 'assets/pancakes.jpg',
    servings: 4,
    cookTime: 20,
    prepTime: 5,
    ingredients: [
      '1 1/2 cups all-purpose flour',
      '3 1/2 teaspoons baking powder',
      '1 tablespoon white sugar',
      '1 teaspoon salt',
      '1 1/4 cups milk',
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
    ingredients: [
      '4 slices of bread',
      '2 Eggs',
      '1 cup Milk',
      '1 stick of Butter',
      '2 tbsp Cinnamon'
    ],
    instructions: [
      'Whisk milk, eggs, cinnamon into a bowl',
      'Dip bread into the mixture, soaking both sides',
      'Cook on hot skillet until golden brown',
    ],
  ),
  Recipe(
    name: 'Avocado Toast',
    imageUrl: 'assets/avocadotoast.jpg',
    servings: 2,
    cookTime: 5,
    prepTime: 5,
    ingredients: [
      '2 slices of bread',
      '1 Avocado',
      '1 tbsp Salt',
      '1 tbsp Pepper',
      '1 tbsp Red Pepper Flakes'
    ],
    instructions: [
      'Toast bread until golden brown',
      'Mash avocado and spread on toast',
      'Sprinkle salt, pepper, and red pepper flakes on top',
    ],
  ),
  Recipe(
    name: 'Smoothie Bowl',
    imageUrl: 'assets/smoothiebowl.jpg',
    servings: 1,
    cookTime: 5,
    prepTime: 5,
    ingredients: [
      '1/2 cup Frozen berries',
      '1/2 cup Strawberries',
      '1 Banana',
      '1/4 cup Almond milk',
      '1 cup Granola'
    ],
    instructions: [
      'Blend berries, strawberries, banana, and almond milk until smooth',
      'Pour into bowl and top with granola and fresh fruit',
    ],
  ),
];

class BreakfastScreen extends StatefulWidget {
  //toggle favorite
  final Function(Recipe) toggleFavorite;

  //add to grocery list
  final Function(String) addToGroceryList;

  //constructor
  const BreakfastScreen(
      {Key? key, required this.toggleFavorite, required this.addToGroceryList})
      : super(key: key);

  @override
  _BreakfastScreenState createState() => _BreakfastScreenState();
}

class _BreakfastScreenState extends State<BreakfastScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _search = '';
  Set<String> _allergies = {};

  //list of allergies
  final Set<String> _allergens = {
    for (var recipe in breakfastRecipes)
      for (var ingredient in recipe.ingredients)
        if (ingredient.toLowerCase().contains(RegExp(r'\bmilk\b|\bcheese\b|\bbutter\b')))
          'Dairy'
        else if (ingredient.toLowerCase().contains('peanut'))
          'Peanuts'
        else if (ingredient.toLowerCase().contains('egg'))
          'Egg'
        else if (ingredient.toLowerCase().contains(RegExp(r'\bflour\b|\bbread\b')))
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
    return breakfastRecipes.where((recipe) {
      final matchesSearch = _search.isEmpty || recipe.name.toLowerCase().contains(_search.toLowerCase());
      final excludesAllergen = !recipe.ingredients.any((ingredient) =>
          _allergies.any((allergen) {
            if (allergen == 'Dairy') {
              return ingredient.toLowerCase().contains(RegExp(r'\bmilk\b|\bcheese\b|\bbutter\b'));
            } else if (allergen == 'Gluten') {
              return ingredient.toLowerCase().contains(RegExp(r'\bflour\b|\bbread\b'));
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
          title: const Text('Breakfast Recipes'),
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
                children: _allergens.map((allergen) => FilterChip(
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
                )).toList(),
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
        ));
  }
}
