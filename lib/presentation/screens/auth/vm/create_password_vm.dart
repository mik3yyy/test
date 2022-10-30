import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/req/create_password_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/manager/auth_manager.dart';

final createPasswordProvider =
    StateNotifierProvider<CreatePasswordVm, RequestState<CreatePassword>>(
        (ref) {
  return CreatePasswordVm(ref);
});

class CreatePasswordVm extends RequestStateNotifier<CreatePassword> {
  final AuthManager _authManager;

  CreatePasswordVm(Ref ref) : _authManager = ref.read(authManagerProvider);

  Future<RequestState<CreatePassword>> createPassword(
    String password,
    String confirmPassword,
  ) =>
      makeRequest(() => _authManager.createPassword(password, confirmPassword));
}
