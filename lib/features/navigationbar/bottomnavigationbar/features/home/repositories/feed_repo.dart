import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/models/post.model.dart';

class FeedRepository {
  final Dio _dio = Dio();
  final String serverUrl;

  FeedRepository({required this.serverUrl});
// Fetch the feed for the logged-in user
Future<List<Map<String, dynamic>>?> getFeed(String token) async {
  try {
    final response = await _dio.get(
      '$serverUrl/feed',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode! >= 200 && response.statusCode! <= 300) {
      log(response.data.toString());
      return List<Map<String, dynamic>>.from(response.data);
    } else {
      return null;
    }
  } catch (e) {
    log(e.toString());
    return null;
  }
}
}