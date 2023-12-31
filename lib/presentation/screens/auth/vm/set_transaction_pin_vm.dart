import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/resendotp_res.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/get_profile_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/get_account_details_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/wallet_transactions.dart';

import '../../../../Data/controller/controller/generic_state_notifier.dart';
import '../../../../Data/services/auth/manager/auth_manager.dart';

final transactionPinProvider = StateNotifierProvider.autoDispose<
    TransactionPinVm, RequestState<ResendOtpRes>>(
  (ref) {
    return TransactionPinVm(ref);
  },
);

class TransactionPinVm extends RequestStateNotifier<ResendOtpRes> {
  final Ref ref;

  TransactionPinVm(this.ref);

  void transactionPin(String transactionPin, String confirmTransactionPin) =>
      makeRequest(() async {
        final transactionX = await ref
            .read(authManagerProvider)
            .transactionPin(transactionPin, confirmTransactionPin);
        if (transactionX.status == "success") {
          ref.invalidate(getAccountDetailsProvider);
          ref.invalidate(walletTransactionProvider);
          ref.invalidate(userProfileProvider);
        }
        return transactionX;
      });
}
