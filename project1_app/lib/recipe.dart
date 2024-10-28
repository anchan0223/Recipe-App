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
