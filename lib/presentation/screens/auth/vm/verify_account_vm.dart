import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/verify_account_res.dart';

import '../../../../Data/controller/controller/generic_state_notifier.dart';
import '../../../../Data/services/auth/manager/auth_manager.dart';

final verifyAccountProvider =
    StateNotifierProvider<VerifyAccountVm, RequestState<bool>>(
  (ref) => VerifyAccountVm(ref),
);

class VerifyAccountVm extends RequestStateNotifier<bool> {
  final AuthManager _authManager;

  VerifyAccountVm(Ref ref) : _authManager = ref.read(authManagerProvider);

  Future<RequestState<bool>> verifyAccount(VerifyAccount verify) =>
      makeRequest(() => _authManager.verifyAccount(verify));
}
