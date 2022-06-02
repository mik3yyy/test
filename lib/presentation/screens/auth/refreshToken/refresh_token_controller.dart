import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/manager/auth_manager.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/refreshToken/refresh_token_req.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';

class RefreshTokenState extends Equatable {
  final bool success;
  final String error;
  final bool loading;

  const RefreshTokenState({
    required this.success,
    required this.error,
    required this.loading,
  });

  factory RefreshTokenState.initial() {
    return const RefreshTokenState(success: false, error: "", loading: false);
  }

  RefreshTokenState copyWith({
    bool? success,
    String? error,
    bool? loading,
  }) {
    return RefreshTokenState(
        success: success ?? this.success,
        error: error ?? this.error,
        loading: loading ?? this.loading);
  }

  @override
  List<Object?> get props => [success, loading, error];
}

final refreshControllerProvider =
    StateNotifierProvider<RefreshTokenController, RefreshTokenState>((ref) {
  return RefreshTokenController(ref.watch(authManagerProvider));
});

class RefreshTokenController extends StateNotifier<RefreshTokenState> {
  final AuthManager authManager;
  RefreshTokenController(this.authManager) : super(RefreshTokenState.initial());

  void refreshToken() async {
    state = state.copyWith(loading: true, success: false);

    try {
      Future.delayed(const Duration(seconds: 20));

      Timer.periodic(const Duration(minutes: 9), (Timer timer) async {
        final refreshToken = PreferenceManager.refreshToken;

        var refreshTokenReq = RefreshTokenReq(
            refreshToken: refreshToken, deviceId: "deviceIDSforlife");
        final token = await authManager.getAuthTOken(refreshTokenReq);
        PreferenceManager.authToken = token.data!.authToken.toString();
        PreferenceManager.refreshToken = token.data!.refreshToken.toString();
      });
    } catch (e) {
      state =
          state.copyWith(loading: false, success: false, error: e.toString());
    }
  }
}
