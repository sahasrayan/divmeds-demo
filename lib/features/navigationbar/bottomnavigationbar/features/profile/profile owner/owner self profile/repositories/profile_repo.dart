// import 'package:dio/dio.dart';
// import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20owner/owner%20self%20profile/models/profile.model.owner.dart';

// class UserProfileRepository {
//   final String baseUrl;
//   final Dio dio;

//   UserProfileRepository({required this.baseUrl}) : dio = Dio();

//   Future<UserProfile> fetchUserProfile(String userId) async {
//     try {
//       final response = await dio.get('$baseUrl/user/$userId');

//       if (response.statusCode == 200) {
//         return UserProfile.fromJson(response.data);
//       } else {
//         throw Exception('Failed to load user profile');
//       }
//     } catch (e) {
//       throw Exception('Failed to load user profile: $e');
//     }
//   }
// }
