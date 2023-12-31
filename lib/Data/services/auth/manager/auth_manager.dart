import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/deactivate_account/deactivate_account_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/req/create_password_req.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/req/reset_email_req.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/req/sign_in_req.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/req/two_fa_req.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/convert_currency_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/country_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/create_account_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/currency_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/forgotten_email_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/new_sign_in_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/resendotp_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/signin_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/sigout_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/verify_account_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/statement_of_account/download_statement.dart';
import 'package:kayndrexsphere_mobile/Data/model/statement_of_account/get_range_request.dart';
import 'package:kayndrexsphere_mobile/Data/model/statement_of_account/statement_of_account.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/auth_service.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/manager/i_auth_manager.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/refreshToken/refresh_token_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/refreshToken/refresh_token_req.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';

final authManagerProvider = Provider<AuthManager>((ref) {
  final userService = ref.watch(userServiceProvider);

  return AuthManager(userService);
});

class AuthManager extends IAuthManager {
  final UserService _userService;

  AuthManager(this._userService);

  // create account
  @override
  Future<CreatAccountRes> createAccount(
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
    PreferenceManager.pseudoToken = res.data!.pseudoToken!;

    return res;
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
  Future<GenericRes> signIn(SigninReq signinReq) async {
    final res = await _userService.signIn(signinReq);

    // if (res.data != null) {
    //   PreferenceManager.authToken = res.data!.tokens!.authToken!;
    //   PreferenceManager.refreshToken = res.data!.tokens!.refreshToken!;
    // }

    return res;
  }

  // forget password
  @override
  Future<bool> forgotPassword(
      String emailPhone, CancelToken cancelToken) async {
    final res = await _userService.forgotPassword(emailPhone, cancelToken);
    return res;
  }

  // reset password
  @override
  Future<SigninRes> resetPassword(String emailPhone, String otpCode,
      String password, String confirmPassword) async {
    final res = await _userService.resetPassword(
        emailPhone, otpCode, password, confirmPassword);
    PreferenceManager.isFirstLaunch = true;
    return res;
  }

  // transaction pin
  @override
  Future<ResendOtpRes> transactionPin(
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

  @override
  Future<RefreshTokenRes> getAuthTOken(RefreshTokenReq refreshTokenReq) async {
    final refreshToken = await _userService.getAuthTOken(refreshTokenReq);
    PreferenceManager.refreshToken = refreshToken.data!.refreshToken!;
    return refreshToken;
  }

  @override
  Future<SigninOutRes> signOut(String deviceId) async =>
      await _userService.signOut(deviceId);

  @override
  Future<ConvertCurrencyRes> convertCurrency(String from, String to) async {
    final currency = await _userService.convertCurrency(from, to);
    return currency;
  }

  @override
  Future<StatementOfAccount> statementOfAccount() async =>
      await _userService.statementOfAccount();

  @override
  Future<DeactivateAccountRes> deactivateAccount(
          String password, String reason) async =>
      await _userService.deactivateAccount(password, reason);

  @override
  Future<StatementOfAccount> getAccountRange(StatementReq statementReq) async =>
      await _userService.getAccountRange(statementReq);

  @override
  Future<DownloadStatement> downloadRange(StatementReq statementReq) async =>
      await _userService.downloadRange(statementReq);

  @override
  Future<SigninRes> verify2FA(The2FaReq verifyReq) async {
    final res = await _userService.verify2FA(verifyReq);
    if (res.data != null) {
      PreferenceManager.authToken = res.data!.tokens!.authToken!;
      PreferenceManager.refreshToken = res.data!.tokens!.refreshToken!;
    }
    return res;
  }

  @override
  Future<SigninRes> signInNewUser(SigninReq signinReq) async {
    final res = await _userService.signInNewUser(signinReq);
    if (res.data != null) {
      PreferenceManager.authToken = res.data!.tokens!.authToken!;
      PreferenceManager.refreshToken = res.data!.tokens!.refreshToken!;
    }
    return res;
  }

  @override
  Future<GenericRes> resend2FA(String email) async {
    final res = await _userService.resend2FA(email);
    return res;
  }

  @override
  Future<ForgettenEmailRes> forgotEmail(
      String phoneNumber, String phoneCode) async {
    final res = await _userService.forgotEmail(phoneNumber, phoneCode);
    PreferenceManager.twoFaToken = res.data.the2FaToken;
    return res;
  }

  @override
  Future<GenericRes> resetEmail(ResetEmailReq resetEmailReq) async {
    final res = await _userService.resetEmail(resetEmailReq);
    return res;
  }
}
