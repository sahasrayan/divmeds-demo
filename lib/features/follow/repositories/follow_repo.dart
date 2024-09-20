import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:divmeds/features/follow/models/follow.model.dart';


class FollowRepository {
  final String serverUrl;
  final Dio _dio;

  FollowRepository({required this.serverUrl})
      : _dio = Dio(BaseOptions(
          baseUrl: serverUrl,
          headers: {
            'Content-Type': 'application/json',
          },
        ));

  Future<bool> followUser(String token, String userId) async {
    try {
      final response = await _dio.post(
        '$serverUrl/follower-following/follow',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: jsonEncode({'userId': userId}),
      );

      return response.statusCode == 201;
    } catch (error) {
      print('Failed to follow user: $error');
      return false;
    }
  }

  Future<bool> unfollowUser(String token, String userId) async {
    try {
      final response = await _dio.post(
        '$serverUrl/follower-following/unfollow',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: jsonEncode({'userId': userId}),
      );

      return response.statusCode == 200;
    } catch (error) {
      print('Failed to unfollow user: $error');
      return false;
    }
  }

  Future<List<Follow>> getFollowers(String token, String userId) async {
    try {
      final response = await _dio.get(
        '$serverUrl/follower-following/followers/$userId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      List<dynamic> data = response.data;
      return data.map((json) => Follow.fromJson(json)).toList();
    } catch (error) {
      print('Failed to get followers: $error');
      return [];
    }
  }

  Future<List<Follow>> getFollowing(String token, String userId) async {
    try {
      final response = await _dio.get(
        '$serverUrl/follower-following/following/$userId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      List<dynamic> data = response.data;
      return data.map((json) => Follow.fromJson(json)).toList();
    } catch (error) {
      print('Failed to get following: $error');
      return [];
    }
  }

  Future<String> getFollowStatus(String token, String userId, String loggedInUserId) async {
    try {
      final response = await _dio.get(
        '$serverUrl/follower-following/status',
        queryParameters: {
          'userId': userId,
          'loggedInUserId': loggedInUserId,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return response.data['status'];
    } catch (error) {
      print('Failed to get follow status: $error');
      return 'error';
    }
  }
}
