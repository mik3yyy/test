import 'dart:async';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectionUtils {
  static Future<bool> getActiveStatus() async {
    var result = await InternetConnectionChecker().connectionStatus;
    if (result == InternetConnectionStatus.disconnected) {
      print(
          'internet is disconnected ${InternetConnectionChecker().checkInterval}"');
      return false;
    } else {
      print('internet is connected');
      print(
          'internet is connected ${InternetConnectionChecker().checkInterval}"');
    }
    return false;
  }
}



// class InternetState extends StateNotifier<bool> {
//   late StreamSubscription internet;
//   InternetState() : super(false) {
//     monitorInternetConnection();
//   }

//   StreamSubscription<InternetConnectionStatus> monitorInternetConnection() {
//     return internet =
//         InternetConnectionChecker().onStatusChange.listen((status) {
//       switch (status) {
//         case InternetConnectionStatus.connected:
//           print('Data connection is available.');
//           break;
//         case InternetConnectionStatus.disconnected:
//           print('You are disconnected from the internet.');
//           break;
//       }
//     });
//   }

//   // @override
//   // Future<void> close() {
//   //   internet.cancel();
//   //   return super.dispose();
//   // }
// }

// final internetStateProvider = StateNotifierProvider((ref) => InternetState());

