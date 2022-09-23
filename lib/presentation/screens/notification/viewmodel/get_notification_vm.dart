import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/notification/repo/notification_manager.dart';
import 'package:kayndrexsphere_mobile/Data/services/notification/res/get_notification.dart';

// final getNotificationProvider =
//     StateNotifierProvider<NotificationVM, RequestState<GetNotification>>(
//   (ref) => NotificationVM(ref),
// );

// class NotificationVM extends RequestStateNotifier<GetNotification> {
//   final NotificationServiceManager notificationServiceManager;

//   NotificationVM(Ref ref)
//       : notificationServiceManager =
//             ref.read(notificationServiceManagerProvider) {
//     getNotification();
//   }

//   void getNotification() =>
//       makeRequest(() => notificationServiceManager.getNotification());
// }

final allnotificationSearchQueryProvider =
    StateProvider.autoDispose<String>((ref) {
  return '';
});

final remoteNotificationListProvider = FutureProvider.autoDispose((ref) {
  // ref.maintainState = true;
  return ref.watch(notificationServiceManagerProvider).getNotification();
});

// USED TO FILTER THE LIST
final notificationSearchResultProvider =
    FutureProvider.autoDispose.family<List<Notification>, String>((ref, query) {
  //GETS THE RESULT FROM THE SERVER
  final listSearch = ref.watch(remoteNotificationListProvider).value;

  //STORE THE RESULT AND THEN FILTER IT
  return listSearch!.data.notifications
      .where((element) =>
          element.data!.message!.toLowerCase().contains(query.toLowerCase()))
      .toList();
});

//FILTER THE STORED RESULT --- THIS IS USED IN THE UI
final notificationSearchInputProvider = FutureProvider.autoDispose((ref) {
  // USED THE STATE PROVIDER FOR THE SEARCH QUERY METHOD
  final searchQuery = ref.watch(allnotificationSearchQueryProvider);

  final listSearch = ref.watch(remoteNotificationListProvider).value;
  //CHECK IF LIST RESULT COMING FROM THE SERVER IS NULL OR NOT

  if (listSearch != null) {
    // RETURN SUCCESSFULL RETURN FROM THE SERVER
    return ref.watch(notificationSearchResultProvider(searchQuery).future);
  } else {
    // RETURN AN EMPTY LIST IF ITS NULL
    return Future.value([]);
  }
});
