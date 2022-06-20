import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/auth_controller/auth_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/manager/auth_manager.dart';

enum AuthenticationStatus {
  unknown,
  authenticated,
  unauthenticated,
  notVerified,
  logout
}

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  final authRepository = ref.watch(authManagerProvider);

  return AuthController(authRepository);
});

class AuthController extends StateNotifier<AuthState> {
  final AuthManager _authManager;
  AuthController(this._authManager, [AuthState? state])
      : super(state ?? const AuthUnauthenticated()) {
    auth(AuthenticationStatus.unknown);
  }

  void auth(AuthenticationStatus status) async {
    if (status == AuthenticationStatus.unauthenticated) {
      state = const AuthUnauthenticated();
    } else if (status == AuthenticationStatus.authenticated) {
      state = const AuthAuthenticated(true);
    } else if (status == AuthenticationStatus.logout) {
      // await _authRepository.removeToken();
      state = const AuthUnauthenticated();
    } else {
      state = const AuthUnauthenticated();
    }
  }
}
