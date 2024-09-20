import 'dart:convert';

import 'package:divmeds/features/auth/models/user.model.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static late SharedPreferences _prefs;

  // Initialize SharedPreferences instance
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Getter for SharedPreferences instance
  static SharedPreferences get instance {
    return _prefs;
  }

  // Save UID
  static Future<void> saveUid(String uid) async {
    await _prefs.setString('uid', uid);
  }

  // Get UID
  static String getUid() {
    return _prefs.getString('uid') ?? '';
  }

  // Save JWT token
  static Future<void> saveToken(String token) async {
    await _prefs.setString('token', token);
  }

  // Get JWT token
  static String getToken() {
    return _prefs.getString('token') ?? '';
  }

  // Remove JWT token
  static Future<void> removeToken() async {
    await _prefs.remove('token');
  }

  // Clear all stored data (useful for logout)
  static Future<void> clear() async {
    await _prefs.clear();
  }
  // Save User
  static Future<void> saveUser(User user) async {
    await _prefs.setString('user', jsonEncode(user.toJson()));
  }

  // Get User
  static User? getUser() {
    String? userJson = _prefs.getString('user');
    if (userJson != null) {
      return User.fromJson(jsonDecode(userJson));
    }
    return null;
  }
  // Save temporary phone number
  static Future<void> savePhoneNumber(String phoneNumber) async {
    await _prefs.setString('temporary_phone_number', phoneNumber);
  }
  // Get temporary phone number
  static String getPhoneNumber() {
    return _prefs.getString('temporary_phone_number') ?? '';
  }
   // Save temporary gender
  static Future<void> saveGender(String gender) async {
    await _prefs.setString('gender', gender );
  }
  // Get temporary gender
  static String getGender() {
    return _prefs.getString('gender') ?? '';
  }
    // Save temporary dob
  static Future<void> saveDOB(DateTime dob) async {
    final formattedDOB = DateFormat('dd-MM-yyyy').format(dob);
    await _prefs.setString('dob', formattedDOB);
  }

  // Get temporary dob
  static String getDOB() {
    return _prefs.getString('dob') ?? '';
  }
}
