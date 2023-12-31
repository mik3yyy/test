import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/repo/wallet_repo.dart';
// import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/get_profile_vm.dart';

final getAccountDetailsProvider = FutureProvider.autoDispose((ref) {
  ref.keepAlive();
  return ref.watch(walletManagerProvider).getUserAccountDetails();
});
