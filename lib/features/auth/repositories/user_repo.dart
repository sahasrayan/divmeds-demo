import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:divmeds/features/auth/models/user.model.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/models/post.model.dart';

class UserRepository {
  final Dio _dio = Dio();
  final String serverUrl;

  UserRepository({required this.serverUrl});

  // Get the logged-in user's profile
  Future<User?> getLoggedInUserProfile(String token) async {
    try {
      final response = await _dio.get(
        '$serverUrl/me',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log(response.data.toString());
        User user = User.fromJson(response.data);
        return user;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  // Get the logged-in user's education details
  Future<List<Education>?> getUserEducation(String token) async {
    try {
      final response = await _dio.get(
        '$serverUrl/me/education',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      // Log the full API response
      log('Full API Response: ${response.data}');

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        List<Education> education = (response.data as List)
            .map((i) => Education.fromJson(i))
            .toList();

        // Log the parsed education data
        log('Parsed Education Data: $education');

        return education;
      } else {
        log('Failed to fetch education data: ${response.statusMessage}');
        return null;
      }
    } catch (e) {
      log('Error fetching education data: $e');
      return null;
    }
  }

  // Get the logged-in user's professional details
  Future<List<ProfessionalDetails>?> getUserProfession(String token) async {
    try {
      final response = await _dio.get(
        '$serverUrl/me/profession',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        List<ProfessionalDetails> professionalDetails = (response.data as List)
            .map((i) => ProfessionalDetails.fromJson(i))
            .toList();
        return professionalDetails;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  // Update user profile name
  Future<void> updateProfileName(Map<String, dynamic> updates, String token) async {
    try {
      final response = await _dio.put(
        '$serverUrl/update/name',
        data: updates,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log('Profile name updated successfully');
      } else {
        throw Exception('Failed to update profile name');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to update profile name');
    }
  }

  // Update userId
  Future<void> updateUserId(String newUserId, String token) async {
    try {
      final response = await _dio.put(
        '$serverUrl/update-userId',
        data: {'newUserId': newUserId},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log('UserId updated successfully');
      } else {
        throw Exception('Failed to update userId');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to update userId');
    }
  }

  // Update user DOB
  Future<void> updateDob(String dob, String token) async {
    try {
      final response = await _dio.put(
        '$serverUrl/update-dob',
        data: {'dob': dob},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log('DOB updated successfully');
      } else {
        throw Exception('Failed to update DOB');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to update DOB');
    }
  }

  // Fetch the logged-in user's posts
  Future<List<Post>?> getMyPosts(String token) async {
    try {
      final response = await _dio.get(
        '$serverUrl/me/posts',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log(response.data.toString());
        List<Post> posts = (response.data as List).map((i) => Post.fromJson(i)).toList();
        return posts;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  // Share the logged-in user's profile
  Future<void> shareUserProfile(String token) async {
    try {
      final response = await _dio.get(
        '$serverUrl/share/me',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log('User profile shared successfully');
      } else {
        throw Exception('Failed to share user profile');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to share user profile');
    }
  }

  // Get another user's profile by user ID
  Future<User?> getUserProfile(String userId, String token) async {
    try {
      final response = await _dio.get(
        '$serverUrl/$userId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log(response.data.toString());
        User user = User.fromJson(response.data);
        return user;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  // Get another user's profile by user summary ID
  Future<User?> getUserProfileBySummaryId(String summaryId, String token) async {
    try {
      final response = await _dio.get(
        '$serverUrl/summaryid/$summaryId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log(response.data.toString());
        User user = User.fromJson(response.data);
        return user;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  // Get userId by summaryId
  Future<String?> getUserIdBySummaryId(String summaryId, String token) async {
    try {
      final response = await _dio.get(
        '$serverUrl/summaryid/$summaryId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log('User data: ${response.data}');
        return response.data['userId']; // Assuming your API response contains 'userId'
      } else {
        return null;
      }
    } catch (e) {
      log('Error fetching userId by summaryId: $e');
      return null;
    }
  }

  // Share other user's profile
  Future<void> shareOtherUserProfile(String userId, String token) async {
    try {
      final response = await _dio.get(
        '$serverUrl/share/$userId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log('Other user profile shared successfully');
      } else {
        throw Exception('Failed to share other user profile');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to share other user profile');
    }
  }

  // Update user profile picture
  Future<void> updateProfilePicture(FormData formData, String token) async {
    try {
      final response = await _dio.put(
        '$serverUrl/update-profile-picture',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log('Profile picture updated successfully');
      } else {
        throw Exception('Failed to update profile picture');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to update profile picture');
    }
  }

  // Remove user profile picture
  Future<void> removeProfilePicture(String token) async {
    try {
      final response = await _dio.delete(
        '$serverUrl/remove-profile-picture',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log('Profile picture removed successfully');
      } else {
        throw Exception('Failed to remove profile picture');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to remove profile picture');
    }
  }

  // Update user email
  Future<void> updateEmail(Map<String, dynamic> emailData, String token) async {
    try {
      final response = await _dio.put(
        '$serverUrl/update-email',
        data: emailData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log('Email updated successfully');
      } else {
        throw Exception('Failed to update email');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to update email');
    }
  }

  // Update user password
  Future<void> updatePassword(Map<String, dynamic> passwordData, String token) async {
    try {
      final response = await _dio.put(
        '$serverUrl/update-password',
        data: passwordData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log('Password updated successfully');
      } else {
        throw Exception('Failed to update password');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to update password');
    }
  }

  // Send OTP for phone number update
  Future<void> sendOtp(String phone, String token) async {
    try {
      final response = await _dio.post(
        '$serverUrl/send-otp',
        data: {'phone': phone},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log('OTP sent successfully');
      } else {
        throw Exception('Failed to send OTP');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to send OTP');
    }
  }

  // Verify OTP and update phone number
  Future<void> verifyOtpAndUpdatePhone(Map<String, dynamic> otpData, String token) async {
    try {
      final response = await _dio.put(
        '$serverUrl/verify-otp-update-phone',
        data: otpData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log('Phone number updated successfully');
      } else {
        throw Exception('Failed to update phone number');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to update phone number');
    }
  }

  // Send OTP for password reset
  Future<void> sendForgotPasswordOtp(String phone) async {
    try {
      final response = await _dio.post(
        '$serverUrl/forgot-password/send-otp',
        data: {'phone': phone},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log('Forgot password OTP sent successfully');
      } else {
        throw Exception('Failed to send forgot password OTP');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to send forgot password OTP');
    }
  }

  // Verify OTP and reset password
  Future<void> verifyOtpAndResetPassword(Map<String, dynamic> otpData) async {
    try {
      final response = await _dio.post(
        '$serverUrl/forgot-password/verify-otp',
        data: otpData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log('Password reset successfully');
      } else {
        throw Exception('Failed to reset password');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to reset password');
    }
  }

  // Update user gender
  Future<void> updateGender(Map<String, dynamic> genderData, String token) async {
    try {
      final response = await _dio.put(
        '$serverUrl/update-gender',
        data: genderData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log('Gender updated successfully');
      } else {
        throw Exception('Failed to update gender');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to update gender');
    }
  }

// Update user educational details
  Future<void> updateEducation(List<Education> education, String token) async {
    try {
      final data = {
        'education': education.map((e) => e.toJson()).toList(),
      };
      log('Sending education data to server: $data');
      
      final response = await _dio.put(
        '$serverUrl/update-education',
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log('Education details updated successfully');
      } else {
        log('Failed to update education details: ${response.statusMessage}');
        log('Response data: ${response.data}');
        throw Exception('Failed to update education details');
      }
    } catch (e) {
      log('Error updating education details: $e');
      throw Exception('Failed to update education details');
    }
  }
  // Update user professional details
  Future<void> updateProfessionalDetails(List<ProfessionalDetails> professionalDetails, String token) async {
    try {
      final response = await _dio.put(
        '$serverUrl/update-professional',
        data: {
          'professionalDetails': professionalDetails.map((e) => e.toJson()).toList(),
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log('Professional details updated successfully');
      } else {
        throw Exception('Failed to update professional details');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to update professional details');
    }
  }

  // Get the logged-in user's tagline
  Future<String?> getTagline(String token) async {
    try {
      final response = await _dio.get(
        '$serverUrl/me/tagline',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log('Tagline fetched successfully');
        return response.data['tagline'];
      } else {
        throw Exception('Failed to get tagline');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to get tagline');
    }
  }

  // Update the logged-in user's tagline
  Future<void> updateTagline(String tagline, String token) async {
    try {
      final response = await _dio.put(
        '$serverUrl/me/tagline',
        data: {'tagline': tagline},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log('Tagline updated successfully');
      } else {
        throw Exception('Failed to update tagline');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to update tagline');
    }
  }

  // Get the logged-in user's about section
  Future<String?> getAboutSection(String token) async {
    try {
      final response = await _dio.get(
        '$serverUrl/me/about',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log('About section fetched successfully');
        return response.data['aboutSection'];
      } else {
        throw Exception('Failed to get about section');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to get about section');
    }
  }

  // Update the logged-in user's about section
  Future<void> updateAboutSection(String aboutSection, String token) async {
    try {
      final response = await _dio.put(
        '$serverUrl/me/about',
        data: {'aboutSection': aboutSection},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log('About section updated successfully');
      } else {
        throw Exception('Failed to update about section');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to update about section');
    }
  }

  // Get the logged-in user's location
  Future<String?> getLocation(String token) async {
    try {
      final response = await _dio.get(
        '$serverUrl/me/location',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log('Location fetched successfully');
        return response.data['location'];
      } else {
        throw Exception('Failed to get location');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to get location');
    }
  }

  // Update the logged-in user's location
  Future<void> updateLocation(String location, String token) async {
    try {
      final response = await _dio.put(
        '$serverUrl/me/location',
        data: {'location': location},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log('Location updated successfully');
      } else {
        throw Exception('Failed to update location');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to update location');
    }
  }

  // Get the logged-in user's links
  Future<List<Link>?> getLinks(String token) async {
    try {
      final response = await _dio.get(
        '$serverUrl/me/links',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log('Links fetched successfully');
        List<Link> links = (response.data['links'] as List)
            .map((i) => Link.fromJson(i))
            .toList();
        return links;
      } else {
        throw Exception('Failed to get links');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to get links');
    }
  }

  // Update the logged-in user's links
  Future<void> updateLinks(List<Link> links, String token) async {
    try {
      final response = await _dio.put(
        '$serverUrl/me/links',
        data: {
          'links': links.map((e) => e.toJson()).toList(),
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log('Links updated successfully');
      } else {
        throw Exception('Failed to update links');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to update links');
    }
  }

  // Get another user's links by user ID
  Future<List<Link>?> getUserLinks(String userId, String token) async {
    try {
      final response = await _dio.get(
        '$serverUrl/$userId/links',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log('Links fetched successfully');
        List<Link> links = (response.data['links'] as List)
            .map((i) => Link.fromJson(i))
            .toList();
        return links;
      } else {
        throw Exception('Failed to get links');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to get links');
    }
  }

  // Get the logged-in user's user tags
  Future<List<String>?> getUserTags(String token) async {
    try {
      final response = await _dio.get(
        '$serverUrl/me/usertags',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log('User tags fetched successfully');
        List<String> userTags = List<String>.from(response.data['userTags']);
        return userTags;
      } else {
        throw Exception('Failed to get user tags');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to get user tags');
    }
  }

  // Update the logged-in user's user tags
  Future<void> updateUserTags(List<String> userTags, String token) async {
    try {
      final response = await _dio.put(
        '$serverUrl/me/usertags',
        data: {'userTags': userTags},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log('User tags updated successfully');
      } else {
        throw Exception('Failed to update user tags');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to update user tags');
    }
  }
}
