import 'dart:async';
import 'dart:developer';
import 'package:internet_connection_checker/internet_connection_checker.dart';

// class ConnectionUtils {
//   static Future<bool> getActiveStatus() async {
//     var connectivityResult = await (Connectivity().checkConnectivity());
//     if (connectivityResult == ConnectivityResult.none) {
//       return false;
//     } else{
//  return true;
//     }

//   }
// }

class ConnectionUtils {
  static Future<bool> getActiveStatus() async {
    var result = await InternetConnectionChecker().connectionStatus;
    if (result == InternetConnectionStatus.disconnected) {
      log('internet is disconnected ${InternetConnectionChecker().checkInterval}"');
      return false;
    } else {
      log('internet is connected ${InternetConnectionChecker().checkInterval}"');
      return false;
    }
  }
}
