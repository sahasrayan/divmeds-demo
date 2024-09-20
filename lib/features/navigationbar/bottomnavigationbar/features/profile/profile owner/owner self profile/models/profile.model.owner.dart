// import 'package:divmeds/features/auth/models/user.model.dart';
// import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/models/post.model.dart';

// class UserProfile {
//   final User user;
//   final List<Post> posts;

//   UserProfile({required this.user, required this.posts});

//   factory UserProfile.fromJson(Map<String, dynamic> json) {
//     return UserProfile(
//       user: User.fromJson(json['user']),
//       posts: (json['posts'] as List)
//           .map((post) => Post.fromJson(post))
//           .toList(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'user': user.toJson(),
//       'posts': posts.map((post) => post.toJson()).toList(),
//     };
//   }
// }
