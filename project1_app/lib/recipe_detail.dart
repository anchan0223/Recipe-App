import 'package:flutter/material.dart';
import 'breakfast.dart';

class RecipeDetailScreen extends StatefulWidget {
  //get recipe and toggleFavorite function
  final Recipe recipe;
  final Function(Recipe) toggleFavorite;

  //get add to grocery list function
  final Function(String) addToGroceryList;

  //constructor
  const RecipeDetailScreen({
    Key? key,
    required this.recipe,
    required this.toggleFavorite,
    required this.addToGroceryList,
  }) : super(key: key);

  @override
  _RecipeDetailScreenState createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  //init state
  late bool isFavorite;
  bool hasFavoriteStatusChanged = false;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.recipe.isFavorite;
  }

  //toggle favorite function
  void _toggleFavorite() {
    setState(() {
      widget.toggleFavorite(widget.recipe);
      isFavorite = widget.recipe.isFavorite;
      hasFavoriteStatusChanged = true;
    });
  }

  //send favorite status to previous screen
  void popWithResult() {
    Navigator.pop(context, hasFavoriteStatusChanged ? widget.recipe : null);
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.name),
        backgroundColor: Colors.amber[100],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          //pop on back btn
          onPressed: popWithResult,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                widget.recipe.imageUrl,
                width: 200,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '${widget.recipe.servings} servings | Cook time: ${widget.recipe.cookTime} mins | Prep time: ${widget.recipe.prepTime} mins',
              style: const TextStyle(fontSize: 18),
            ),
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.black,
              ),
              //toggle favorite
              onPressed: _toggleFavorite,
            ),
            const SizedBox(height: 20),
            const Text(
              'Ingredients:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ...widget.recipe.ingredients.map((ingredient) {
                  bool isAdded = false;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(ingredient),
                      StatefulBuilder(
                        builder: (context, setState) {
                          return ElevatedButton(
                            onPressed: () {
                              widget.addToGroceryList(ingredient);
                              setState(() {
                                isAdded = true;
                              });
                            },
                            child: Text(isAdded ? 'Added' : 'Add to grocery list'),
                          );
                        },
                      ),
                    ],
                  );
                }),
            const SizedBox(height: 20),
            const Text(
              'Instructions:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ListView.builder(
              //display within scroll view
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),

              itemCount: widget.recipe.instructions.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    '${index + 1}. ${widget.recipe.instructions[index]}',
                    style: const TextStyle(fontSize: 16),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
