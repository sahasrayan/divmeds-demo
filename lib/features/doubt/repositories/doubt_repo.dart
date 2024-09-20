import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:divmeds/features/doubt/models/doubt_model.dart';


class DoubtRepository {
  final Dio _dio = Dio();
  final String serverUrl;

  DoubtRepository({required this.serverUrl});

  // Ask a new doubt
  Future<Doubt?> askDoubt({
    required String title,
    required String description,
    required List<String> tags,
    required List<String> referredTo,
    required List<String> images,
    required String token,
  }) async {
    try {
      final response = await _dio.post(
        '$serverUrl/api/doubts',
        data: {
          'title': title,
          'description': description,
          'tags': tags,
          'referredTo': referredTo,
          'images': images,
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
        return Doubt.fromJson(response.data['doubt']);
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  // Get a specific doubt by ID
  Future<Doubt?> getDoubt(String doubtId, String token) async {
    try {
      final response = await _dio.get(
        '$serverUrl/api/doubts/$doubtId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log(response.data.toString());
        return Doubt.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  // Answer a doubt
  Future<bool> answerDoubt({
    required String doubtId,
    required String answer,
    required String token,
  }) async {
    try {
      final response = await _dio.post(
        '$serverUrl/api/doubts/$doubtId/answer',
        data: {'answer': answer},
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

  // Get all doubts
  Future<List<Doubt>?> getAllDoubts(String token) async {
    try {
      final response = await _dio.get(
        '$serverUrl/api/doubts',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log(response.data.toString());
        return (response.data as List).map((i) => Doubt.fromJson(i)).toList();
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  // Update a doubt
  Future<bool> updateDoubt({
    required String doubtId,
    required String title,
    required String description,
    required List<String> tags,
    required List<String> images,
    required String token,
  }) async {
    try {
      final response = await _dio.put(
        '$serverUrl/api/doubts/$doubtId',
        data: {
          'title': title,
          'description': description,
          'tags': tags,
          'images': images,
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

  // Delete a doubt
  Future<bool> deleteDoubt(String doubtId, String token) async {
    try {
      final response = await _dio.delete(
        '$serverUrl/api/doubts/$doubtId',
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
}
