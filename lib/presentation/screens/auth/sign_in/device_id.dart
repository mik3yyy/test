import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceID {
  static Future<String> deviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String deviceIdentifier = "unknown";
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.androidId.toString();
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor.toString();
    } else {
      return deviceIdentifier;
    }
  }

  // if(Platform.isAndroid){
  // AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  //  deviceName = "Android Phone";
  //  model = androidInfo.model ?? "";
  //  os = androidInfo.version.baseOS ?? "";
  // }else if(Platform.isIOS){
  //   IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
  //   deviceName = "iPhone";
  //   model = iosInfo.name ?? "";
  //   os = iosInfo.systemVersion ?? "";
  // }

}
