import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/forgotten_email_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/manager/auth_manager.dart';

final forgottenEmailProvider =
    StateNotifierProvider<ForgottenEmailVm, RequestState<ForgettenEmailRes>>(
  (ref) => ForgottenEmailVm(ref),
);

class ForgottenEmailVm extends RequestStateNotifier<ForgettenEmailRes> {
  final AuthManager _authManager;

  ForgottenEmailVm(Ref ref) : _authManager = ref.read(authManagerProvider);

  Future<RequestState<ForgettenEmailRes>> forgottenEmail(
          String phoneNumber, String phoneCode) =>
      makeRequest(() => _authManager.forgotEmail(phoneNumber, phoneCode));
}
