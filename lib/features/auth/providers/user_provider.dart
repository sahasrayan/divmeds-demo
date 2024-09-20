import 'package:divmeds/features/auth/repositories/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:divmeds/core/api/api.url.dart';
import 'package:dio/dio.dart';
import 'package:divmeds/features/auth/models/user.model.dart';
import 'package:divmeds/features/auth/repositories/auth_repo.dart';


class UserProvider with ChangeNotifier {
  User? _user;
  String? _token;
  final AuthRepository _authRepository = AuthRepository(serverUrl: Config.serverUrl);
  final UserRepository _userRepository = UserRepository(serverUrl: Config.serverUrl); // Initialize the UserRepository

  User? get user => _user;
  String? get token => _token;

  Future<void> login(String phone, String password) async {
    final response = await _authRepository.login(phone: phone, password: password);
    if (response != null) {
      _token = response['token'];
      _user = response['user'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', _token!);
      await prefs.setString('uid', _user!.userId);
      notifyListeners();
    }
  }

  Future<void> register(String firstName, String lastName, String userId, String password, String phone, String dob, String gender) async {
    final user = await _authRepository.register(
      firstName: firstName,
      lastName: lastName,
      userId: userId,
      password: password,
      phone: phone,
      dob: dob,
      gender: gender,
    );
    if (user != null) {
      _user = user;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    if (_token != null) {
      await _authRepository.logout(_token!);
      _user = null;
      _token = null;
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.remove('uid');
      notifyListeners();
    }
  }

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    final userId = prefs.getString('uid');
    if (_token != null && userId != null) {
      final user = await _userRepository.getLoggedInUserProfile(_token!);
      if (user != null) {
        _user = user;
        notifyListeners();
      }
    }
  }
}
