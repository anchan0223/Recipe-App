import 'package:flutter/material.dart';

class GroceryListScreen extends StatefulWidget {
  final List<String> groceryList;
  final List<String> checkedItems; 
  final Function(String) removeFromGroceryList;

  const GroceryListScreen({Key? key,required this.groceryList,required this.removeFromGroceryList, required this.checkedItems}) : super(key: key);

  @override
  _GroceryListScreenState createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen> {


  //clean ingredients names
  String cleanIngredient(String ingredient) {
  //remove everything except ingredient
  final pattern = RegExp(
   r'^[\d\s/]+(?:\s*(?:cup|cups|tablespoon|tablespoons|teaspoon|teaspoons|tbsp|tsp|stick|sticks|slice|slices|oz|ounce|ounces|gram|grams|kg|pound|lb|ml|liter|liters|pinch|dash))?\b\s*',
    caseSensitive: false,
  );

  //return cleaned ingredient
  return ingredient.replaceAll(pattern, '').trim();
}



  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grocery List'),
        backgroundColor: Colors.amber[100],
      ),
      body: widget.groceryList.isEmpty
          ? const Center(child: Text('Your grocery list is empty!'))
          : ListView.builder(
              itemCount: widget.groceryList.length,
              itemBuilder: (context, index) {
                final item = widget.groceryList[index];
                final cleanedItem = cleanIngredient(item); // Cleaned for display
                final isChecked = widget.checkedItems.contains(item);

                return ListTile(
                  title: Text(
                    cleanedItem,
                    style: TextStyle(
                      decoration: isChecked
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  leading: Checkbox(
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          widget.checkedItems.add(item);
                        } else {
                          widget.checkedItems.remove(item);
                        }
                      });
                    },
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        widget.removeFromGroceryList(item);
                        widget.checkedItems.remove(item); 
                      });
                    },
                  ),
                );
              },
            ),
    );
   }
}