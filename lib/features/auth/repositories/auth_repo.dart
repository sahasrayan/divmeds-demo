import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:divmeds/core/db/local/sharepreferencesmanager.dart';
import 'package:divmeds/features/auth/models/user.model.dart';

class AuthRepository {
  final Dio _dio = Dio();
  final String serverUrl;

  AuthRepository({required this.serverUrl});

  // Register a new user
  Future<User?> register({
    required String firstName,
    required String lastName,
    required String userId,
    required String password,
    required String phone,
    required String dob,
    required String gender,
  }) async {
    try {
      final response = await _dio.post(
        '$serverUrl/auth/register',
        data: {
          'firstName': firstName,
          'lastName': lastName,
          'userId': userId,
          'password': password,
          'phone': phone,
          'dob': dob,
          'gender': gender,
        },
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log(response.data.toString());
        User userModel = User.fromJson(response.data['user']);
        return userModel;
      } else {
        log('Failed to register: ${response.data.toString()}');
        return null;
      }
    } catch (e) {
      log('Error during registration: $e');
      return null;
    }
  }

  // Login a user
  Future<Map<String, dynamic>?> login({
    required String phone,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '$serverUrl/auth/login',
        data: {
          'phone': phone,
          'password': password,
        },
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log('Login response: ${response.data.toString()}');
        // Save token and user ID
        String token = response.data['token'];
        User user = User.fromJson(response.data['user']);
        await SharedPreferencesManager.saveToken(token);
        await SharedPreferencesManager.saveUid(user.userId);
        return {
          'token': token,
          'user': user,
        };
      } else {
        log('Failed to login: ${response.data.toString()}');
        return null;
      }
    } catch (e) {
      log('Error during login: $e');
      return null;
    }
  }

  // Logout a user
  Future<bool> logout(String token) async {
    try {
      final response = await _dio.post(
        '$serverUrl/auth/logout',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        // Clear token and user ID
        await SharedPreferencesManager.clear();
        return true;
      } else {
        log('Failed to logout: ${response.data.toString()}');
        return false;
      }
    } catch (e) {
      log('Error during logout: $e');
      return false;
    }
  }
}