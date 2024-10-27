// favorites_screen.dart
import 'package:flutter/material.dart';
import 'breakfast.dart';
import 'recipe_detail.dart';

class FavoritesScreen extends StatefulWidget {
  final List<Recipe> favoriteRecipes;
  final Function(Recipe) toggleFavorite;

  const FavoritesScreen({Key? key,required this.favoriteRecipes,required this.toggleFavorite,}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Favorites'),
        backgroundColor: Colors.amber[100],
      ),
      //error message if no recipes
      body: widget.favoriteRecipes.isEmpty
          ? const Center(
              child: Text(
                'No favorite recipes yet!',
                style: TextStyle(fontSize: 18),
              ),
            )
          : 
          //display list of favorites
          ListView.builder(
              itemCount: widget.favoriteRecipes.length,
              itemBuilder: (context, index) {
                final recipe = widget.favoriteRecipes[index];
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
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      //handle unfavorite
                      onPressed: () {
                        setState(() {
                          widget.toggleFavorite(recipe); //unfavorite 
                        });
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeDetailScreen(
                            recipe: recipe,
                            toggleFavorite: widget.toggleFavorite,
                          ),
                        ),
                      ).then((_) => setState(() {})); //referesh screen
                    },
                  ),
                );
              },
            ),
    );
  }
}
