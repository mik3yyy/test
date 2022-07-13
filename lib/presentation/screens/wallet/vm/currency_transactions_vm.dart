import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/currency_transactions.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/repo/wallet_repo.dart';

final currencyTransactionProvider = FutureProvider.autoDispose
    .family<CurrencyTransaction, String>((ref, currency) async {
  ref.maintainState = true;
  return ref.watch(walletManagerProvider).currencyTransactions(currency);
});
