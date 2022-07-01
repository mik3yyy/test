import 'dart:async';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/manager/auth_manager.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/refreshToken/refresh_token_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/refreshToken/refresh_token_res.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/device_id.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';

class RefreshTokenState extends Equatable {
  final bool success;
  final String error;
  final bool loading;
  final String countryCode;

  const RefreshTokenState(
      {required this.success,
      required this.error,
      required this.loading,
      required this.countryCode});

  factory RefreshTokenState.initial() {
    return const RefreshTokenState(
        success: false, error: "ERROR", loading: false, countryCode: "");
  }

  RefreshTokenState copyWith(
      {bool? success, String? error, bool? loading, String? countryCode}) {
    return RefreshTokenState(
        success: success ?? this.success,
        error: error ?? this.error,
        loading: loading ?? this.loading,
        countryCode: countryCode ?? this.countryCode);
  }

  @override
  List<Object?> get props => [success, loading, error, countryCode];
}

final refreshControllerProvider =
    StateNotifierProvider<RefreshTokenController, RefreshTokenState>((ref) {
  return RefreshTokenController(ref);
});

class RefreshTokenController extends StateNotifier<RefreshTokenState> {
  final Ref ref;
  RefreshTokenController(this.ref) : super(RefreshTokenState.initial());

  void addCountryCode(String countryCode) {
    state = state.copyWith(countryCode: countryCode);
  }

  Future<RefreshTokenRes> refreshToken() async {
    state = state.copyWith(loading: true, success: false);

    try {
      Future.delayed(const Duration(seconds: 20));

      final refreshToken = PreferenceManager.refreshToken;
      final deviceId = ref.watch(deviceInfoProvider);
      // DeviceID.deviceId().then((value) async {
      var refreshTokenReq =
          RefreshTokenReq(refreshToken: refreshToken, deviceId: deviceId);
      final token =
          await ref.read(authManagerProvider).getAuthTOken(refreshTokenReq);

      PreferenceManager.authToken = token.data!.authToken.toString();
      PreferenceManager.refreshToken = token.data!.refreshToken.toString();
      state = state.copyWith(loading: false, success: true);
      // });

      return token;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      print(e);
      throw e.toString();
    }
  }
}
