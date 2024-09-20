import 'package:divmeds/core/db/local/sharepreferencesmanager.dart';

class Config {
  // static const String serverUrl = "https://api.divmeds.app/";
  static const String serverUrl = "http://localhost:3000/api/v1";
  
  static String get token => SharedPreferencesManager.getToken();
  
  static set token(String value) {
    SharedPreferencesManager.saveToken(value);
  }
}
class Temp {
  static String get tempPhoneNumber => SharedPreferencesManager.getPhoneNumber();
  
  static set tempPhoneNumber(String value) {
    SharedPreferencesManager.saveToken(value);
  }
}
