import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/deactivate_account/deactivate_account_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/manager/auth_manager.dart';

final deactivateAccountProvider = StateNotifierProvider.autoDispose<
    DeactivateAccountVM, RequestState<DeactivateAccountRes>>((ref) {
  return DeactivateAccountVM(ref);
});

class DeactivateAccountVM extends RequestStateNotifier<DeactivateAccountRes> {
  final AuthManager _authManager;

  DeactivateAccountVM(Ref ref) : _authManager = ref.read(authManagerProvider);

  Future<RequestState<DeactivateAccountRes>> deactivateAccount(
          String password, String reason) =>
      makeRequest(() => _authManager.deactivateAccount(password, reason));
}
