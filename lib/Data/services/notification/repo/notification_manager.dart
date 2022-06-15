import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/notification/repo/notification_repo.dart';
import 'package:kayndrexsphere_mobile/Data/services/notification/res/get_notification.dart';
import 'package:kayndrexsphere_mobile/Data/services/notification/service/notification_service.dart';

final notificationServiceManagerProvider = Provider((ref) {
  final notificationService = ref.watch(notificationServiceProvider);
  return NotificationServiceManager(notificationService);
});

class NotificationServiceManager extends NotificationRepo {
  NotificationService notificationService;
  NotificationServiceManager(this.notificationService);

  @override
  Future<GetNotification> getNotification() async =>
      await notificationService.getNotification();
}
