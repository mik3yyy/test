import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';

enum AuthenticationStatus {
  unknown,
  authenticated,
  unauthenticated,
  notVerified,
  logout
}

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  // final authRepository = ref.watch(authManagerProvider);

  return AuthController();
});

class AuthController extends StateNotifier<bool> {
  AuthController() : super(PreferenceManager.isFirstLaunch);

  void getAuth() {
    state = PreferenceManager.isFirstLaunch;
  }

  void setAuth(bool value) async {
    state = value;
  }
}
