import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/user_saved_wallet_beneficiary_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/repo/wallet_repo.dart';

final usersavedWalletBeneficirayProvider = StateNotifierProvider<
    UserSavedWalletBeneficiaryVm, RequestState<UserSavedWalletBeneficiaryRes>>(
  (ref) => UserSavedWalletBeneficiaryVm(ref),
);

class UserSavedWalletBeneficiaryVm
    extends RequestStateNotifier<UserSavedWalletBeneficiaryRes> {
  final WalletRepo _walletRepo;

  UserSavedWalletBeneficiaryVm(Ref ref)
      : _walletRepo = ref.read(walletManagerProvider) {
    usersavedWalletBeneficiary();
  }

  void usersavedWalletBeneficiary() =>
      makeRequest(() => _walletRepo.userSavedWalletBeneficiary());
}
