import 'package:flutter/material.dart';
import 'package:recipe_app_api/models/recipe_model.dart';
import 'package:recipe_app_api/services/api_services.dart'; // Make sure ApiServices has search functionality

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<RecipeModel> filteredRecipes = []; // Store filtered recipes
  bool isLoading = false; // Track loading state
  String errorMessage = ''; // Store error message, if any

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // Function to search recipes based on query
  void _searchRecipes(String query) async {
    if (query.isEmpty) {
      setState(() {
        filteredRecipes = [];
        errorMessage = ''; // Reset error message
      });
    } else {
      setState(() {
        isLoading = true;
        errorMessage = ''; // Reset error message on new search
      });

      try {
        final recipes = await ApiServices().searchRecipes(query);
        setState(() {
          filteredRecipes = recipes;
          isLoading = false;
        });
      } catch (e) {
        setState(() {
          filteredRecipes = [];
          isLoading = false;
          errorMessage = 'Error fetching recipes: $e'; // Show error message
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search the recipes",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: searchController,
                onChanged: _searchRecipes, // Trigger search when text changes
                decoration: InputDecoration(
                  labelText: 'Search The Recipes',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Show loading indicator if searching
              if (isLoading) const Center(child: CircularProgressIndicator()),

              // Show error message if any
              if (errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                ),

              // Display filtered recipes
              Expanded(
                child: filteredRecipes.isEmpty && !isLoading
                    ? const Center(
                        child: Text(
                          'Search Recipes',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredRecipes.length,
                        itemBuilder: (context, index) {
                          final recipe = filteredRecipes[index];
                          return GestureDetector(
                            onTap: () {},
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network(
                                      recipe.recipeImage,
                                      height:
                                          150, // Set the height of the image
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          // Image loaded
                                          return child;
                                        } else {
                                          // While the image is loading, show a CircularProgressIndicator
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      (loadingProgress
                                                              .expectedTotalBytes ??
                                                          1)
                                                  : null,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      recipe.recipeName,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      "Category: ${recipe.category}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
