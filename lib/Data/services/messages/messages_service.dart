import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/model/Dialog/dialog_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/failure_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/contact/contact_list.dart';
import 'package:kayndrexsphere_mobile/Data/model/contact/contact_res.dart';
import 'package:kayndrexsphere_mobile/Data/utils/api_interceptor.dart';
import 'package:kayndrexsphere_mobile/Data/utils/app_config/environment.dart';
import 'package:kayndrexsphere_mobile/Data/utils/error_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final messageServiceProvider = Provider<MessageService>((ref) {
  return MessageService((ref), ref);
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

  Future<ContactRes> createContact(String email) async {
    const url = '/messaging/contacts';

    try {
      final response = await _read.read(dioProvider).post(
        url,
        data: {
          'email': email,
        },
      );
      final result = ContactRes.fromJson(response.data);
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
        throw e.error;
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
        throw e.error;
      }
    }
  }
}
