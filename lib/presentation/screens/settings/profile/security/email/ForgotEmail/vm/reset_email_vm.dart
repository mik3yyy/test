import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/req/reset_email_req.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/new_sign_in_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/manager/auth_manager.dart';

final resetEmailProvider =
    StateNotifierProvider<ResetEmailVm, RequestState<GenericRes>>(
  (ref) => ResetEmailVm(ref),
);

class ResetEmailVm extends RequestStateNotifier<GenericRes> {
  final AuthManager _authManager;

  ResetEmailVm(Ref ref) : _authManager = ref.read(authManagerProvider);

  Future<RequestState<GenericRes>> resetEmail(ResetEmailReq resetEmailReq) =>
      makeRequest(() => _authManager.resetEmail(resetEmailReq));
}
