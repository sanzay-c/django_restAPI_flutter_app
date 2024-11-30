import 'package:flutter/material.dart';
import 'package:recipe_app_api/models/recipe_model.dart';
import 'package:recipe_app_api/screens/user_comments.dart';
import 'package:recipe_app_api/services/api_services.dart';

class RecipeDetailsPage extends StatefulWidget {
  final int recipeId; // Recipe ID passed as a parameter

  const RecipeDetailsPage({super.key, required this.recipeId});

  @override
  State<RecipeDetailsPage> createState() => _RecipeDetailsPageState();
}

class _RecipeDetailsPageState extends State<RecipeDetailsPage> {
  late Future<RecipeModel> recipeDataModel; // Fetch a single recipe dynamically

  @override
  void initState() {
    super.initState();
    // Initialize the recipe data model with the specific recipe ID
    recipeDataModel = ApiServices().fetchRecipeById(widget.recipeId);
  }

  void _showComments() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => UserComments(
        recipeId: widget.recipeId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark_border, color: Colors.white),
            onPressed: () {
             
            },
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: FutureBuilder<RecipeModel>(
        future: recipeDataModel,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final recipe = snapshot.data!; // Now recipe is a single object.
            return Stack(
              children: [
                // Background Image
                Positioned.fill(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(30)),
                          child: recipe.recipeImage.isNotEmpty
                              ? Image.network(
                                  recipe.recipeImage,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Center(
                                        child: Text('Image not available'));
                                  },
                                )
                              : Container(
                                  color: Colors.grey[200],
                                  child: Center(child: Text("No Image")),
                                ),
                        ),
                      ),
                      Expanded(flex: 3, child: Container(color: Colors.white)),
                    ],
                  ),
                ),
                // Content
                Positioned.fill(
                  top: MediaQuery.of(context).size.height * 0.3,
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30)),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              height: 5,
                              width: 50,
                              color: Colors.grey[300],
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            recipe.recipeName ?? 'Recipe Title',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                'By: ${recipe.user ?? 'Unknown'}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              const Icon(Icons.star,
                                  color: Colors.orange, size: 20),
                              const Text(
                                ' N/A',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.access_time, color: Colors.grey),
                                  SizedBox(width: 5),
                                  Text('${recipe.cookingTime ?? 'N/A'} mins'),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Category: '),
                                  SizedBox(width: 5),
                                  Text('${recipe.category ?? 'N/A'}'),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.local_fire_department,
                                      color: Colors.grey),
                                  SizedBox(width: 5),
                                  Text('${'N/A'} cal'),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Description',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Text(
                            recipe.recipeDescription,
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Ingredients',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Column(children: [Text(recipe.recipeIngridents)]),
                          SizedBox(height: 20),
                          Text(
                            'Instruction',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Column(children: [Text(recipe.instructions)]),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: ElevatedButton(
                              onPressed: _showComments,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors
                                    .transparent, // Transparent background
                                iconColor: Colors
                                    .blue, // Text color (blue for contrast)
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      12), // Rounded corners
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 14,
                                    horizontal: 32), // Button padding
                                elevation:
                                    0, // No shadow to maintain transparency
                                side: BorderSide(
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                    width: 2), // Border color and width
                              ),
                              child: Text(
                                'View Comments',
                                style: TextStyle(
                                    fontSize: 16, // Text size
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black // Text weight
                                    ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(child: Text('No Data Available.'));
          }
        },
      ),
    );
  }
}
