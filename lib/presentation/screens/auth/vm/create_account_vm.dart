import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/manager/auth_manager.dart';

final createAccountProvider =
    StateNotifierProvider<CreateAccountVm, RequestState<bool>>(
  (ref) => CreateAccountVm(ref),
);

class CreateAccountVm extends RequestStateNotifier<bool> {
  final AuthManager _authManager;

  CreateAccountVm(Ref ref) : _authManager = ref.read(authManagerProvider);

  Future<RequestState<bool>> createAccount(
    String firstName,
    String lastName,
    String emailPhone,
  ) =>
      makeRequest(() => _authManager.createAccount(
          firstName: firstName, lastName: lastName, emailPhone: emailPhone));
}
