import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';

class LocalAuthState extends Equatable {
  final String error;
  final bool hasBiometric;
  final bool isAuthenticated;
  const LocalAuthState({
    required this.error,
    required this.hasBiometric,
    required this.isAuthenticated,
  });

  factory LocalAuthState.initial() {
    return const LocalAuthState(
        error: "", hasBiometric: false, isAuthenticated: false);
  }

  LocalAuthState copyWith({
    final String? error,
    final bool? hasBiometric,
    final bool? isAuthenticated,
  }) {
    return LocalAuthState(
        error: error ?? this.error,
        hasBiometric: hasBiometric ?? this.hasBiometric,
        isAuthenticated: isAuthenticated ?? this.isAuthenticated);
  }

  @override
  List<Object?> get props => [error, hasBiometric, isAuthenticated];
}

final localAuthStateProvider =
    StateNotifierProvider<LocalAuthNotifier, LocalAuthState>((ref) {
  final localAuth = LocalAuthentication();
  return LocalAuthNotifier(localAuth);
});

class LocalAuthNotifier extends StateNotifier<LocalAuthState> {
  LocalAuthNotifier(this.auth) : super(LocalAuthState.initial());
  final LocalAuthentication auth;
  Future<bool> hasBiometrics() async {
    try {
      final hasBiometric = await auth.canCheckBiometrics;
      state = state.copyWith(hasBiometric: hasBiometric);

      return hasBiometric;
    } on PlatformException catch (e) {
      state = state.copyWith(error: e.message);
      return false;
    }
  }

  Future<bool> authenticate() async {
    try {
      final isAuthenticated = await auth.authenticate(
        localizedReason: "Verify your account with your Finger print",
        authMessages: <AuthMessages>[
          const AndroidAuthMessages(
            biometricHint: 'Finger print authentication is required!',
            cancelButton: 'No thanks',
          ),
        ],
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: false,
        ),
      );

      state = state.copyWith(isAuthenticated: isAuthenticated);
      return isAuthenticated;
    } on PlatformException catch (e) {
      state = state.copyWith(error: e.message);
      return false;
    }
  }
}
