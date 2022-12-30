import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/beneficiary_accounts.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/repository/withdrawal_manager.dart';

final nubanBeneficiaryProvider =
    FutureProvider.autoDispose<BeneficiaryAccount>((ref) async {
  ref.keepAlive();
  return ref.watch(withdrawManagerProvider).nubanBeneficiary();
});
