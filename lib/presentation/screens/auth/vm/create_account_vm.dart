import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/create_account_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/manager/auth_manager.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';

final createAccountProvider =
    StateNotifierProvider<CreateAccountVm, RequestState<CreatAccountRes>>(
  (ref) => CreateAccountVm(ref),
);

class CreateAccountVm extends RequestStateNotifier<CreatAccountRes> {
  final AuthManager _authManager;

  CreateAccountVm(Ref ref) : _authManager = ref.read(authManagerProvider);
  void createAccount(
    String firstName,
    String lastName,
    String emailPhone,
  ) =>
      makeRequest(() async {
        final res = await _authManager.createAccount(
            firstName: firstName, lastName: lastName, emailPhone: emailPhone);
        if (res.data != null) {
          PreferenceManager.email = emailPhone;
        }
        return res;
      });
}
