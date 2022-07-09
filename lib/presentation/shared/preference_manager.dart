import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  static late SharedPreferences prefs;

  static set enableBioMetrics(bool enableBioMetrics) =>
      prefs.setBool("enableBioMetrics", enableBioMetrics);
  static bool get enableBioMetrics =>
      prefs.getBool("enableBioMetrics") ?? false;

//* avatarUrl
  static set avatarUrl(String avatarUrl) =>
      prefs.setString("avatarUrl", avatarUrl);
  static String get avatarUrl => prefs.getString("avatarUrl") ?? '';

  //* auth token
  static set authToken(String authToken) =>
      prefs.setString("authToken", authToken);
  static String get authToken => prefs.getString("authToken") ?? '';
  //* auth token
  static set deviceId(String deviceId) => prefs.setString("deviceId", deviceId);
  static String get deviceId => prefs.getString("deviceId") ?? '';

  static set depositRef(String depositRef) =>
      prefs.setString("depositRef", depositRef);
  static String get depositRef => prefs.getString("depositRef") ?? '';

  static set pseudoToken(String pseudoToken) =>
      prefs.setString("pseudoToken", pseudoToken);
  static String get pseudoToken => prefs.getString("pseudoToken") ?? '';

  static set refreshToken(String refreshToken) =>
      prefs.setString("refreshToken", refreshToken);
  static String get refreshToken => prefs.getString("refreshToken") ?? '';

  //* AppUser
  static set appUser(String appUser) => prefs.setString("appUser", appUser);
  static String get appUser => prefs.getString("appUser") ?? '';

  //* password
  static set password(String password) => prefs.setString("password", password);
  static String get password => prefs.getString("password") ?? '';

  static void clear() {
    prefs.clear();
    // PreferenceManager.isFirstLaunch = false;
  }

  static void removeToken() {
    PreferenceManager.authToken = "";
    PreferenceManager.refreshToken = "";
    PreferenceManager.depositRef = "";
    // PreferenceManager.password = "";

    // PreferenceManager.isFirstLaunch = false;
  }

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
