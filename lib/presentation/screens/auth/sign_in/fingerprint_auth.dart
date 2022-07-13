import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/constant/constant.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/req/sign_in_req.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/device_id.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/vm/sign_in_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/security/auth_security/auth_secure.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';

class LocalAuthState extends Equatable {
  final String error;
  final bool hasBiometric;
  final bool isAuthenticated;
  final bool signInUser;
  const LocalAuthState(
      {required this.error,
      required this.hasBiometric,
      required this.isAuthenticated,
      required this.signInUser});

  factory LocalAuthState.initial() {
    return const LocalAuthState(
        error: "",
        hasBiometric: false,
        isAuthenticated: false,
        signInUser: false);
  }

  LocalAuthState copyWith({
    final String? error,
    final bool? hasBiometric,
    final bool? isAuthenticated,
    final bool? signInUser,
  }) {
    return LocalAuthState(
        error: error ?? this.error,
        hasBiometric: hasBiometric ?? this.hasBiometric,
        signInUser: signInUser ?? this.signInUser,
        isAuthenticated: isAuthenticated ?? this.isAuthenticated);
  }

  @override
  List<Object?> get props => [
        error,
        hasBiometric,
        isAuthenticated,
      ];
}

final localAuthStateProvider =
    StateNotifierProvider<LocalAuthNotifier, LocalAuthState>((ref) {
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
      state = state.copyWith(hasBiometric: hasBiometric);

      return hasBiometric;
    } on PlatformException catch (e) {
      state = state.copyWith(error: e.message);
      return false;
    }
  }

  Future<bool> authenticate() async {
    final password = await ref
        .read(credentialProvider.notifier)
        .getCredential(Constants.userPassword);
    final email = await ref
        .read(credentialProvider.notifier)
        .getCredential(Constants.userEmail);
    final deviceId = ref.watch(deviceInfoProvider);

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
        var signinReq = SigninReq(
            emailPhone: email!,
            password: password!,
            timezone: "Africa/Lagos",
            deviceId: deviceId);

        ref.read(signInProvider.notifier).signIn(signinReq);
      } else {
        throw "Unathenticated. Please try again";
      }

      state = state.copyWith(
        isAuthenticated: isAuthenticated,
      );
      return isAuthenticated;
    } on PlatformException catch (e) {
      state = state.copyWith(error: e.message);
      return false;
    }
  }

  //* reset biometric value when user signs out

  void resetbiometrics(bool value) {
    state = state.copyWith(isAuthenticated: value);
  }
}
