import 'dart:async';
import 'package:connectivity/connectivity.dart';

class ConnectionUtils {
  static Future<bool> getActiveStatus() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    return true;
  }
}



// class ConnectionUtils {
//   static Future<bool> getActiveStatus() async {
//     var result = await InternetConnectionChecker().connectionStatus;
//     if (result == InternetConnectionStatus.disconnected) {
//       print(
//           'internet is disconnected ${InternetConnectionChecker().checkInterval}"');
//       return false;
//     } else {
//       print('internet is connected');
//       print(
//           'internet is connected ${InternetConnectionChecker().checkInterval}"');
//     }
//     return false;
//   }
// }



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

