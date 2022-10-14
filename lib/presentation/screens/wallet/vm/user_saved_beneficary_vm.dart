import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/repo/wallet_repo.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/get_profile_vm.dart';

final usersavedWalletBeneficirayProvider = FutureProvider.autoDispose((ref) {
  ref.maintainState = true;
  ref.watch(userProfileProvider);
  return ref.watch(walletManagerProvider).userSavedWalletBeneficiary();
});




// final usersavedWalletBeneficirayProvider = StateNotifierProvider<
//     UserSavedWalletBeneficiaryVm, RequestState<UserSavedWalletBeneficiaryRes>>(
//   (ref) => UserSavedWalletBeneficiaryVm(ref),
// );

// class UserSavedWalletBeneficiaryVm
//     extends RequestStateNotifier<UserSavedWalletBeneficiaryRes> {
//   final WalletRepo _walletRepo;

//   UserSavedWalletBeneficiaryVm(Ref ref)
//       : _walletRepo = ref.read(walletManagerProvider) {
//     usersavedWalletBeneficiary();
//   }

//   void usersavedWalletBeneficiary() =>
//       makeRequest(() => _walletRepo.userSavedWalletBeneficiary());
// }
