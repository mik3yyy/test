import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/foundation.dart';
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
import 'package:kayndrexsphere_mobile/Data/model/auth/res/signin_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/sigout_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/verify_account_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/statement_of_account/download_statement.dart';
import 'package:kayndrexsphere_mobile/Data/model/statement_of_account/get_range_request.dart';
import 'package:kayndrexsphere_mobile/Data/model/statement_of_account/statement_of_account.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/refreshToken/refresh_token_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/refreshToken/refresh_token_res.dart';
import 'package:kayndrexsphere_mobile/Data/utils/api_interceptor.dart';
import 'package:kayndrexsphere_mobile/Data/utils/app_config/environment.dart';
import 'package:kayndrexsphere_mobile/Data/utils/error_interceptor.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod/riverpod.dart';

import '../../model/auth/res/failure_res.dart';

final userServiceProvider = Provider<UserService>((ref) {
  return UserService((ref), ref);
});

final dioProvider = Provider((ref) => Dio(BaseOptions(
    receiveTimeout: 100000,
    connectTimeout: 100000,
    // contentType: "application/json-patch+json",
    baseUrl: AppConfig.coreBaseUrl)));
final cacheProvider =
    Provider((ref) => MemCacheStore(maxSize: 10485760, maxEntrySize: 1048576));
final cacheOptions = Provider((ref) => CacheOptions(
      store: ref.watch(cacheProvider),
      hitCacheOnErrorExcept: [],
      priority: CachePriority.normal,
      maxStale: const Duration(days: 2),
      // for offline behaviour
    ));

CancelToken cancelToken = CancelToken();

class UserService {
  final Ref _read;
  final Ref ref;
  UserService(this._read, this.ref) {
    _read.read(dioProvider).interceptors.addAll([
      ApiInterceptor(),
      ErrorInterceptor(),
      if (kDebugMode) ...[PrettyDioLogger()],
      DioCacheInterceptor(options: ref.watch(cacheOptions)),
    ]);

    // _read(dioProvider).interceptors.add(RetryInterceptor(
    //       dio: _read(dioProvider),
    //       logPrint: print, // specify log function (optional)
    //       retries: 3, // retry count (optional)
    //       retryDelays: const [
    //         // set delays between retries (optional)
    //         Duration(seconds: 2), // wait 1 sec before first retry
    //         Duration(seconds: 2), // wait 2 sec before second retry
    //         Duration(
    //             seconds:
    //                 2), // wait 3 sec before third retry // wait 3 sec before third retry
    //       ],
    //     ));
  }

  // create account
  Future<bool> createAccount(
    String firstName,
    String lastName,
    String emailPhone,
  ) async {
    const url = '/auth/create-account';
    try {
      final response = await _read.read(dioProvider).post(
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

        throw result.status!;
      } else {
        throw e.error;
      }
    }
  }

  // verify account
  Future<VerifyRes> verifyAccount(VerifyAccount verify) async {
    const url = '/auth/verify-account';
    try {
      final response = await _read.read(dioProvider).post(
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
      final response = await _read
          .read(dioProvider)
          .post(url, data: {"email_phone": emailPhone});
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
      final response = await _read.read(dioProvider).post(url,
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
    const url = '/currencies/all';
    try {
      final response = await _read.read(dioProvider).get(url);
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
      final response = await _read.read(dioProvider).get(url);
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
      final response = await _read.read(dioProvider).get(url);
      final stringList = CountryRes.fromJson(response.data);
      return stringList;
    } on DioError catch (e) {
      throw e.error;
    }
  }

  // //  STATEMENT OF ACCOUNT
  // String url(bool isDownload) {
  //   if (isDownload) {
  //     return '/misc/statement-of-account-ranged/download';
  //   } else {
  //     return '/misc/statement-of-account-ranged';
  //   }
  // }

  Future<StatementOfAccount> getAccountRange(StatementReq statementReq) async {
    const url = '/misc/statement-of-account-ranged';
    try {
      final response =
          await _read.read(dioProvider).post(url, data: statementReq.toJson());
      final result = StatementOfAccount.fromJson(response.data);
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

  Future<DownloadStatement> downloadRange(
    StatementReq statementReq,
  ) async {
    const url = '/misc/statement-of-account-ranged/download';
    try {
      final response =
          await _read.read(dioProvider).post(url, data: statementReq.toJson());
      final result = DownloadStatement.fromJson(response.data);
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

  Future<StatementOfAccount> statementOfAccount() async {
    const url = '/misc/statement-of-account';
    try {
      final response = await _read.read(dioProvider).post(
            url,
          );
      final result = StatementOfAccount.fromJson(response.data);
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

  // set currency
  Future<bool> setCurrency(
      String currency, String language, String country) async {
    const url = '/auth/set-currency';
    try {
      final pseudoToken = PreferenceManager.pseudoToken;
      final response = await _read.read(dioProvider).post(url,
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
  Future<LoginRes> signIn(SigninReq signinReq) async {
    const url = '/auth/sign-in-new';
    try {
      final response =
          await _read.read(dioProvider).post(url, data: signinReq.toJson());

      final result = LoginRes.fromJson(response.data);
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

  // sign in New User
  Future<SigninRes> signInNewUser(SigninReq signinReq) async {
    const url = '/auth/sign-in';
    try {
      final response =
          await _read.read(dioProvider).post(url, data: signinReq.toJson());

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

  // 2FA Verification
  Future<SigninRes> verify2FA(The2FaReq verifyReq) async {
    const url = '/auth/verify-2fa';
    try {
      final response =
          await _read.read(dioProvider).post(url, data: verifyReq.toJson());

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

  Future<LoginRes> resend2FA(String email) async {
    const url = '/auth/resend-2fa';
    try {
      final response =
          await _read.read(dioProvider).post(url, data: {"email": email});
      final result = LoginRes.fromJson(response.data);
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
  Future<bool> forgotPassword(
      String emailPhone, CancelToken cancelToken) async {
    const url = '/auth/forgot-password/send-code';
    try {
      final response = await _read.read(dioProvider).post(url,
          data: {"email_phone": emailPhone}, cancelToken: cancelToken);
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
      final response = await _read.read(dioProvider).post(url, data: {
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
  Future<ResendOtpRes> transactionPin(
      String transactionPin, String confirmTransactionPin) async {
    const url = '/auth/transaction-pin/set-pin';
    try {
      final response = await _read.read(dioProvider).post(
        url,
        data: {
          "pin": transactionPin,
          "confirm_pin": confirmTransactionPin,
        },
      );

      final result = ResendOtpRes.fromJson(response.data);
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
      final response = await _read.read(dioProvider).post(url,
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
      final response = await _read
          .read(dioProvider)
          .post(url, data: refreshTokenReq.toJson());
      final result = RefreshTokenRes.fromJson(response.data);
      return result;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != "") {
        Failure result = Failure.fromJson(e.response!.data);
        throw result.message ?? "";
      } else {
        throw e.error;
      }
    }
  }

  Future<SigninOutRes> signOut(String deviceId) async {
    const url = '/auth/sign-out';
    try {
      final response = await _read
          .read(dioProvider)
          .post(url, data: {"device_id": deviceId});
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

  Future<DeactivateAccountRes> deactivateAccount(
      String password, String reason) async {
    const url = '/auth/deactivate-account';
    try {
      final response = await _read
          .read(dioProvider)
          .post(url, data: {"password": password, "reason": reason});
      final result = DeactivateAccountRes.fromJson(response.data);
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
