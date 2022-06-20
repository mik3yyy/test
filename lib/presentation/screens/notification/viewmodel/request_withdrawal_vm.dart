import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/notification/repo/notification_manager.dart';
import 'package:kayndrexsphere_mobile/Data/services/notification/withdrawal_request/withdrawal_req.dart';

final getWithdrawalNotificationProvider = StateNotifierProvider.autoDispose<
    GetWithdrawalNotification, RequestState<GetWithdrawalReq>>(
  (ref) => GetWithdrawalNotification(ref),
);

class GetWithdrawalNotification extends RequestStateNotifier<GetWithdrawalReq> {
  final NotificationServiceManager notificationServiceManager;

  GetWithdrawalNotification(Ref ref)
      : notificationServiceManager =
            ref.read(notificationServiceManagerProvider) {
    getWithdrawlNotification();
  }

  void getWithdrawlNotification() =>
      makeRequest(() => notificationServiceManager.getWithdrawalRequest());
}
