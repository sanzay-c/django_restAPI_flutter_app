import 'package:flutter/material.dart';
import 'package:recipe_app_api/models/comment_model.dart';
import 'package:recipe_app_api/services/api_services.dart';

class UserComments extends StatefulWidget {
  final int recipeId; // recipeId will be passed as a required parameter

  const UserComments({super.key, required this.recipeId});

  @override
  State<UserComments> createState() => _UserCommentsState();
}

class _UserCommentsState extends State<UserComments> {
  late Future<List<CommentModel>> userCommentsModel;

  @override
  void initState() {
    super.initState();
    // Fetch the comments for the specific recipeId
    userCommentsModel = ApiServices().fetchCommentsByRecipeId(widget.recipeId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      width: double.infinity,
      child: Column(
        children: [
          Text('User Comments', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          FutureBuilder<List<CommentModel>>(
            future: userCommentsModel,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                List<CommentModel> comments = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Username: ${comment.user}",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Comments: ${comment.content}",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Text('No comments available');
              }
            },
          ),
        ],
      ),
    );
  }
}
