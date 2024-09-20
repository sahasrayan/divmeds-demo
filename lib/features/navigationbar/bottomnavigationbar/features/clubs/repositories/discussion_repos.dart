import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/clubs/models/club_discussion_model.dart';


class DiscussionRepository {
  final Dio _dio = Dio();
  final String serverUrl;

  DiscussionRepository({required this.serverUrl});

  // Send a message in a club discussion
  Future<Discussion?> sendMessage(String token, String clubId, String content, List<String> attachments) async {
    try {
      final response = await _dio.post(
        '$serverUrl/api/discussions/$clubId/message',
        data: {
          'content': content,
          'attachments': attachments,
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
        return Discussion.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  // Get messages in a club discussion
  Future<List<Message>?> getMessages(String token, String clubId) async {
    try {
      final response = await _dio.get(
        '$serverUrl/api/discussions/$clubId/messages',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log(response.data.toString());
        return (response.data as List).map((json) => Message.fromJson(json)).toList();
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
