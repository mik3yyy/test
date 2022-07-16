import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final deviceInfoProvider =
    StateNotifierProvider<DeviceIDNotifier, DeviceState>((ref) {
  final deviceInfo = DeviceInfoPlugin();
  return DeviceIDNotifier(deviceInfo);
});

class DeviceState extends Equatable {
  final String deviceId;
  final String timeZone;
  const DeviceState({
    required this.deviceId,
    required this.timeZone,
  });

  factory DeviceState.initial() {
    return const DeviceState(deviceId: "", timeZone: "");
  }

  DeviceState copyWith({
    final String? deviceId,
    final String? timeZone,
  }) {
    return DeviceState(
        deviceId: deviceId ?? this.deviceId,
        timeZone: timeZone ?? this.timeZone);
  }

  @override
  List<Object?> get props => [deviceId, timeZone];
}

class DeviceIDNotifier extends StateNotifier<DeviceState> {
  DeviceIDNotifier(
    this.deviceInfo,
  ) : super(DeviceState.initial());
  final DeviceInfoPlugin deviceInfo;

  Future<String> deviceId() async {
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        state = state.copyWith(deviceId: androidInfo.androidId.toString());

        return androidInfo.androidId.toString();
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        state =
            state.copyWith(deviceId: iosInfo.identifierForVendor.toString());

        return iosInfo.identifierForVendor.toString();
      } else {
        return state.deviceId;
      }
    } catch (e) {
      throw state.toString();
    }
  }

  Future<String> timeZone() async {
    try {
      final String currentTimeZone =
          await FlutterNativeTimezone.getLocalTimezone();
      state = state.copyWith(timeZone: currentTimeZone);
      return currentTimeZone;
    } catch (e) {
      throw state.toString();
    }
  }
}
