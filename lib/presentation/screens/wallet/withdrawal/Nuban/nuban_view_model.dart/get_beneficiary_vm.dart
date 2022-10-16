import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/beneficiary_accounts.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/repository/withdrawal_manager.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/get_profile_vm.dart';

final nubanBeneficiaryProvider =
    FutureProvider.autoDispose<BeneficiaryAccount>((ref) async {
  ref.maintainState = true;
  ref.watch(userProfileProvider);
  return ref.watch(withdrawManagerProvider).nubanBeneficiary();
});
