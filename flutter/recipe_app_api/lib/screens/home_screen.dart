import 'package:flutter/material.dart';
import 'package:recipe_app_api/models/recipe_model.dart';
import 'package:recipe_app_api/screens/recipe_details_page.dart';
import 'package:recipe_app_api/screens/search_screen.dart';
import 'package:recipe_app_api/services/api_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Future<List<RecipeModel>> recipeDataModel = ApiServices().fetchRecipe();
  
  // Function to refresh the data
  Future<void> _onRefresh(BuildContext context) async {
    // Triggering a refresh by reloading the data
    await ApiServices().fetchRecipe();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe Sharing App', style: TextStyle(fontWeight: FontWeight.bold),),
        actions: [
          IconButton(
              onPressed: () {
                 Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(),
                ),
              );
              },
              icon: Icon(
                Icons.search,
                size: 30,
              ))
        ],
      ),
      body: FutureBuilder(
        future: recipeDataModel,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('NO DATA AVAILABLE'),
            );
          } else if (snapshot.hasData) {
            final List<RecipeModel> recipeList = snapshot.data!;
            return RefreshIndicator(
              onRefresh: () => _onRefresh(context),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Set the number of columns you want
                  crossAxisSpacing: 16, // Space between columns
                  mainAxisSpacing: 16, // Space between rows
                  childAspectRatio:
                      0.8, // Aspect ratio of each item (adjust as needed)
                ),
                padding: const EdgeInsets.all(16), // Padding around the grid
                itemCount: recipeList.length,
                itemBuilder: (context, index) {
                  final recipe = recipeList[index];
                  return GestureDetector(
                    onTap: () {
                      // Pass the recipeId to RecipeDetailsPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeDetailsPage(
                            recipeId:
                                recipe.id, // Pass the ID of the selected recipe
                          ),
                        ),
                      );
                    },
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
                              height: 150, // Set the height of the image
                              width: double.infinity,
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context, Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  // Image loaded
                                  return child;
                                } else {
                                  // While the image is loading, show a CircularProgressIndicator
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes !=
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
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
