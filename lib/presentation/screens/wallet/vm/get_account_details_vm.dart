import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/repo/wallet_repo.dart';

final getAccountDetailsProvider = FutureProvider.autoDispose((ref) {
  ref.maintainState = true;
  return ref.watch(walletManagerProvider).getUserAccountDetails();
});
