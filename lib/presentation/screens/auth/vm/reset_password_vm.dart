import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/signin_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/manager/auth_manager.dart';

final resetPasswordProvider =
    StateNotifierProvider<ResetPasswordVm, RequestState<SigninRes>>(
  (ref) => ResetPasswordVm(ref),
);

class ResetPasswordVm extends RequestStateNotifier<SigninRes> {
  final AuthManager _authManager;

  ResetPasswordVm(Ref ref) : _authManager = ref.read(authManagerProvider);

  Future<RequestState<SigninRes>> resetPassword(
    String emailPhone,
    String otpCode,
    String password,
    String confirmPassword,
  ) =>
      makeRequest(() => _authManager.resetPassword(
          emailPhone, otpCode, password, confirmPassword));
}
