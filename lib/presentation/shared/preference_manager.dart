import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  static late SharedPreferences prefs;

  static set enableBioMetrics(bool enableBioMetrics) =>
      prefs.setBool("enableBioMetrics", enableBioMetrics);
  static bool get enableBioMetrics =>
      prefs.getBool("enableBioMetrics") ?? false;
  static set isSaved(bool isSaved) => prefs.setBool("isSaved", isSaved);
  static bool get isSaved => prefs.getBool("isSaved") ?? false;

  static set enableTransactionBioMetrics(bool enableTransactionBioMetrics) =>
      prefs.setBool("enableTransactionBioMetrics", enableTransactionBioMetrics);
  static bool get enableTransactionBioMetrics =>
      prefs.getBool("enableTransactionBioMetrics") ?? false;

  static set hasBiometrics(bool hasBiometrics) =>
      prefs.setBool("hasBiometrics", hasBiometrics);
  static bool get hasBiometrics => prefs.getBool("hasBiometrics") ?? false;

  static set isFirstLaunch(bool isFirstLaunch) =>
      prefs.setBool("isFirstLaunch", isFirstLaunch);
  static bool get isFirstLaunch => prefs.getBool("isFirstLaunch") ?? true;

  static set isloggedIn(bool isloggedIn) =>
      prefs.setBool("isloggedIn", isloggedIn);
  static bool get isloggedIn => prefs.getBool("isloggedIn") ?? false;

  static set revealBalance(bool revealBalance) =>
      prefs.setBool("revealBalance", revealBalance);
  static bool get revealBalance => prefs.getBool("revealBalance") ?? false;

//* avatarUrl
  static set avatarUrl(String avatarUrl) =>
      prefs.setString("avatarUrl", avatarUrl);
  static String get avatarUrl => prefs.getString("avatarUrl") ?? '';

  static set idUrl(String idUrl) => prefs.setString("avatarUrl", idUrl);
  static String get idUrl => prefs.getString("idUrl") ?? '';

  // //* DialingCode
  // static set dailingCode(String dailingCode) =>
  //     prefs.setString("dailingCode", dailingCode);
  // static String get dailingCode => prefs.getString("dailingCode") ?? '';

  //* avatarUrl
  static set defaultWallet(String defaultWallet) =>
      prefs.setString("defaultWallet", defaultWallet);
  static String get defaultWallet => prefs.getString("defaultWallet") ?? '';

  //* auth token
  static set authToken(String authToken) =>
      prefs.setString("authToken", authToken);
  static String get authToken => prefs.getString("authToken") ?? '';

  //* 2FA Token
  static set twoFaToken(String twoFaToken) =>
      prefs.setString("twoFaToken", twoFaToken);
  static String get twoFaToken => prefs.getString("twoFaToken") ?? '';
  //* Device ID
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

  static set email(String email) => prefs.setString("email", email);
  static String get email => prefs.getString("email") ?? '';

  //* password
  static set password(String password) => prefs.setString("password", password);
  static String get password => prefs.getString("password") ?? '';

  //* reaction to post
  static set isPostLike(bool isLiked) => prefs.setBool("isPostLike", isLiked);
  static bool get isPostLike => prefs.getBool("isPostLike") ?? false;

  //* reaction to post
  static set isPostUnLike(bool isUnLiked) =>
      prefs.setBool("isPostUnLike", isUnLiked);
  static bool get isPostUnLike => prefs.getBool("isPostUnLike") ?? false;

  static set pusherVal(String pusherVal) =>
      prefs.setString("pusherVal", pusherVal);
  static String get pusherVal => prefs.getString("pusherVal") ?? '';

  static void clear() {
    // prefs.clear();
    PreferenceManager.isFirstLaunch = false;
    PreferenceManager.authToken = "";
    PreferenceManager.refreshToken = "";
    PreferenceManager.pseudoToken = "";
    PreferenceManager.isloggedIn = false;
  }

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }
}
