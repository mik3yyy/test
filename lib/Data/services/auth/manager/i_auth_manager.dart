import 'package:kayndrexsphere_mobile/Data/model/auth/req/create_password_req.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/req/sign_in_req.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/req/verify_account_req.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/convert_currency_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/country_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/currency_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/sigout_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/verify_account_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/statement_of_account/statement_of_account.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/refreshToken/refresh_token_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/refreshToken/refresh_token_res.dart';

import '../../../model/auth/res/signin_res.dart';

abstract class IAuthManager {
  Future<bool> createAccount(
      {required String firstName,
      required String lastName,
      required emailPhone});
  Future<VerifyRes> verifyAccount(VerifyAccount verify);
  Future<bool> resendOtp({required String emailPhone});
  Future<CreatePassword> createPassword(
    String password,
    String confirmPassword,
  );
  Future<CurrencyRes> getCurrency();
  Future<CountryRes> getCountry();
  Future<bool> setCurrency(String currency, String language, String country);
  Future<SigninRes> signIn(SigninReq signinReq);
  Future<bool> forgotPassword(String emailPhone);
  Future<SigninRes> resetPassword(String emailPhone, String otpCode,
      String password, String confirmPassword);
  Future<bool> transactionPin(
      String transactionPin, String confirmTransactionPin);
  Future<bool> referralCode(String refCode);
  Future<RefreshTokenRes> getAuthTOken(RefreshTokenReq refreshTokenReq);
  Future<SigninOutRes> signOut(String deviceId);
  Future<ConvertCurrencyRes> convertCurrency(String from, String to);
  Future<StatementOfAccount> statementOfAccount();
}
