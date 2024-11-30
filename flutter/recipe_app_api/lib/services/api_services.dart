import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:recipe_app_api/models/comment_model.dart';
import 'package:recipe_app_api/models/recipe_model.dart';
import 'package:recipe_app_api/models/user_profile_model.dart';

class ApiServices {
  // Fetch all recipes (as before)
  Future<List<RecipeModel>> fetchRecipe() async {
    try {
      const baseUrl = 'http://10.0.2.2:8000/api/recipe/';
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        log("success response: ");
        print(response.body);

        List<dynamic> jsonData = json.decode(response.body);
        List<RecipeModel> fetchRecipeList =
            jsonData.map((e) => RecipeModel.fromJson(e)).toList();

        return fetchRecipeList;
      } else {
        throw Exception(
            'Failed to load recipe. Status code: ${response.statusCode}');
      }
    } catch (e) {
      log("Error occurred while fetching recipe: $e");
      throw Exception('Error occurred while fetching recipe: $e');
    }
  }

  Future<List<RecipeModel>> searchRecipes(String query) async {
    const baseUrl = 'http://10.0.2.2:8000/api/recipe/search/';

    // Construct the URL with the search query
    final url = Uri.parse('$baseUrl?query=$query');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Parse the JSON response
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => RecipeModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search recipes');
    }
  }

  // Fetch a single recipe by ID
  Future<RecipeModel> fetchRecipeById(int recipeId) async {
    try {
      // URL with dynamic recipeId
      final baseUrl = 'http://10.0.2.2:8000/api/recipe/$recipeId/';
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        log("success response for recipe $recipeId: ");
        print(response.body);

        // Decode the JSON response into a RecipeModel
        final jsonData = json.decode(response.body);
        return RecipeModel.fromJson(jsonData);
      } else {
        // Handle failed response status
        throw Exception(
            'Failed to load recipe with ID $recipeId. Status code: ${response.statusCode}');
      }
    } catch (e) {
      log("Error occurred while fetching recipe by ID: $e");
      throw Exception('Error occurred while fetching recipe by ID: $e');
    }
  }

  // Fetch user profile (as before)
  Future<List<UserProfileModel>> fetchUserProfile() async {
    try {
      const baseUrl = 'http://10.0.2.2:8000/api/user-profile/';
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        log("success response: ");
        print(response.body);

        List<dynamic> jsonData = json.decode(response.body);
        List<UserProfileModel> fetchUserProfileList =
            jsonData.map((e) => UserProfileModel.fromJson(e)).toList();

        return fetchUserProfileList;
      } else {
        throw Exception(
            'Failed to load user-profile. Status code: ${response.statusCode}');
      }
    } catch (e) {
      log("Error occurred while fetching user-profile: $e");
      throw Exception('Error occurred while fetching user-profile: $e');
    }
  }

  // Fetch user comments (as before)
  Future<List<CommentModel>> fetchUserComment() async {
    try {
      const baseUrl = 'http://10.0.2.2:8000/api/comment/';
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        log("success response: ");
        print(response.body);

        List<dynamic> jsonData = json.decode(response.body);
        List<CommentModel> fetchUserCommentList =
            jsonData.map((e) => CommentModel.fromJson(e)).toList();

        return fetchUserCommentList;
      } else {
        throw Exception(
            'Failed to load user-comment. Status code: ${response.statusCode}');
      }
    } catch (e) {
      log("Error occurred while fetching user-comment: $e");
      throw Exception('Error occurred while fetching user-comment: $e');
    }
  }

  // Fetch user comments by recipe ID
  Future<List<CommentModel>> fetchCommentsByRecipeId(int recipeId) async {
    try {
      final baseUrl =
          'http://10.0.2.2:8000/api/comment/?recipe_id=$recipeId'; // Assuming your API supports filtering by recipe_id
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        List<CommentModel> fetchUserCommentList =
            jsonData.map((e) => CommentModel.fromJson(e)).toList();

        return fetchUserCommentList;
      } else {
        throw Exception('Failed to load comments for recipeId: $recipeId');
      }
    } catch (e) {
      log("Error occurred while fetching comments for recipeId: $recipeId: $e");
      throw Exception(
          'Error occurred while fetching comments for recipeId: $recipeId: $e');
    }
  }
}
