import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:divmeds/features/verification/models/verification_model.dart';


class VerificationRepository {
  final Dio _dio = Dio();
  final String serverUrl;

  VerificationRepository({required this.serverUrl});

  // Upload healthcare verification documents
  Future<Verification?> uploadHealthcareVerification({
    required String token,
    required FormData formData,
  }) async {
    try {
      final response = await _dio.post(
        '$serverUrl/verification/healthcare',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log(response.data.toString());
        Verification verification = Verification.fromJson(response.data['verification']);
        return verification;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  // Upload non-healthcare verification documents
  Future<Verification?> uploadNonHealthcareVerification({
    required String token,
  }) async {
    try {
      final response = await _dio.post(
        '$serverUrl/verification/nonhealthcare',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log(response.data.toString());
        Verification verification = Verification.fromJson(response.data['verification']);
        return verification;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  // Get verification status
  Future<Verification?> getVerificationStatus(String token) async {
    try {
      final response = await _dio.get(
        '$serverUrl/verification/status',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log(response.data.toString());
        Verification verification = Verification.fromJson(response.data);
        return verification;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
