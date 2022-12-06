import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static SharedPreferences _localStorage;

  static Future initService() async {
    _localStorage = await SharedPreferences.getInstance();
  }

  static String getString(String key) {
    return _localStorage.getString(key);
  }

  static int getInt(String key) {
    return _localStorage.getInt(key);
  }

  static Future<bool> setString(String key, String value) async {
    return await _localStorage.setString(key, value);
  }

  static Future<bool> setInt(String key, int value) async {
    return await _localStorage.setInt(key, value);
  }

  static Future<bool> clear() async {
    return await _localStorage.clear();
  }

  static SharedPreferences getInstance() {
    return _localStorage;
  }
}
