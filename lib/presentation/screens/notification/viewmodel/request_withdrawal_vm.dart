import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/notification/repo/notification_manager.dart';
import 'package:kayndrexsphere_mobile/Data/services/notification/withdrawal_request/withdrawal_req.dart';

// final getWithdrawalNotificationProvider = StateNotifierProvider.autoDispose<
//     GetWithdrawalNotification, RequestState<GetWithdrawalReq>>(
//   (ref) => GetWithdrawalNotification(ref),
// );

// class GetWithdrawalNotification extends RequestStateNotifier<GetWithdrawalReq> {
//   final NotificationServiceManager notificationServiceManager;

//   GetWithdrawalNotification(Ref ref)
//       : notificationServiceManager =
//             ref.read(notificationServiceManagerProvider) {
//     getWithdrawlNotification();
//   }

//   void getWithdrawlNotification() =>
//       makeRequest(() => notificationServiceManager.getWithdrawalRequest());
// }

final notificationReqSearchQueryProvider =
    StateProvider.autoDispose<String>((ref) {
  return '';
});

final remoteReqNotificationListProvider = FutureProvider.autoDispose((ref) {
  ref.maintainState = true;
  return ref.watch(notificationServiceManagerProvider).getWithdrawalRequest();
});

// USED TO FILTER THE LIST
final notificationReqSearchResultProvider =
    FutureProvider.autoDispose.family<List<Withdrawal>, String>((ref, query) {
  //GETS THE RESULT FROM THE SERVER
  final listSearch = ref.watch(remoteReqNotificationListProvider).value;

  //STORE THE RESULT AND THEN FILTER IT
  return listSearch!.data.withdrawals
      .where((element) =>
          element.status!.toLowerCase().contains(query.toLowerCase()))
      .toList();
});

//FILTER THE STORED RESULT --- THIS IS USED IN THE UI
final notificationReqSearchInputProvider = FutureProvider.autoDispose((ref) {
  // USED THE STATE PROVIDER FOR THE SEARCH QUERY METHOD
  final searchQuery = ref.watch(notificationReqSearchQueryProvider);

  final listSearch = ref.watch(remoteReqNotificationListProvider).value;
  //CHECK IF LIST RESULT COMING FROM THE SERVER IS NULL OR NOT

  if (listSearch != null) {
    // RETURN SUCCESSFULL RETURN FROM THE SERVER
    return ref.watch(notificationReqSearchResultProvider(searchQuery).future);
  } else {
    // RETURN AN EMPTY LIST IF ITS NULL
    return Future.value([]);
  }
});
