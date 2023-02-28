import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/auth_controller/auth_controller.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/req/two_fa_req.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/signin_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/auth/manager/auth_manager.dart';
import 'package:kayndrexsphere_mobile/presentation/app_session/app_session.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/app_session/session_timeout_manager.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/create_acount/success.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/get_profile_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/get_account_details_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/wallet_transactions.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';

final verify2FAProvider =
    StateNotifierProvider.autoDispose<Verify2FAVM, RequestState<SigninRes>>(
        (ref) {
  return Verify2FAVM(ref);
});

class Verify2FAVM extends RequestStateNotifier<SigninRes> {
  final Ref ref;

  Verify2FAVM(this.ref);

  Future<RequestState<SigninRes>> verify2FA(The2FaReq verify2FA) {
    ref.read(authControllerProvider.notifier).setAuth(false);
    return makeRequest(() async {
      final res = await ref.read(authManagerProvider).verify2FA(verify2FA);
      if (res.status == "success") {
        ref.invalidate(getAccountDetailsProvider);
        ref.invalidate(userProfileProvider);
        ref.invalidate(walletTransactionProvider);

        /// REFRESH USER EMAIL
        ref.invalidate(userEmail);

        ///
        PreferenceManager.isloggedIn = true;
        PreferenceManager.isFirstLaunch = false;
        ref.read(sessionStateStreamProvider).add(SessionState.startListening);
      }
      return res;
    });
  }
}

final accountStateProvider = StateProvider<Account>((ref) {
  return Account.newAccount;
});

final userEmail = StateProvider<String>((ref) {
  return "";
});
