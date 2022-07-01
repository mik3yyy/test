import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final deviceInfoProvider =
    StateNotifierProvider<DeviceIDNotifier, String>((ref) {
  final deviceInfo = DeviceInfoPlugin();
  return DeviceIDNotifier(deviceInfo);
});

class DeviceIDNotifier extends StateNotifier<String> {
  DeviceIDNotifier(
    this.deviceInfo,
  ) : super("unknown");
  final DeviceInfoPlugin deviceInfo;

  Future<String> deviceId() async {
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        state = androidInfo.androidId.toString();
        return androidInfo.androidId.toString();
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        state = iosInfo.identifierForVendor.toString();
        return iosInfo.identifierForVendor.toString();
      } else {
        return state;
      }
    } catch (e) {
      throw state.toString();
    }
  }
}

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
}
