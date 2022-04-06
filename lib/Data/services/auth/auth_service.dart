import 'package:dio/dio.dart';
import 'package:kayndrexsphere_mobile/Data/constant/constant.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/verify_account_res.dart';
import 'package:kayndrexsphere_mobile/Data/utils/api_interceptor.dart';
import 'package:kayndrexsphere_mobile/Data/utils/error_interceptor.dart';
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
        print(e.error);
        throw e.error;
      }
    }
  }

  Future<bool> verifyAccount(VerifyAccount verify) async {
    const url = '/auth/verify-account';
    try {
      final response =
          await _read(dioProvider).post(url, data: verify.toJson());
      final result = response.data = true;
      return result;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != "") {
        Failure result = Failure.fromJson(e.response!.data);
        throw result.message!;
      } else {
        print(e.error);
        throw e.error;
      }
    }
  }
}
