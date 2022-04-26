import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/manager/auth_manager.dart';

final refCodeProvider = StateNotifierProvider<RefCodeVm, RequestState<bool>>(
  (ref) => RefCodeVm(ref),
);

class RefCodeVm extends RequestStateNotifier<bool> {
  final AuthManager _authManager;

  RefCodeVm(Ref ref) : _authManager = ref.read(authManagerProvider);

  Future<RequestState<bool>> refCode(
    String refCode,
  ) =>
      makeRequest(() => _authManager.referralCode(refCode));
}
