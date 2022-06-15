import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/beneficiary_accounts.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/repository/withdrawal_manager.dart';

// final getBeneficiaryProvider = StateNotifierProvider<NubanBeneficiaryVM,
//     RequestState<NubanBeneficiariesRes>>(
//   (ref) => NubanBeneficiaryVM(ref),
// );

// class NubanBeneficiaryVM extends RequestStateNotifier<NubanBeneficiariesRes> {
//   final WithdrawalManager withdrawalManager;

//   NubanBeneficiaryVM(Ref ref)
//       : withdrawalManager = ref.read(withdrawManagerProvider) {
//     getNubanBeneficiary();
//   }

//   void getNubanBeneficiary() =>
//       makeRequest(() => withdrawalManager.nubanBeneficiary());
// }

final getBeneficiaryProvider = FutureProvider.autoDispose
    .family<BeneficiaryAccount, String>((ref, _) async {
  return ref.watch(withdrawManagerProvider).nubanBeneficiary();
});
