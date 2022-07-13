import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:kayndrexsphere_mobile/Data/constant/constant.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/req/create_password_req.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/req/sign_in_req.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/req/verify_account_req.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/convert_currency_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/country_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/currency_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/signin_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/sigout_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/verify_account_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/refreshToken/refresh_token_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/refreshToken/refresh_token_res.dart';
import 'package:kayndrexsphere_mobile/Data/utils/api_interceptor.dart';
import 'package:kayndrexsphere_mobile/Data/utils/error_interceptor.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod/riverpod.dart';

import '../../model/auth/res/failure_res.dart';

final userServiceProvider = Provider<UserService>((ref) {
  return UserService((ref.read));
});

final dioProvider = Provider((ref) => Dio(BaseOptions(
    receiveTimeout: 100000,
    connectTimeout: 100000,
    // contentType: "application/json-patch+json",
    baseUrl: Constants.apiBaseUrl)));

class UserService {
  final Reader _read;
  UserService(this._read) {
    _read(dioProvider).interceptors.add(ApiInterceptor());
    _read(dioProvider).interceptors.add(ErrorInterceptor());
    _read(dioProvider).interceptors.add(PrettyDioLogger());
  }

  // create account
  Future<bool> createAccount(
    String firstName,
    String lastName,
    String emailPhone,
  ) async {
    const url = '/auth/create-account';
    try {
      final response = await _read(dioProvider).post(
        url,
        data: {
          "first_name": firstName,
          "last_name": lastName,
          "email_phone": emailPhone
        },
      );
      final result = response.data = true;
      return result;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != "") {
        Failure result = Failure.fromJson(e.response!.data);
        throw result.message!;
      } else {
        throw e.error;
      }
    }
  }

  // verify account
  Future<VerifyRes> verifyAccount(VerifyAccount verify) async {
    const url = '/auth/verify-account';
    try {
      final response = await _read(dioProvider).post(
        url,
        data: verify.toJson(),
      );
      final result = VerifyRes.fromJson(response.data);
      return result;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != "") {
        Failure result = Failure.fromJson(e.response!.data);
        throw result.message!;
      } else {
        throw e.error;
      }
    }
  }

  // resend otp
  Future<bool> resendOtp(String emailPhone) async {
    const url = '/auth/resend-verification-code';
    try {
      final response =
          await _read(dioProvider).post(url, data: {"email_phone": emailPhone});
      final result = response.data = true;
      return result;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != "") {
        Failure result = Failure.fromJson(e.response!.data);
        throw result.message!;
      } else {
        throw e.error;
      }
    }
  }

  // create password
  Future<CreatePassword> createPassword(
    String password,
    String confirmPassword,
  ) async {
    const url = '/auth/create-password';
    final pseudoToken = PreferenceManager.pseudoToken;
    try {
      final response = await _read(dioProvider).post(url,
          data: {
            "password": password,
            "confirm_password": confirmPassword,
          },
          options: Options(
              headers: {"Pseudo-Authentication": "Bearer $pseudoToken"}));
      final result = CreatePassword.fromJson(response.data);
      return result;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != "") {
        Failure result = Failure.fromJson(e.response!.data);
        throw result.message!;
      } else {
        throw e.error;
      }
    }
  }

  //  get currency
  Future<CurrencyRes> getCurrency() async {
    const url = '/currencies/all-api';
    try {
      final response = await _read(dioProvider).get(url);
      final stringList = CurrencyRes.fromJson(response.data);
      return stringList;
    } on DioError catch (e) {
      throw e.error;
    }
  }

  //  convert currency
  Future<ConvertCurrencyRes> convertCurrency(String from, String to) async {
    final url = '/currencies/convert/$from/$to';
    try {
      final response = await _read(dioProvider).get(url);
      final stringList = ConvertCurrencyRes.fromJson(response.data);
      return stringList;
    } on DioError catch (e) {
      throw e.error;
    }
  }

  //  get country
  Future<CountryRes> getCountry() async {
    const url = '/misc/countries/all';
    try {
      final response = await _read(dioProvider).get(url);
      final stringList = CountryRes.fromJson(response.data);
      return stringList;
    } on DioError catch (e) {
      throw e.error;
    }
  }

  // set currency
  Future<bool> setCurrency(
      String currency, String language, String country) async {
    const url = '/auth/set-currency';
    try {
      final pseudoToken = PreferenceManager.pseudoToken;
      final response = await _read(dioProvider).post(url,
          data: {
            "currency": currency,
            "language": language,
            "country": country,
          },
          options: Options(
              headers: {"Pseudo-Authentication": "Bearer $pseudoToken"}));
      final result = response.data = true;
      return result;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != "") {
        Failure result = Failure.fromJson(e.response!.data);
        throw result.message!;
      } else {
        throw e.error;
      }
    }
  }

  // sign in
  Future<SigninRes> signIn(SigninReq signinReq) async {
    const url = '/auth/sign-in';
    try {
      final response =
          await _read(dioProvider).post(url, data: signinReq.toJson());
      PreferenceManager.appUser = jsonEncode(response.data);

      final result = SigninRes.fromJson(response.data);
      return result;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != "") {
        Failure result = Failure.fromJson(e.response!.data);
        throw result.message!;
      } else {
        throw e.error;
      }
    }
  }

  // forget password
  Future<bool> forgotPassword(String emailPhone) async {
    const url = '/auth/forgot-password/send-code';
    try {
      final response =
          await _read(dioProvider).post(url, data: {"email_phone": emailPhone});
      final result = response.data = true;
      return result;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != "") {
        Failure result = Failure.fromJson(e.response!.data);
        throw result.message!;
      } else {
        throw e.error;
      }
    }
  }

  // reset password
  Future<SigninRes> resetPassword(String emailPhone, String otpCode,
      String password, String confirmPassword) async {
    const url = '/auth/forgot-password/reset-password';
    try {
      final response = await _read(dioProvider).post(url, data: {
        "email_phone": emailPhone,
        "code": otpCode,
        "password": password,
        "confirm_password": confirmPassword
      });

      final result = SigninRes.fromJson(response.data);
      return result;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != "") {
        Failure result = Failure.fromJson(e.response!.data);
        throw result.message!;
      } else {
        throw e.error;
      }
    }
  }

  // set transaction pin
  Future<bool> transactionPin(
      String transactionPin, String confirmTransactionPin) async {
    const url = '/auth/transaction-pin/set-pin';
    try {
      final response = await _read(dioProvider).post(
        url,
        data: {
          "pin": transactionPin,
          "confirm_pin": confirmTransactionPin,
        },
      );

      final result = response.data = true;
      return result;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != "") {
        Failure result = Failure.fromJson(e.response!.data);
        throw result.message!;
      } else {
        throw e.error;
      }
    }
  }

  // referral code
  Future<bool> referralCode(String refCode) async {
    const url = '/auth/handle-referral';
    final pseudoToken = PreferenceManager.pseudoToken;
    try {
      final response = await _read(dioProvider).post(url,
          data: {
            "ref_code": refCode,
          },
          options: Options(
              headers: {"Pseudo-Authentication": "Bearer $pseudoToken"}));
      final result = response.data = true;
      return result;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != "") {
        Failure result = Failure.fromJson(e.response!.data);
        throw result.message!;
      } else {
        throw e.error;
      }
    }
  }

  //Refresh Token

  Future<RefreshTokenRes> getAuthTOken(RefreshTokenReq refreshTokenReq) async {
    const url = '/auth/refresh-tokens';
    try {
      final response =
          await _read(dioProvider).post(url, data: refreshTokenReq.toJson());
      final result = RefreshTokenRes.fromJson(response.data);
      return result;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != "") {
        Failure result = Failure.fromJson(e.response!.data);
        throw result.message!;
      } else {
        throw e.error;
      }
    }
  }

  Future<SigninOutRes> signOut(String deviceId) async {
    const url = '/auth/sign-out';
    try {
      final response =
          await _read(dioProvider).post(url, data: {"device_id": deviceId});
      final result = SigninOutRes.fromJson(response.data);
      return result;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != "") {
        Failure result = Failure.fromJson(e.response!.data);
        throw result.message!;
      } else {
        throw e.error;
      }
    }
  }
}
