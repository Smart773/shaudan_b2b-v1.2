import 'package:shared_preferences/shared_preferences.dart';

class LoginPref {
  LoginPref._();
  static const String tokenKey = "token";
  static const String accountIdKey = "accountId";
  static const String userIdkey = "userId";

  static Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }

  static Future<void> saveAccountId(String accountId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(accountIdKey, accountId);
  }

  static Future<String?> getAccountId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(accountIdKey);
  }

  static Future<void> clearAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<void> clearToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
  }

  static Future<void> clearAccountId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(accountIdKey);
  }

  static Future<void> saveUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(userIdkey, userId);
  }

  static Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print("userId ${prefs.getString(userIdkey)}");
    return prefs.getString(userIdkey);
  }

  static Future<void> clearUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(userIdkey);
  }
}
