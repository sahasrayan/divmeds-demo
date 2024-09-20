import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:divmeds/features/notifications/models/notification_model.dart';


class NotificationRepository {
  final Dio _dio = Dio();
  final String serverUrl;

  NotificationRepository({required this.serverUrl});

  // Fetch notifications for the logged-in user
  Future<List<NotificationModel>?> getNotifications(String token) async {
    try {
      final response = await _dio.get(
        '$serverUrl/api/notifications',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log(response.data.toString());
        List<NotificationModel> notifications = (response.data as List)
            .map((i) => NotificationModel.fromJson(i))
            .toList();
        return notifications;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  // Mark a notification as read
  Future<NotificationModel?> markAsRead(String token, String notificationId) async {
    try {
      final response = await _dio.put(
        '$serverUrl/api/notifications/$notificationId/read',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log(response.data.toString());
        return NotificationModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
