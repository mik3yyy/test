import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/auth_controller/auth_controller.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/req/sign_in_req.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/signin_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/manager/auth_manager.dart';
import 'package:kayndrexsphere_mobile/presentation/app_session/app_session.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/app_session/session_timeout_manager.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/get_profile_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/get_account_details_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';

final signInProvider =
    StateNotifierProvider.autoDispose<SignInVm, RequestState<SigninRes>>((ref) {
  // ref.refresh(getAccountDetailsProvider);
  // ref.refresh(userProfileProvider);
  // ref.refresh(walletTransactionProvider);
  // PreferenceManager.isloggedIn = true;
  return SignInVm(ref);
});

class SignInVm extends RequestStateNotifier<SigninRes> {
  final Ref ref;

  SignInVm(this.ref);

  Future<RequestState<SigninRes>> signIn(SigninReq signinReq) {
    // PreferenceManager.isFirstLaunch = false;
    ref.read(authControllerProvider.notifier).setAuth(false);
    return makeRequest(() async {
      final res = await ref.read(authManagerProvider).signIn(signinReq);
      if (res.status == "success") {
        ref.refresh(getAccountDetailsProvider);
        ref.refresh(userProfileProvider);
        PreferenceManager.isloggedIn = true;
        ref.read(sessionStateStreamProvider).add(SessionState.startListening);
      }
      return res;
    });
  }
}
