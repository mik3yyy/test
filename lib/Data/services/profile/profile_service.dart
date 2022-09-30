import 'dart:io';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/req/change_password_req.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/req/change_transactionpin_req.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/req/update_profile_req.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/res/profile_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/res/upload_id_res.dart';
import 'package:kayndrexsphere_mobile/Data/utils/app_config/environment.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/constant.dart';
import '../../model/auth/res/failure_res.dart';
import '../../utils/api_interceptor.dart';
import '../../utils/error_interceptor.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

final profileProvider = Provider<ProfileService>((ref) {
  return ProfileService((ref.read));
});

final dioProvider = Provider((ref) => Dio(BaseOptions(
    receiveTimeout: 100000,
    connectTimeout: 100000,
    // contentType: "application/json-patch+json",
    baseUrl: AppConfig.coreBaseUrl)));

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
        throw e.error;
      }
    }
  }

  // change password
  Future<bool> changePassword(ChangePasswordReq changePasswordReq) async {
    const url = '/auth/change-password';
    try {
      final response =
          await _read(dioProvider).post(url, data: changePasswordReq.toJson());
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

  // change transaction pin
  Future<bool> changeTransactionPin(
      ChangeTransactionPinReq changeTransactionPinReq) async {
    const url = '/auth/transaction-pin/change-pin';
    try {
      final response = await _read(dioProvider)
          .post(url, data: changeTransactionPinReq.toJson());
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

  // forget pin
  Future<bool> forgotPin(String emailPhone) async {
    const url = '/auth/transaction-pin/forgot-pin';
    try {
      final response =
          await _read(dioProvider).post(url, data: {"route": "email"});
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

  // reset pin
  Future<bool> resetPin(String otpCode, String pin, String confirmPin) async {
    const url = '/auth/transaction-pin/reset-pin';
    try {
      final response = await _read(dioProvider).post(url, data: {
        "route": "email",
        "code": otpCode,
        "new_pin": pin,
        "confirm_new_pin": confirmPin
      });

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

  // Future upLoadProfilePic(String filePath) async {
  //   var cloudinary = CloudinaryPublic('dnnxnfr6c', 'ouvoc5zb', cache: false);
  //   try {
  //     final response = await cloudinary.uploadFile(
  //       CloudinaryFile.fromFile(filePath,
  //           resourceType: CloudinaryResourceType.Image),
  //     );
  //     print("this is  ${response.secureUrl}");
  //     return response.secureUrl;
  //   } on DioError catch (e) {
  //     if (e.response != null && e.response!.data != "") {
  //       Failure result = Failure.fromJson(e.response!.data);
  //       throw result.message!;
  //     } else {
  //       throw e.error;
  //     }
  //   }
  // }

  Future<bool> updateImage(String filePath) async {
    const url = '/profile/upload-picture';

    File file = File(filePath);
    final mimeTypeData =
        lookupMimeType(file.path, headerBytes: [0xFF, 0xD8])!.split('/');

    FormData formData = FormData.fromMap({
      "profile_picture": await MultipartFile.fromFile(file.path,
          contentType: MediaType(mimeTypeData[0], mimeTypeData[1])),
    });
    try {
      final response = await _read(dioProvider).post(url,
          data: formData, options: Options(headers: {"requireToken": true}));
      // final result = ProfileRes.fromJson(response.data);
      return response.data != null;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != '') {
        Failure result = Failure.fromJson(e.response!.data);
        throw result.message!;
      } else {
        // print(Constants.errorMessage);
        // throw Constants.errorMessage;
        throw e.error;
      }
    }
  }

  Future<UploadIdRes> updateId(
      String filePath, String idType, String idNo) async {
    const url = '/profile/add-id';

    File file = File(filePath);
    final mimeTypeData =
        lookupMimeType(file.path, headerBytes: [0xFF, 0xD8])!.split('/');

    FormData formData = FormData.fromMap({
      "file_front": await MultipartFile.fromFile(file.path,
          contentType: MediaType(mimeTypeData[0], mimeTypeData[1])),
      "id_no": idNo,
      "id_type": idType
    });
    try {
      final response = await _read(dioProvider).post(url,
          data: formData, options: Options(headers: {"requireToken": true}));
      // final result = ProfileRes.fromJson(response.data);
      return UploadIdRes.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != '') {
        Failure result = Failure.fromJson(e.response!.data);
        throw result.message!;
      } else {
        // print(Constants.errorMessage);
        // throw Constants.errorMessage;
        throw e.error;
      }
    }
  }

  // Future<bool> uploadPP(String imageUrl) async {
  //   const url = '/profile/upload-picture';
  //   try {
  //     final response = await _read(dioProvider)
  //         .post(url, data: {"profile_picture": imageUrl});

  //     final result = response.data = true;
  //     return result;
  //   } on DioError catch (e) {
  //     if (e.response != null && e.response!.data != "") {
  //       Failure result = Failure.fromJson(e.response!.data);
  //       throw result.message!;
  //     } else {
  //       throw e.error;
  //     }
  //   }
  // }
}
