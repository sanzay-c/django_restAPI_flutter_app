import 'dart:convert';

class RecipeModel {
    int id;
    String user;
    String recipeName;
    String recipeIngridents;
    String recipeDescription;
    String instructions;
    int cookingTime;
    DateTime createdAt;
    String category;
    String recipeImage;

    RecipeModel({
        required this.id,
        required this.user,
        required this.recipeName,
        required this.recipeIngridents,
        required this.recipeDescription,
        required this.instructions,
        required this.cookingTime,
        required this.createdAt,
        required this.category,
        required this.recipeImage,
    });

    RecipeModel copyWith({
        int? id,
        String? user,
        String? recipeName,
        String? recipeIngridents,
        String? recipeDescription,
        String? instructions,
        int? cookingTime,
        DateTime? createdAt,
        String? category,
        String? recipeImage,
    }) => 
        RecipeModel(
            id: id ?? this.id,
            user: user ?? this.user,
            recipeName: recipeName ?? this.recipeName,
            recipeIngridents: recipeIngridents ?? this.recipeIngridents,
            recipeDescription: recipeDescription ?? this.recipeDescription,
            instructions: instructions ?? this.instructions,
            cookingTime: cookingTime ?? this.cookingTime,
            createdAt: createdAt ?? this.createdAt,
            category: category ?? this.category,
            recipeImage: recipeImage ?? this.recipeImage,
        );

    factory RecipeModel.fromRawJson(String str) => RecipeModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
        id: json["id"],
        user: json["user"],
        recipeName: json["recipe_name"],
        recipeIngridents: json["recipe_ingridents"],
        recipeDescription: json["recipe_description"],
        instructions: json["instructions"],
        cookingTime: json["cooking_time"],
        createdAt: DateTime.parse(json["created_at"]),
        category: json["category"],
        recipeImage: json["recipe_image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "recipe_name": recipeName,
        "recipe_ingridents": recipeIngridents,
        "recipe_description": recipeDescription,
        "instructions": instructions,
        "cooking_time": cookingTime,
        "created_at": createdAt.toIso8601String(),
        "category": category,
        "recipe_image": recipeImage,
    };
}
