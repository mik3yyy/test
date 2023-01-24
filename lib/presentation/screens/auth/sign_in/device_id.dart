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

  void deviceId() {
    try {
      if (Platform.isAndroid) {
        deviceInfo.androidInfo.then((value) {
          state = state.copyWith(deviceId: value.androidId.toString());
        });

        // return androidInfo.androidId.toString();
      } else if (Platform.isIOS) {
        deviceInfo.iosInfo.then((value) {
          state =
              state.copyWith(deviceId: value.identifierForVendor.toString());
        });

        // return iosInfo.identifierForVendor.toString();
      } else {
        return;
      }
    } catch (e) {
      throw state.toString();
    }
  }

  void timeZone() {
    try {
      FlutterNativeTimezone.getLocalTimezone().then((value) {
        state = state.copyWith(timeZone: value);
      });
    } catch (e) {
      throw state.toString();
    }
  }
}
