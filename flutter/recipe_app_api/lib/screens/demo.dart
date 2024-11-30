import 'package:flutter/material.dart';
import 'package:recipe_app_api/models/user_profile_model.dart';
import 'package:recipe_app_api/services/api_services.dart';

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  final Future<List<UserProfileModel>> userDataModel =
      ApiServices().fetchUserProfile();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('This is demo'),
      ),
      body: FutureBuilder<List<UserProfileModel>>(
  future: userDataModel,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (snapshot.hasError) {
      return Center(
        child: Text(
          'Error: ${snapshot.error}',
          style: const TextStyle(color: Colors.red),
        ),
      );
    } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
      final userInfo = snapshot.data![0];
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture
            if (userInfo.profilePic != null)
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(userInfo.profilePic!),
              )
            else
              const CircleAvatar(
                radius: 50,
                child: Icon(Icons.person, size: 40),
              ),
            const SizedBox(height: 16),

            // User Name
            Text(
              'Username: ${userInfo.user}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Bio
            Text(
              userInfo.bio ?? 'No bio available',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),

            // DOB
            if (userInfo.dob != null)
              Text(
                'Date of Birth: ${userInfo.dob!.toLocal().toString().split(' ')[0]}',
                style: const TextStyle(color: Colors.grey),
              )
            else
              const Text(
                'Date of Birth: Not available',
                style: TextStyle(color: Colors.grey),
              ),
          ],
        ),
      );
    } else {
      return const Center(
        child: Text('No user information available.'),
      );
    }
  },
),

    );
  }
}
