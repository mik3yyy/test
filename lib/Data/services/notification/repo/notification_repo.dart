import 'package:kayndrexsphere_mobile/Data/services/notification/res/get_notification.dart';
import 'package:kayndrexsphere_mobile/Data/services/notification/withdrawal_request/withdrawal_req.dart';

abstract class NotificationRepo {
  Future<GetNotification> getNotification();
  Future<GetWithdrawalReq> getWithdrawalRequest();
}
