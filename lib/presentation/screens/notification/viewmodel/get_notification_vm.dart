import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/notification/repo/notification_manager.dart';
import 'package:kayndrexsphere_mobile/Data/services/notification/res/get_notification.dart';

final getNotificationProvider = StateNotifierProvider.autoDispose<
    NotificationVM, RequestState<GetNotification>>(
  (ref) => NotificationVM(ref),
);

class NotificationVM extends RequestStateNotifier<GetNotification> {
  final NotificationServiceManager notificationServiceManager;

  NotificationVM(Ref ref)
      : notificationServiceManager =
            ref.read(notificationServiceManagerProvider) {
    getNotification();
  }

  void getNotification() =>
      makeRequest(() => notificationServiceManager.getNotification());
}
