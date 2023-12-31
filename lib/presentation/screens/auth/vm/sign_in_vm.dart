import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/auth_controller/auth_controller.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/req/sign_in_req.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/new_sign_in_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/signin_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/manager/auth_manager.dart';
import 'package:kayndrexsphere_mobile/presentation/app_session/app_session.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/app_session/session_timeout_manager.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/get_profile_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/get_account_details_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/wallet_transactions.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';

final verifyAuthProvider =
    StateNotifierProvider.autoDispose<VerifyAuthVm, RequestState<GenericRes>>(
        (ref) {
  return VerifyAuthVm(ref);
});

class VerifyAuthVm extends RequestStateNotifier<GenericRes> {
  final Ref ref;

  VerifyAuthVm(this.ref);

  Future<RequestState<GenericRes>> verifyAuth(SigninReq signinReq) {
    ref.read(authControllerProvider.notifier).setAuth(false);
    return makeRequest(() async {
      final res = await ref.read(authManagerProvider).signIn(signinReq);
      return res;
    });
  }
}

final signInProvider =
    StateNotifierProvider.autoDispose<SignInVm, RequestState<SigninRes>>((ref) {
  return SignInVm(ref);
});

class SignInVm extends RequestStateNotifier<SigninRes> {
  final Ref ref;

  SignInVm(this.ref);

  Future<RequestState<SigninRes>> signIn(SigninReq signinReq) {
    ref.read(authControllerProvider.notifier).setAuth(false);
    return makeRequest(() async {
      final res = await ref.read(authManagerProvider).signInNewUser(signinReq);
      if (res.status == "success") {
        ref.invalidate(getAccountDetailsProvider);
        ref.invalidate(userProfileProvider);
        ref.invalidate(walletTransactionProvider);
        PreferenceManager.isloggedIn = true;
        PreferenceManager.isFirstLaunch = false;
        ref.read(sessionStateStreamProvider).add(SessionState.startListening);
      }
      return res;
    });
  }
}
