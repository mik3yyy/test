import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/req/verify_account_req.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/verify_account_res.dart';

import '../../../../Data/controller/controller/generic_state_notifier.dart';
import '../../../../Data/services/auth/manager/auth_manager.dart';

final verifyAccountProvider =
    StateNotifierProvider<VerifyAccountVm, RequestState<VerifyRes>>(
  (ref) => VerifyAccountVm(ref),
);

class VerifyAccountVm extends RequestStateNotifier<VerifyRes> {
  final AuthManager _authManager;

  VerifyAccountVm(Ref ref) : _authManager = ref.read(authManagerProvider);

  Future<RequestState<VerifyRes>> verifyAccount(VerifyAccount verify) =>
      makeRequest(() => _authManager.verifyAccount(verify));
}
