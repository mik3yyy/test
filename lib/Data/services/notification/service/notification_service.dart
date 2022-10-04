import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/failure_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/notification/res/get_notification.dart';
import 'package:kayndrexsphere_mobile/Data/services/notification/withdrawal_request/withdrawal_req.dart';
import 'package:kayndrexsphere_mobile/Data/utils/api_interceptor.dart';
import 'package:kayndrexsphere_mobile/Data/utils/app_config/environment.dart';
import 'package:kayndrexsphere_mobile/Data/utils/error_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService((ref.read), ref);
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

class NotificationService {
  final Reader _read;
  final Ref ref;
  NotificationService(this._read, this.ref) {
    _read(dioProvider).interceptors.addAll([
      ApiInterceptor(),
      ErrorInterceptor(),
      PrettyDioLogger(),
      DioCacheInterceptor(options: ref.watch(cacheOptions)),
    ]);
  }

  // get Notification
  Future<GetNotification> getNotification() async {
    const url = '/notifications';

    try {
      final response = await _read(dioProvider).get(url,
          options: ref
              .watch(cacheOptions)
              .copyWith(
                policy: CachePolicy.refreshForceCache,
              )
              .toOptions());
      final result = GetNotification.fromJson(response.data);

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

  Future<GetWithdrawalReq> getWithdrawalRequest() async {
    const url = '/payments/withdrawals';

    try {
      final response = await _read(dioProvider).get(url,
          options: ref
              .watch(cacheOptions)
              .copyWith(
                policy: CachePolicy.refreshForceCache,
              )
              .toOptions());
      final result = GetWithdrawalReq.fromJson(response.data);

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
