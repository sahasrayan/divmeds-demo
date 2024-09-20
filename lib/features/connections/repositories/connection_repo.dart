import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:divmeds/features/connections/models/connection_model.dart';

class ConnectionRepository {
  final Dio _dio = Dio();
  final String serverUrl;

  ConnectionRepository({required this.serverUrl});

  // Send connection request
  Future<bool> sendConnectionRequest(String userId, String token) async {
    try {
      final response = await _dio.post(
        '$serverUrl/connections/send-request',
        data: {'userId': userId},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      return response.statusCode! >= 200 && response.statusCode! < 300;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  // Accept connection request
  Future<bool> acceptConnectionRequest(String connectionId, String token) async {
    try {
      final response = await _dio.post(
        '$serverUrl/connections/accept-request',
        data: {'connectionId': connectionId},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      return response.statusCode! >= 200 && response.statusCode! < 300;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  // Reject connection request
  Future<bool> rejectConnectionRequest(String connectionId, String token) async {
    try {
      final response = await _dio.post(
        '$serverUrl/connections/reject-request',
        data: {'connectionId': connectionId},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      return response.statusCode! >= 200 && response.statusCode! < 300;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  // Cancel connection request
  Future<bool> cancelConnectionRequest(String connectionId, String token) async {
    try {
      final response = await _dio.post(
        '$serverUrl/connections/cancel-request',
        data: {'connectionId': connectionId},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      return response.statusCode! >= 200 && response.statusCode! < 300;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  // Remove connection
  Future<bool> removeConnection(String connectionId, String token) async {
    try {
      final response = await _dio.post(
        '$serverUrl/connections/remove-connection',
        data: {'connectionId': connectionId},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      return response.statusCode! >= 200 && response.statusCode! < 300;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  // Get my connections
  Future<List<Connection>?> getMyConnections(String token) async {
    try {
      final response = await _dio.get(
        '$serverUrl/connections/my-connections',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        List<Connection> connections = (response.data as List)
            .map((i) => Connection.fromJson(i))
            .toList();
        return connections;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  // Get user connections by user ID
  Future<List<Connection>?> getUserConnections(String userId, String token) async {
    try {
      final response = await _dio.get(
        '$serverUrl/connections/connections/$userId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        List<Connection> connections = (response.data as List)
            .map((i) => Connection.fromJson(i))
            .toList();
        return connections;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
// Get connection status between two users
  Future<String> getConnectionStatus(String userId, String loggedInUserId, String token) async {
    try {
      final response = await _dio.get(
        '$serverUrl/connections/status',
        queryParameters: {
          'userId': userId,
          'loggedInUserId': loggedInUserId,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response.data['status']; // Assuming the API returns a status field
      } else {
        throw Exception('Failed to fetch connection status');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to fetch connection status');
    }
  }
  
}
