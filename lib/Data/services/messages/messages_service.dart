import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http_parser/http_parser.dart';
import 'package:kayndrexsphere_mobile/Data/model/Dialog/all_dialog.dart';
import 'package:kayndrexsphere_mobile/Data/model/Dialog/create_dialog_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/Dialog/dialog_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/failure_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/new_sign_in_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/contact/contact_list.dart';
import 'package:kayndrexsphere_mobile/Data/model/contact/contact_res.dart';
import 'package:kayndrexsphere_mobile/Data/utils/api_interceptor.dart';
import 'package:kayndrexsphere_mobile/Data/utils/app_config/environment.dart';
import 'package:kayndrexsphere_mobile/Data/utils/error_handler.dart';
import 'package:kayndrexsphere_mobile/Data/utils/error_interceptor.dart';
import 'package:mime/mime.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:path_provider/path_provider.dart';

final messageServiceProvider = Provider<MessageService>((ref) {
  return MessageService((ref), ref);
});

final dioProvider = Provider((ref) => Dio(BaseOptions(
    receiveTimeout: const Duration(milliseconds: 100000),
    connectTimeout: const Duration(milliseconds: 100000),
    // contentType: "application/json-patch+json",
    baseUrl: AppConfig.coreBaseUrl)));

final cacheProvider =
    Provider((ref) => MemCacheStore(maxSize: 10485760, maxEntrySize: 1048576));
final cacheOptions = Provider((ref) => CacheOptions(
      store: ref.watch(cacheProvider),
      hitCacheOnErrorExcept: [401, 403],
      priority: CachePriority.normal,
      maxStale: const Duration(days: 5),
      // for offline behaviour
    ));

// final cacheStore = MemCacheStore(maxSize: 10485760, maxEntrySize: 1048576);
// final cacheOptions = CacheOptions(
//   store: cacheStore,
//   hitCacheOnErrorExcept: [], // for offline behaviour
// );

class MessageService {
  final Ref _read;
  final Ref ref;

  MessageService(this._read, this.ref) {
    _read.read(dioProvider).interceptors.addAll([
      ApiInterceptor(),
      ErrorInterceptor(),
      PrettyDioLogger(),
      DioCacheInterceptor(options: ref.watch(cacheOptions)),
    ]);
  }

