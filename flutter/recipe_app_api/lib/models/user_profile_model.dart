class UserProfileModel {
  final int id;
  final String user; // Changed to String
  final String? profilePic; // Nullable
  final String? bio; // Nullable
  final DateTime? dob; // Nullable

  UserProfileModel({
    required this.id,
    required this.user,
    this.profilePic,
    this.bio,
    this.dob,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json["id"] ?? 0, // Default to 0 if null
      user: json["user"] ?? 'Unknown', // Default to 'Unknown' if null
      profilePic: json["profile_pic"], // Nullable String
      bio: json["bio"], // Nullable String
      dob: json["dob"] != null ? DateTime.parse(json["dob"]) : null, // Nullable DateTime
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "profile_pic": profilePic,
        "bio": bio,
        "dob": dob != null
            ? "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}"
            : null,
      };
}
