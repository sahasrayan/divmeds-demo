import 'dart:developer';
import 'package:dio/dio.dart';

import '../models/club_model.dart';


class ClubRepository {
  final Dio _dio = Dio();
  final String serverUrl;

  ClubRepository({required this.serverUrl});

  // Create a new club
  Future<Club?> createClub(String token, {required String name, required String description, required bool isPublic}) async {
    try {
      final response = await _dio.post(
        '$serverUrl/api/clubs',
        data: {
          'name': name,
          'description': description,
          'isPublic': isPublic,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log(response.data.toString());
        return Club.fromJson(response.data['club']);
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  // Edit a club
  Future<Club?> editClub(String token, String clubId, {String? name, String? description, bool? isPublic}) async {
    try {
      final response = await _dio.put(
        '$serverUrl/api/clubs/$clubId',
        data: {
          if (name != null) 'name': name,
          if (description != null) 'description': description,
          if (isPublic != null) 'isPublic': isPublic,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log(response.data.toString());
        return Club.fromJson(response.data['club']);
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  // Delete a club
  Future<bool> deleteClub(String token, String clubId) async {
    try {
      final response = await _dio.delete(
        '$serverUrl/api/clubs/$clubId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      return response.statusCode! >= 200 && response.statusCode! <= 300;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  // Join a club
  Future<bool> joinClub(String token, String clubId) async {
    try {
      final response = await _dio.post(
        '$serverUrl/api/clubs/$clubId/join',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      return response.statusCode! >= 200 && response.statusCode! <= 300;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  // Leave a club
  Future<bool> leaveClub(String token, String clubId) async {
    try {
      final response = await _dio.post(
        '$serverUrl/api/clubs/$clubId/leave',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      return response.statusCode! >= 200 && response.statusCode! <= 300;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  // Share a club
  Future<bool> shareClub(String token, String clubId) async {
    try {
      final response = await _dio.post(
        '$serverUrl/api/clubs/$clubId/share',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      return response.statusCode! >= 200 && response.statusCode! <= 300;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  // Add a member to a club
  Future<bool> addMember(String token, String clubId, String userId) async {
    try {
      final response = await _dio.post(
        '$serverUrl/api/clubs/add-member',
        data: {
          'clubId': clubId,
          'userId': userId,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      return response.statusCode! >= 200 && response.statusCode! <= 300;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  // Remove a member from a club
  Future<bool> removeMember(String token, String clubId, String userId) async {
    try {
      final response = await _dio.post(
        '$serverUrl/api/clubs/remove-member',
        data: {
          'clubId': clubId,
          'userId': userId,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      return response.statusCode! >= 200 && response.statusCode! <= 300;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  // Get members of a club
  Future<List<String>?> getClubMembers(String token, String clubId) async {
    try {
      final response = await _dio.get(
        '$serverUrl/api/clubs/$clubId/members',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log(response.data.toString());
        return List<String>.from(response.data);
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
