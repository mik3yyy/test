import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../Data/controller/controller/generic_state_notifier.dart';
import '../../../../Data/services/auth/manager/auth_manager.dart';

final resendOtpProvider =
    StateNotifierProvider<ResendOtpVm, RequestState<bool>>(
  (ref) => ResendOtpVm(ref),
);

class ResendOtpVm extends RequestStateNotifier<bool> {
  final AuthManager _authManager;

  ResendOtpVm(Ref ref) : _authManager = ref.read(authManagerProvider);

  Future<RequestState<bool>> resendOtp(
    String emailPhone,
  ) =>
      makeRequest(() => _authManager.resendOtp(emailPhone: emailPhone));
}
