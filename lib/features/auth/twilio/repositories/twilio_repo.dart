import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:divmeds/core/api/api.url.dart';


class OtpRepository {
  final Dio _dio = Dio();
  final String serverUrl = Config.serverUrl;

  // Send OTP
  Future<bool> sendOtp(String phone) async {
    final formattedPhone = '+91$phone';
    try {
      final response = await _dio.post(
        '$serverUrl/auth/send-otp',
        data: {'phone': formattedPhone},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        log(response.data.toString());
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  // Resend OTP
  Future<bool> resendOtp(String phone) async {
    final formattedPhone = '+91$phone';
    try {
      final response = await _dio.post(
        '$serverUrl/auth/resend-otp',
        data: {'phone': formattedPhone},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        log(response.data.toString());
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  // Verify OTP
  Future<bool> verifyOtp(String phone, String code) async {
    final formattedPhone = '+91$phone';
    try {
      final response = await _dio.post(
        '$serverUrl/auth/verify-otp',
        data: {
          'phone': formattedPhone,
          'code': code,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        log(response.data.toString());
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
