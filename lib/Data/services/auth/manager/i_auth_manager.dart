import 'package:dio/dio.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/deactivate_account/deactivate_account_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/req/create_password_req.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/req/sign_in_req.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/req/two_fa_req.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/req/verify_account_req.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/convert_currency_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/country_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/currency_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/new_sign_in_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/resendotp_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/sigout_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/verify_account_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/statement_of_account/download_statement.dart';
import 'package:kayndrexsphere_mobile/Data/model/statement_of_account/get_range_request.dart';
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
  Future<GenericRes> signIn(SigninReq signinReq);
  Future<SigninRes> verify2FA(The2FaReq verifyReq);
  Future<SigninRes> signInNewUser(SigninReq signinReq);
  Future<bool> forgotPassword(String emailPhone, CancelToken cancelToken);
  Future<SigninRes> resetPassword(String emailPhone, String otpCode,
      String password, String confirmPassword);
  Future<GenericRes> resend2FA(String email);
  Future<ResendOtpRes> transactionPin(
      String transactionPin, String confirmTransactionPin);
  Future<bool> referralCode(String refCode);
  Future<RefreshTokenRes> getAuthTOken(RefreshTokenReq refreshTokenReq);
  Future<SigninOutRes> signOut(String deviceId);
  Future<ConvertCurrencyRes> convertCurrency(String from, String to);
  Future<StatementOfAccount> statementOfAccount();
  Future<StatementOfAccount> getAccountRange(StatementReq statementReq);
  Future<DownloadStatement> downloadRange(
    StatementReq statementReq,
  );
  Future<DeactivateAccountRes> deactivateAccount(
      String password, String reason);
}
