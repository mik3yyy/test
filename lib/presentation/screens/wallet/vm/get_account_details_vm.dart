import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/user_account_details_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/repo/wallet_repo.dart';

final getAccountDetailsProvider = StateNotifierProvider<GetAccountDetailsVm,
    RequestState<UserAccountDetails>>(
  (ref) => GetAccountDetailsVm(ref),
);

class GetAccountDetailsVm extends RequestStateNotifier<UserAccountDetails> {
  final WalletRepo _walletRepo;

  GetAccountDetailsVm(Ref ref) : _walletRepo = ref.read(walletManagerProvider) {
    getAccountDetails();
  }

  void getAccountDetails() =>
      makeRequest(() => _walletRepo.getUserAccountDetails());
}
