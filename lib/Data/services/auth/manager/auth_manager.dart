import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/constant/constant.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/req/create_password_req.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/country_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/currency_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/signin_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/verify_account_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/auth_service.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/manager/i_auth_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authManagerProvider = Provider<AuthManager>((ref) {
  final userService = ref.watch(userServiceProvider);

  return AuthManager(userService);
});

class AuthManager extends IAuthManager {
  final UserService _userService;

  AuthManager(this._userService);

  // create account
  @override
  Future<bool> createAccount(
      {required String firstName,
      required String lastName,
      required emailPhone}) async {
    final res =
        await _userService.createAccount(firstName, lastName, emailPhone);
    return res;
  }

  // verify account
  @override
  Future<VerifyRes> verifyAccount(verify) async {
    final res = await _userService.verifyAccount(verify);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final isSaved =
        await prefs.setString(Constants.pseudoToken, res.data!.pseudoToken!);
    if (isSaved) {
      return res;
    }
    throw Exception(
        "An Error has occured while signing you in. Please contact support");
  }

  // resend otp
  @override
  Future<bool> resendOtp({required String emailPhone}) async {
    final res = await _userService.resendOtp(emailPhone);
    return res;
  }

  // create password
  @override
  Future<CreatePassword> createPassword(
      String password, String confirmPassword) async {
    final res = await _userService.createPassword(password, confirmPassword);
    return res;
  }

  // get currency
  @override
  Future<CurrencyRes> getCurrency() async {
    final res = await _userService.getCurrency();
    return res;
  }

  // get country
  @override
  Future<CountryRes> getCountry() async {
    final res = await _userService.getCountry();
    return res;
  }

  // set currency
  @override
  Future<bool> setCurrency(
      String currency, String language, String country) async {
    final res = await _userService.setCurrency(currency, language, country);
    return res;
  }

  // sign in
  @override
  Future<SigninRes> signIn(String emailPhone, String password) async {
    final res = await _userService.signIn(emailPhone, password);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token =
        await prefs.setString(Constants.token, res.data!.tokens!.authToken!);
    if (token) {
      return res;
    }
    throw Exception(
        "An Error has occured while signing you in. Please contact support");
  }

  // forget password
  @override
  Future<bool> forgotPassword(String emailPhone) async {
    final res = await _userService.forgotPassword(emailPhone);
    return res;
  }

  // reset password
  @override
  Future<SigninRes> resetPassword(String emailPhone, String otpCode,
      String password, String confirmPassword) async {
    final res = await _userService.resetPassword(
        emailPhone, otpCode, password, confirmPassword);
    return res;
  }

  // transaction pin
  @override
  Future<bool> transactionPin(
      String transactionPin, String confirmTransactionPin) async {
    final res = await _userService.transactionPin(
        transactionPin, confirmTransactionPin);
    return res;
  }

  // ref code
  @override
  Future<bool> referralCode(String refCode) async {
    final res = await _userService.referralCode(refCode);
    return res;
  }
}
