import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/sigout_res.dart';

import '../../../../Data/controller/controller/generic_state_notifier.dart';
import '../../../../Data/services/auth/manager/auth_manager.dart';

final signOutProvider =
    StateNotifierProvider<SignOutVM, RequestState<SigninOutRes>>(
  (ref) => SignOutVM(ref),
);

class SignOutVM extends RequestStateNotifier<SigninOutRes> {
  final AuthManager _authManager;

  SignOutVM(Ref ref) : _authManager = ref.read(authManagerProvider);

  Future<RequestState<SigninOutRes>> signOut(
    String deviceId,
  ) =>
      makeRequest(() => _authManager.signOut(deviceId));
}
