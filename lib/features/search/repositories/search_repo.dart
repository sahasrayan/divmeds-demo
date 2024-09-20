import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:divmeds/features/auth/models/user.model.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/clubs/models/club_model.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/models/post.model.dart';


class SearchRepository {
 final Dio _dio = Dio();
  final String serverUrl;

  SearchRepository({required this.serverUrl});

  Future<List<User>?> searchUsers(String search, String token) async {
    if (search.isEmpty) {
      return [];
    }

    List<User>? usersById = await _searchUsersByUserId(search, token);
    if (usersById != null && usersById.isNotEmpty) {
      return usersById;
    }

    List<User>? usersByFirstName = await _searchUsersByFirstName(search, token);
    List<User>? usersByLastName = await _searchUsersByLastName(search, token);

    Set<User> uniqueUsers = {...?usersByFirstName, ...?usersByLastName};

    return uniqueUsers.toList();
  }

  Future<List<User>?> _searchUsersByUserId(String search, String token) async {
    try {
      final response = await _dio.get(
        '$serverUrl/search/userid',
        queryParameters: {'search': search},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log(response.data.toString());
        List<User> users = (response.data as List).map((i) => User.fromJson(i)).toList();
        return users;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<List<User>?> _searchUsersByFirstName(String search, String token) async {
    try {
      final response = await _dio.get(
        '$serverUrl/search/firstname',
        queryParameters: {'search': search},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log(response.data.toString());
        List<User> users = (response.data as List).map((i) => User.fromJson(i)).toList();
        return users;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<List<User>?> _searchUsersByLastName(String search, String token) async {
    try {
      final response = await _dio.get(
        '$serverUrl/search/lastname',
        queryParameters: {'search': search},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log(response.data.toString());
        List<User> users = (response.data as List).map((i) => User.fromJson(i)).toList();
        return users;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }


  // Search for posts by content
  Future<List<Post>?> searchPosts(String search, String token) async {
    try {
      final response = await _dio.get(
        '$serverUrl/search/posts',
        queryParameters: {'search': search},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
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

  // Search for clubs by name or description
  Future<List<Club>?> searchClubs(String query, String token) async {
    try {
      final response = await _dio.get(
        '$serverUrl/search/clubs',
        queryParameters: {'q': query},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        log(response.data.toString());
        List<Club> clubs = (response.data as List).map((i) => Club.fromJson(i)).toList();
        return clubs;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
