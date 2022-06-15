import 'package:kayndrexsphere_mobile/Data/services/notification/res/get_notification.dart';

abstract class NotificationRepo {
  Future<GetNotification> getNotification();
}