  Future<ContactRes> createContact(String accountNumber) async {
    const url = '/messaging/contacts';

    try {
      final response = await _read.read(dioProvider).post(
        url,
        data: {
          'account_no': accountNumber,
        },
      );
      final result = ContactRes.fromJson(response.data);
      return result;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != "") {
        if (e.response?.statusCode == 500) {
          throw "An Error occurred";
        } else {
          Failure result = Failure.fromJson(e.response!.data);
          throw result.message!;
        }
      } else {
        final errorMessage = DioExceptions.fromDioError(e).toString();
        throw errorMessage;
      }
    }
  }

  Future<ContactList> getContacts() async {
    const url = '/messaging/contacts';
    try {
      final response = await _read.read(dioProvider).get(url,
          options: ref
              .watch(cacheOptions)
              .copyWith(
                policy: CachePolicy.refresh,
              )
              .toOptions());

      final result = ContactList.fromJson(response.data);
      return result;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != "") {
        Failure result = Failure.fromJson(e.response!.data);
        throw result.message!;
      } else {
        final errorMessage = DioExceptions.fromDioError(e).toString();
        throw errorMessage;
      }
    }
  }

  /// RENAME CONTACT
  Future<GenericRes> renameContact(String contactName, int id) async {
    final url = '/messaging/contacts/rename/$id';
    try {
      final response = await _read.read(dioProvider).post(
        url,
        data: {
          "contact_name": contactName,
        },
      );

      final result = GenericRes.fromJson(response.data);
      return result;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != "") {
        if (e.response?.statusCode == 500 || (e.response?.statusCode == 404)) {
          throw "An Error occurred";
        } else {
          Failure result = Failure.fromJson(e.response!.data);
          throw result.message!;
        }
      } else {
        final errorMessage = DioExceptions.fromDioError(e).toString();
        throw errorMessage;
      }
    }
  }

  /// DELETE CONTACT
  Future<GenericRes> deleteContact(int id) async {
    final url = '/messaging/delete/$id';
    try {
      final response = await _read.read(dioProvider).post(
            url,
          );

      final result = GenericRes.fromJson(response.data);
      return result;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != "") {
        if (e.response?.statusCode == 500 || (e.response?.statusCode == 404)) {
          throw "An Error occurred";
        } else {
          Failure result = Failure.fromJson(e.response!.data);
          throw result.message!;
        }
      } else {
        final errorMessage = DioExceptions.fromDioError(e).toString();
        throw errorMessage;
      }
    }
  }

  /// BLOCK CONTACT
  Future<GenericRes> blockContact(int id) async {
    final url = '/messaging/contacts/block/$id';
    try {
      final response = await _read.read(dioProvider).post(
            url,
          );

      final result = GenericRes.fromJson(response.data);
      return result;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != "") {
        if (e.response?.statusCode == 500 || (e.response?.statusCode == 404)) {
          throw "An Error occurred";
        } else {
          Failure result = Failure.fromJson(e.response!.data);
          throw result.message!;
        }
      } else {
        final errorMessage = DioExceptions.fromDioError(e).toString();
        throw errorMessage;
      }
    }
  }

  /// UNBLOCK CONTACT
  Future<GenericRes> unblockContact(int id) async {
    final url = '/messaging/contacts/unblock/$id';
    try {
      final response = await _read.read(dioProvider).post(
            url,
          );

      final result = GenericRes.fromJson(response.data);
      return result;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != "") {
        if (e.response?.statusCode == 500 || (e.response?.statusCode == 404)) {
          throw "An Error occurred";
        } else {
          Failure result = Failure.fromJson(e.response!.data);
          throw result.message!;
        }
      } else {
        final errorMessage = DioExceptions.fromDioError(e).toString();
        throw errorMessage;
      }
    }
  }

  /// GET ALL DIALOGS

  Future<AllDialog> getAllDialog() async {
    const url = '/messaging/dialogs/';
    try {
      final response = await _read.read(dioProvider).get(url,
          options: ref
              .watch(cacheOptions)
              .copyWith(
                policy: CachePolicy.refresh,
              )
              .toOptions());

      final result = AllDialog.fromJson(response.data);
      return result;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != "") {
        Failure result = Failure.fromJson(e.response!.data);
        throw result.message!;
      } else {
        final errorMessage = DioExceptions.fromDioError(e).toString();
        throw errorMessage;
      }
    }
  }

  Future<DialogRes> getDialogMessages(int id) async {
    final url = '/messaging/dialogs/$id';
    try {
      final response = await _read.read(dioProvider).get(url,
          options: ref
              .watch(cacheOptions)
              .copyWith(
                policy: CachePolicy.refresh,
              )
              .toOptions());

      final result = DialogRes.fromJson(response.data);
      return result;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != "") {
        Failure result = Failure.fromJson(e.response!.data);
        throw result.message!;
      } else {
        final errorMessage = DioExceptions.fromDioError(e).toString();
        throw errorMessage;
      }
    }
  }

  /// CREATE DIALOG
  Future<CreateDialogRes> createDialog(int contactId, String message) async {
    const url = '/messaging/dialogs/';
    try {
      final response = await _read.read(dioProvider).post(
        url,
        data: {"contact_id": contactId, "message": message},
      );

      final result = CreateDialogRes.fromJson(response.data);
      return result;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != "") {
        if (e.response?.statusCode == 500 || (e.response?.statusCode == 404)) {
          throw "An Error occurred";
        } else {
          Failure result = Failure.fromJson(e.response!.data);
          throw result.message!;
        }
      } else {
        final errorMessage = DioExceptions.fromDioError(e).toString();
        throw errorMessage;
      }
    }
  }

  /// SEND MESSAGES
  Future<GenericRes> sendMessage(
      int id, String message, String filePath) async {
    const url = '/messaging/dialogs/send-message';
    File file = File(filePath);
    final mimeTypeData =
        lookupMimeType(file.path, headerBytes: [0xFF, 0xD8])!.split('/');

    FormData formData = FormData.fromMap({
      "dialog_id": id,
      "message": message,
      "attachment": filePath.isNotEmpty
          ? await MultipartFile.fromFile(file.path,
              contentType: MediaType(mimeTypeData[0], mimeTypeData[1]))
          : "",
    });
    try {
      final response = await _read.read(dioProvider).post(
            url,
            data: formData,
          );

      final result = GenericRes.fromJson(response.data);
      return result;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != "") {
        if (e.response?.statusCode == 500 || (e.response?.statusCode == 404)) {
          throw "An Error occurred";
        } else {
          Failure result = Failure.fromJson(e.response!.data);
          throw result.message!;
        }
      } else {
        final errorMessage = DioExceptions.fromDioError(e).toString();
        throw errorMessage;
      }
    }
  }

  // Future<String> downloadAttachment(
  //     String url, String downloadDirectory) async {
  //   var downloadedImagePath = '$downloadDirectory/image.jpg';
  //   try {
  //     final response = await _read.read(dioProvider).download(
  //           url,
  //           downloadedImagePath,
  //         );
  //     log(response.data.toString());
  //     return downloadedImagePath;
  //   } on DioError catch (e) {
  //     final errorMessage = DioExceptions.fromDioError(e).toString();
  //     throw errorMessage;
  //   }
  // }

  // Future<String> _prepareSaveDir() async {
  //   final _localPath = (await _findLocalPath())!;
  //   final savedDir = Directory(_localPath);
  //   bool hasExisted = await savedDir.exists();
  //   if (!hasExisted) {
  //     savedDir.create();
  //   }

  //   return _localPath;
  // }

  Future<String?> _findLocalPath() async {
    // await _prepareSaveDir();
    if (Platform.isAndroid) {
      return "/storage/emulated/0/Download/";
    } else {
      //getApplicationSupportDirectory()
      var directory = await getApplicationDocumentsDirectory();
      return directory.path + Platform.pathSeparator + 'Download';
    }
  }

  /// Download file to device
  Future<String> downloadAttachment(String url, String fileType) async {
    final _localPath = (await _findLocalPath())!;

    // Checks file type before downloading
    String fileEx() {
      if (fileType == "image") {
        return "image.jpg";
      } else {
        return "file.pdf";
      }
    }

    try {
      await _read.read(dioProvider).download(
            url,
            _localPath + "/" + fileEx(),
          );
      return _localPath;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
