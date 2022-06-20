import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/verify_acct_no_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/repo/wallet_repo.dart';

import '../../../../Data/controller/controller/generic_state_notifier.dart';

final verifyAcctNoProvider =
    StateNotifierProvider<VerifyAcctNoVM, RequestState<VerifyAcctNoRes>>(
  (ref) => VerifyAcctNoVM(ref),
);

class VerifyAcctNoVM extends RequestStateNotifier<VerifyAcctNoRes> {
  final WalletRepo _walletRepo;

  VerifyAcctNoVM(Ref ref) : _walletRepo = ref.read(walletManagerProvider);

  void verifyAcctNo(
    String accountNo,
  ) =>
      makeRequest(() => _walletRepo.verifyAcctNo(accountNo));
}
