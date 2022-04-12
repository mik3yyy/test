import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/signin_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/manager/auth_manager.dart';

final signInProvider = StateNotifierProvider<SignInVm, RequestState<SigninRes>>(
  (ref) => SignInVm(ref),
);

class SignInVm extends RequestStateNotifier<SigninRes> {
  final AuthManager _authManager;

  SignInVm(Ref ref) : _authManager = ref.read(authManagerProvider);

  Future<RequestState<SigninRes>> signIn(
    String emailPhone,
    String password,
  ) =>
      makeRequest(() => _authManager.signIn(emailPhone, password));
}
