import 'dart:convert';

class CommentModel {
  int id;
  String content;
  DateTime createdAt;
  String user; // Changed user type to String
  int recipeName;

  CommentModel({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.user, // user is now a String
    required this.recipeName,
  });

  CommentModel copyWith({
    int? id,
    String? content,
    DateTime? createdAt,
    String? user, // user is now a String
    int? recipeName,
  }) =>
      CommentModel(
        id: id ?? this.id,
        content: content ?? this.content,
        createdAt: createdAt ?? this.createdAt,
        user: user ?? this.user, // user is now a String
        recipeName: recipeName ?? this.recipeName,
      );

  factory CommentModel.fromRawJson(String str) =>
      CommentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        id: json["id"],
        content: json["content"],
        createdAt: DateTime.parse(json["created_at"]),
        user: json["user"].toString(), // Convert user to String
        recipeName: json["recipe_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "created_at": createdAt.toIso8601String(),
        "user": user, // user is now a String
        "recipe_name": recipeName,
      };
}
