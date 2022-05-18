import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/req/update_profile_req.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/res/profile_res.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/constant.dart';
import '../../model/auth/res/failure_res.dart';
import '../../utils/api_interceptor.dart';
import '../../utils/error_interceptor.dart';

final profileProvider = Provider<ProfileService>((ref) {
  return ProfileService((ref.read));
});

final dioProvider = Provider((ref) => Dio(BaseOptions(
    receiveTimeout: 100000,
    connectTimeout: 100000,
    // contentType: "application/json-patch+json",
    baseUrl: Constants.apiBaseUrl)));

class ProfileService {
  final Reader _read;
  ProfileService(this._read) {
    _read(dioProvider).interceptors.add(ApiInterceptor());
    _read(dioProvider).interceptors.add(ErrorInterceptor());
    _read(dioProvider).interceptors.add(PrettyDioLogger());
  }

  // get profile details
  Future<ProfileRes> getPrfileDetails() async {
    const url = '/profile';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(Constants.token);
    try {
      final response = await _read(dioProvider).get(url,
          options: Options(headers: {"Authentication": "Bearer $token"}));
      final result = ProfileRes.fromJson(response.data);

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

  // update profile details
  Future<bool> updatePrfileDetails(UpdateProfileReq updateProfileReq) async {
    const url = '/profile/edit-personal-info';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(Constants.token);
    try {
      final response = await _read(dioProvider).post(url,
          data: updateProfileReq.toJson(),
          options: Options(headers: {"Authentication": "Bearer $token"}));
      return response.data != null;
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
