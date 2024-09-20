// import 'package:dio/dio.dart';
// import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20outsider/models/outsider_profile_model.dart';

// class OutsiderProfileRepository {
//   final Dio _dio = Dio();
//   final String baseUrl;

//   OutsiderProfileRepository({required this.baseUrl});

//   Future<OutsiderProfile> fetchOutsiderProfile(String userId) async {
//     try {
//       final response = await _dio.get('$baseUrl/profile/$userId');

//       if (response.statusCode == 200) {
//         return OutsiderProfile.fromJson(response.data);
//       } else {
//         throw Exception('Failed to load outsider profile');
//       }
//     } catch (e) {
//       throw Exception('Error fetching profile: $e');
//     }
//   }
// }
