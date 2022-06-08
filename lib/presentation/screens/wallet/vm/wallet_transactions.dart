import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/wallet_transactions.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/repo/wallet_repo.dart';

final walletTransactionProvider = StateNotifierProvider<WalletTransactionsVM,
    RequestState<WalletTransactions>>(
  (ref) => WalletTransactionsVM(ref),
);

class WalletTransactionsVM extends RequestStateNotifier<WalletTransactions> {
  final WalletRepo _walletRepo;

  WalletTransactionsVM(Ref ref)
      : _walletRepo = ref.read(walletManagerProvider) {
    getwalletTransactions();
  }

  void getwalletTransactions() =>
      makeRequest(() => _walletRepo.getTransactions());
}
