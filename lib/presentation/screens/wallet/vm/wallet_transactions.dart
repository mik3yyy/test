import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/repo/wallet_repo.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/get_profile_vm.dart';

final walletTransactionProvider = FutureProvider.autoDispose((ref) {
  ref.maintainState = true;
  ref.watch(userProfileProvider);
  return ref.watch(walletManagerProvider).getTransactions();
});
