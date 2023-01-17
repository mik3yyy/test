import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/new_sign_in_res.dart';

import '../../../../Data/controller/controller/generic_state_notifier.dart';
import '../../../../Data/services/auth/manager/auth_manager.dart';

final resend2FAProvider =
    StateNotifierProvider<Resend2FAVm, RequestState<GenericRes>>(
  (ref) => Resend2FAVm(ref),
);

class Resend2FAVm extends RequestStateNotifier<GenericRes> {
  final AuthManager _authManager;

  Resend2FAVm(Ref ref) : _authManager = ref.read(authManagerProvider);

  Future<RequestState<GenericRes>> resend2FA(
    String email,
  ) =>
      makeRequest(() => _authManager.resend2FA(email));
}
