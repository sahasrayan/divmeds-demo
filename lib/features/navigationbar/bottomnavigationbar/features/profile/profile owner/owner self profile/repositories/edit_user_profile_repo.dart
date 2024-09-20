// import 'package:dio/dio.dart';
// import 'package:divmeds/features/auth/models/user.model.dart';


// class UserRepository {
//   final String serverUrl;
//   final Dio dio;

//   UserRepository({required this.serverUrl}) : dio = Dio();

//   Future<User> fetchUserProfile(String userId) async {
//     try {
//       final response = await dio.get('$serverUrl/user/$userId');
//       if (response.statusCode == 200) {
//         return User.fromJson(response.data);
//       } else {
//         throw Exception('Failed to load user profile');
//       }
//     } catch (e) {
//       throw Exception('Failed to load user profile: $e');
//     }
//   }

//   Future<void> updateProfile(String userId, Map<String, dynamic> updates) async {
//     try {
//       final response = await dio.put('$serverUrl/user/$userId', data: updates);
//       if (response.statusCode != 200) {
//         throw Exception('Failed to update user profile');
//       }
//     } catch (e) {
//       throw Exception('Failed to update user profile: $e');
//     }
//   }

// Future<void> updateProfilePicture(String userId, FormData formData) async {
//     try {
//       final response = await dio.put('$serverUrl/user/update-profile-picture', data: formData);
//       if (response.statusCode != 200) {
//         throw Exception('Failed to update profile picture');
//       }
//     } catch (e) {
//       throw Exception('Failed to update profile picture: $e');
//     }
//   }

//   Future<void> removeProfilePicture(String userId) async {
//     try {
//       final response = await dio.delete('$serverUrl/user/remove-profile-picture');
//       if (response.statusCode != 200) {
//         throw Exception('Failed to remove profile picture');
//       }
//     } catch (e) {
//       throw Exception('Failed to remove profile picture: $e');
//     }
//   }

//   Future<void> updatePassword(String userId, String oldPassword, String newPassword) async {
//     try {
//       final response = await dio.put('$serverUrl/user/update-password', data: {
//         'oldPassword': oldPassword,
//         'newPassword': newPassword,
//       });
//       if (response.statusCode != 200) {
//         throw Exception('Failed to update password');
//       }
//     } catch (e) {
//       throw Exception('Failed to update password: $e');
//     }
//   }

//   Future<void> updatePhoneNumber(String userId, String phone, String otp) async {
//     try {
//       final response = await dio.put('$serverUrl/user/verify-otp-update-phone', data: {
//         'phone': phone,
//         'otp': otp,
//       });
//       if (response.statusCode != 200) {
//         throw Exception('Failed to update phone number');
//       }
//     } catch (e) {
//       throw Exception('Failed to update phone number: $e');
//     }
//   }

//   Future<void> updateEducation(String userId, List<Education> education) async {
//     try {
//       final response = await dio.put('$serverUrl/user/update-education', data: {
//         'education': education.map((e) => e.toJson()).toList(),
//       });
//       if (response.statusCode != 200) {
//         throw Exception('Failed to update education details');
//       }
//     } catch (e) {
//       throw Exception('Failed to update education details: $e');
//     }
//   }

//   Future<void> updateProfessionalDetails(String userId, ProfessionalDetails professionalDetails) async {
//     try {
//       final response = await dio.put('$serverUrl/user/update-professional', data: {
//         'professionalDetails': professionalDetails.toJson(),
//       });
//       if (response.statusCode != 200) {
//         throw Exception('Failed to update professional details');
//       }
//     } catch (e) {
//       throw Exception('Failed to update professional details: $e');
//     }
//   }

// }
