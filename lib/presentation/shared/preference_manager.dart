import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  static late SharedPreferences prefs;

  static set isFirstLaunch(bool isFirstLaunch) =>
      prefs.setBool("isFirstLaunch", isFirstLaunch);
  static bool get isFirstLaunch => prefs.getBool("isFirstLaunch") ?? true;

  static set isLoggedIn(bool isLoggedIn) =>
      prefs.setBool("isLoggedIn", isLoggedIn);
  static bool get isLoggedIn => prefs.getBool("isLoggedIn") ?? false;

  //* Google
  static set googleUserName(String googleUserName) =>
      prefs.setString("googleUserName", googleUserName);
  static String get googleUserName => prefs.getString("googleUserName") ?? '';

  //* auth token
  static set authToken(String authToken) =>
      prefs.setString("authToken", authToken);
  static String get authToken => prefs.getString("authToken") ?? '';

  static set pseudoToken(String pseudoToken) =>
      prefs.setString("pseudoToken", pseudoToken);
  static String get pseudoToken => prefs.getString("pseudoToken") ?? '';

  static set refreshToken(String refreshToken) =>
      prefs.setString("refreshToken", refreshToken);
  static String get refreshToken => prefs.getString("refreshToken") ?? '';

  static void clear() {
    prefs.clear();
    // PreferenceManager.isFirstLaunch = false;
  }

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }
}
