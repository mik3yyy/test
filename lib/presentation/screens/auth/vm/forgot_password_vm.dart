import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../Data/controller/controller/generic_state_notifier.dart';
import '../../../../Data/services/auth/manager/auth_manager.dart';

final forgotPasswordProvider =
    StateNotifierProvider<ForgotPasswordVm, RequestState<bool>>(
  (ref) => ForgotPasswordVm(ref),
);

class ForgotPasswordVm extends RequestStateNotifier<bool> {
  final AuthManager _authManager;

  ForgotPasswordVm(Ref ref) : _authManager = ref.read(authManagerProvider);

  Future<RequestState<bool>> forgotPassword(
    String emailPhone,
  ) =>
      makeRequest(() => _authManager.forgotPassword(emailPhone));
}
