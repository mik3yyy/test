import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/constant/constant.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/req/sign_in_req.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/device_id.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/vm/sign_in_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/security/auth_security/auth_secure.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';

class LocalAuthState extends Equatable {
  final String error;
  final bool hasBiometric;
  final bool isAuthenticated;
  final bool success;
  const LocalAuthState(
      {required this.error,
      required this.hasBiometric,
      required this.isAuthenticated,
      required this.success});

  factory LocalAuthState.initial() {
    return const LocalAuthState(
        error: "", hasBiometric: false, isAuthenticated: false, success: false);
  }

  LocalAuthState copyWith({
    final String? error,
    final bool? hasBiometric,
    final bool? isAuthenticated,
    final bool? success,
  }) {
    return LocalAuthState(
        error: error ?? this.error,
        hasBiometric: hasBiometric ?? this.hasBiometric,
        success: success ?? this.success,
        isAuthenticated: isAuthenticated ?? this.isAuthenticated);
  }

  @override
  List<Object?> get props => [error, hasBiometric, isAuthenticated, success];
}

final localAuthStateProvider =
    StateNotifierProvider.autoDispose<LocalAuthNotifier, LocalAuthState>((ref) {
  final localAuth = LocalAuthentication();
  return LocalAuthNotifier(localAuth, ref);
});

class LocalAuthNotifier extends StateNotifier<LocalAuthState> {
  LocalAuthNotifier(this.auth, this.ref) : super(LocalAuthState.initial());
  final LocalAuthentication auth;
  final Ref ref;
  final storage = const FlutterSecureStorage();
  Future<bool> hasBiometrics() async {
    try {
      final hasBiometric = await auth.canCheckBiometrics;
      // final  availableBiometrics =
      //     await auth.getAvailableBiometrics();

      if (!mounted) return false;
      // print(hasBiometric);
      // print(availableBiometrics);
      state = state.copyWith(hasBiometric: hasBiometric);
      PreferenceManager.hasBiometrics = hasBiometric;

      return hasBiometric;
    } on PlatformException catch (e) {
      state = state.copyWith(error: e.message);
      return false;
    }
  }

  ///  AUTHENTICATE A USER HERE
  Future<bool> authenticate() async {
    final password = await ref
        .read(credentialProvider.notifier)
        .getCredential(Constants.userPassword);
    final email = await ref
        .read(credentialProvider.notifier)
        .getCredential(Constants.userEmail);
    final device = ref.watch(deviceInfoProvider);

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

      if (state.isAuthenticated) {
        var signinReq = SigninReq(
            emailPhone: email ?? "",
            password: password ?? "",
            timezone: device.timeZone,
            deviceId: device.deviceId);

        switch (PreferenceManager.isFirstLaunch) {
          case false:
            ref.read(verifyAuthProvider.notifier).verifyAuth(signinReq);
            break;
          case true:
            ref.read(signInProvider.notifier).signIn(signinReq);
            break;
          default:
        }

        if (mounted) {
          state = state.copyWith(success: true);
        }
      } else {
        throw "Unathenticated. Please try again";
      }

      return isAuthenticated;
    } on PlatformException catch (e) {
      state = state.copyWith(error: e.message);
      return false;
    }
  }

  //* AUTHENTICATE TRANSACTION PIN

  Future<String> authenticateTransaction() async {
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

      if (isAuthenticated) {
        final pin = await ref
            .read(credentialProvider.notifier)
            .getCredential(Constants.transactionPin);
        return pin.toString();
      } else {
        return "Could not be Authenticated. Try again";
      }
    } on PlatformException catch (e) {
      if (mounted) {
        state = state.copyWith(error: e.message);
      }
      throw e.toString();
    }
  }

  //* reset biometric value when user signs out

  void resetbiometrics(bool value) {
    state = state.copyWith(isAuthenticated: value);
  }
}
